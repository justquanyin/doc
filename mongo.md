## Mongo 数据库常用操作
```
help                                     #mongodb支持的命令
show dbs                                 #查看所有数据库
use test
db                                       #查看当前连接在哪个数据库
show collections                         #查看所有的collection 
db.help()                                #当前数据库支持哪些方法
db.user.help()                           #当前数据库下的表或者表collection支持的方法
 
db.foo.find()                            #查找所有
db.foo.findOne()                         #查找一条记录
db.foo.find({'msg':'Hello 1'}).limit(10) #根据条件检索10条记录
 
db.mail_addr.drop()                      #删除collection
db.dropDatabase()                        #删除当前的数据库
db.foo.remove({'yy':5})                  #删除yy=5的记录 
db.foo.remove()                          #删除所有的记录

#存储嵌套的对象
db.foo.save({'name':'ysz','address':{'city':'beijing','post':100096},'phone':[138,139]})
 
#存储数组对象
db.user_addr.save({'Uid':'yushunzhi[@sohu](/user/sohu).com','Al':['test-1[@sohu](/user/sohu).com','test-2[@sohu](/user/sohu).com']})
 
#根据query条件修改，如果不存在则插入，允许修改多条记录
db.foo.update({'yy':5},{'$set':{'xx':2}},upsert=true,multi=true)

#去重
db.orders.distinct("user.raw.unionid",{_purchase_item:ObjectId("57554f3f9b53ed2836e14825")},{"user.raw.unionid":1,_id:0}).length;

# 导入 
mongorestore -h  --port -u -p -d --drop ./

# 导出
mongodump --host= --port= -u -p -d qtime -c -o ./

#导出 csv
mongoexport --host= --port= -u -p -d -c -o ./***.csv

#用户权限  (可先设置超级用户，其他再有超级用户设置即可)
db.createUser(
    {
      user: "super",
      pwd: "****",
      roles: [ "root" ]
    }
)

### 一般权限设置
db.createUser(
 {
   user: "user",
   pwd: "****",
   roles: [
      { role: "readWrite", db: "dbname" },
   ]
 }
)

```
### 查询性能
```
db.testing.find({name: 123}).explain()
```

###刷新配置 
```
db.runCommand("flushRouterConfig");
```

### 更新mongo field value use other field value
```
db.purchaseitems.find({}).snapshot().forEach(function(ele){db.purchaseitems.update({_id:ele._id},{$set:{qingting_icon:ele.fee*10}})});
```

## relpset 集群配置相关
####relpset 设置
```
rs.initiate({ _id:qtime, members:[ {_id:0,host:'',priority:2}, {_id:1,host:'',priority:1},{_id:2,host:'',priority:1}] })
```
####relpset 查看
```rs.status()```

####relpset 结点增加
``` rs.add("host:port") ```

####relpset config file
```
storage:
  dbPath: /mnt/mongodb/data
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /mnt/mongodb/log/mongod.log


net:
  port: 
  bindIp: 

security:
   keyFile: /etc/mongodb-keyfile
   authorization: enabled
replication:
  replSetName: qtpay

```
### 更新repl set集群配置信息
```
cfg = rs.conf()
cfg.members[0].host = "xxxhost: 20000"
cfg.members[1].host = "yyyhost: 20001"
cfg.members[2].host = "zzzhost: 20002"
rs.reconfig(cfg)
```