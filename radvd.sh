#!/bin/bash

if [ "$SRV_MESSAGE" != "REPLY" ]
then
                exit 1
fi

function fullPrefix () {
  local input=$1
  local o=""
  local z=""
                                   
  input=$(tr 'A-F' 'a-f' <<< $input )
                               
  while [ "$o" != "$input" ]; do
    o="$input"
                                                                 
    input="$( sed  's|:\([0-9a-f]\{3\}\):|:0\1:|g'  <<< "$input" )"
    input="$( sed  's|:\([0-9a-f]\{3\}\)$|:0\1|g'   <<< "$input" )"
    input="$( sed  's|^\([0-9a-f]\{3\}\):|0\1:|g'   <<< "$input" )"
                                                                 
    input="$( sed  's|:\([0-9a-f]\{2\}\):|:00\1:|g' <<< "$input" )"
    input="$( sed  's|:\([0-9a-f]\{2\}\)$|:00\1|g'  <<< "$input" )"
    input="$( sed  's|^\([0-9a-f]\{2\}\):|00\1:|g'  <<< "$input" )"
                                                               
    input="$( sed  's|:\([0-9a-f]\):|:000\1:|g'     <<< "$input" )"
    input="$( sed  's|:\([0-9a-f]\)$|:000\1|g'      <<< "$input" )"
    input="$( sed  's|^\([0-9a-f]\):|000\1:|g'      <<< "$input" )"
  done
                           
  grep -qs "::" <<< "$input"
  if [ "$?" -eq 0 ]; then                             
    GRPS="$( sed  's|[0-9a-f]||g' <<< "$input" | wc -m )"
    ((GRPS--)) # carriage return
    ((MISSING=8-GRPS))           
    for ((i=0;i<$MISSING;i++)); do
      z="$z:0000"
    done
                                                               
    input="$( sed  's|\(.\)::\(.\)|\1'$z':\2|g'          <<< "$input" )"
    input="$( sed  's|\(.\)::$|\1'$z':0000|g'            <<< "$input" )"         
    input="$( sed  's|^::\(.\)|'$z':0000:\1|g;s|^:||g'   <<< "$input" )"
  fi           
  echo "$input"
}

ETH1_SUFFIX="01::1"

STATUS_FILE=/run/dibbler.lease

if [ -f "$STATUS_FILE" ];
then
                source $STATUS_FILE
fi

TRIM_SIZE=17
FULLPREFIX=$( fullPrefix $PREFIX1 ) 
PREFIX1=${FULLPREFIX:0:TRIM_SIZE}

if [ "$PREFIX1" != "$CURRENT_PREFIX1" ]
then
                if [ "$CURRENT_PREFIX1" != "" ]
                then
                               ip addr delete "$CURRENT_PREFIX1$ETH1_SUFFIX/64" dev eth1
                fi

                echo "CURRENT_PREFIX1=$PREFIX1" > $STATUS_FILE

                ip addr add "$PREFIX1$ETH1_SUFFIX/64" dev eth1
                service radvd restart >/dev/null 2>&1
fi