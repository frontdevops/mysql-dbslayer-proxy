#!/bin/env bash

sed -e 's/\t/\",\"/g' \
    -e 's/^/\[\"/'    \
    -e 's/$/\"\],/'   \
    -e '1s/\(.*\)/\{\"fields\":\1\ \"data\":[/g' -e '$s/.$/\]\}/' \
| tr -d "\n"

#EOF#
