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


### Pre-Commit Git Hooks
This repository includes a git hook that automatically prepends ticket numbers to commit messages based on your branch name. For example, if you are on a branch like chore/ems-12345-add-login, and commit with: 

```
git commit -m "implement user authentication
```

The hook automatically changes your message to:

```
ems-12345 implement user authentication
```

### Setup

1. Copy the hook into your global git hooks directory. `(~/.git-hooks)`
2. Ensure the hook name remains `prepare-commit-msg`, and ensure it is executable with `chmod +x ~/.git-hooks/prepare-commit-msg`
3. Configure git to use global hooks

```
  git config --global core.hooksPath ~/.git-hooks
```

4. Verify the setup

```
# Check if the hook exists and is executable
ls -la ~/.git-hooks/prepare-commit-msg

# Verify Git configuration
git config --global --get core.hooksPath
# Should output: /Users/yourusername/.git-hooks
```

5. Test the hook

```
# Create a test branch with a ticket number
git checkout -b feature/test-123-verify-hook

# Make a commit
echo "test" > test.txt
git add test.txt
git commit -m "testing the hook"

# Check the result
git log -1 --pretty=format:"%s"
# Should show: "test-123 testing the hook"
```