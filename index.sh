#!/bin/bash

#   SELF DESTROING TIMEOUT
{   
    # For testing t=3s
    #sleep 5s
    # For real t=86340s or 23hrs and 59min
    sleep 86400s
    process_id=`/bin/ps -f | grep "guvcview" | awk '{print $2}'`
    kill -9 $process_id

} &

records_folder="/media/geovani/RECORDS/"
max_records=3 #Cause each record is around 45GB and I have only 156GB free

#   DELETING THE OLDEST FILE
count_files=$(find ${records_folder} -type f | wc -l)
echo "FOUND $count_files FILES"

if [ $count_files -ge $max_records ] #when we first use it
then
    oldest_file=$(find ${records_folder} -type f -printf '%T+ %p\n' | sort | awk -F ' ' '{print $2}' | head -n 1)
    rm -f $oldest_file
    echo "Deleted oldest: $oldest_file"
fi

#   NAMING NEW FILE CURRENT DATE
### mmddyyyy ###
file_name=$(date +'%m%d%Y')
format=".mpeg"

#   STARING CAPTURING
echo "SAVING AT ${records_folder}${file_name}${format}"
#touch "${records_folder}${file_name}${format}"
# For testing t=3s
#guvcview --video_timer=3 --video=${records_folder}${file_name}${format}
# For real t=86340s or 23hrs and 59min
guvcview --video_timer=86340 --video=${records_folder}${file_name}${format} 

echo "RECORDED AND SAVED"


