diff file1.txt file2.txt


diff compares files line by line.

3c3 → line 3 in file1 changed in file2.

6c6 → line 6 changed.

< → from file1, > → from file2.

Useful to see exactly which lines differ, and optionally apply patches.







comm — shows common and unique lines

Command:

comm file1.txt file2.txt


Output:
	3 coloumns 
	1st column: 
		file1 diff
	2nd column: 
		file2 diff		
	3rd column: 
		what is same between file1 and file2 
		
Explanation:

N.B: comm expects sorted files
	add an extra file between one of data in a file and re-execute 
	
sort file1.txt > file1s.txt
sort file2.txt > file2s.txt
comm file1s.txt file2s.txt


Output is in three columns:

	Lines only in file1

	Lines only in file2

	Lines common to both (default shown in middle)

	You can suppress columns with options:

	comm -23 file1s.txt file2s.txt → lines only in file1

	comm -12 file1s.txt file2s.txt → lines common to both

cmp — byte-by-byte comparison

Command:

cmp file1.txt file2.txt


Output:
	points if there is a difference - what is the first diff. 
	file1.txt file2.txt differ: byte 14, line 3


Explanation:

cmp compares files byte by byte, not line-based.

Tells you the first byte and line where files differ.

Very fast for large files if you just want to know “are these files identical or not?”

You can suppress output and use exit code:

cmp -s file1.txt file2.txt
echo $?


0 → identical
1 → different
2 → error
