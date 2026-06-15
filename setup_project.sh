#!/bin/bash
# 1. Directory Architecture
mkdir -p attendance_tracker_v1
cd attendance_tracker_v1

# creating attendance_checker.py file
touch  attendance_checker.py

# Create Helpers and reports folders
mkdir -p Helpers
mkdir -p reports

# creating assets.csv and config.json files
cd Helpers
touch assets.csv
echo '{
  "warning": 75,
  "failure": 50
}' > "config.json"

# creating reports.log
cd -
cd reports
touch reports.log

#2. Dynamic Configuration (Stream Editing)
# deciding if I want  to update the attendance thresholds
echo "Do I want to update the attendance thresholds? (y/n)"
read update_choice
if [ $update_choice = y ]; then
        echo "new warning threshold (default 75):"
        read warning
        warning=${warning:-75}
        
        #checking if warning is a number only
	if ! [[ "$warning" =~ ^[0-9]+$ ]]; then
		echo "Invalid input. Warning must be a number. 	With default 75"		
		warning=75
	fi	

	echo "Enter new Failure threshold (default 50):"
        read failure
        failure=${failure:-50}

	# checking if failure is a number 
	if ! [[ "$failure" =~ ^[0-9]+$ ]]; then
		echo "Invalid input. failure  must be a number. With default as 50"
		failure=50
	fi
# using the sed command to perform an "in-place" edit of the config.json file
sed -i "s/\"warning\": [0-9]\+/\"warning\": $warning/" /root/deploy_agent_Roheya/attendance_tracker_v1/Helpers/config.json
sed -i "s/\"failure\": [0-9]\+/\"failure\": $failure/" /root/deploy_agent_Roheya/attendance_tracker_v1/Helpers/config.json
else
    echo "no changes"
fi


