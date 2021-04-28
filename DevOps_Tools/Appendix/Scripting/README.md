# DevOps_Proj02_Part02
## Table of contents
* [Overview](#Overview)
* [Usage](#Usage)

## Overview
The repository consists of 2 parts:
* Part 1 - Contains 2 different scripts. The first one just to print a “hello world” message in notepad, and the second one to create a scheduled task that run the first script, disable it after period of time and print the current tasks in a specific format. (This section is divided in parts only for simplicity
* Part 2 - Testing the strength of a given password

## Usage
* Part 1 - Provide the following arguments for the mytask_runner.ps1, which in turn will use mytask.ps1:
	* Name for the created tasks
	* Period of time that will pass before disabling it

Example:
mytask_runner.ps1  -TaskName "genady" -SecToWait 15

* Part 2 - Provide a password for the script and expect for a return value and feedback for the strength of the password.

Example:
./password-validator.sh "MyP@ssw0rd!"

Note - Although the validation works, the feedback may be wrong. This can be happening because of the use of git-bash on windows, instead of using the bash of linux (Line 67 in the script)




