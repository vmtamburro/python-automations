Local python automations using VSCode for macOS

https://code.visualstudio.com/docs/debugtest/tasks

## Setup
1. Clone this repo at the same file directory level as other python repositories that require a virtual environment.
2. Copy the tasks.json into the same directory as  your VSCode settings.json location. `HOME/Library/Application\ Support/Code/User/settings.json` for macOS. See https://code.visualstudio.com/docs/configure/settings#_settings-file-locations
3. Run `shift + command + p` to open the command pallete
4. Hit `Tasks: Run Task` and select the automation you would like to run. Enter any perliminary parameters if necessary.


Note: for easy access to the global tasks.json file in the future, run `Tasks: Open User Tasks` in the command pallete. See https://stackoverflow.com/questions/76141850/how-can-i-set-a-default-tasks-json-file-for-visual-studio-code
