#!/bin/bash
# 3. Process Management (The Trap)
project_directory="/root/deploy_agent_Roheya/attendance_tracker_v1"
archive_name="attendance_tracker_v1_archive"

# Trap SIGINT (Ctrl+C) and call the handler
trap 'handle_user_interrupt' SIGINT

# creating attendance_tracker_v1_archive and removing the incomplete directory
handle_user_interrupt() {
        echo "Interrupt detected!"
        tar -cf "$archive_name" "$project_directory"
        echo "Archive created: $archive_name"
        rm -rf "$project_directory"
        echo "Incomplete project directory removed"
        echo "Cleanup complete. Exiting"
        exit
}

sleep 10

# 1. Directory Architecture
if [ -d "$project_directory" ]; then
    echo "Directory $project_directory already exists" 
else
    
    if mkdir -p "$project_directory"; then 
       echo "Created project directory: $project_directory"
    else
         echo "Error: Could not create project directory."
         exit
    fi
fi    
cd "$project_directory" || { echo "Error: Cannot enter project directory."; exit; }

# creating attendance_checker.py file
touch  attendance_checker.py || { echo "Error: cannot create attendance_checker.py"; exit; }

# Create Helpers and reports folders
mkdir -p Helpers || { echo "Error: canot create Helpers directory"; exit; }
mkdir -p reports || { echo "Error cannot create reports directory"; exit; }
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
echo "Do I want to update the attendance thresholds? y/n"
read update_choice
if [ "$update_choice" = "y" ]; then
        echo "new warning threshold (default 75):"
        read warning
        warning=${warning:-75}
        
        #checking if warning is a number only
        if ! [[ "$warning" =~ ^[0-9]+$ ]]; then
                echo "Invalid input. Warning must be a number.  With default 75"                
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
# using the sed command to perform an "in-place" edit of the config.json file
sed -i "s/\"warning\": [0-9]\+/\"warning\": $warning/" $project_directory/Helpers/config.json
sed -i "s/\"failure\": [0-9]\+/\"failure\": $failure/" $project_directory/Helpers/config.json
else
    echo "no changes"
fi

# 4. Environment Validation
# Verify python3 installation
version=$(python3 --version)
if [ -n "$version" ]; then
        echo "Success: Python3 is installed ($version)"
else
        echo "Warning: Python3 is not installed."
fi
# Verify application directory structure
if [ -d "$project_directory" ];then
        echo "Success: Application directory exists at $project_directory"
else
        echo "Warning: Application directory missing: $project_directory"
fi
