#This script generates MAC address and saves it to output.txt file. 

#!/bin/bash

front="$(echo 00:0D:56: 00:0D:60: 00:0D:9D: 00:0D:28: 00:24:D6: | xargs shuf -n1 -e)" #order of vendors - DELL IBM HP CISCO INTEL 
end="7B:0C:9F"
NEW_MAC=$front$end
echo $NEW_MAC > "/root/output.txt"
