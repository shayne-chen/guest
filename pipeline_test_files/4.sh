#!/bin/bash
percent_dir=$(dirname $(readlink -f "$0"))
echo ${percent_dir}
cd /var/jenkins_home/workspace/test_pipeline/
./seg_fault_test
