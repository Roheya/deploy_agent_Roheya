Follow these instructions to setup and run the project:

1. clone into my repository (deploy_agent_Roheya)
  git clone https://github.com/Roheya/deploy_agent_Roheya.git

2. change the working directory to deploy_agent_Roheya
   cd deploy_agent_Roheya

3. run the script with
  bash setup_project.sh

What happens when you run the script?
The script pauses for 10 seconds (sleep 10) to allow you to test the trap.
During this pause, pressing Ctrl+C sends a SIGINT signal, which triggers the archive feature.]

If interrupted before 10 seconds (Ctrl+C):
1. It creates an archive (attendance_tracker_v1_archive) of the project directory,hence ctrl+c triggers the creation of the archive.
2. Deletes the incomplete directory.
3. Prints cleanup messages and exits.

If not interrupted (after 10 seconds):
1. It builds the directory structure (attendance_tracker_v1 with Helpers and reports).
2. Creates files (attendance_checker.py, assets.csv, config.json, reports.log).
3. Prompts you to update thresholds.
4. Validates Python3 installation and directory existence.



