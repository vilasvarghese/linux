Shell scripting is the process of writing programs called scripts that leverage the power of the command-line interface (CLI) to automate tasks on Unix-based operating systems like Linux and macOS.  These scripts essentially act as a series of commands bundled together for efficient execution.

**Why Use Shell Scripting?**

The primary purpose of shell scripting is to streamline repetitive tasks.  Imagine manually copying and renaming dozens of files every day. A shell script can automate this process, saving you time and effort. Here are some key benefits:

- **Automation:** Shell scripts eliminate the need to repeatedly type the same commands, reducing human error and saving valuable time.
- **Efficiency:** Complex tasks involving multiple commands can be executed with a single script, improving workflow efficiency.
- **Customization:** Scripts can be tailored to specific needs, making them highly adaptable for various scenarios.
- **Portability:** In general, shell scripts written for one Unix-like system can run on others with minimal modifications.
- **Resource Management:** Scripts can automate system administration tasks like managing files, processes, and user accounts.

**Common Shells for Scripting**

Several popular shells provide environments for creating and running scripts. Here are a few:

- **Bash (Bourne Again SHell):** The most widely used shell, offering a rich set of features for scripting, including variables, conditional statements (like if/else), and functions. It's the default shell for many Linux distributions.
- **sh (Bourne SHell):** The original Unix shell, considered simpler and lighter than Bash. It's often used for scripting on systems requiring a minimalistic approach.
- **zsh (Z SHell):** An extension of Bash with additional features for customization and a powerful auto-completion function to suggest commands as you type. Popular among power users and developers.
- **ksh (Korn SHell):** Offers advanced scripting capabilities like working with associative arrays (flexible data structures) and complex mathematical operations. Primarily used in Unix environments.

**Example: Automating File Backups**

Here's a simplified example of a shell script that automatically compresses and backs up a directory named "documents" to a folder named "backups":

```bash
#!/bin/bash
# Script to backup documents directory

# Get the current date
date=$(date +%Y-%m-%d)

# Create a compressed backup archive with the date in the filename
tar -czvf backups/documents_$date.tar.gz documents/

echo "Documents backed up successfully to backups/documents_$date.tar.gz"
```

This script demonstrates the basic structure of a shell script with comments explaining each step.

By learning shell scripting, you can unlock the power of automation and simplify your workflow on Unix-based systems.




### **Shell Scripting: Getting Started**

This guide equips you with the basics of creating and running shell scripts on Unix-based systems.

**Choosing a Text Editor:**

Before diving in, you'll need a text editor to write your scripts. Here are some popular options, including a beginner-friendly choice:

- **Classic Editors:**
    - `vi` and `vim`: Powerful but require some learning curve for beginners.
    - `emacs`: Another powerful option with extensive customization possibilities.
- **Modern Editors:**
    - **Visual Studio Code:** Free, user-friendly editor with excellent features for scripting.
    - **Sublime Text:** Popular editor with a clean interface and scripting plugins.
- **Beginner-Friendly:**
    - **nano:** A user-friendly editor pre-installed on most Unix systems, ideal for beginners.

**Creating Your First Script:**

1. **Create a new file:** Open your terminal and use the `nano` command followed by the desired filename (ending in `.sh`):
    
    **Bash**
    
    ```bash
    vim hello.sh
    ```
    
2. **Write your script:** Inside the nano editor, type the commands you want the script to execute, one line per command.

**Example: Printing a Message**

Here's a basic script named `hello.sh` that prints a message:

**Bash**

```bash
#!/bin/bash
echo "Hello, world!"
```

### **Running the Script:**

1. **Make it executable:** Shell scripts need execution permission. Use the `chmod` command:
    
    **Bash**
    
    ```bash
    chmod +x hello.sh
    ```
    
    This grants execute permission for the script owner.
    
2. **Run the script:** There are multiple ways to execute your script (same as before):
    - **From the current directory:**
        
        **Bash**
        
        ```bash
        ./hello.sh
        ```
        
    - **Using the full path:**
        
        **Bash**
        
        ```bash
        /path/to/hello.sh
        ```
        
    - **Specifying the interpreter (optional):**
        
        **Bash**
        
        ```bash
        sh hello.sh  # Assuming Bash is the default shell
        /bin/bash hello.sh
        ```
        
    
    Each command above will execute the script and print "Hello, world!" on your terminal.
    

### **Shebang Line and Permissions:**

The first line of a shell script, often called the shebang line, starts with `#!` followed by the path to the interpreter. This tells the system which program to use to run the script. For Bash scripts, it's typically:

**Bash**

`#!/bin/bash`

**Permissions Explained:**

- `chmod +x script.sh`: This grants execute permission (`x`) to the script owner, allowing it to be run.
- Unix systems have various permissions: Read (`r`), Write (`w`), and Execute (`x`). These can be set for the owner, group, and others.











### Shell Basics

- It's the command-line interpreter acting as your interface to interact with Unix-like operating systems.
- It provides a prompt (`$`) where you type commands to execute.
- Example: `$ ls` lists files and directories in the current directory.

**Shell Variables:**

- Store information that can be accessed by name.
- Assigned values using `=` (no spaces).
- Example: `$ my_var="Hello, World!"`
- Accessed with a `$` prefix: `$ echo $my_var` echoes "Hello, World!"

**Environment Variables:**

- Special shell variables accessible to child processes.
- Store system-wide settings or configuration information.
- Examples: `PATH` (directories to search for commands), `HOME` (user's home directory), `USER` (current user's username).
- **Set Environment Variables with `export`**
- Example: **`export VARIABLE_NAME=variable_value`**

**Command Substitution:**

- Incorporates a command's output as an argument to another command.
- Enclose the command within `$()`.
- Example: `$ echo "Today is $(date)"` prints the current date.

**Command-Line Arguments:**

- Input values provided when executing a script.
- Accessed within the script using `$1`, `$2`, etc.
- Example:

**Bash**

```bash
#!/bin/bash

echo "The first argument is $1"
echo "The second argument is $2"
```

`$  ./my-script Hello World`  # Output: "The first argument is Hello" and "The second argument is World"





Working with Data in Shell Scripting
Shell scripting empowers you to manipulate various data types, including:
Strings: Textual data like names, messages, or file paths.
Integers: Whole numbers used for calculations or counting.
Files: Collections of data stored on disk.
This guide explores how to handle data in your scripts effectively.
Reading and Writing Files:
Reading data: Use cat to display a file's contents entirely or tools like head and tail for specific portions.
Bash
cat input.txt  # Read the entire content of input.txt
head input.txt  # Display the first few lines of input.txt
 
Writing data: Use echo or printf to create new files or append content to existing ones.
Bash
echo "Hello, World!" > output.txt  # Create output.txt with "Hello, World!"
echo "This is appended content." >> output.txt  # Append text to output.txt
 
User Input and Output:
Input: Capture user input using read.
Bash
echo "Enter your name:"
read name
echo "Hello, $name!"  # Use the captured name in a greeting
 
Output: Provide informative messages for the user with echo or the more versatile printf.
Bash
printf "You entered: %s\n" "$name"  # Formatted output with variable insertion
 
Text Manipulation:
Shell scripting offers tools to transform text data:
Substrings: Extract specific portions of a string using string slicing syntax "${variable:start:length}".
Bash
name="Hello, World!"
echo "${name:0:5}"  # Extract the first 5 characters (Hello)
 
Note: if you're referring to the position or length of a substring, those indices start from 0
Replacement: Modify parts of a string with string substitution "${variable/old/new}".
Bash
message="This is an ERROR message."
echo "${message/ERROR/WARNING}"  # Replace "ERROR" with "WARNING"
 
Case conversion: Change the case of text using parameter expansion.
Bash
name="HeLlO WoRlD"
echo $name
echo "${name,,}"  # Convert to lowercase
echo "${name^^}"  # Convert to uppercase
 
Performing Calculations:
Shell scripting provides several ways to perform arithmetic operations on integers:
let command: Assign the result of an expression to a variable.
Bash
let sum=10+20
echo $sum  # Prints: 30
 
expr command: Evaluate an expression and display the result.
Bash
difference=$(expr 50 - 30)
echo $difference  # Prints: 20
 
Double parentheses: Perform arithmetic directly within an echo statement.
Bash
echo $((2 * 5 + 3))  # Prints: 13
 
Working with Arrays:
Arrays store collections of values in an ordered manner. Bash offers two ways to create arrays:
declare -a command: Explicitly declare an array and assign values.
Bash
declare -a fruits=("apple" "banana" "cherry")
echo ${fruits[1]}  # Access the second element (banana)
echo ${fruits[@]}  # Access all the elements
 
Direct assignment: Assign multiple values to an array variable.
Bash
colors=("red" "green" "blue")
echo ${colors[0]}  # Access the first element (red)












Shell Scripting
 
 
Controls Structure 
This guide dives deeper into controlling the flow of your shell scripts using conditional statements and loops.
Conditional Statements (if, elif, else):
Conditional statements allow your script to make decisions based on specific conditions. Here's the syntax:
Bash
#!/bin/bash
if [ condition ]; then
    # Code to execute if condition is true
elif [ condition2 ]; then
    # Code to execute if condition1 is false and condition2 is true (optional)
else
    # Code to execute if both conditions are false (optional)
fi
 
Example:
Bash
#!/bin/bash

number=20
if [[ $number -gt 15 ]]; then
    echo "The number is greater than 15."
elif [[ $number -eq 15 ]]; then
    echo "The number is equal to 15."
else
    echo "The number is less than 15."
fi
 
Loops (for, while, until):
Loops enable repeated execution of code blocks. Here's an overview of common loops:
for loop: Iterates over a sequence of elements.
Bash
#!/bin/bash
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
    echo "I like to eat $fruit."
done
 
while loop: Executes code as long as a condition is true.
Bash
#!/bin/bash
count=1
while [[ $count -le 5 ]]; do
    echo "Iteration: $count"
    count=$((count + 1))  # Increment counter
done
 
until loop: Executes code until a condition becomes true.
Bash
#!/bin/bash
file="data.txt"
until [[ -f $file ]]; do
    echo "Waiting for file: $file"
    sleep 5  # Wait 5 seconds
done
echo "File $file found!"
 
Case Statements:
Case statements provide another way to handle multiple conditions.
Bash
#!/bin/bash

dayOfWeek=$(date +%u)  # Get day of week (1-7)
echo $dayOfWeek

case $dayOfWeek in
  1 )
    echo "Today is Monday."
    ;;
  2 )
    echo "Today is Tuesday."
    ;;
  * )  # Default case (any other day)
    echo "It's a weekday."
    ;;
esac
 
Remember:
Use square brackets [] for condition evaluations in if statements.
Double square brackets [[ ]] offer more flexibility for string comparisons.
Indentation is crucial for defining code blocks within conditionals and loops.
Consider using exit statements to signal script termination with specific codes (e.g., exit 0 for success, exit 1 for error).
By effectively using these control flow constructs, you can create well-structured and dynamic shell scripts!








Functions and Modularization 
This guide explores functions, a cornerstone of well-organized and reusable shell scripts.
Modularizing Code with Functions
Functions are self-contained blocks of code that perform specific tasks. They enhance script maintainability and readability by:
Reusability: A function can be called multiple times from different parts of your script or even from other scripts.
Organization: Functions break down complex tasks into smaller, manageable units.
Readability: Clear function names improve script understanding.
Defining Functions:
The function keyword followed by the function name and parentheses defines a function. Code within curly braces { } executes when the function is called.
Bash
#!/bin/bash
function greet {
    echo "Hello, World"
}

greet   # Call the function 
 
Function Parameters and Arguments
Functions can accept arguments (inputs) passed when you call them.
Inside the function, access these arguments using positional parameters like $1 (first argument), $2 (second argument), and so on.
Example:
Bash
#!/bin/bash
function add {
    local sum=$(( $1 + $2 ))  # Use `local` for local variables
    echo $sum
}

result=$(add 5 10)  # Call the function and capture the "return" value
echo $result        # Prints: 15
 
Simulating Return Values:
While Bash functions don't have built-in return values, you can simulate them by:
Echoing the desired value within the function.
Capturing the output using command substitution $(function_name arguments).
Function Scope and Variable Visibility:
Variables in Bash can be global (accessible throughout the script) or local (limited to the function's scope).
By default, variables are global.
Use the local keyword to declare variables local to a function, preventing them from affecting the global scope.
Example:
Bash
#!/bin/bash
var="global"

function test_var {
    local var="local"
    echo $var  # Prints: local
}

test_var
echo $var  # Prints: global (original value preserved)
 
Key Points:
Functions promote code reusability, organization, and readability.
Pass arguments to functions for customization.
Simulate return values using echo and command substitution.
Control variable scope using local for better data management.
By mastering functions, you can create robust and modular shell scripts that tackle complex tasks efficiently.





Shell Scripting
 
 
File Handling 
Shell Scripting: File I/O and Management
This guide equips you with essential file handling techniques in shell scripting:
Creating and Deleting Files:
touch: Creates an   file.
Bash
#!/bin/bash
touch new_file.txt
 
rm: Deletes a file (use with caution!).
Bash
#!/bin/bash
rm important_file.txt  # Be mindful of what you delete!
 
Reading and Writing Files:
Reading:
cat: Displays the entire content of a file.
Bash
#!/bin/bash
cat message.txt
 
head: Shows the first few lines of a file.
Bash
#!/bin/bash
head -n 3 data.csv  # Display the first 3 lines
 
tail: Displays the last few lines of a file.
Bash
#!/bin/bash
tail -n 2 log.txt  # Display the last 2 lines
 
Directory Operations:
Creating directories:
mkdir: Creates a new directory.
Bash
#!/bin/bash
mkdir new_directory
 
Navigating directories:
cd: Changes the current working directory.
Bash
#!/bin/bash
cd new_directory
 
Deleting directories:
rmdir: Deletes an   directory.
Bash
#!/bin/bash
rmdir new_directory  # Ensure the directory is   before deletion
 
Remember:
Be cautious when using rm to avoid accidental data loss.
Consider using mv (move) to rename or relocate files within the filesystem.
File permissions play a crucial role in system security. Understand permission settings before modifying them.
By mastering these file handling techniques, you can effectively manage data in your shell scripts!






achieve this:

### **Understanding Error Codes and Exit Status:**

- Every shell command returns an exit code upon termination.
- By convention:
    - Exit code of 0 indicates successful execution.
    - Non-zero code signifies an error.
- The special variable `$?` stores the exit code of the last executed command.

**Bash**

```bash
#!/bin/bash

command  # This command might succeed or fail
exit_status=$?

if [[ $exit_status -eq 0 ]]; then
    echo "Command executed successfully."
else
    echo "Error: Command failed with exit code $exit_status."
fi
```

### **Error Trapping (Simulating Try-Catch):**

While Bash doesn't have a native try-catch block, you can achieve similar functionality:

**Bash**

```bash
#!/bin/bash
{
  # Code block to try (put potentially risky commands here)
  command1  # This command might fail
} || {
  # Code block to execute if command1 fails (catch block)
  echo "An error occurred while executing command1."
  # Log the error or take corrective actions
}
```

In this example, if `command1` fails, the code within the `||` block (catch block) executes.

**Using `command` with `set -e` to check if a command inside a command fails**

This approach utilizes the `command` builtin with `set -e`:

**Bash**

```bash
#!/bin/bash
set -e

# Use `command` instead of backticks or double quotes for stricter execution
command date

echo "Time is $(date)"  # This echo will only execute if `date` succeeded
```

Here, `command` ensures the enclosed command (`date`) is executed directly by the shell, bypassing potential shell interpretations. If `date` fails, `set -e` will trigger the script to exit with a non-zero code.

**Debugging Techniques:**

- **`set -x`:** Enables debug mode, printing each command before execution.
- **`echo`:** Print variables and command output to inspect script state at different points.
- **`trap`:** Captures signals like `SIGINT` (Ctrl+C) for cleanup actions before termination.
- **`set -e`:** Exits the script immediately if any command returns a non-zero exit code (strict mode).
- **`set -u`:** Treats unset variables as errors, causing immediate script termination.
- **`set -o pipefail`:** Ensures pipelines exit with a non-zero code if any command within the pipeline fails.

**Additional Tips:**

- Use meaningful variable and function names to improve script readability.
- Add comments to explain complex logic or code sections.
- Test your scripts with various inputs and scenarios to uncover potential errors.
- Consider using logging mechanisms to record script execution details for further analysis.

By effectively implementing error handling and debugging practices, you can create reliable and robust shell scripts!















Advanced Scripting Techniques  
Shell Scripting Advanced Techniques with Practical Examples
This guide empowers you with advanced shell scripting techniques, along with practical examples to elevate your scripts:
Functions and Modules: Break down complex logic into reusable functions and modular components for better organization and maintainability.
Input/Output Redirection: Master redirection operators (>, >>, <, |) to control data flow between commands, files, and the shell.
Command-Line Argument Parsing: Effectively process arguments passed to your script, enabling dynamic behavior based on user input.
String Manipulation: Utilize techniques like cut, sed, awk, and parameter expansion for advanced text processing and manipulation.
Regular Expressions (RegEx): Unleash the power of RegEx patterns to match complex text patterns within files and data streams.
Arrays and Associative Arrays: Store and manage collections of data using indexed arrays and associative arrays (key-value pairs) for efficient data organization.







Scripts(Part-1) 
1.
Introduction to Shell Scripting: System Info Script
#!/bin/bash 
# A simple script to print system information 
 
echo "System Information" 
echo "==================" 
echo "Hostname: $(hostname)" 
echo "Current Date and Time: $(date)" 
echo "System Uptime: $(uptime -p)" 
echo "Logged in Users: $(who)"
This script uses basic commands like hostname, date, uptime, and who to print system information. It's a good starting point for beginners to understand how shell scripts can execute common commands and display their output. 
Let me know if you would like to proceed with the next scripts or if you have specific requirements for each script.
2.
Getting Started with Shell Scripting: Basic Script with Shebang Line and Permissions
This script will demonstrate the basic structure of a shell script, including the shebang line, making the script executable, and producing a simple output.
#!/bin/bash 
# This is a basic shell script with a shebang line and simple output 
 
# Display a welcome message 
echo "Welcome to Shell Scripting!" 
 
# Display the current directory 
echo "You are currently in the directory: $(pwd)"
Explanation: 
• Shebang Line (#!/bin/bash): This is the first line of the script. It tells the system that this script should be run in the bash shell. 
• Comments (#): Lines starting with # are comments and are not executed. They are used to explain what the script or a part of the script does. 
• echo command: This command is used to display lines of text or script variables. Here, it's used to print a welcome message and the current working directory (using $(pwd)). 
How to Use: 
1. Create the Script: Copy the above script into a text editor. 
2. Save the Script: Save it as welcome_script.sh or any other name you prefer, with a .sh extension. 
3. Make it Executable: Before running the script, you need to make it executable. This is done via the command line with the command chmod +x welcome_script.sh. 
4. Run the Script: After making it executable, you can run the script by typing ./welcome_script.sh in the terminal. 
This script is a basic example to get you started with shell scripting, demonstrating the essential components like the shebang line and simple output generation. Let me know if you need scripts for other topics from your list!
3.
Shell Basics: A script showing the use of shell variables and command-line arguments.
This script will illustrate the use of shell variables and how to handle command-line arguments in a script.
#!/bin/bash 
# This script demonstrates the use of shell variables and command-line arguments 
 
# Define a shell variable 
greeting="Hello" 
 
# Display the greeting with the first command-line argument 
echo "$greeting, $1!" 
 
# Check if a second argument is provided 
if [ -n "$2" ]; then 
    echo "You also mentioned '$2'." 
else 
    echo "No second argument was provided." 
fi 
 
# Display the total number of arguments passed to the script 
echo "Total number of arguments: $#"
Explanation: 
• Shell Variable (greeting): A variable greeting is defined with the value "Hello". 
• First Command-Line Argument ($1): The script uses $1 to refer to the first argument passed to it. For example, if you run ./script.sh World, World becomes $1. 
• Conditional Statement (if [ -n "$2" ]): This checks if a second argument is provided. $2 refers to the second command-line argument. 
• Total Number of Arguments ($#): This special variable contains the number of arguments passed to the script.
How to Use: 
1. Save the Script: Copy and save this script in a file, for example, greeting_script.sh. 
2. Make it Executable: Use the command chmod +x greeting_script.sh to make it executable. 
3. Run the Script: Execute the script with command-line arguments, like ./greeting_script.sh User OptionalSecondArg. 
This script provides a basic introduction to using shell variables and handling command-line arguments, both of which are fundamental concepts in shell scripting. Feel free to reach out if you need examples for more advanced topics or other areas from your guide!
4
Control Structures: A script with conditional statements and loops.
#!/bin/bash 
# This script demonstrates the use of conditional statements and loops 
 
# Ask for a number 
read -p "Enter a number (1-5): " number 
 
# Conditional Statement: Check if the number is within the range 
if [ "$number" -ge 1 ] && [ "$number" -le 5 ]; then 
    echo "Your number is within the range 1-5." 
else 
    echo "Your number is out of range." 
    exit 1 
fi 
 
# While Loop: Count down from the number to 1 
echo "Countdown from $number to 1:" 
while [ $number -gt 0 ]; do 
    echo "$number" 
    ((number--)) 
done 
 
# For Loop: Display some multiplication 
echo "Multiplication table for 3:" 
for i in {1..5}; do 
    echo "3 x $i = $((3 * i))" 
done
Explanation: 
• Read User Input (read -p): The script starts by asking the user to enter a number. 
• Conditional Statement (if): The if statement checks if the number is between 1 and 5. 
• While Loop: If the number is in range, the script counts down from that number to 1 using a while loop. 
• For Loop: After the countdown, it uses a for loop to print a small multiplication table for the number 3.
How to Use: 
1. Create and Save the Script: Copy this script into a text file, for example, control_structures.sh. 
2. Make the Script Executable: Change the script's permissions with chmod +x control_structures.sh. 
3. Run the Script: Execute the script by typing ./control_structures.sh and following the prompt to enter a number. 
This script offers a basic understanding of how conditional statements and loops work in shell scripting. These structures are essential for creating dynamic and interactive scripts. Let me know if you need scripts covering other topics from your list!
1. 
Working with Data: Script Demonstrating Arrays and Arithmetic Operations
This script will show how to use arrays and perform basic arithmetic operations in shell scripting.
#!/bin/bash 
# This script demonstrates the use of arrays and arithmetic operations 
 
# Define an array of numbers 
numbers=(10 20 30 40 50) 
 
# Display the array elements 
echo "Array elements: ${numbers[@]}" 
 
# Sum up the array elements 
sum=0 
for num in "${numbers[@]}"; do 
    sum=$((sum + num)) 
done 
echo "Sum of array elements: $sum" 
 
# Multiply array elements by a factor 
factor=2 
echo "Array elements multiplied by $factor:" 
for num in "${numbers[@]}"; do 
    echo "$((num * factor))" 
done 
 
# Find the average of array elements 
average=$((sum / ${#numbers[@]})) 
echo "Average of array elements: $average"
Explanation: 
• Array Initialization: The script begins by defining an array numbers with a set of integers. 
• Display Array Elements: Using ${numbers[@]}, the script prints all elements of the array. 
• Summing Array Elements: A for loop iterates over the array, adding each element to sum. 
• Multiplying Elements: Another loop multiplies each element by a specified factor (2 in this case). 
• Average Calculation: The script calculates the average of the array elements.
How to Use: 
1. Save the Script: Copy the above script into a text file, like data_operations.sh. 
2. Make It Executable: Use the command chmod +x data_operations.sh. 
3. Run the Script: Execute it with ./data_operations.sh. 
This script offers a basic introduction to handling arrays and performing arithmetic operations in shell scripting, which are key for data manipulation and processing tasks. Feel free to ask for more examples or scripts covering other topics in your guide!




# Scripts(Part-2)

| 6. | Functions and Modularization: A script defining and using a function with parameters. |  |  |
| --- | --- | --- | --- |
|  | This script will demonstrate how to define and use a function with parameters in shell scripting. 
 |  |  |
|  | #!/bin/bash 
# This script demonstrates defining and using functions with parameters 
 
# Function to greet a user 
greet_user() { 
    local name=$1 
    echo "Hello, $name!" 
} 
 
# Function to calculate the square of a number 
calculate_square() { 
    local number=$1 
    echo "$((number * number))" 
} 
 
# Calling the greet_user function 
greet_user "Alice" 
 
# Calling the calculate_square function and capturing the result 
square=$(calculate_square 4) 
echo "Square of 4 is: $square" |  |  |
|  | Explanation: 
• Function Definition: The script defines two functions: greet_user and calculate_square. 
• local Keyword: Inside the functions, local keyword is used to declare function-local variables. 
• Function Parameters: The first parameter passed to the function is accessed via $1. 
• Calling Functions: The functions are then called with specific arguments. 
• Capturing Function Output: The output of calculate_square is captured in a variable square. |  |  |
|  | How to Use: 
1. Create the Script: Copy the script into a file, say functions_demo.sh. 
2. Make it Executable: Run chmod +x functions_demo.sh to make it executable. 
3. Execute the Script: Run it using ./functions_demo.sh. 
This script is a basic introduction to using functions in shell scripts, an essential aspect of script modularization and reuse. Functions make scripts more organized and easier to maintain, especially for complex tasks. If you have any more specific requirements or need scripts for other topics, feel free to ask! |  |  |
| 1.  | File Handling: Script for Reading from and Writing to a File |  |  |
|  | This script will demonstrate how to read from and write to a file, along with performing some basic file operations in shell scripting. |  |  |
|  | #!/bin/bash 
# This script demonstrates file reading, writing, and basic file operations 
 
# Name of the file to use 
filename="sample.txt" 
 
# Check if the file exists, if not create it 
if [ ! -f "$filename" ]; then 
    echo "Creating $filename as it does not exist." 
    touch "$filename" 
fi 
 
# Write to the file 
echo "Writing to $filename." 
echo "This is a sample text file." > "$filename" 
echo "It contains some sample text." >> "$filename" 
 
# Read and display the contents of the file 
echo "Reading from $filename:" 
while IFS= read -r line; do 
    echo "$line" 
done < "$filename" 
 
# Append more text to the file 
echo "Appending more text to $filename." 
echo "This is another line of text." >> "$filename" 
 
# Display the updated file content 
echo "Updated content of $filename:" 
cat "$filename" 
 
# Delete the file (uncomment to enable) 
# rm "$filename" 
# echo "$filename has been deleted." |  |  |
|  | Explanation: 
• File Check and Creation: The script first checks if the specified file exists. If not, it creates the file using touch. 
• Writing to a File: It writes and appends text to the file using > and >> redirection operators. 
• Reading from a File: The script reads and displays the file content using a while loop and read command. 
• Appending Text: It appends additional text to the file. 
• Displaying Updated Content: The updated file content is displayed using cat. 
• File Deletion: The script includes a commented out command to delete the file. Uncommenting rm "$filename" will delete the file. |  |  |
|  | How to Use: 
1. Save the Script: Copy this into a file, for instance, file_handling.sh. 
2. Make It Executable: Use chmod +x file_handling.sh to make it executable. 
3. Run the Script: Execute it with ./file_handling.sh. 
This script provides a basic understanding of file handling operations in shell scripting, such as creating, reading, writing, and appending files. If you need more complex examples or scripts for other topics, feel free to let me know! |  |  |
| 8. | Error Handling and Debugging: Script with Error Trapping and Exit Status |  |  |
|  | #!/bin/bash 
# This script demonstrates error trapping and exit status handling 
 
# Function to read a file 
read_file() { 
    local file=$1 
    if [ ! -f "$file" ]; then 
        echo "Error: File '$file' not found." 
        return 1 # Return with an error status 
    fi 
 
    echo "Reading file '$file':" 
    cat "$file" 
    return 0 # Return with a success status 
} 
 
# File to read 
filename="example.txt" 
 
# Error trap 
trap 'echo "An error occurred."; exit 1' ERR 
 
# Attempt to read the file 
read_file "$filename" 
 
# Check the exit status 
if [ $? -eq 0 ]; then 
    echo "File read successfully." 
else 
    echo "Failed to read the file." 
fi |  |  |
|  | Explanation: 
• Function read_file: This function attempts to read a file and checks if the file exists. If the file is not found, it returns an error status (1). 
• Error Trap (trap): The trap command catches any errors that occur during the execution of the script. In this case, if an error occurs, a message is displayed and the script exits with status 1. 
• Exit Status Check ($?): After calling read_file, the script checks the exit status ($?). If it's 0, the file was read successfully; otherwise, it indicates failure. |  |  |
|  | How to Use: 
1. Create the Script: Copy the script into a file, for example, error_handling.sh. 
2. Make it Executable: Change the script's permissions with chmod +x error_handling.sh. 
3. Run the Script: Execute the script by typing ./error_handling.sh. 
This script provides a basic introduction to error handling and debugging in shell scripts, particularly focusing on trapping errors and working with exit statuses. Advanced scripts often include more sophisticated error handling mechanisms to ensure robustness and reliability. If you need further examples or have other topics to cover, feel free to ask! |  |  |
| 9. | Advanced Scripting Techniques: Script Utilizing Regular Expressions and Pattern Matching |  |  |
|  | This script will demonstrate the use of regular expressions and pattern matching in shell scripting, particularly for text processing tasks. |  |  |
|  | #!/bin/bash 
# This script demonstrates the use of regular expressions and pattern matching 
 
# Function to validate email format 
validate_email() { 
    local email=$1 
    local regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$" 
 
    if [[ $email =~ $regex ]]; then 
        echo "Valid email format." 
    else 
        echo "Invalid email format." 
    fi 
} 
 
# Function to extract phone numbers from a text 
extract_phone_numbers() { 
    local text=$1 
    local phone_regex="([0-9]{3}-[0-9]{3}-[0-9]{4})" 
 
    echo "Extracted phone numbers:" 
    while read -r line; do 
        if [[ $line =~ $phone_regex ]]; then 
            echo "${BASH_REMATCH[1]}" 
        fi 
    done <<< "$text" 
} 
 
# Validate email example 
email="example@email.com" 
echo "Validating email: $email" 
validate_email "$email" 
 
# Extract phone numbers example 
sample_text="Call me at 123-456-7890 or at 987-654-3210." 
echo "Extracting phone numbers from text:" 
extract_phone_numbers "$sample_text" |  |  |
|  | Explanation: 
• Function validate_email: This function uses a regular expression to validate the format of an email address. It employs the =~ operator for pattern matching in bash. 
• Function extract_phone_numbers: This function demonstrates how to extract phone numbers from a given text using regular expressions. It reads through lines of text and matches the pattern defined in phone_regex. |  |  |
|  | How to Use: 
1. Save the Script: Copy this script into a file, like regex_demo.sh. 
2. Make It Executable: Use chmod +x regex_demo.sh to make it executable. 
3. Run the Script: Execute it with ./regex_demo.sh. 
This script offers a glimpse into advanced scripting techniques involving regular expressions, which are powerful for text processing and pattern matching. Shell scripting provides robust tools for these tasks, making it useful for a wide range of applications. If you're interested in more advanced examples or scripts for other topics, feel free to let me know! |  |  |
| 1.  | Working with External Commands: A script showing the use of command execution and pipelines. |  |  |
|  | #!/bin/bash 
# This script demonstrates the execution of external commands and the use of pipelines 
 
# Function to find and display processes running a specific command 
display_processes() { 
    local command_name=$1 
    echo "Processes running '$command_name':" 
    ps aux | grep "$command_name" | grep -v grep 
} 
 
# Function to count the number of lines in a file 
count_file_lines() { 
    local file=$1 
    local line_count=$(wc -l < "$file") 
    echo "The file '$file' contains $line_count lines." 
} 
 
# Display processes for a given command 
command_to_check="bash" 
display_processes "$command_to_check" 
 
# Count the number of lines in a file 
file_to_check="sample.txt" 
count_file_lines "$file_to_check" |  |  |
|  | Explanation: 
• Function display_processes: This function uses ps aux to list all running processes, then filters them with grep to find processes related to a specific command. The grep -v grep part is used to exclude the grep command itself from the results. 
• Pipelines (|): The script uses pipelines to pass the output of one command (ps aux) as input to another command (grep). 
• Function count_file_lines: This function demonstrates how to use command substitution ($(...)) to capture the output of a command (wc -l) and then uses it in a script. |  |  |
|  | How to Use: 
1. Save the Script: Copy this script into a file, like external_commands.sh. 
2. Make It Executable: Change the permissions with chmod +x external_commands.sh. 
3. Run the Script: Execute it with ./external_commands.sh. 
This script provides a basic overview of using external commands and pipelines, which are fundamental concepts in shell scripting for processing and manipulating data streams. If you need more detailed scripts or have other topics you'd like to cover, feel free to ask! |  |  |














# Scripts(Part-3)

| 1. | System Health Check Script |  |
| --- | --- | --- |
|  | #!/bin/bash 
# System Health Check Script 
echo "CPU and Memory Usage:" 
top -bn1 | head -5 
echo "Disk Usage:" 
df -h 
echo "Active Network Connections:" 
netstat -tuln |  |
|  | Purpose: Regular health checks on servers for CPU, memory, disk, and network. |  |
| 2. | Backup Script |  |
|  | #!/bin/bash 
# Backup Script 
tar -czf /backup/$(date +%Y%m%d_%H%M%S)_backup.tar.gz /important/data |  |
|  | Purpose: Automated backup of critical directories. |  |
| 3. | 3. Log File Cleaner |  |
|  | #!/bin/bash 
# Log File Cleaner 
find /var/log -name "*.log" -type f -mtime +30 -exec rm -f {} \; |  |
|  | Purpose: Cleanup old log files and free up space. |  |
| 1.  | Deployment Script |  |
|  | #!/bin/bash 
# Deployment Script 
git pull origin main 
npm install 
npm run build 
systemctl restart myapp |  |
|  | Purpose: Pull the latest code, build, and restart the application. |  |
| 1.  | 5. SSL Certificate Expiry Check |  |
|  | #!/bin/bash 
# SSL Certificate Expiry Check 
echo | openssl s_client -servername example.com -connect example.com:443 2>/dev/null | openssl x509 -noout -dates |  |
|  | Purpose: Check SSL certificate expiry dates. |  |
| 1.  | Docker Container Health Check |  |
|  | #!/bin/bash 
# Docker Container Health Check 
docker ps -q | xargs docker inspect --format '{{ .Id }}: Health={{ .State.Health.Status }}' |  |
|  | Purpose: Monitor the health status of all running Docker containers. |  |
| 1.  | Network Latency Test |  |
|  | #!/bin/bash 
# Network Latency Test 
ping -c 4 google.com |  |
|  | Purpose: Simple network latency test to an external site. |  |
| 8. | Database Backup Script |  |
|  | #!/bin/bash 
# Database Backup Script 
mysqldump -u root -p mydatabase > /backup/mydatabase_$(date +%Y%m%d).sql |  |
|  | Purpose: Backing up a MySQL database |  |
| 1.  | User Account Audit |  |
|  | #!/bin/bash 
# User Account Audit 
cut -d: -f1 /etc/passwd |  |
| 1.  | Service Monitoring Script |  |
|  | #!/bin/bash 
# Service Monitoring Script 
systemctl status myservice |  |
|  | Purpose: Check the status of a specific service |  |
|  |  |  |





# Scripts(Part-4)

|  | 11. Checking Disk Space |  |  |
| --- | --- | --- | --- |
|  | #!/bin/bash 
# Check Disk Space Usage 
df -h | grep -vE '^Filesystem|tmpfs|cdrom' |  |  |
|  | 12. Monitoring CPU Load |  |  |
|  | #!/bin/bash 
# Monitor CPU Load 
uptime |  |  |
|  | 13. Restarting a Service if Not Running |  |  |
|  | #!/bin/bash 
# Restart a Service if it's Not Running 
service=my_service 
if ! systemctl is-active --quiet $service; then 
    systemctl restart $service 
fi |  |  |
|  | 14. Checking for Open Ports |  |  |
|  | #!/bin/bash 
# Check Open Ports 
netstat -tulnp |  |  |
|  | 15.Updating System Packages |  |  |
|  | #!/bin/bash 
# Update System Packages 
sudo apt-get update && sudo apt-get upgrade -y |  |  |
|  | 16.Syncing Files with Remote Server |  |  |
|  | #!/bin/bash 
# Sync Files with Remote Server 
rsync -avz /local/directory/ user@remote:/remote/directory/ |  |  |
|  | 17. Checking Website Availability |  |  |
|  | #!/bin/bash 
# Check Website Availability 
curl -Is http://www.example.com/ | head -n 1 |  |  |
|  | 18. Database Health Check |  |  |
|  | #!/bin/bash 
# Check MySQL Database Health 
mysqladmin -u root -p status |  |  |
|  | 19. Extracting Logs for a Specific Date |  |  |
|  | #!/bin/bash 
# Extract Logs for a Specific Date 
grep '2023-03-15' /var/log/myapp.log |  |  |
|  | 20.Listing Large Files |  |  |
|  | #!/bin/bash 
# List Large Files 
find / -type f -size +100M |  |  |







|  | 21. Monitoring Memory Usage |  |  |
| --- | --- | --- | --- |
|  | #!/bin/bash 
# Monitor Memory Usage 
free -m |  |  |
|  | 22. Checking HTTP Headers of a Website |  |  |
|  | #!/bin/bash 
# Check HTTP Headers 
curl -I http://www.example.com/ |  |  |
|  | 23. Automating SSH into Server |  |  |
|  | #!/bin/bash 
# Automating SSH 
ssh user@server 'bash -s' < local_script.sh |  |  |
|  | 24. Creating a User Account |  |  |
|  | #!/bin/bash 
# Creating a User Account 
sudo useradd -m newuser |  |  |
|  | 25. Killing a Process by Name |  |  |
|  | #!/bin/bash 
# Kill a Process by Name 
pkill -f process_name |  |  |
|  | 26. Checking Inode Usage |  |  |
|  | #!/bin/bash 
# Check Inode Usage 
df -i |  |  |
|  | 27. Displaying Open Files by a Process |  |  |
|  | #!/bin/bash 
# Display Open Files by a Process 
lsof -p PID |  |  |
|  | 28. Automated FTP Upload |  |  |
|  | #!/bin/bash 
# Automated FTP Upload 
ftp -n <<EOF 
open http://ftp.example.com/ 
user username password 
put local_file.txt remote_file.txt 
quit 
EOF |  |  |
|  | 29. Checking Server Uptime |  |  |
|  | #!/bin/bash 
# Check Server Uptime 
uptime -p |  |  |
|  | 30. Archiving Old Logs |  |  |
|  | #!/bin/bash 
# Archive Old Logs 
tar -czf logs-$(date +%Y%m%d).tar.gz /var/log/myapp/ |  |  |
|  |  |  |  |







## Level 100

1. **Time Announcer:** Write a script that displays a personalized greeting along with the current time every minute. For example, "Good morning, Alice! It's Wednesday, 27 March 2024 11:15 AM." (Use `date` and a loop to update every minute).

2. **System Uptime Monitor:** Write a script that displays the system uptime and refreshes it every 5 seconds. Use the `uptime` command and a loop to achieve real-time updating.

3. **Interactive File Size Check:** Write a script that prompts the user for a file path and displays the file size in real-time as the user types (using backspace for corrections). Employ the `read` command and the `du -s` command to check size.

4. **Countdown with User Input:** Write a script that asks the user for a duration in seconds and displays a countdown timer that updates every second until it reaches zero. Combine a loop with the `sleep` command for real-time updates.

5. **Interactive Currency Converter:** Write a script that prompts the user for an amount in their local currency and displays the equivalent value in another currency. Use a loop for continuous input and consider APIs for real-time conversion rates (may require additional research).

6. **Simple File Change Monitor:** Write a script that monitors a specific file for changes. If the file modification time changes, the script displays a message indicating the file has been modified. Use the `stat` command for comparisons.

7. **Real-Time Fortune Teller (Simple):** Write a script that displays a random fortune message. Use a loop and pre-defined fortunes stored in an array for real-time display.

8. **Simple System Info Display:** Write a script that displays essential system information like the current user, hostname, and operating system version in real-time. Update the script to display this information periodically (e.g., every minute). (Use commands like `whoami`, `hostname`, and `uname -r` to retrieve the information).

9. **Free Disk Space Monitor:** Write a script that checks the free disk space on a specific partition  (e.g., `/`) and displays the available space in megabytes (MB) or gigabytes (GB). Update the information periodically (e.g., every minute) using a loop.

10. **Simple File Watcher:** Write a script that monitors a specific file for changes (modifications). Use a loop to check the file's last modified time and display a message if it has been updated since the script started.

1. **Network Health Monitoring Tool**

Objective: Create a script that checks the network health of your server. It should ping a set of predefined IPs or domain names and report any failures along with the timestamp. The script should log this information and send an alert (e.g., via email) if any of the pings fail.

1. **Log File Analyzer**

Develop a script that analyzes a specified log file (e.g., Apache or Nginx access log) and extracts information such as the most frequent IP addresses and request URLs. The script should also identify any error codes (like 404 or 500) and count their occurrences.

1. **User Account and Permission Audit Script**

Objective: Create a script that audits user accounts and file permissions in a system. The script should list all users, their last login time, and check for any files in sensitive directories (like /etc or /var) with permissions that are too permissive (e.g., world-writable files).

## Level 200-300

1. **Interactive System Resource Monitor (Graphical):** Write a script that monitors CPU, memory, and network usage. Utilize libraries like `ncurses` to display them in a user-configurable graphical format (e.g., bar charts, gauges). Allow users to choose the refresh rate and potentially switch between different display modes.

**2. Service Monitoring Script**: Develop a script that monitors critical system services (e.g., Apache, SSH, MySQL) and restarts them automatically if they are found to be down. Include logging functionality to record service status changes.

**3. User Account Management Tool**: Build a shell script for managing user accounts on a Linux system. The script should allow administrators to add, modify, and delete user accounts, set password policies, and manage user permissions.

4. **File Encryption/Decryption Tool**: Develop a shell script that encrypts and decrypts files using symmetric encryption algorithms (e.g., AES). Ensure that the script prompts the user for a passphrase and supports options for both encryption and decryption.

**5. Database Backup and Restore**: Develop a shell script that automates the backup and restore process for databases such as MySQL or PostgreSQL. The script should dump the database contents, compress them, and store them securely. It should also be able to restore databases from backup files.

## Cron Job Assignment

1. **Traffic Monitoring:**
    - Task: Run a script every 5 minutes to collect network traffic statistics. If the incoming traffic exceeds a certain threshold for three consecutive checks, send an email alert to the network administrator.
    - Focus: Scripting logic, conditional cron execution, persistence for traffic tracking.
2. **Emailing System Logs:**
    - Task: Set up a cron job to compress system logs daily at 2:30 AM, delete compressed log files older than 30 days, and email a report of successful and failed compressions to the system administrator.
    - Focus: File manipulation, error handling, email integration
	
	
	
	