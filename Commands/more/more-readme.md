Markdown

# Linux `more` Command Tutorial (Detailed)

The `more` command in Linux is a pager program, similar to `less`, used for viewing the contents of text files or output from other commands one screenful at a time. It's a simpler and older pager compared to `less`, offering basic navigation capabilities. While `less` has largely superseded `more` due to its enhanced features (especially scrolling backward), `more` is still widely available and useful for quick viewing.

## Basic Syntax

```bash
more [OPTIONS] FILE...
more [OPTIONS] < COMMAND_OUTPUT
OPTIONS: Control more's behavior (e.g., line numbers, squeezing blank lines).

FILE...: One or more files to view.

COMMAND_OUTPUT: The standard output of another command, piped into more.

How more Works
more reads its input (either from a file or from a pipe) and displays it page by page. It pauses after each full screen, waiting for user input to display the next portion of the content.

The key limitation of more compared to less is its "forward-only" nature by default. Once you've scrolled past a line, you generally cannot scroll back up to it.

Interactive Commands within more
Once more is open, you can use these keys:

Spacebar / f: Scroll forward one full screen (or a specified number of lines).

Enter / j / Down Arrow: Scroll forward one line.

d: Scroll forward half a screen.

h: Display help screen (list of commands).

/pattern: Search forward for pattern. Press n for next match.

q: Quit more.

=: Display the current line number.

: followed by a command (e.g., :n, :p): Commands for navigating multiple files.

:n: Go to the next file (if multiple files were specified on the command line).

:p: Go to the previous file.

:f: Display the current filename and line number.

b (or Ctrl+B): This command allows backward scrolling in some more implementations (e.g., GNU more) but is not universally supported or as robust as less. If supported, it scrolls backward one screen.

Common Options
-num: Specifies the number of lines per screen (page). For example, more -20 would display 20 lines at a time.

-d: Display prompts like "[Press space to continue, 'q' to quit.]" and "[Press 'h' for instructions.]" instead of simply beeping or showing ---More---. Useful for beginners.

-f: Count logical lines, rather than screen lines (i.e., don't wrap long lines). This can make navigation more predictable for very long lines.

-l: Suppress pausing after form feeds (^L).

-p: Clear the screen before displaying each page.

-c: Do not scroll. Display output by clearing the rest of the screen and then redrawing it.

-s (or --squeeze-blank-lines): Squeeze multiple blank lines into a single blank line. Very useful for cleaning up formatted text.

-u: Suppress underlining. (Less relevant for modern terminals).

+num: Start displaying the file at line num.

+/pattern: Start displaying the file at two lines before the first occurrence of pattern.

Examples and Use Cases
Let's assume you have a file named sample.txt with some content:

Line 1: Apple
Line 2: Banana
Line 3: Cherry
Line 4: Date
Line 5: Elderberry
Line 6: Fig
Line 7: Grape
Line 8: Honeydew
Line 9: Ice Cream
Line 10: Jackfruit
Line 11: Kiwi
Line 12: Lemon
Line 13: Mango
Line 14: Nectarine
Line 15: Orange
Line 16: Papaya
Line 17: Quince
Line 18: Raspberry
Line 19: Strawberry
Line 20: Tangerine
Line 21: Ugly Fruit
Line 22: Vanilla
Line 23: Watermelon
Line 24: Xigua
Line 25: Yam
Line 26: Zucchini
And another file another_file.txt.

1. Basic File Viewing
Bash

more sample.txt
This will open sample.txt and display the first screenful of content (determined by your terminal height). You'll see ---More--- or similar at the bottom.

2. Paging by a Specific Number of Lines
To view 5 lines at a time:

Bash

more -5 sample.txt
more will display the first 5 lines. Press Spacebar to see the next 5 lines. Press Enter to see 1 line.

3. Displaying Prompts (-d)
Helpful for users unfamiliar with more.

Bash

more -d sample.txt
You'll see messages like [Press space to continue, 'q' to quit.].

4. Squeezing Blank Lines (-s)
If your file has multiple consecutive blank lines, -s will collapse them into a single blank line.

file_with_blanks.txt:

Line 1

Line 2


Line 3



Line 4
Bash

more -s file_with_blanks.txt
Output (how it's displayed in more):

Line 1

Line 2

Line 3

Line 4
5. Starting at a Specific Line Number (+num)
Bash

more +10 sample.txt
This will open sample.txt and start displaying from Line 10.

6. Starting at a Specific Pattern (+/pattern)
Bash

more +/Orange sample.txt
This will open sample.txt and display the screen starting from the line containing "Orange".

7. Viewing Output from Another Command
more is commonly used in a pipeline to paginate the output of commands that produce a lot of text (e.g., ls -lR, cat /var/log/syslog).

Bash

ls -lR /etc | more
This will list the contents of /etc and its subdirectories, paginating the output.

8. Viewing Multiple Files
Bash

more sample.txt another_file.txt
more will display sample.txt first. After you reach the end of sample.txt (by pressing Spacebar until ---More--(Next file: another_file.txt) is shown), pressing Spacebar again will move to another_file.txt.
You can use interactive commands like :n to go to the next file or :p to go to the previous (if supported).

9. Clearing Screen Before Each Page (-p)
Bash

more -p sample.txt
Each time you press Spacebar, the screen will be cleared, and the next page will be drawn from the top.

10. Combining Options
You can combine multiple options:

Bash

ls -lR /etc | more -ds +/passwd
This command will:

Pipe the recursive listing of /etc to more.

Use more to display helpful prompts (-d).

Squeeze multiple blank lines (-s).

Start displaying the output from the first occurrence of the pattern "passwd" (+/passwd).

more vs. less
Feature	more (Traditional)	less
Scrolling Backward	Limited/None (depending on version)	Yes (primary advantage)
File Editing	No	No
Memory Usage	Loads entire file (sometimes)	Loads only a portion; more efficient for large files
Search	Forward only	Forward and backward
Prompt	---More---	% (percentage read), filename, etc.
Default behavior	Forward-only pager	Forward and backward pager
Installation	Almost always present	Almost always present

Export to Sheets
When to use more?
Simplicity: For quick, straightforward viewing of files where you just need to read forward.

Compatibility: On very old or minimal systems where less might not be installed.

Muscle Memory: If you're accustomed to its commands from older Unix systems.

Piping to grep: For situations where you only care about filtering the start of a large output (though grep itself would be more direct).

For most modern use cases, especially when you might need to scroll back, search extensively, or handle very large files efficiently, less is generally the preferred choice. However, more remains a simple and reliable tool for its intended purpose.
```