#!/bin/bash
cd /var/jenkins_home
new_filename=`ls -lt core-seg_fault_test*|awk '{print $9}'|head -n 1`
gdb -c ${new_filename}
