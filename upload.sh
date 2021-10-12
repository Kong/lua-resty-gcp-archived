#!/bin/bash

TARGET=./src/resty/gcp/api

ALL_URLS=(`curl https://discovery.googleapis.com/discovery/v1/apis | jq -r ".items[].discoveryRestUrl"`)
API_NAMES=(`curl https://discovery.googleapis.com/discovery/v1/apis | jq -r ".items[].id" | sed -e 's/:/_/g' | sed -e 's/[.]/p/g'`)
ROCKSPEC_ADD=''


for (( i=0; i<${#ALL_URLS[@]}; i++ ))
# for (( i=0; i<3; i++ ))
do
   echo 'local decode = require("cjson").new().decode
return assert(decode([===[' > "$TARGET/${API_NAMES[$i]}.lua"
   echo `curl ${ALL_URLS[$i]}` >> "$TARGET/${API_NAMES[$i]}.lua"
   echo ']===]))' >> "$TARGET/${API_NAMES[$i]}.lua"
   ROCKSPEC_ADD+='\t\t["resty.gcp.api.'${API_NAMES[$i]}'"]="src/resty/gcp/api/'${API_NAMES[$i]}'.lua",\n'

done

mv lua-resty-gcp-dev-1.rockspec lua-resty-gcp-dev-1.rockspec.original

cp lua-resty-gcp-dev-1.rockspec.template lua-resty-gcp-dev-1.rockspec

sed -i 's#--AUTOGEN--#'$ROCKSPEC_ADD'#g' lua-resty-gcp-dev-1.rockspec