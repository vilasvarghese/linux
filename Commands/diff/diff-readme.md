Markdown

# Linux `diff` Command Tutorial (Detailed)

The `diff` command in Linux is a powerful utility used to compare two files line by line. It analyzes the differences between the files and outputs instructions on how to change the first file to make it identical to the second. `diff` is an indispensable tool for programmers, system administrators, and anyone who needs to track changes between versions of text files.

## Basic Syntax

```bash
diff [OPTIONS] FILE1 FILE2
FILE1: The first file to compare (often considered the "original" or "older" file).

FILE2: The second file to compare (often considered the "modified" or "newer" file).

How diff Works
diff performs a line-by-line comparison. It uses an algorithm (typically a variation of the longest common subsequence problem) to identify the minimal set of changes (additions, deletions, and changes) required to transform FILE1 into FILE2.

Output Formats
diff can produce output in several formats. The default format is called Normal Format.

1. Normal Format (Default)
This format uses specific codes to indicate differences.

Let's create two files:

file1.txt:

Line 1: Apple
Line 2: Banana
Line 3: Cherry
Line 4: Date
Line 5: Elderberry
Line 6: Fig
file2.txt:

Line 1: Apple
Line 2: Grapes
Line 3: Cherry
Line 4: Durian
Line 5: Elderberry
Line 7: Guava
Line 8: Honeydew
Now, run diff:

Bash

diff file1.txt file2.txt
Output:

2c2,4
< Line 2: Banana
---
> Line 2: Grapes
> Line 3: Cherry
> Line 4: Durian
5a7,8
> Line 7: Guava
> Line 8: Honeydew
Explanation of Normal Format Codes:

Each difference block starts with a line indicating the change type and line numbers: [line_num_1][change_type][line_num_2]

c (change): Lines in FILE1 need to be changed to match lines in FILE2.

2c2,4: Line 2 in file1.txt needs to be changed to become lines 2 through 4 in file2.txt.

< prefixed lines are from FILE1.

--- separator.

> prefixed lines are from FILE2.

d (delete): Lines in FILE1 need to be deleted.

Example: 3d2 means delete line 3 from FILE1 to get to line 2 of FILE2.

> prefixed lines are from FILE2 (not applicable for pure deletion from FILE1).

a (add): Lines need to be added to FILE1 to match lines in FILE2.

5a7,8: After line 5 in file1.txt, add lines 7 and 8 from file2.txt.

< prefix for FILE1 (not applicable for a operations as nothing is deleted from FILE1).

--- separator (not applicable for a operations).

> prefixed lines are from FILE2.

2. Context Format (-c)
This format provides a few lines of context around the changes, making it easier to see what changed in relation to the surrounding text. Added lines are prefixed with +, deleted lines with -, and common lines with a space.

Bash

diff -c file1.txt file2.txt
Output:

*** file1.txt	2025-07-26 08:20:10.000000000 +0530
--- file2.txt	2025-07-26 08:20:10.000000000 +0530
***************
*** 1,6 ****
  Line 1: Apple
! Line 2: Banana
  Line 3: Cherry
  Line 4: Date
  Line 5: Elderberry
  Line 6: Fig
--- 1,8 ----
  Line 1: Apple
! Line 2: Grapes
  Line 3: Cherry
+ Line 4: Durian
  Line 5: Elderberry
+ Line 7: Guava
+ Line 8: Honeydew
Explanation:

*** FILE1 and --- FILE2: Indicate the files being compared with their timestamps.

***************: Separator between change blocks.

*** L1,L2 ****: Line numbers in FILE1.

--- L1,L2 ----: Line numbers in FILE2.

Lines starting with a space (     ): Context lines (unchanged).

Lines starting with !: Changed lines (in both files, if diff is combining a deletion and addition into one 'change').

Lines starting with -: Deleted from FILE1.

Lines starting with +: Added in FILE2.

3. Unified Format (-u)
Unified format is the most compact and commonly used format, especially for generating patches (patch command). It combines context and changes into a single block. Added lines are prefixed with +, deleted lines with -, and common lines with a space.

Bash

diff -u file1.txt file2.txt
Output:

--- file1.txt	2025-07-26 08:20:10.000000000 +0530
+++ file2.txt	2025-07-26 08:20:10.000000000 +0530
@@ -1,6 +1,8 @@
 Line 1: Apple
-Line 2: Banana
+Line 2: Grapes
 Line 3: Cherry
-Line 4: Date
+Line 4: Durian
 Line 5: Elderberry
-Line 6: Fig
+Line 7: Guava
+Line 8: Honeydew
Explanation:

--- FILE1 and +++ FILE2: Indicate the files being compared.

@@ -L1,N1 +L2,N2 @@: This is the "hunk header".

-L1,N1: Starts at line L1 in FILE1 and covers N1 lines.

+L2,N2: Starts at line L2 in FILE2 and covers N2 lines.

Lines starting with a space (     ): Context lines (unchanged).

Lines starting with -: Deleted from FILE1.

Lines starting with +: Added in FILE2.

Other Useful diff Options
-r (or --recursive): Recursively compare subdirectories. When comparing directories, diff will compare files with the same name in each directory.

Bash

diff -r dir1 dir2
-q (or --brief): Report only whether files differ, not the details of the differences. Useful for scripting.

Bash

diff -q file1.txt file2.txt
# Output: Files file1.txt and file2.txt differ
-s (or --report-identical-files): Report when two files are identical.

Bash

diff -s file1.txt file1.txt
# Output: Files file1.txt and file1.txt are identical
-i (or --ignore-case): Ignore changes in case when comparing lines.

Bash

diff -i file1.txt file2.txt # 'apple' and 'Apple' would be treated as identical
-w (or --ignore-all-space): Ignore all whitespace changes (spaces and tabs) when comparing lines.

Bash

diff -w file1.txt file2.txt # 'hello world' and 'hello   world' would be identical
-B (or --ignore-blank-lines): Ignore changes where lines are all blank.

Bash

diff -B file1.txt file2.txt # Blank lines added/removed will be ignored
-E (or --ignore-tab-expansion): Ignore changes due to tab expansion.

-b (or --ignore-space-change): Ignore changes in the amount of whitespace. This treats sequences of one or more whitespace characters as equivalent. (e.g., "a b" and "a  b" are same).

-N (or --new-file): Treat absent files as empty. Useful when comparing directories where files might only exist in one of the directories.

Bash

diff -uN dir1 dir2
-a (or --text): Treat all files as text files, even if they appear to be binary. This is important when diff incorrectly identifies a file as binary and refuses to compare it.

-L LABEL (or --label=LABEL): Use LABEL instead of the file name in the output. Useful for creating patches for version control.

Bash

diff -u -L "Old Version" -L "New Version" file1.txt file2.txt
-W NUM (or --width=NUM): Output NUM columns wide. Useful for very wide lines.

Comparing Directories
When using diff with directories, it performs a recursive comparison by default (if -r is used).

Bash

mkdir dir1 dir2
echo "file1 content" > dir1/file1.txt
echo "file2 content old" > dir1/file2.txt
echo "file1 content" > dir2/file1.txt
echo "file2 content new" > dir2/file2.txt
echo "only_in_dir2" > dir2/file3.txt

diff -r dir1 dir2
Output:

diff -r dir1/file2.txt dir2/file2.txt
2c2
< file2 content old
---
> file2 content new
Only in dir2: file3.txt
Creating Patches
The unified format (-u) is specifically designed to create patch files that can be applied using the patch command.

Bash

diff -u original_file.txt modified_file.txt > my_changes.patch
Then, to apply the patch to original_file.txt (assuming original_file.txt is in the current directory):

Bash

patch < my_changes.patch
To revert the patch:

Bash

patch -R < my_changes.patch
When to use diff?
Code Review and Version Control: Essential for understanding changes between different versions of source code files. Version control systems like Git use diff extensively under the hood.

Configuration File Management: Comparing configuration files (e.g., /etc/apache2/apache2.conf) after updates or for troubleshooting.

Troubleshooting: Identifying unexpected changes in log files or output from commands.

Debugging: Pinpointing where an issue might have been introduced in a script or configuration.

Documentation: Generating change logs or documenting updates.

diff is a fundamental and powerful command-line utility for managing text differences in Linux. Its various output formats and options provide flexibility for a wide range of comparison tasks, from simple file comparisons to generating complex patches for collaborative development.

```