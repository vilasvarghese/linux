


Question 2.2 (Finding Files by Partial Name - Case Insensitive)
You remember a script name contained "backup" somewhere, but you're not sure of the exact case or the full name. You want to find all files ending with .sh that have "backup" (case-insensitive) in their name, anywhere under /opt/scripts.

Command:

Bash

# How would you find all shell scripts in '/opt/scripts' with "backup" in their name, ignoring case?
find /opt/scripts -type f -iname "*backup*.sh"

Question 2.3 (Finding Empty Files)
Your system is running low on disk space. You want to identify and potentially delete any empty files within your user's Downloads directory.

Command:

Bash

# How would you find all empty files in '~/Downloads'?
find ~/Downloads -type f -empty

Question 2.4 (Finding Files by Size)
You're looking for large log files that might be consuming excessive disk space. You want to find all files larger than 100MB in /var/log.

Command:

Bash

# How would you find all files larger than 100MB in '/var/log'?
find /var/log -type f -size +100M
Question 2.5 (Finding Files by Modification Time)
You need to identify all files that have been modified in the last 24 hours (1 day) within the /srv/www directory.

Command:

Bash

# How would you find files modified within the last 24 hours in '/srv/www'?
find /srv/www -type f -mtime -1
Question 2.6 (Finding Files by Permissions)
You need to find any files in /var/www that are executable by "others" (world-executable), which could be a security risk.

Command:

Bash

# How would you find files in '/var/www' that have world-execute permission?
find /var/www -type f -perm /o+x
# OR (if looking for exact numeric match like 777, 755 etc.):
# find /var/www -type f -perm 007 # for any permission in the 'other' field
# find /var/www -type f -perm /111 # for files executable by anyone
Question 2.7 (Finding Files by User/Group Ownership)
You need to find all files in /home that are owned by a user named olduser (who is no longer with the company) and change their ownership to newuser.

Command:

Bash

# How would you find files owned by 'olduser' in '/home' and then change their ownership to 'newuser'?
find /home -user olduser -exec chown newuser {} +
Question 2.8 (Executing a Command on Found Files)
You've found many old temporary files (ending with .tmp) under /tmp/my_app_cache that need to be deleted.

Command:

Bash

# How would you find all '.tmp' files in '/tmp/my_app_cache' and delete them?
find /tmp/my_app_cache -name "*.tmp" -type f -delete
# OR
# find /tmp/my_app_cache -name "*.tmp" -type f -exec rm {} +
Safety Note: Always test find ... -exec with echo first (e.g., find ... -exec echo {} +) before running rm to ensure you're deleting the correct files.

Part 3: grep Command
Scenario: You need to search for specific text patterns within files, often in logs or configuration files.

Question 3.1 (Basic String Search)
You want to find all lines in /var/log/syslog that contain the word "error".

Command:

Bash

# How would you find all lines containing "error" in '/var/log/syslog'?
grep "error" /var/log/syslog
Question 3.2 (Case-Insensitive Search)
You're looking for a user's activity in /var/log/auth.log, but you're not sure if their username "jdoe" is logged as "jdoe", "JDOE", or "Jdoe".

Command:

Bash

# How would you find all lines containing "jdoe" (case-insensitive) in '/var/log/auth.log'?
grep -i "jdoe" /var/log/auth.log
Question 3.3 (Displaying Line Numbers)
You're debugging a configuration file (/etc/apache2/apache2.conf) and want to see the lines matching "Listen" along with their corresponding line numbers.

Command:

Bash

# How would you display lines containing "Listen" in '/etc/apache2/apache2.conf', including line numbers?
grep -n "Listen" /etc/apache2/apache2.conf
Question 3.4 (Counting Matches)
You want to quickly find out how many times the word "failed" appears in /var/log/secure to gauge the frequency of login attempts.

Command:

Bash

# How would you count the number of lines containing "failed" in '/var/log/secure'?
grep -c "failed" /var/log/secure
Question 3.5 (Inverting Matches - Lines NOT Containing a Pattern)
You want to view all lines in a hosts file (/etc/hosts) that are not comments (lines starting with #) and are not empty.

Command:

Bash

# How would you display lines from '/etc/hosts' that do not start with '#' and are not empty?
grep -v "^#" /etc/hosts | grep -v "^$"
# OR using extended regex for a single grep:
# grep -Ev "^#|^$" /etc/hosts
Question 3.6 (Searching in Multiple Files and Directories)
You need to find all configuration files (.conf extension) under /etc that contain the string "ServerName". You want to see the filename and the matching line.

Command:

Bash

# How would you recursively search for "ServerName" in all '.conf' files under '/etc'?
grep -r "ServerName" /etc --include="*.conf"
# OR (if grep -r --include is not available or preferred for clarity):
# find /etc -name "*.conf" -type f -exec grep -H "ServerName" {} +
Question 3.7 (Displaying Context Around Matches)
You found an "error" in /var/log/myapp.log, but you need to see the 5 lines before and 5 lines after the error message to understand the context.

Command:

Bash

# How would you display lines containing "error" in '/var/log/myapp.log', along with 5 lines of context before and after?
grep -C 5 "error" /var/log/myapp.log
# OR, for just lines after: grep -A 5 "error"
# OR, for just lines before: grep -B 5 "error"
Question 3.8 (Searching with Regular Expressions)
You want to find all lines in /var/log/messages that contain either the word "warning" or "critical".

Command:

Bash

# How would you find lines containing "warning" OR "critical" in '/var/log/messages' using extended regular expressions?
grep -E "warning|critical" /var/log/messages
Question 3.9 (Piping Output to Grep)
You have a very long list of active network connections (ss -an) and you only want to see connections to port 80 or 443.

Command:

Bash

# How would you pipe the output of `ss -an` to `grep` to filter for port 80 or 443?
ss -an | grep -E ":80|:443"



Question 9 (Combining Head and Tail for Middle Section)
You're interested in log entries between line 50 and line 100 (inclusive) of a very large log file (large_app.log).

Command:

Bash

# How would you display lines 50 through 100 of 'large_app.log'?
head -n 100 large_app.log | tail -n 51
# Explanation: head gets the first 100 lines, then tail gets the last 51 of those (lines 50-100).

Question 12 (Viewing a File from a Specific Starting Point)
You know a specific error message ("Segmentation fault") occurred somewhere in the middle of debug.log. You want to open the file directly at the first occurrence of this string, so you can immediately see the context.

Command:

Bash

# How would you open 'debug.log' directly to the first line containing "Segmentation fault"?
less +/"Segmentation fault" debug.log



Question: You're testing a new script (debug_network.sh) that might produce a lot of output (both stdout and stderr). You want to see the output on your terminal and simultaneously save it to a file named network_debug.txt for later review.
Answer:

Bash

./debug_network.sh | tee network_debug.txt
# OR (to include stderr in the tee output)
# ./debug_network.sh 2>&1 | tee network_debug.txt



Question: A directory /var/www/html and all its contents need to be owned by the nginx user and nginx group, and permissions should be rwx for owner, rx for group, and no access for others on directories, while files should be rw for owner and r for group, and no access for others.
Answer:

Bash

chown -R nginx:nginx /var/www/html

find /var/www/html -type d -exec chmod 750 {} +
find /var/www/html -type f -exec chmod 640 {} +


Question: You need to verify if your server's eth0 interface has been assigned an IPv6 address.
Answer:

Bash

ifconfig eth0 | grep inet6
# Or simply: ifconfig eth0

	get command for next 5 line 