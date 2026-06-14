#!/bin/bash
# 1. Directory Architecture
mkdir -p attendance_tracker_v1
cd attendance_tracker_v1

# creating attendance_checker.py file
vi attendance_checker.py

# Create Helpers and reports folders
mkdir -p Helpers
mkdir -p reports

# creating assets.csv and config.json files
cd Helpers
vi assets.csv
vi config.json

# creating reports.log
cd -
cd reports
vi reports.log

#2. Dynamic Configuration (Stream Editing)
# deciding if I want  to update the attendance thresholds
echo "Do I want to update the attendance thresholds? (y/n)"
read update_choice
if [ $update_choice = y ]; then
        echo "new warning threshold (default 75):"
        read warning
        warning=${warning:-75}
        echo "Enter new Failure threshold (default 50):"
        read failure
        failure=${failure:-50}

# using the sed command to perform an "in-place" edit of the config.json file
sed -i "s/\"warning\": 75/\"warning\": $warning/" /root/deploy_agent_Roheya/attendance_tracker_v1/Helpers/config.json
sed -i "s/\"failure\": 50/\"failure\": $failure/" /root/deploy_agent_Roheya/attendance_tracker_v1/Helpers/config.json
else
    echo "no changes"
fi

# 4. Environment Validation
# Verify python3 installation
version=$(python3 --version 2>/dev/null)
if [ -n "$version" ]; then
        echo "Success: Python3 is installed ($version)"
else
        echo "Warning: Python3 is not installed."
fi
# Verify application directory structure
project_directory="/root/deploy_agent_Roheya/attendance_tracker_v1"
if [ -d "$project_directory" ];then
        echo "Success: Application directory exists at $project_directory"
else
        echo "Warning: Application directory missing: $project_directory"
fi
