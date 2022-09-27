#!/bin/env bash


function m2j()
{
  sed -e 's/\t/\",\"/g' \
      -e 's/^/\[\"/'    \
      -e 's/$/\"\],/'   \
      -e '1s/\(.*\)/\{\"fields\":\1\ \"data\":[/g' -e '$s/.$/\]\}/' \
  | tr -d "\n" $1
}



:;while [ $? -eq 0 ]
do.
  nc -vlp 8880 -c '(
    r=read;
    e=echo;

    $r a b c;

    z=$r;

    while [ ${#z} -gt 2 ]
    do.
      $r z;
    done;

    f=`$e $b|sed 's/[^a-z0-9_.-]//gi'`;

    h="HTTP/1.0";
    o="$h 200 OK\r\n";
    c="Content";

    m="mysql -ulol -ptrololo"

    $e "$o$c-Type: text/json";
    $e;

    if [[ ( -n "$f" ) && ( "$f" != "favicon.ico" ) ]]
    then.
      $e "+ Connect to [$f]">&2;

      db=${f%.*};
      tb=${f#*.};

      if [ "$tb" = "$db" ]
      then
        $e `$m ${db:-test} -e "show tables" | m2j`;
      else
        $e `$m ${db:-test} -e "select * from $tb" | m2j`;
      fi;

    else
      $e `$m -e "show databases" | m2j`;
    fi
  )';
done
