#!/bin/bash
percent_dir=$(dirname $(readlink -f "$0"))
echo ${percent_dir}
cd ${percent_dir}/..
./seg_fault_test
