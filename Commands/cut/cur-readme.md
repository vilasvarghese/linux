Markdown

# Linux `cut` Command Tutorial (Detailed)

The `cut` command in Linux is a powerful and specialized utility used for extracting specific sections (columns) from each line of a file or standard input. It operates on delimited data, allowing you to select fields based on character positions, byte positions, or a specified delimiter. It's particularly useful for processing structured text files like CSVs, log files, or `/etc/passwd`.

## Basic Syntax

```bash
cut OPTION... [FILE]...
OPTION: Specifies how to cut the data (e.g., by bytes, characters, or fields).

FILE...: The file(s) to process. If no file is specified, cut reads from standard input.

Key Concepts and Options
cut offers three primary ways to define the sections you want to extract:

By Byte Position (-b): Extracts bytes at specific numerical positions.

By Character Position (-c): Extracts characters at specific numerical positions. This is similar to -b but handles multi-byte characters correctly (e.g., UTF-8).

By Field (-f): Extracts fields (columns) separated by a delimiter. This is the most common use case.

Common Options:
-b LIST (or --bytes=LIST): Selects bytes specified in LIST.

-c LIST (or --characters=LIST): Selects characters specified in LIST.

-f LIST (or --fields=LIST): Selects fields specified in LIST.

-d DELIM (or --delimiter=DELIM): Specifies the field delimiter for -f option. Default is TAB.

--complement: Inverts the selection; prints everything except the specified bytes, characters, or fields.

--output-delimiter=STRING: Specifies the output delimiter when cutting fields. Default is the input delimiter.

The LIST Format:
LIST can be a single number or a range/set of numbers:

N: The Nth byte, character, or field.

N-: From the Nth to the end of the line.

-N: From the beginning of the line to the Nth.

N-M: From the Nth to the Mth (inclusive).

N,M,P: A comma-separated list of individual numbers or ranges.

Examples and Use Cases
Let's assume we have a file named data.txt with the following content:

apple,banana,cherry,date
grape,lemon,mango,nectarine
orange,peach,quince,raspberry
1. Extracting by Field (-f)
This is the most common usage, perfect for CSV-like data.

a) Extract the second field (column):
Bash

cut -f 2 -d ',' data.txt
-f 2: Selects the second field.

-d ',': Specifies that the comma (,) is the field delimiter.

Output:

banana
lemon
peach
b) Extract the first and third fields:
Bash

cut -f 1,3 -d ',' data.txt
Output:

apple,cherry
grape,mango
orange,quince
c) Extract fields from the second to the end:
Bash

cut -f 2- -d ',' data.txt
Output:

banana,cherry,date
lemon,mango,nectarine
peach,quince,raspberry
d) Extract fields from the beginning to the third:
Bash

cut -f -3 -d ',' data.txt
Output:

apple,banana,cherry
grape,lemon,mango
orange,peach,quince
e) Extract all fields except the second:
Using --complement to invert the selection.

Bash

cut -f 2 -d ',' --complement data.txt
Output:

apple,cherry,date
grape,mango,nectarine
orange,quince,raspberry
f) Change the output delimiter:
By default, cut uses the input delimiter for output. You can change this with --output-delimiter.

Bash

cut -f 1,3 -d ',' --output-delimiter=' | ' data.txt
Output:

apple | cherry
grape | mango
orange | quince
2. Extracting by Character Position (-c)
This is useful when data is at fixed positions, or when you need to extract parts of a string.

Let's use a file fixed_width.txt:

Name  ID   Score
John  1234 85
Jane  5678 92
Mark  9012 78
a) Extract characters from position 1 to 4:
Bash

cut -c 1-4 fixed_width.txt
Output:

Name
John
Jane
Mark
b) Extract the 7th and 9th character:
Bash

cut -c 7,9 fixed_width.txt
Output:

I S
1 4
5 2
9 8
(Note: the output might look odd if the characters don't align nicely).

c) Extract characters from the 6th to the end:
Bash

cut -c 6- fixed_width.txt
Output:

 ID   Score
 1234 85
 5678 92
 9012 78
3. Extracting by Byte Position (-b)
Similar to -c, but counts bytes. For ASCII text, -b and -c behave identically. For multi-byte encodings (like UTF-8), -b might cut in the middle of a character, leading to garbled output. Generally, -c is preferred for character-based extraction.

Bash

cut -b 1-4 data.txt
(Same output as cut -c 1-4 data.txt for ASCII data.txt)

4. Reading from Standard Input (Piping)
cut is frequently used in pipelines to process the output of other commands.

a) Extract usernames from /etc/passwd:
The /etc/passwd file uses a colon (:) as a delimiter. The username is the first field.

Bash

cut -d ':' -f 1 /etc/passwd
Output (example):

root
daemon
bin
sys
...
b) Extract specific columns from ls -l output:
Let's get file permissions (field 1) and filename (field 9).

Bash

ls -l | cut -d ' ' -f 1,9 --output-delimiter=' '
Note: ls -l output uses multiple spaces as delimiters, which can be tricky for cut. A better tool for this is often awk. However, if the spacing is consistent (e.g., single spaces as delimiters), it can work. Here we force a single space output delimiter.

More robust way for ls -l (often better with awk):

Bash

ls -l | awk '{print $1, $9}'
c) Get the PID of a specific process:
If you know the command name, you can use pgrep, but ps combined with grep and cut is a classic method.

Bash

ps aux | grep "apache2" | grep -v "grep" | cut -d ' ' -f 2
ps aux: List all processes.

grep "apache2": Filter for lines containing "apache2".

grep -v "grep": Exclude the grep command itself from the results.

cut -d ' ' -f 2: Cut by space delimiter and take the second field (which is the PID in ps aux output).
Caution: The exact field number for PID in ps aux can vary slightly based on system/padding, making this less robust than ps -o pid -C apache2 --no-headers or pgrep apache2.

5. Handling Lines Without Delimiters
By default, if cut -f encounters a line without the specified delimiter, it outputs the entire line.

Bash

echo "no_delimiter_here" | cut -d ',' -f 2
Output:

no_delimiter_here
To suppress lines that don't contain the delimiter, use the -s (or --only-delimited) option:

Bash

echo "no_delimiter_here" | cut -d ',' -f 2 -s
Output:
(empty)

When to use cut?
Simple Column Extraction: When you need to extract specific columns from text files that have a consistent delimiter (e.g., CSV, TSV, log files where fields are fixed).

Fixed-Width Data: When data is aligned in fixed character positions.

Piping and Scripting: Ideal for quick data manipulation in shell scripts or on the command line as part of a pipeline.

Limitations and Alternatives
While powerful, cut has limitations:

Single Character Delimiter: cut can only use a single character as a delimiter. It cannot handle multi-character delimiters (e.g., ;;;).

Whitespace Handling: cut struggles with fields separated by varying amounts of whitespace (e.g., output of ls -l, ps aux). It treats multiple spaces as distinct delimiters, often leading to empty fields.

For more complex parsing, consider these alternatives:

awk: A much more powerful text processing tool that can handle multiple delimiters, varying whitespace, complex logic, and arithmetic. For example, awk -F':' '{print $1}' /etc/passwd is equivalent to cut -d':' -f1 /etc/passwd.

sed: Primarily a stream editor for text transformation, but can also extract parts of lines using regular expressions.

grep -o: Can extract only the matching part of a line (or parts of a line) using regular expressions.

cut remains an excellent choice for straightforward column extraction from consistently delimited files due to its simplicity and efficiency. For anything more complex, awk is usually the better tool.
```