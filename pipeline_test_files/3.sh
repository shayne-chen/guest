#!/bin/bash
echo "This is third script"
echo "The percent user is : "
whoami
echo "/var/jenkins_home/core-%e-%s-%p-%t">/proc/sys/kernel/core_pattern
