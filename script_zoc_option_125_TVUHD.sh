#!/bin/bash

maclivebox=24:7F:20:XX:XX:XX
verlivebox=4
serlivebox=LKXXXXXDPXXXXXX

tohex() {
  for h in $(echo $1 | sed "s/\(.\)/\1 /g"); do printf %02x \'$h; done
}

addsep() {
  echo $(echo $1 | sed "s/\(..\)/:\1/g")
}

m=0406$(tohex ${maclivebox//:/} | cut -c1-12)
s=050f$(tohex ${serlivebox})
l=0609$(tohex Livebox)20$(tohex $verlivebox)

echo 00:00:0d:e9:24$(addsep ${m}${s}${l}) 