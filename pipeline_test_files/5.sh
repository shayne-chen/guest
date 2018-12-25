#!/bin/bash
cd /var/jenkins_home
new_filename=`ls -lt core-seg_fault_test*|awk '{print $9}'|head -n 1`
echo ${new_filename}
echo "GDB Debug info is below : "
gdb -c ${new_filename}
