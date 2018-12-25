#!/bin/bash
cd /var/jenkins_home
new_filename=`ls -lt core-seg_fault_test*|awk '{print $9}'|head -n 1`
echo ${new_filename}
echo "GDB Debug info is below : "
current_time=`date '+%Y-%m-%d %H:%M:%S'`
gdb -c ${new_filename}>>/var/jenkins_home/core_info_${current_time}.info
core_file=`ls -lt core_info*|awk '{print $9}'|head -n 1`
tail -n 20 ${core_file}
