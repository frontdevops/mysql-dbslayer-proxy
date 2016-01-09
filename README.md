# MySQL DBS Layer proxy

Simple DBSLayer for MySQL writen on Bash.
This simple server get data from MySQL by REST in JSON format.

## Components

* mysql2json.sh - convert output from MySQL to JSON
* dbjs.sh - DBS proxy server

## Usage

### mysql2json

    # exec
    mysql -e "SELECT * FROM `mytable`" | ./mysql2json.sh
    
    # output
    {"fields":["field_1","field_2","field_3"],"data":[["1","2","3"],["4","5","6"],["7","8","9"]]}

### Start server

    ./dbjs.sh
    listening on [any] 8880 ...

### Connect to server from client (browser or other)

**List of databases**

```
// http://127.0.0.1:8880 
{
    fields: [
           "Database"
    ],
    data: [
         [ "information_schema" ],
         [ "test" ]
    ]
}
```

**List of tables from selected database**
```
// http://127.0.0.1:8880/test
{
          fields: [
              "Tables_in_test"
          ],
         data: [
             ["prods"],
             ["shops"],
             ["sp"],
             ["stat"]
         ]
}
```

**Get data from table**
```
// http://127.0.0.1:8880/test.shops
{
     "fields": [
           "id",
           "name",
           "adress"
     ],
     "data": [
           ["1","aaaaa",""],
           ["2","bbbbbbbbb",""],
           ["3","cccccccccccccccc","ccc"]
     ]
}
```
