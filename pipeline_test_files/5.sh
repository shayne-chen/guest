#!/bin/bash
cd /var/jenkins_home
new_filename=`ls -lt core-seg_fault_test*|awk '{print $9}'|head -n 1`
echo ${new_filename}
gdb -c ${new_filename}|tee -a /var/jenkins_home/core_info.log

cat /var/jenkins_home/core_info.log
