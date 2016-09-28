#LINUX系统命令

#### 1.查看磁盘

```
df -h
du -h --max-depth=1
```

#### 2.查看内存大小

```
free

free [-m|g]按MB,GB显示内存

vmstat
```

####3.查看cpu

`cat /proc/cpuinfo`

``` 只看cpu数量grep "model name" /proc/cpuinfo | wc -l ```

####4.查看系统内存

`cat /proc/meminfo`

####5.查看每个进程的情况

`cat /proc/5346/status 5347是pid`

####6.查看负载
`ss -s `

`w`

`uptime`

####7.查看系统整体状态

`top`

```
*** 最后一些输出信息的解释：***

load average: 0.09, 0.05, 0.01

三个数分别代表不同时间段的系统平均负载(一分钟、五 分钟、以及十五分钟)，它们的数字当然是越小越好。“有多少核心即为有多少负荷”法则： 在多核处理中，你的系统均值不应该高于处理器核心的总数量

进程使用的内存可以用top,有3个列VIRT RES SHR, 标示了进程使用的内存情况, VIRT标识这个进程可以使用的内存总大小, 包括这个进程真实使用的内存, 映射过的文件, 和别的进程共享的内存等. RES标识这个这个进程真实占用内存的大小. SHR标识可以和别的进程共享的内存和库大小.
```
####8.性能监视sar命令

`sar -u输出显示CPU信息。-u选项是sar的默认选项。该输出以百分比显示CPU的使用情况`

`CPU`

```
CPU编号

%user

在用户模式中运行进程所花的时间

%nice

运行正常进程所花的时间

%system

在内核模式（系统）中运行进程所花的时间

%iowait

没有进程在该CPU上执行时，处理器等待I/O完成的时间

%idle

没有进程在该CPU上执行的时间

sar 5 10 sar以5秒钟间隔取得10个样本

sar -u -p ALL 5 5 分cup显示

sar -n { DEV | EDEV | NFS | NFSD | SOCK | ALL }

sar 提供六种不同的语法选项来显示网络信息。-n选项使用6个不同的开关：DEV | EDEV | NFS | NFSD | SOCK | ALL 。DEV显示网络接口信息，EDEV显示关于网络错误的统计数据，NFS统计活动的NFS客户端的信息，NFSD统计NFS服务器的信息，SOCK显示套接字信息，ALL显示所有5个开关。它们可以单独或者一起使用。

sar -n DEV 各参数含义

IFACE

LAN接口

rxpck/s

每秒钟接收的数据包

txpck/s

每秒钟发送的数据包

rxbyt/s

每秒钟接收的字节数

txbyt/s

每秒钟发送的字节数

rxcmp/s

每秒钟接收的压缩数据包

txcmp/s

每秒钟发送的压缩数据包

rxmcst/s

每秒钟接收的多播数据包
```

####9.查看命令历史(含时间戳）

`export HISTTIMEFORMAT='%F %T ';history| more`

####10.查看文件夹和文件大小

```
du -h --max-depth=0 dm 查看dm目录大小

du -h --max-depth=1 dm 查看dm目录大小，以及dm各文件文件夹的大小

du -h --max-depth=0 查看当前文件夹大小
```
####11.挂载查看
`vim /etc/fstab`

####12.tcp连接
```
LINUX 查看tcp连接数及状态

netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

TIME_WAIT 8947 等待足够的时间以确保远程TCP接收到连接中断请求的确认
FIN_WAIT1 15 等待远程TCP连接中断请求，或先前的连接中断请求的确认
FIN_WAIT2 1 从远程TCP等待连接中断请求
ESTABLISHED 55 代表一个打开的连接
SYN_RECV 21 再收到和发送一个连接请求后等待对方对连接请求的确认
CLOSING 2 没有任何连接状态
LAST_ACK 4 等待原来的发向远程TCP的连接中断请求的确认
 
TCP连接状态详解
LISTEN： 侦听来自远方的TCP端口的连接请求
SYN-SENT： 再发送连接请求后等待匹配的连接请求
SYN-RECEIVED：再收到和发送一个连接请求后等待对方对连接请求的确认
ESTABLISHED： 代表一个打开的连接
FIN-WAIT-1： 等待远程TCP连接中断请求，或先前的连接中断请求的确认
FIN-WAIT-2： 从远程TCP等待连接中断请求
CLOSE-WAIT： 等待从本地用户发来的连接中断请求
CLOSING： 等待远程TCP对连接中断的确认
LAST-ACK： 等待原来的发向远程TCP的连接中断请求的确认
TIME-WAIT： 等待足够的时间以确保远程TCP接收到连接中断请求的确认
CLOSED： 没有任何连接状态
```
####13.系统参数查看与生效
```
sysctl -a
sysctl -p
```
####14.查看tcp连接等待最大时间
`cat /proc/sys/net/ipv4/tcp_fin_timeout`

[参考](http://blog.csdn.net/huangxy10/article/details/8012180)
