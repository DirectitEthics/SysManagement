Structuring for Organizing Scripts / Files

bash syntax language {

    _system.sh = the ending of any script that relates to administration

    (purpose)_system.sh  = system scripts
}

$ for variables, can be used in 2 ways
! ? < << >> > # 0-9 [ ] 



# Gemini AI Edu Sourced {


    - The: exec &> >(tee -a "$LOG_FILE") 
            line ensures that all output from the script, including both standard output and standard error, is captured and appended to the log file.
            
    - The: >&2 redirection within the script is used to specifically direct error messages to stderr, which are then captured by the initial redirection and logged to the file.


    - Loops / Statements

    Yes, every while loop must end with a done statement, and every if statement must end with a fi statement. These are essential for proper syntax and execution of the script.

Rules for then, else, and elif:

    then: This keyword follows an if condition and indicates the block of code to be executed if the condition is true.
    else: This keyword follows a then block and indicates the block of code to be executed if the condition is false.
    elif: This keyword stands for "else if" and allows you to check additional conditions. It can be used multiple times within an if statement.

Basic Structure:
Bash

if [ condition ]; then
    # Code to be executed if the condition is true
else
    # Code to be executed if the condition is false
fi

while [ condition ]; do
    # Code to be executed repeatedly while the condition is true
done

Use code with caution.

Example:
Bash

#!/bin/bash

# Check if a file exists
if [ -f myfile.txt ]; then
    echo "File exists."
else
    echo "File does not exist."
fi

# Read user input
read -p "Enter a number: " num

# Check if the number is positive
if [ $num -gt 0 ]; then
    echo "Positive number."
elif [ $num -lt 0 ]; then
    echo "Negative number."
else
    echo "Zero."
fi

# Loop until the user enters 'quit'
while true; do
    read -p "Enter a command (quit to exit): " command
    if [ "$command" = "quit" ]; then
        break
    fi
    echo "You entered: $command"
done

    Bash Variables {

General Variables:

$0: The name of the current script.   
$1, $2, ...: The command-line arguments passed to the script.  
$#: The number of command-line arguments.  
$*: All command-line arguments, joined together as a single string.  
$@: All command-line arguments, each in a separate string.
$?: The exit status of the most recently executed command.  
$$: The process ID (PID) of the current script.  
$USER: The username of the user running the script.  
$HOSTNAME: The hostname of the machine.
$PWD: The present working directory.  
$HOME: The home directory of the user.  
$SHELL: The shell being used.
$PATH: The search path for commands.   


Environment Variables:

These are variables that are set by the system or by other programs. You can access them using the $ prefix. Some common environment variables include:

PATH: The search path for commands.   
HOME: The home directory of the user.
USER: The username of the user.
PWD: The present working directory.  
SHELL: The default shell.  

Remember that the values of these variables can vary depending on the system and the environment in which the script is running. You can use the set command to display all the variables and their current values.
 }
}