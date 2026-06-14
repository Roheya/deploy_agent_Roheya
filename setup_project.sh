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
