# Python Automations

## Overview
Local Python automation scripts leveraging [VSCode tasks](https://code.visualstudio.com/docs/debugtest/tasks) on macOS to streamline development workflows. These automations include creating and tearing down virtual environments, debugging processes, and integrating with VSCode's task and debugging features.


## Setup Instructions

###  Creating and Destorying Conda Environments
1. Clone this repo at the same file directory level as other python repositories that require a virtual environment.
2. Copy the tasks.json into the same directory as  your VSCode settings.json location. `HOME/Library/Application\ Support/Code/User/settings.json` for macOS. See https://code.visualstudio.com/docs/configure/settings#_settings-file-locations
3. Run `shift + command + p` to open the command pallete
4. Hit `Tasks: Run Task` and select the automation you would like to run. Enter any perliminary parameters if necessary.


Note: for easy access to the global tasks.json file in the future, run `Tasks: Open User Tasks` in the command pallete. See https://stackoverflow.com/questions/76141850/how-can-i-set-a-default-tasks-json-file-for-visual-studio-code


### Attaching Debugger to a current running Process
1. Add the below code to wherever you'd like the execution to pause to allow you to attach to the process, and add a breakpoint where you would like the debugger to pause at.

```python
    import debugpy

    # Start the debugger and listen on a specific port
    debugpy.listen(("localhost", 5678))
    print("Waiting for debugger to attach...") # Optional: Helps you know when to attach
    debugpy.wait_for_client() # Pause execution until the debugger is attached
```
2. Add the following to the .vscode/launch.json file in the repo
```json
    {
      "name": "Python: Attach to Debugger",
      "type": "python",
      "request": "attach",
      "connect": {
        "host": "localhost",
        "port": 5678
      },
      "justMyCode": false
    }
```
3. Make sure you have the python interpreter to the correct conda environment. Open the control pallete, and type `Python: Select Interpreter`. Select the one that pretains to your repo.
4. Run the command in your console. This will pause at your added debugger statement from step 1, and will wait for you to attach the debugger.
5. Click the `Run and Debug` tab in VSCode, and select `Python: Attach to Debugger`
6. You should hit the breakpoint, and be able to step through and interpret the code


### Launching from the Debugger 

1. Add a command following to your `.vscode/launch.json` file similar to the below:
```json
{
    "name": "Python Debugger: Pytest",
    "type": "python",
    "request": "launch",
    "module": "pytest",
    "args": [
        "-v"
    ],
    "cwd": "${workspaceFolder}",
    "console": "integratedTerminal",
    "justMyCode": false
}
``` 
2. Add a breakpoint where you would like the debugger to pause at.
3. Make sure you have the python interpreter to the correct conda environment. Open the control pallete, and type `Python: Select Interpreter`. Select the one that pretains to your repo.
4. Run the command in your console. This will pause at your added debugger statement from step 1, and will wait for you to attach the debugger.
5. Click the `Run and Debug` tab in VSCode, and select your  configuration. In this example, it would be `Python: Attach to Debugger`.