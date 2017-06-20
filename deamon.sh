#! /bin/sh
name="PM2"
port=3300
proc_name (){
    name=`ps -ef | grep $proc_name | awk '{print $8}'`
}
proc_name
realname=`echo $name|sed 's/grep//g'`
if [ $proc_name = $realname ]
then
   echo "true"
   instance=`netstat -anlp | grep $port| awk '{print $1}'`
   
   if [ $instance = "tcp" ]
   then
	   echo "true"
   else
	   echo "false"
	   pm2 kill && pm2 resurrect
   fi
else
   echo "false"
   pm2 resurrect
fi
