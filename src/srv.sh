#!/bin/env bash

read a b c
z=read

while [ ${#z} -gt 2 ]
do
  read z
done

f=`echo $b|sed 's/[^a-z0-9_.-]//gi'`
h="HTTP/1.0"
o="$h 200 OK\r\n"
c="Content"

m="mysql -ulol -ptrololo"
m2j="~/bin/mysql2json.sh"

echo "$o$c-Type: text/json"
echo

if [[ ( -n "$f" ) && ( "$f" != "favicon.ico" ) ]]
then
  echo "+ Connect to [$f]">&2
  db=${f%.*}
  tb=${f#*.}
  if [ "$tb" = "$db" ]
  then
    echo `$m ${db:-test} -e "show tables" | $m2j`
  else
    echo `$m ${db:-test} -e "select * from $tb" | $m2j`
  fi
else
  echo `$m -e "show databases" | $m2j`
fi

#EOF#
