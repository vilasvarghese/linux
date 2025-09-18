AWK: 
	A Powerful Text Processing Language

awk 
	versatile programming language 
	designed for text processing and data extraction. 
	It's particularly adept at handling structured text files, like 
		logs, 
		CSVs, or 
		command outputs, 
		by breaking them into 
			records (lines) and 
			fields (words). 
	awk is available on virtually all Unix-like systems, including RHEL, Ubuntu, and macOS.

Conclusion

1. What is awk?
	awk is a powerful text-processing programming language that reads input line by line, processes each line based on a set of rules (patterns and actions), and then prints the result. It's a key tool in the Unix philosophy, often used in conjunction with other commands like grep, sed, sort, and cut.

	The name awk comes from the initials of its developers: 
		Alfred Aho, 
		Peter Weinberger, and 
		Brian Kernighan. 
	gawk (GNU awk) is the most common implementation found on Linux systems.

2. How awk Works: The Pattern-Action Paradigm

awk operates on a simple but powerful "pattern-action" model:

'pattern { action }'
For each line of input:

awk checks if the pattern matches the current line.

If the pattern matches (or if no pattern is specified), awk executes the action block.

If no action is specified, awk defaults to printing the entire line ({ print $0 }).

awk automatically divides each input line into fields (words) and records (lines).


Simple examples of awk 
	ps 
	ps | awk '{print $1}'
	ps | awk '{print $2}'
	ps | awk '{print $0}' #no manupulations
	cat /etc/passwd 
	awk -F ":" '{print $1}' /etc/passwd 
	awk -F ":" '{print $1"\t"$6"\t"$7}' /etc/passwd 
		print 1, 6, 7 with a tab 
	awk  'BEGIN{FS=":"} {print $1","$6"\t"$7}' /etc/passwd 
	echo "user:x:1000:/home/user:/bin/bash" | awk 'BEGIN {FS=":"; OFS="-"} {print $1, $3, $5}'
		FS - separator (: will be considered as separator)
		OFS - output separator (in the printed output - would be the separator).
	cat /etc/shells
	awk -F "/" '/^\// {print $NF}' /etc/shells 
		1. -F "/"
			input field separator (FS) to /.
			So each line is split into fields by /.
		
		2. /^\//
			This is a pattern: match lines that start with /.
			In /etc/shells, valid shells always start with / (like /bin/bash, /usr/bin/zsh).

		3. {print $NF}
			$NF = last field in the line (number of fields).


	awk -F "/" '/^\// {print $NF}' /etc/shells | uniq 
	awk -F "/" '/^\// {print $NF}' /etc/shells | uniq | sort 
	df | awk '/\/dev\/loop/  {print $1"\t"$2"\t"$3}'
	

3. Basic awk Syntax

echo -e "Line 1\nLine 2\nLine 3" | awk '{ print }' 

	# Output:
	# Line 1
	# Line 2
	# Line 3
	Here, no pattern is specified, 
		so the action { print } (which defaults to print $0) is performed for every line.

echo -e "Line 1\nLine 2\nLine 3" | awk '/Line 2/ { print }' 


	# Output:
	# Line 2
	Here, /Line 2/ is a regular expression pattern. If a line matches, print is executed.

	Example 3: Print only the pattern (no action specified)

4. Built-in Variables
awk provides several useful built-in variables that store information about the current record and processing environment.


4.1 Record and Field Variables

	$0: The entire current input record (line).
	$1, $2, $3, ...: Individual fields (columns) of the current record.

	NF (Number of Fields): The total number of fields in the current record.
	NR (Number of Records): The current record (line) number being processed.
	FNR: The current record number in the current file (resets for each new file).
	FILENAME: The name of the current input file.

	Example:
	Assume data.txt contains:

	Alice 25 Female
	Bob 30 Male
	Charlie 22 Male

	Bash



	awk '{ print "Line:", NR, "Fields:", NF, "First Field:", $1, "Last Field:", $NF }' data.txt

	awk '{ print "Line:", NR, "Fields:", NF, "First Field:", $1, "Last Field:", $NF }' /etc/passwd
# Output:
# Line: 1 Fields: 3 First Field: Alice Last Field: Female
# Line: 2 Fields: 3 First Field: Bob Last Field: Male
# Line: 3 Fields: 3 First Field: Charlie Last Field: Male



4.2 Separator Variables
FS (Field Separator): The input field separator. Defaults to any whitespace (spaces, tabs, newlines). Can be changed using -F option or in BEGIN block.

OFS (Output Field Separator): The output field separator when print is used with commas between fields. Defaults to a single space.

RS (Record Separator): The input record separator. Defaults to newline character.

ORS (Output Record Separator): The output record separator. Defaults to newline character.

Example: Changing OFS

Bash

awk 'BEGIN { OFS="---" } { print $1, $2, $3 }' data.txt
# Output:
# Alice---25---Female
# Bob---30---Male
# Charlie---22---Male



5. Operators
awk supports various types of operators:

	Arithmetic: +, -, *, /, % (modulo), ^ (exponentiation)

	Relational: == (equal to), != (not equal to), > (greater than), < (less than), >= (greater than or equal to), <= (less than or equal to)

	Logical: && (AND), || (OR), ! (NOT)

	Assignment: =, +=, -=, *=, /=, %=, ^=

	Concatenation: Just placing two strings next to each other (e.g., print $1 $2 will concatenate $1 and $2).

	Regular Expression Matching: ~ (matches), !~ (does not match)

Example:

Bash

echo "apple 10" > fruits.txt
echo "banana 25" >> fruits.txt
echo "cherry 5" >> fruits.txt

awk '$2 > 15 { print $1, "is expensive!" }' fruits.txt
# Output:
# banana is expensive!



6. Conditional Statements (if/else)
awk supports if and if-else statements within action blocks for conditional execution.

Awk

if (condition) {
    action
} else if (condition) {
    action
} else {
    action
}
Example:

Bash

awk '{
    if ($2 > 25) {
        print $1, "is old."
    } else if ($2 < 25) {
        print $1, "is young."
    } else {
        print $1, "is exactly 25."
    }
}' data.txt
# Output:
# Alice is exactly 25.
# Bob is old.
# Charlie is young.



7. Loops (for, while)
awk includes for and while loops for iterating.

for loop (C-style):

Awk

for (i = 1; i <= NF; i++) {
    print $i
}
for loop (for associative arrays - see section 10):

Awk

for (var in array) {
    # do something with array[var]
}
while loop:

Awk

i = 1
while (i <= NF) {
    print $i
    i++
}
Example (iterating through fields):

Bash

echo "one two three four" | awk '{
    for (i = 1; i <= NF; i++) {
        print "Field " i ":", $i
    }
}'
# Output:
# Field 1: one
# Field 2: two
# Field 3: three
# Field 4: four





8. String Functions
awk provides a rich set of string manipulation functions.

length(string): Returns the length of string. If string is omitted, returns length of $0.

substr(string, start, length): Returns a substring.

index(string, substring): Returns the starting position of substring in string, or 0 if not found.

split(string, array, separator): Splits string into elements of array using separator. Returns number of elements.

sub(regexp, replacement, string): Substitutes the first match of regexp in string with replacement. Returns 1 if substituted, 0 otherwise. If string is omitted, it defaults to $0.

gsub(regexp, replacement, string): Global substitute. Substitutes ALL matches of regexp.

tolower(string): Converts string to lowercase.

toupper(string): Converts string to uppercase.

Example:

Bash

echo "Hello World" | awk '{
    print "Length:", length($0)
    print "Substring:", substr($0, 7, 5) # "World"
    print "Index of 'World':", index($0, "World")
    print "Lowercase:", tolower($0)
    gsub(/o/, "X", $0) # Replace all 'o' with 'X'
    print "Modified:", $0
}'
# Output:
# Length: 11
# Substring: World
# Index of 'World': 7
# Lowercase: hello world
# Modified: HellX WXrld




9. Numeric Functions
int(x): Truncates x to an integer.

sqrt(x): Returns the square root of x.

rand(): Returns a pseudo-random floating-point number between 0 and 1.

srand([x]): Seeds the random number generator. If x is omitted, uses the time of day.

Example:

Bash

awk 'BEGIN {
    print "Random number:", rand()
    srand() # Seed with current time
    print "Another random number:", rand()
    print "Integer part of 3.14:", int(3.14)
    print "Square root of 25:", sqrt(25)
}'
# Output (random numbers will vary):
# Random number: 0.814674
# Another random number: 0.123456
# Integer part of 3.14: 3
# Square root of 25: 5



10. Arrays (Associative Arrays)
awk supports associative arrays, which use strings (or numbers) as indices. This is incredibly powerful for counting occurrences, summing values, or storing unique elements.

Awk

array[index] = value
Example: Counting word frequencies

Bash

echo "apple banana apple orange banana apple" | awk '{
    for (i = 1; i <= NF; i++) {
        word_counts[$i]++
    }
}
END {
    for (word in word_counts) {
        print word, word_counts[word]
    }
}'
# Output:
# apple 3
# banana 2
# orange 1



11. Special Patterns (BEGIN, END)
BEGIN { action }: The code inside the BEGIN block is executed once before awk starts reading any input lines. Useful for initializing variables, setting FS/OFS, or printing headers.

END { action }: The code inside the END block is executed once after awk has finished processing all input lines. Useful for printing summary statistics, footers, or final calculations.

Example:

Bash

awk 'BEGIN { print "--- Start of Report ---" }
{ print NR, $0 }
END { print "--- End of Report. Total lines:", NR, "---" }' test.txt
# Output:
# --- Start of Report ---
# 1 Line 1
# 2 Line 2
# 3 Line 3
# --- End of Report. Total lines: 3 ---

12. Executing awk Scripts from a File (-f)
For more complex awk programs, it's better to store the script in a separate file and pass it to awk using the -f option.

Create a script file (e.g., myscript.awk):

Awk

# myscript.awk
BEGIN {
    FS=":" # Example: Process /etc/passwd
    print "User List Report"
    print "----------------"
}
{
    print "User:", $1, "Home:", $6, "Shell:", $NF
}
END {
    print "----------------"
    print "End of Report. Processed", NR, "users."
}
Execute the script:

Bash

awk -f myscript.awk /etc/passwd
13. Examples
Let's use a sample file users.txt:

john:1001:developers:/home/john:/bin/bash
mary:1002:designers:/home/mary:/bin/zsh
peter:1003:developers:/home/peter:/bin/bash
alice:1004:testers:/home/alice:/bin/sh
guest:1005:guests:/home/guest:/sbin/nologin
13.1 Printing Specific Columns
Print username and home directory (assuming colon as separator).

Bash

awk -F':' '{ print "Username:", $1, "Home Dir:", $4 }' users.txt
# Output:
# Username: john Home Dir: /home/john
# Username: mary Home Dir: /home/mary
# Username: peter Home Dir: /home/peter
# Username: alice Home Dir: /home/alice
# Username: guest Home Dir: /home/guest
13.2 Filtering Lines by Pattern
Print lines where the shell is /bin/bash.

Bash

awk '/\/bin\/bash/' users.txt
# Output:
# john:1001:developers:/home/john:/bin/bash
# peter:1003:developers:/home/peter:/bin/bash
13.3 Filtering by Column Value
Print users whose UID is greater than 1002.

Bash

awk -F':' '$2 > 1002 { print $1, $2 }' users.txt
# Output:
# peter 1003
# alice 1004
# guest 1005
13.4 Counting Lines/Records
Count the total number of users.

Bash

awk 'END { print "Total users:", NR }' users.txt
# Output:
# Total users: 5
13.5 Calculating Sums and Averages
Calculate the sum of UIDs (not very meaningful, but demonstrates sum).

Bash

awk -F':' '{ sum_uids += $2 } END { print "Sum of UIDs:", sum_uids }' users.txt
# Output:
# Sum of UIDs: 5015
13.6 Changing Field Separator (e.g., CSV)
Assume grades.csv: Name,Math,Science,English

Alice,85,90,78
Bob,70,65,80
Charlie,95,92,88
Print average score for each student.

Bash

awk -F',' 'NR==1 { next } {
    total_score = $2 + $3 + $4
    average_score = total_score / 3
    print $1, "Average:", average_score
}' grades.csv
# Output:
# Alice Average: 84.3333
# Bob Average: 71.6667
# Charlie Average: 91.6667
13.7 Conditional Formatting
Highlight users in the 'developers' group.

Bash

awk -F':' '{
    if ($3 == "developers") {
        print $1, "(DEVELOPER)"
    } else {
        print $1
    }
}' users.txt
# Output:
# john (DEVELOPER)
# mary
# peter (DEVELOPER)
# alice
# guest
13.8 Using BEGIN and END for Headers/Footers
Bash

awk -F':' 'BEGIN { print "--- User Report ---" }
{ print $1, "\t", $4 }
END { print "--- End of Report. Total users: " NR " ---" }' users.txt
# Output:
# --- User Report ---
# john     /home/john
# mary     /home/mary
# peter    /home/peter
# alice    /home/alice
# guest    /home/guest
# --- End of Report. Total users: 5 ---
13.9 Using Arrays for Unique Counts or Aggregation
Count users per group.

Bash

awk -F':' '{ group_counts[$3]++ }
END {
    print "Users per Group:"
    for (group in group_counts) {
        print "\t" group ":", group_counts[group]
    }
}' users.txt
# Output:
# Users per Group:
# 	developers: 2
# 	designers: 1
# 	testers: 1
# 	guests: 1
13.10 Regex Matching with ~ and !~
Find users whose names start with 'p' or 'P'.

Bash

awk -F':' '$1 ~ /^[Pp]/ { print $1 }' users.txt
# Output:
# peter
Find users whose shell is NOT /bin/bash.

Bash

awk -F':' '$NF !~ /\/bin\/bash/ { print $1, $NF }' users.txt
# Output:
# mary /bin/zsh
# alice /bin/sh
# guest /sbin/nologin
13.11 Using next to Skip Records
Skip the 'guest' user record.

Bash

awk -F':' '{
    if ($1 == "guest") {
        next # Skip to the next record
    }
    print $1, $4
}' users.txt
# Output:
# john /home/john
# mary /home/mary
# peter /home/peter
# alice /home/alice
14. Conclusion
awk is an incredibly powerful and versatile tool for text manipulation. Its pattern-action model, combined with built-in variables, functions, and control structures, makes it ideal for extracting, filtering, reformatting, and summarizing data from structured text files. While it has a learning curve, the investment pays off significantly for anyone working extensively with text-based data on Linux systems.

For more detailed information, consult the awk man page (man awk or info awk) or the GNU Awk User's Guide.