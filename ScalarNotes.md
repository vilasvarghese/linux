	Text Processing and Pattern Matching

	##Regular expressions fundamentals 
	---------------------------------------------------------------------------------------------
	
# Regular Expressions (Regex) Fundamentals – A Detailed Tutorial

---

## 1.  What is Regex?

- A **regex** is a pattern that describes sets of strings.  
- Think of it as a **language for finding text**.  
- Common uses:
  - Search text (e.g., find all emails in a file).
  - Validation (e.g., check if input is a phone number).
  - Replace/transform text (e.g., reformat dates).
  - Parsing logs, config files, or structured text.

---


##1940s–1950s: Theoretical Foundations

	1943 – Warren McCulloch & Walter Pitts wrote a paper on neural activity and formal logic, which introduced the idea of describing neural networks using mathematical notation.

	1951 – Stephen Kleene (mathematician, MIT) published a paper defining regular sets using operators like * (Kleene star), +, and concatenation.
	This is the true birth of regular expressions in mathematics.

##1960s: From Theory to Early Programming

Ken Thompson (Bell Labs) applied regular expressions while developing text editors for early Unix systems.

1968 – Thompson’s text editor QED (precursor to ed and vi) allowed searching with regex-like patterns.

##1970s–1980s: Regex in Unix Tools

Regex became mainstream through Unix tools:

ed (line editor, early Unix)

grep (1973, written by Ken Thompson; name comes from g/re/p = “global regular expression print”)

sed (stream editor, 1974)

awk (pattern scanning & processing language, 1977)

	These made regex essential for text processing.

##1980s–1990s: Extended Regex & Languages

1986 – Henry Spencer wrote a widely used regex library in C, spreading regex beyond Unix.

Regex began appearing in programming languages:

Perl (Larry Wall, 1987) integrated regex deeply.

Emacs & vi added regex search.

Extended Regular Expressions (ERE) appeared in POSIX standards, adding operators like +, ?, and |.

##2000s: Modern Regex Engines

Regex became a standard in most programming languages:

Java (1997) added java.util.regex.

.NET (2000) built regex into the framework.

Python, Ruby, PHP, JavaScript all adopted regex with PCRE-style (Perl Compatible Regular Expressions).

PCRE (Perl Compatible Regular Expressions) became the de facto standard for “advanced” regex (lookaheads, backreferences, etc.).

##2010s–Present: Regex Everywhere

Regex is now built into databases (PostgreSQL, MySQL, MongoDB).

Command-line tools (GNU grep, ripgrep, ag) optimize regex for speed.

Regex derivatives:

RE2 (Google) – safe regex library (no catastrophic backtracking).

Rust regex crate – guarantees linear-time performance.





## 2. ️ Basic Building Blocks

### 2.1 Literal Characters
- A regex without any special symbols just matches exact text.  

```
cat
Matches "cat" in "my cat is cute".


```
2.2 Metacharacters
```
Special characters with meaning in regex:

. ^ $ * + ? { } [ ] \ | ( )
If you want to match them literally, escape with \.


\.com
Matches .com exactly.
```
2.3 The Dot .
```
Matches any single character (except newline by default).


c.t
Matches cat, cot, cut, c9t...
```
2.4 Anchors ^ and $
```
^ = beginning of string

$ = end of string

regex

^Hello
Matches "Hello world", not "Say Hello".

regex

world$
Matches "Hello world".
```
3.  Character Classes
3.1 Square Brackets []
Match one character from a set.

regex

[aeiou]
Matches any vowel.

Ranges:

regex

[a-z]
Matches any lowercase letter.





3.2 Negation [^ ]
Inside [], ^ means NOT.

regex

[^0-9]
Matches any non-digit.

3.3 Predefined Classes
\d → digit (0-9)

\D → non-digit

\w → word character (letters, digits, underscore)

\W → non-word character

\s → whitespace (space, tab, newline)

\S → non-whitespace




4.  Quantifiers (How many times?)
* → 0 or more

+ → 1 or more

? → 0 or 1

{n} → exactly n

{n,} → n or more

{n,m} → between n and m

Examples:

regex

go+gle
Matches gogle, google, gooogle…

regex

a{2,4}
Matches aa, aaa, or aaaa.

5.  Groups and Alternation
5.1 Grouping ()
Groups multiple tokens together.

regex

(ab)+
Matches ab, abab, ababab…

5.2 Alternation |
Acts like OR.

regex

cat|dog
Matches either cat or dog.

5.3 Capture Groups vs Non-Capturing
(abc) → captures abc.

(?:abc) → non-capturing group.

6. ️ Greedy vs Lazy Matching
Regex quantifiers are greedy by default (they match as much as possible).

Example:

regex

<.*>
Applied to <div>text</div> matches the whole <div>text</div>.

Lazy version:

regex

<.*?>
Matches <div> first, then </div>.

7.  Practical Examples
7.1 Validate Email
regex

^[\w.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
7.2 Validate Phone Number
regex

^\+?[0-9]{10,13}$
7.3 Extract Date (dd/mm/yyyy or dd-mm-yyyy)
regex

\b\d{2}[-/]\d{2}[-/]\d{4}\b
7.4 Find IP Address
regex

\b(?:\d{1,3}\.){3}\d{1,3}\b
8.  Testing Regex
Online tools: regex101.com, regexr.com

Python Example:

python

import re

text = "Contact me at test@example.com or admin@site.org"
emails = re.findall(r'[\w\.-]+@[\w\.-]+\.\w+', text)
print(emails)
Output:

css

['test@example.com', 'admin@site.org']
9.  Tips & Best Practices
Always test with sample data.

Start simple, then add complexity.

Use raw strings (r"regex") in Python.

Be careful with .* (can overmatch).

Document regex with comments ((?#comment) in some engines).

That covers fundamentals + practical regex usage.




---

	
	---------------------------------------------------------------------------------------------
	Advanced patterns of Regular expressions
	
	---------------------------------------------------------------------------------------------
	
	
	# Advanced Regular Expressions Tutorial

This tutorial goes beyond the basics and explores **advanced regex patterns** that give you more power and flexibility in matching text.

---

## 1. Lookahead & Lookbehind (Assertions)

### Positive Lookahead `(?=...)`
- Ensures that what follows the current position **matches** the pattern.  
- Does not consume characters (zero-width).

 Example:  
- Pattern: `\d(?=px)`  
- Matches a digit only if it is followed by `px`.  
- `"10px"` → matches `1` but not `0`.

---

### Negative Lookahead `(?!...)`
- Ensures that what follows **does not** match the pattern.

 Example:  
- Pattern: `\d(?!px)`  
- Matches a digit not followed by `px`.  
- `"10px 20em"` → matches `2` in `20em`.

---

### Positive Lookbehind `(?<=...)`
- Ensures that what precedes the current position **matches** the pattern.

 Example:  
- Pattern: `(?<=\$)\d+`  
- Matches digits only if they are preceded by `$`.  
- `"$100"` → matches `100`.

---

### Negative Lookbehind `(?<!...)`
- Ensures that what precedes does **not** match.

 Example:  
- Pattern: `(?<!\$)\d+`  
- Matches digits not preceded by `$`.  
- `"100 USD"` → matches `100`.

---

## 2. Non-Capturing Groups `(?:...)`

- Groups regex parts together **without capturing** them for backreferencing.

 Example:  
- Pattern: `(?:cat|dog)s`  
- Matches `cats` or `dogs`, but does not capture `cat` or `dog`.

---

## 3. Backreferences

- Refers back to a previously captured group using `\1`, `\2`, etc.

 Example:  
- Pattern: `(\w+)\s\1`  
- Matches repeated words.  
- `"hello hello"` → matches `hello hello`.

---

## 4. Named Groups & References

- Use `(?P<name>...)` in Python or `(?<name>...)` in many regex engines.  
- Reference with `\k<name>`.

 Example:  
- Pattern: `(?<word>\w+)\s\k<word>`  
- Matches repeated words by name.

---



## 5. Atomic Groups `(?>...)`

- Once a match inside an atomic group is made, regex does not backtrack inside it.  
- Helps optimize performance and avoid catastrophic backtracking.

 Example:  
- Pattern: `(?>a+)a`  
- Will not match `"aaaa"` because after `a+` matches all, it won’t give back one `a`.

---



## 6. Conditional Expressions

- Match different patterns depending on whether a group has been matched.  

Syntax:  
(?(condition)then|else)


 Example:  
- Pattern: `(a)?(?(1)b|c)`  
- If `a` matched, then `b` must follow; otherwise, `c` must follow.  
- Matches: `"ab"`, `"c"`  
- Does not match: `"a"`, `"ac"`

---



## 7. Subroutines & Recursion

- Some regex engines support **recursive patterns**.  
- Useful for nested structures like parentheses.

 Example (PCRE):  
- Pattern: `\((?:[^()]+|(?R))*\)`  
- Matches balanced parentheses: `"(a(b)c)"`.

---



## 8. Possessive Quantifiers

- Similar to `+`, `*`, etc., but **do not backtrack**.  
- Denoted by adding `+` after quantifier.

 Examples:  
- `a*+` → match as many `a`s as possible, no backtracking.  
- Useful for performance optimization.

---



## 9. Inline Modifiers

- Change regex behavior inside a pattern.

 Examples:  
- `(?i)` → case-insensitive  
- `(?m)` → multiline mode (`^` and `$` match start/end of line)  
- `(?s)` → dot matches newlines  

Example:  
- Pattern: `(?i)hello` → matches `Hello`, `HELLO`, `heLLo`.

---



## 10. Practical Advanced Patterns

- **Match an HTML tag (simplified):**  

<([A-Za-z][A-Za-z0-9])\b[^>]>(.*?)</\1>


- **Validate IPv4 address:**  
^((25[0-5]|2[0-4]\d|[01]?\d\d?).){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$




- **Match nested quotes:**  
"([^"\](\.[^"\])*)"




---



	
	---------------------------------------------------------------------------------------------
	Text manipulation with sed (stream editor)
	
	---------------------------------------------------------------------------------------------

The sed command: Stream Editor. 
- Text processing tool 
- Can 
	search, 
	find, 
	replace, 
	insert, and 
	delete text 
		in files or streams (like stdin) — 
	all in a non-interactive way (you don’t need to open an editor).


	sed uses regular expressions (regex) for its matching by default
	


 1. Find and Replace Text

The most common use is search and replace:

sed 's/error/warning/' logfile.txt
	Replaces the first occurrence of the word error with warning in each line.

sed 's/error/warning/g' logfile.txt
	Replaces all occurrences (g = global) of error with warning in each line.

 2. Editing Files in Place
sed -i 's/8080/9090/g' config.yaml
	Changes port 8080 → 9090 directly inside the file (in-place edit).
	Useful for config updates in automation scripts.

 3. Delete Lines
sed '/^#/d' config.yaml
	Deletes all lines starting with # (comments).

sed '5d' file.txt
	Deletes the 5th line of the file.

 4. Print Specific Lines
sed -n '5p' file.txt
	Prints only line 5.

sed -n '10,20p' file.txt
	Prints lines 10 to 20.

 5. Insert or Append Text
sed '1i # This is a header' file.txt
	Inserts text before line 1.

sed '$a # End of file' file.txt
	Appends text after the last line.

 6. Substitute with Regex
sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2}/DATE/g' logfile.txt
	Replaces all date patterns (YYYY-MM-DD) with the word DATE.



Real-World DevOps Use Cases of sed
----------------------------------
Update Configurations in CI/CD Pipelines

sed -i 's/version:.*/version: 2.0.1/' deployment.yaml
	Automatically bump version numbers in Kubernetes manifests.

Sanitize Secrets from Logs

sed -i 's/API_KEY=.*/API_KEY=********/' app.env
	Mask sensitive keys before sharing logs.

Bulk Update Ports in Configs

sed -i 's/port=3306/port=3307/' my.cnf
	Useful during DB migrations.

Clean Log Files
sed -i '/DEBUG/d' app.log
	Remove all DEBUG log lines to reduce log size.

Infrastructure as Code Automation

sed -i "s/AMI_ID_PLACEHOLDER/$AMI_ID/" terraform.tfvars
	Dynamically replace placeholders in Terraform variables.



To replace text with regex groups:

	sed -E 's/(pattern)/\1.../'


	For file editing:

	sed -i.bak 's/old/new/g' file   # BSD version
	sed -i 's/old/new/g' file        # GNU version


For config changes, like setting a port:

	sed -i 's/port=8080/port=80/' app.conf


In YAML files, be cautious about syntax, and use tools like kubectl instead:

kubectl set image deployment/myapp myapp=myrepo:tag


In pipelines, try:
	curl | sed 's/REPLACE_ME/'"$VALUE"'/g' | kubectl apply -f -


For scripts:
	sed -f script.sed file


To delete or insert lines based on a pattern, use:
	sed -i '/pattern/i\new line' file


For SSH keys, ensure idempotency with:
	grep -q 'key' /.ssh/authorized_keys || echo "key" >> /.ssh/authorized_keys


To anonymize IPs in logs:
	sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log


To extract data, this gets URLs:
	sed -n 's/.*"GET \([^ ]*\) .*/\1/p' access.log


Use sed in CI for environment variables:
	sed -e "s|__IMAGE__|$IMAGE|g" -e "s|__TAG__|$TAG|g" template.yaml > out.yaml


To avoid slash escaping, you can use a different delimiter like |:
	sed 's|/old/path|/new/path|g'


For extended regular expressions, use -E:
	sed -E 's/.../.../'


For portability, -E works on both macOS BSD and GNU sed. It’s best to stick with -E for compatibility.

For batch renaming files, sed can’t rename directly, but this works:
	for f in *; do mv "$f" "$(echo "$f" | sed 's/old/new/')"; done


- jq or awk for JSON or complex data tasks.



Nice — here’s a thorough, practical guide to text manipulation with sed focused on real-world DevOps use cases. It’s Markdown so you can paste it into docs or a README.




# `sed` for DevOps — Practical Text Manipulation Guide

`sed` (stream editor) is a tiny, lightning-fast tool for editing text streams and files. In DevOps it’s everywhere: patching configs, templating manifests, redacting logs, quick refactors, CI scripts, and more. This guide walks through fundamentals, useful one-liners, real-world scenarios, portability caveats, and best practices.

---




## Quick primer: how `sed` works

- `sed` reads input line-by-line (stream), applies commands, prints (by default) result to stdout.
- Basic substitution:
  ```

  sed 's/pattern/replacement/' file      # replace first match on each line
  sed 's/pattern/replacement/g' file     # replace all matches on each line


Common flags:

-n : suppress automatic printing (use p to print selected lines).

-i[SUFFIX] : edit file in-place; optional SUFFIX makes a backup (BSD/macOS requires an argument: -i '').

-E : use extended regex (preferred portably).

-r : GNU extended regex (older GNU-only flag).

Portability note (macOS vs Linux)

GNU sed (Linux): sed -i 's/a/b/g' file

BSD/macOS sed: sed -i '' -e 's/a/b/g' file (empty backup suffix)

Use -E (POSIX ERE) for portability instead of -r.

When writing scripts for multiple platforms, detect GNU vs BSD or use perl -pi -e as a portable alternative.

Useful building blocks & tricks

Use alternate delimiters to avoid escaping /:

sed 's|/old/path|/new/path|g'


Reference whole match with &, groups via \1, \2:

sed -E 's/(v)([0-9]+\.[0-9]+\.[0-9]+)/\1\2-rev/' file


Suppress default output and print only matches:

sed -n 's/.*GET \([^ ]*\) .*/\1/p' access.log   # extract requested URLs


Edit multiple files with find safely:

find . -name '*.conf' -print0 | xargs -0 sed -i.bak 's/old/new/g'

Real-world DevOps use cases (with examples)
1) Patch a configuration file (change port or host)

Change application port from 8080 → 80:

# GNU
sed -i 's/^port *= *8080/port=80/' app.conf

# macOS/BSD
sed -i '' -E 's/^port *= *8080/port=80/' app.conf


Tip: Use ^ to avoid changing comments or similar lines.

2) Template substitution in CI/CD pipelines

Replace placeholders in Kubernetes manifest templates during CI:

IMAGE="myrepo/app:$TAG"
sed -E "s|__IMAGE__|${IMAGE}|g; s|__REPLICAS__|${REPLICAS}|g" deployment.tpl.yaml > deployment.yaml
kubectl apply -f deployment.yaml


Advice: For YAML edits prefer yq for structured edits; sed is fine for simple tokens.

3) In-place edits with backups (safe automation)
sed -i.bak -E 's/DEBUG=true/DEBUG=false/' /etc/myapp/config.ini
# verify, then remove backups if all good:
rm /etc/myapp/config.ini.bak

4) Redact sensitive info in logs (PII / IPs)

Anonymize IPv4 addresses:

sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log > access.redacted.log


Use Case: Shipping logs to third-party analytics while hiding IPs.

5) Extract fields from logs (parsing)

Get request path from Apache-like logs:

sed -n 's/.*"GET \([^ ]*\) .*/\1/p' access.log


Pipe to sort | uniq -c to produce hit counts.

6) Replace image tags for a rolling deploy

Dangerous if used blindly — prefer kubectl set image. But for CI templating:

sed -E "s|(image:\s*)([^:]+):([^[:space:]]+)|\1\2:${NEW_TAG}|" deployment.yaml > patched.yaml
kubectl apply -f patched.yaml

7) Replace a block (multiline) between markers

Replace everything between # START-SECTION and # END-SECTION:

# GNU sed version (works with -z to treat file as single string)
sed -z 's/# START-SECTION.*# END-SECTION/# START-SECTION\nNEW LINE 1\nNEW LINE 2\n# END-SECTION/s' file > newfile


Portable approach using line-range c\:

sed -i.bak '/# START-SECTION/,/# END-SECTION/c\
# START-SECTION\
NEW LINE 1\
NEW LINE 2\
# END-SECTION' file


Caveat: Escaping and newlines vary between GNU/BSD — test first.

8) Ensure idempotency (apply change only if needed)

Append a config line only if missing:

grep -q '^export MYVAR=' /etc/profile || echo 'export MYVAR=1' | sudo tee -a /etc/profile


sed alone is awkward for “append-if-not-exist”; combine with grep for safety.

9) Bulk renaming of files (via loop)

Rename files replacing spaces with underscores:

for f in *' '*; do
  mv -- "$f" "$(echo "$f" | sed 's/ /_/g')"
done

10) Automating service config changes + reload

Change systemd drop-in or nginx config and reload:

sudo sed -i -E 's/listen 80;/listen 8080;/' /etc/nginx/sites-available/default
sudo nginx -t && sudo systemctl reload nginx


Best practice: nginx -t to validate before reloading.

Advanced sed features you should know
Hold space & pattern space (buffer manipulation)

Useful for multi-line transforms without -z:

N : append next line into pattern space (\n between lines).

P, D, h, H, g, G, x : move/copy pattern/hold buffers.

Example: join line pairs into one line:

sed -n 'N;s/\n/ /;p' file

Delete, insert, append lines

Delete lines matching a pattern:

sed -i '/^#/d' file   # remove comments


Insert line before a match:

sed -i '/pattern/i\
New line to insert' file


Append after a match:

sed -i '/pattern/a\
New appended line' file


Be mindful of quoting (especially in scripts and macOS).

One-liners cheat sheet (DevOps favorites)

Replace across files:

find . -type f -name '*.yaml' -exec sed -i.bak 's/old/new/g' {} +


Delete blank lines:

sed -i '/^$/d' file


Convert CRLF → LF:

sed -i 's/\r$//' file


Print matching lines only:

sed -n '/ERROR/p' /var/log/myapp.log


Print lines 10–20:

sed -n '10,20p' file

Pitfalls & when not to use sed

Structured formats (JSON/YAML/XML) → prefer jq, yq, or XML parsers. sed can break structure/whitespace and cause hard-to-find bugs.

Complex nested edits → consider perl or a small Python script (with pyyaml/json) for clarity and maintainability.

Platform differences → macOS vs Linux sed -i differences; always test in CI runner environment.

Insufficient validation → always validate changes (e.g., kubectl apply --dry-run=client, nginx -t, systemctl daemon-reload).

Best practices for safe automation

Always test on stdout first (omit -i):

sed 's/old/new/g' file > /tmp/test && diff -u file /tmp/test


Create backups when running -i in automation: -i.bak. Clean up after verification.

Prefer idempotent changes (scripts should be safe to re-run).

Use structured editors for structured data (jq, yq) when possible.

Validate after editing (configs lint/test).

Use version control for config templates and CI job logs to roll back easily.

Document one-liners in your ops runbook so teammates know why edits are safe.

When to reach for alternatives

For JSON: jq

For YAML: yq (or kubectl patch / kubectl set image for Kubernetes)

For advanced regex and file-in-place edits across platforms: perl -pi -e 's/.../.../g' file

Handy examples summary
# 1. Replace placeholder in template
sed -E "s|__IMAGE__|${IMAGE}|g" deployment.tpl.yaml > deployment.yaml

# 2. Anonymize IPs before shipping logs
sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log > anon.log

# 3. Insert a line before pattern (macOS-safe)
sed -i '' '/^server_name/i\
# Added by deploy script' nginx.conf

# 4. Replace block between markers
sed -n '/# START/,/# END/{/START/b;/END/b;p}' file   # print only block
sed -i.bak '/# START/,/# END/c\
# START\
new contents\
# END' file


# More Advanced `sed` Examples for DevOps

---

### 11) Remove all comments from a config file
Useful when you need to generate a "clean" version of a config without human comments.
```
sed -i '/^#/d;/^$/d' /etc/myapp/config.conf
Removes lines starting with # and empty lines.

12) Replace only specific environment variable values
Patch .env files in CI/CD:



sed -i -E 's/^API_KEY=.*/API_KEY=abcd1234/' .env
Ensures the API_KEY variable is updated while leaving others untouched.

13) Change file permissions inside Dockerfile during pipeline
Quickly fix a Dockerfile before build:



sed -i -E 's/(chmod )[0-9]{3}/\1644/' Dockerfile
Replaces any chmod 777 with chmod 644.

14) Append config if missing (idempotent pattern)
Add a JVM option only if it’s not present:



grep -q 'Xmx' jvm.options || sed -i '$a -Xmx2g' jvm.options
Uses grep + sed append to avoid duplicates.

15) Remove ANSI color codes from CI logs
CI/CD tools often output colorized logs. Strip them before saving to file:



sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' colored.log > clean.log
Makes logs readable in plain text viewers.

16) Mass update Kubernetes namespace in manifests


sed -i 's/namespace: dev/namespace: staging/g' *.yaml
Useful for quick environment promotion when templates are not parameterized.

17) Standardize indentation (convert tabs → spaces)


sed -i 's/\t/    /g' script.sh
Converts tabs into 4 spaces for consistency in scripts.

18) Extract only error lines with timestamp
From app logs:



sed -n -E 's/^\[([0-9-]+ [0-9:]+)\].*ERROR.*/\1 ERROR/p' app.log
Captures timestamp + keyword ERROR.

19) Swap order of fields (comma-separated logs)
Convert "user,ip" → "ip,user":



sed -E 's/^([^,]+),([^,]+)/\2,\1/' users.csv
20) Remove duplicate blank lines


sed -E '/^$/N;/\n$/D' file
Ensures there’s only ever one blank line between sections.

21) Quick replace in Helm chart values
Patch chart values dynamically:



sed -i -E "s|replicaCount: [0-9]+|replicaCount: ${COUNT}|" values.yaml
22) Obfuscate email addresses before exporting logs


sed -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/[EMAIL_REDACTED]/g' log.txt > log_clean.txt
23) Insert a line after a matching pattern
For systemd drop-ins:



sed -i '/^\[Service\]/a Environment=APP_ENV=prod' /etc/systemd/system/myapp.service
24) Change domain across config files


find ./configs -type f -exec sed -i 's/old-domain.com/new-domain.org/g' {} +
Updates dozens of configs at once — CI/CD ready.

25) Normalize Windows CRLF → Unix LF in Git repos


sed -i 's/\r$//' *.sh
Ensures scripts don’t fail in Linux environments.

Best practice reminder
Always run without -i first, e.g.:



sed -E 's/old/new/g' file | diff file -
to preview changes safely before applying.





	---------------------------------------------------------------------------------------------
	Pattern processing with awk (field processing)
	
	---------------------------------------------------------------------------------------------
	
	
	`awk` 
		text processing tool 
		designed for 
			**scanning files, splitting data into fields, applying filters, and transforming output**.  
It’s extremely useful for **log analysis, parsing system metrics, working with CSV/TSV data, and automating reporting** in DevOps workflows.

---
```
### 1. Basics of `awk`

### Structure
```
awk 'pattern { action }' file
pattern → What to match (regex, expression, condition).

action → What to do with matching lines (print, compute, transform).

Field References
	$0 → Entire line
	$1, $2, $3 → First, second, third fields (by default split on whitespace)
	NF → Number of fields in the line
	NR → Line number
	FS → Input field separator (default is space)
	OFS → Output field separator (default is space)


```
###2. Real-World DevOps Use Cases
 Example 1: Summarize Nginx access logs
Get total requests per IP:

	awk '{count[$1]++} END {for (ip in count) print ip, count[ip]}' access.log | sort -k2 -nr
	$1 → first field (client IP in access logs).

	Useful for traffic analysis & blocking suspicious IPs.



Example 2: Monitor CPU usage from top
Extract CPU idle percentage:

top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"% CPU used"}'
	$8 → idle CPU percentage.

Helps build quick monitoring scripts without a full metrics stack.

 Example 3: Find slowest API endpoints
From log lines like:



GET /api/users 200 123ms
Extract endpoint + time:



awk '{print $2, $4}' api.log | sort -k2 -nr | head -10
	Shows top 10 slowest API calls.

 Example 4: Extract pod restarts from kubectl get pods


kubectl get pods -A | awk '$5 > 0 {print $1, $2, $5}'
	$5 = RESTARTS column in kubectl output.

Instantly identify flapping pods in Kubernetes.

 Example 5: Disk space monitoring
	From df -h output:



df -h | awk '$5+0 > 80 {print $1, $5}'
Prints filesystems where usage > 80%.

Perfect for alerting in cron jobs.

 Example 6: Extract failed login attempts
From /var/log/auth.log:



grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr
$(NF-3) → extracts the username/IP field.

Quickly detects brute-force attempts.

 Example 7: JSON log processing (with delimiters)
For logs like:

css

{"time":"2025-09-17","level":"ERROR","msg":"DB connection failed"}
Extract only errors:



awk -F'"' '/ERROR/ {print $4, $8}' app.log
-F'"' → split by quotes.

Captures timestamp and error message.

 Example 8: CSV parsing for metrics
From a users.csv:

pgsql

id,name,age,role
1,Alice,30,admin
2,Bob,25,dev
Get all devs:



awk -F, '$4=="dev" {print $2}' users.csv
Prints Bob.

Useful for inventory & IAM audits.

 Example 9: Extract HTTP status distribution
From logs like:

swift

10.0.0.1 - - [17/Sep/2025] "GET /api" 200
Count status codes:



awk '{status[$9]++} END {for (s in status) print s, status[s]}' access.log
$9 = HTTP status code.

Helps track API health trends.

 Example 10: Auto-scale hint from pod CPU usage
From metrics file:

nginx

pod1 50
pod2 90
pod3 40
Find pods > 80% CPU:



awk '$2 > 80 {print $1, "needs scaling"}' cpu_metrics.txt
3. Key Takeaways for DevOps
awk = lightweight data processor (no need for Python scripts for simple parsing).

Great for logs, metrics, system outputs.

Works well in pipelines with grep, sort, uniq, sed.

Use in CI/CD pipelines to transform config, validate logs, or extract metrics before deployment.

4. Best Practices
Always test with awk (without destructive commands) before integrating in scripts.

Combine with sort | uniq for summaries.

Use -F for structured files (CSV, JSON-like logs).

When parsing complex formats (like JSON), consider jq but awk is faster for lightweight needs.




###  11) Find top talkers in network connections
From `netstat` output:
```
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
Shows which IPs are connecting the most to your server (potential DDoS or scraping detection).
```
### 12) Calculate average response time from logs
From logs like:



/api/users 123
/api/orders 245
/api/cart 67

```
awk '{sum+=$2; count++} END {print "Average:", sum/count}' response_times.log
Computes average latency across API endpoints.
```


 13) Identify long-running processes
From ps output:



ps -eo pid,etime,cmd | awk '$2 ~ /[0-9]+:[0-9]{2}:[0-9]{2}/ {print $0}'
Finds processes running for more than an hour.

 14) Find pods using high memory in Kubernetes


kubectl top pods -A | awk '$3+0 > 500 {print $1, $2, $3}'
$3 = memory column.

Prints pods using >500Mi memory.

 15) Validate YAML indentation
Catch lines with tabs (which break YAML):



awk '/\t/ {print "Invalid tab at line " NR ":" $0}' config.yaml
 16) Extract failed HTTP requests
From Nginx logs:



awk '$9 ~ /^5/ {print $7}' access.log | sort | uniq -c | sort -nr | head
$9 = status code, $7 = requested URL.

Shows top failing endpoints.

 17) Disk I/O usage from iostat


iostat -dx | awk '$1 ~ /^sd/ && $10 > 80 {print $1, $10"% util"}'
Identifies disks with >80% utilization.

 18) Monitor JVM heap usage
From GC logs like:

csharp

[GC] Heap before: 500M
[GC] Heap after: 300M


awk '/Heap/ {print $3, $4}' gc.log
Extracts before/after heap usage for analysis.

 19) Detect duplicate entries in config
Check for duplicate env variables:



awk -F= '{if (seen[$1]++) print "Duplicate key:", $1}' .env
 20) Parse Docker image sizes


docker images --format "{{.Repository}} {{.Size}}" | awk '$2 ~ /GB/ || $2+0 > 500 {print}'
Flags images larger than 500MB or in GB.

 21) Find most common error codes in logs


awk '/ERROR/ {count[$3]++} END {for (c in count) print c, count[c]}' app.log | sort -k2 -nr
$3 = error code or message part.

Helps prioritize common failures.

 22) Alert on too many failed logins


awk '/Failed password/ {fail++} END {if (fail > 10) print "WARNING: " fail " failed logins"}' /var/log/auth.log
 23) Extract top namespaces in K8s


kubectl get pods -A | awk 'NR>1 {count[$1]++} END {for (ns in count) print ns, count[ns]}' | sort -k2 -nr
Finds namespaces with most pods.

 24) Generate quick CSV from logs
Convert space-separated logs to CSV:



awk '{OFS=","; print $1,$2,$3}' app.log > output.csv
 25) Combine multiple log files with timestamps


awk '{print FILENAME, $0}' *.log | sort -k2
Adds filename + sorts logs chronologically.

 26) Identify largest files in a directory tree


find . -type f -exec ls -lh {} + | awk '{print $5, $9}' | sort -hr | head -10
 27) Extract unique Kubernetes node names


kubectl get pods -o wide | awk 'NR>1 {print $7}' | sort | uniq
 28) Check SSL certificate expiry


echo | openssl s_client -connect example.com:443 2>/dev/null | \
openssl x509 -noout -dates | awk -F= '/notAfter/ {print "Expiry:", $2}'
 29) Report container restart counts


kubectl get pods -A | awk 'NR>1 {restart[$5]+=$5} END {for (ns in restart) print ns, restart[ns]}'
 30) Extract top API consumers by token
From API logs:



awk '{count[$2]++} END {for (token in count) print token, count[token]}' api.log | sort -k2 -nr | head
$2 = token column.

Identifies heavy API users.

```
	---------------------------------------------------------------------------------------------
	Text comparison tools (diff, comm, cmp)
	
	---------------------------------------------------------------------------------------------
	



	
	
	
	 diff Command
	-------------

diff is a file and directory comparison tool in Linux/Unix. It highlights differences between two files or two directories.
It’s especially useful in DevOps, where configuration drift, deployment validation, and troubleshooting are common.

 Basic Usage
diff file1.conf file2.conf


Compares line by line.

Output tells you what needs to change in file1 to make it like file2.

 Output Formats

Normal diff → human-readable differences.

Unified diff (-u) → compact, shows context lines (most popular in code reviews, Git).

Side-by-side diff (-y) → easy to visually compare.

Example:

diff -u file1.conf file2.conf

 Real-World DevOps Use Cases for diff
1. Configuration Drift Detection

When servers should have identical configs (e.g., nginx.conf):

diff /etc/nginx/nginx.conf /backup/nginx.conf


Quickly detects if production config drifted from the reference.

2. Validating Kubernetes Manifests

When you edit Kubernetes YAMLs, you can compare:

diff -u old-deployment.yaml new-deployment.yaml


Shows what changed before applying with kubectl apply -f.

3. CI/CD Pipeline Validation

During deployments, diff can be automated to check if new build artifacts are different:

diff -rq build_v1/ build_v2/


-r → recursive, -q → only report if files differ.

Helps detect if a pipeline produced a new artifact or accidentally redeployed the same version.

4. Troubleshooting Environment Issues

Compare environment variable files across staging and production:

diff staging.env production.env


Quickly spot missing/extra variables.

5. Verifying Ansible/Puppet/Chef Templates

Check if generated configs match expected templates:

ansible all -m copy -a "src=nginx.conf dest=/etc/nginx/nginx.conf"
diff nginx.conf <(ssh server1 cat /etc/nginx/nginx.conf)


Prevents misconfiguration after automation runs.

6. Comparing Dockerfiles or Helm Charts

When debugging image size or vulnerabilities:

diff Dockerfile.old Dockerfile.new
diff -ru helm-chart-v1/ helm-chart-v2/


Shows what changed between chart versions.

7. Log Comparison Across Runs

Compare logs from two executions:

diff job_run1.log job_run2.log


Quickly reveals different error messages or responses.

8. Infrastructure Drift Detection (IaC)

Terraform generates a plan file; you can store and compare them:

terraform plan -out=plan1.out
terraform plan -out=plan2.out
diff plan1.out plan2.out


Detects infrastructure drift across runs.

9. Debugging System Package Updates

Compare package lists before and after an update:

diff <(rpm -qa | sort) <(ssh server2 rpm -qa | sort)


Detects missing or extra packages.

10. Monitoring Secrets and Certificates

Compare old and new certificates:

diff old-cert.pem new-cert.pem


Ensures correct updates (no accidental change in CN, SAN, expiry).

 Summary of Why diff Matters in DevOps

 Configuration Management → detect drift between environments.

 CI/CD Pipelines → ensure deployments actually introduce changes.

 IaC Validation → catch unplanned differences before applying changes.

 Troubleshooting → compare logs, environment variables, configs.

 Security → verify secrets, certs, and config files.

 A lot of DevOps teams combine diff with vimdiff, colordiff, or even meld for more visual inspection when working interactively.




```
 comm Command in DevOps
-----------------------
The comm command in Linux compares two sorted files line by line and shows common lines and differences.

It’s a set operation tool (like UNION, INTERSECTION, DIFFERENCE) for text data.

This is especially handy in DevOps where we often deal with lists of servers, users, configs, logs, or package inventories.

 Syntax
comm [options] file1 file2


Both file1 and file2 must be sorted.

 Default Output Columns

Column 1 → Lines only in file1

Column 2 → Lines only in file2

Column 3 → Lines common to both

 Options

-1 → Suppress column 1 (hide unique to file1)

-2 → Suppress column 2 (hide unique to file2)

-3 → Suppress column 3 (hide common lines)

⚙️ Real-World DevOps Use Cases of comm
1. Server Inventory Management

Compare servers in production vs staging:

sort prod_servers.txt -o prod_servers.txt
sort stage_servers.txt -o stage_servers.txt

comm prod_servers.txt stage_servers.txt


Column 1 → servers only in prod

Column 2 → servers only in staging

Column 3 → servers common to both

 Helps detect inventory drift.

2. User/Access Control Validation

Compare users in /etc/passwd with a standard allowed list:

cut -d: -f1 /etc/passwd | sort > system_users.txt
sort allowed_users.txt > allowed_users.txt

comm -23 system_users.txt allowed_users.txt


-23 → hide columns 2 & 3, only show extra system users not in policy.
 Helps detect unauthorized accounts.

3. Kubernetes Resource Validation

Compare running pods vs expected pods list:

kubectl get pods -o name | sort > running_pods.txt
sort expected_pods.txt > expected_pods.txt

comm -23 running_pods.txt expected_pods.txt


Shows pods that exist but are not expected.
 Detects rogue or leftover pods.

4. Log Analysis Across Runs

Compare error logs from two different deployments:

sort errors_run1.log > run1.log
sort errors_run2.log > run2.log

comm -12 run1.log run2.log


-12 → hide columns 1 & 2, only show common errors.
 Helps spot persistent errors across releases.

5. Package/Dependency Validation

Check if all required packages are installed:

rpm -qa | sort > installed.txt
sort required_packages.txt > required.txt

comm -23 required.txt installed.txt


Shows packages that are required but missing.
 Detects misconfigured servers.

6. CI/CD Pipeline Output Comparison

When comparing build artifacts list:

ls build_v1/ | sort > build1.txt
ls build_v2/ | sort > build2.txt

comm -3 build1.txt build2.txt


Shows differences in artifacts between builds.
 Useful for release validation.

7. Secrets & Config Drift Detection

Compare env files in staging and prod:

sort staging.env > staging_sorted.env
sort prod.env > prod_sorted.env

comm staging_sorted.env prod_sorted.env


Column 1 → staging-only secrets

Column 2 → prod-only secrets

Column 3 → shared secrets
 Ensures config consistency across environments.

8. Terraform / IaC Validation

Compare current Terraform state vs desired resources:

terraform state list | sort > current_state.txt
sort desired_resources.txt > desired_state.txt

comm -23 desired_state.txt current_state.txt


Shows resources in IaC that are not yet deployed.
 Prevents IaC drift.

9. Monitoring Alert Comparison

Compare alerts from two monitoring systems:

sort prometheus_alerts.txt > prom.txt
sort datadog_alerts.txt > ddog.txt

comm -12 prom.txt ddog.txt


Shows alerts detected by both systems.
 Helps validate monitoring consistency.

10. Network Policy Validation

Compare firewall rules vs expected rules:

iptables-save | sort > current_rules.txt
sort expected_rules.txt > expected_rules.txt

comm -23 expected_rules.txt current_rules.txt


Lists missing firewall rules.
 Prevents security misconfigurations.

 Why DevOps Engineers Use comm

 Inventory Drift Detection → servers, packages, configs.

 Security Audits → detect unauthorized users or missing firewall rules.

 CI/CD Validation → ensure builds/deployments produce expected artifacts.

 Troubleshooting → compare logs, alerts, or pod lists across runs.

 Consistency Enforcement → verify staging vs production alignment.

 Think of comm as a fast "set difference" tool for text-based data, while diff is more for line-by-line contextual differences.

Would you like me to also prepare a side-by-side comparison of comm vs diff for DevOps use cases so you’ll know exactly when to use which?





	cmp Command
	------------
The cmp (compare) command compares two files byte by byte.

If they’re identical, it outputs nothing (exit code 0).

If they differ, it shows the byte number and line number of the first difference (exit code 1).

It can also be used to check only whether files are identical without dumping differences.

 Unlike diff (which is line-based) or comm (set-based for sorted lists), cmp works at the raw binary/byte level.

 Syntax
cmp [options] file1 file2

 Common Options

-s → Silent mode, just return exit code (0 if same, 1 if different).

-l → Print all differing bytes, not just the first one.

--bytes=N → Compare only the first N bytes.

--skip1=N, --skip2=N → Skip bytes at start of file1 or file2.




Real-World DevOps Use Cases of cmp
1. Verify Config File Consistency

When syncing config files across servers:

cmp -s /etc/nginx/nginx.conf backup/nginx.conf
if [ $? -ne 0 ]; then
   echo "Config drift detected for nginx.conf!"
fi


 Detects configuration drift in Nginx, Apache, HAProxy, etc.


2. Validate Secrets Across Environments

Ensure staging.env and prod.env are not mistakenly identical:

cmp -s staging.env prod.env || echo "Files differ (as expected)."


 Prevents accidental deployment of staging secrets into production.

3. Binary File Comparison

Compare Docker images (saved as tar files):

docker save myapp:latest -o app_latest.tar
docker save myapp:stable -o app_stable.tar

cmp -s app_latest.tar app_stable.tar && echo "Images are identical"


 Ensures image reproducibility in CI/CD pipelines.

4. Validate SSL/TLS Certificates

Ensure certs are consistent across load balancers:

cmp -s /etc/ssl/certs/prod.crt /mnt/backup/prod.crt \
  || echo "SSL cert mismatch!"


 Avoids certificate mismatch errors in HA/clustered environments.

5. Check Package Integrity

Verify downloaded packages vs baseline copy:

cmp -s /tmp/nginx.rpm /artifacts/nginx.rpm \
  || echo "Corrupted or tampered package!"


 Acts as a quick integrity check (alternative to checksums).

6. CI/CD Artifact Validation

Compare build outputs between environments:

cmp build_v1/app.jar build_v2/app.jar


 Detects if a pipeline change introduced binary-level differences.

7. Validate Backup Files

Ensure a database dump backup matches source:

pg_dump mydb > dump1.sql
pg_dump mydb > dump2.sql

cmp -s dump1.sql dump2.sql && echo "Backup verified"


 Helps detect silent corruption in backups.

8. Container Volume Sync Validation

Ensure two volume snapshots are identical:

cmp -s /mnt/vol1/data.db /mnt/vol2/data.db \
  || echo "Mismatch in database volumes!"


 Detects data drift across replicated volumes.

9. Kubernetes ConfigMap/Secret Sync

Compare ConfigMap manifests in Git vs cluster:

kubectl get configmap app-config -o yaml > live.yaml
cmp -
```	
	---------------------------------------------------------------------------------------------
	Advanced text processing techniques
	
	---------------------------------------------------------------------------------------------
	


Field manipulation & calculations (excute these in awk folder )

	awk '{sum += $2} END {print sum}' data.txt  # Sum 3rd column


Conditional processing

in awk folder 

	awk '$2 > 24 {print $1, $3}' data.txt



Multi-character field separators

	awk -F',' '{print $1, $2}' file.csv



Regular expressions in awk

	awk '$2 ~ /^error/' logfile.txt  # 2nd column starts with error
	awk '$2 ~ /^2/' data.txt 

Built-in functions

	toupper(), tolower(), length(), substr(), gsub() for replacements.



Complex sed Usage

Multi-line patterns



2. sed -n '/START/,/END/p' file.txt  # Print block between markers


Insert, append, change lines

sed '/pattern/i\New line before' file.txt
sed '/pattern/a\New line after' file.txt
sed '/pattern/c\Replace entire line' file.txt


Regex groups and backreferences

sed -E 's/(user)([0-9]+)/\1-\2/' file.txt


In-place editing with backup

sed -i.bak 's/old/new/g' file.txt




3️. grep / egrep / fgrep Power

Recursive search

grep -R 'TODO' ./project


Context lines

grep -C3 'error' logfile.txt  # 3 lines before and after
grep -B2 'error' logfile.txt  # Before
grep -A2 'error' logfile.txt  # After




Perl-compatible regex

grep -P '\d{4}-\d{2}-\d{2}' file.txt


Color highlighting & counting

grep --color=auto 'pattern' file.txt
grep -c 'pattern' file.txt  # Count matches




4️. cut, paste, and Column Operations

Extract fields from text files:

cut -d',' -f1,3 file.csv


Merge columns from multiple files:

paste file1.txt file2.txt

sort, uniq, and Data Summarization

Sort numerically or alphabetically

sort -n numbers.txt
sort -k2,2 file.txt  # Sort by 2nd column


Remove duplicates

sort file.txt | uniq
sort file.txt | uniq -c  # Count occurrences

tr / fold / fmt for Text Transformation

Character translation

tr 'a-z' 'A-Z' < file.txt
tr -d '\r' < windowsfile.txt > unixfile.txt  # Remove CR


Wrap lines

fold -w 80 file.txt
fmt -w 80 file.txt


xargs / find / parallel Integration

Process multiple files efficiently:

find . -name '*.log' | xargs grep 'ERROR'
find . -name '*.txt' -print0 | xargs -0 sed -i 's/foo/bar/g'
parallel grep 'TODO' ::: *.txt

perl and python for Advanced Regex / Multi-line Edits

Perl inline editing

perl -pe 's/\d{4}-\d{2}-\d{2}/DATE/g' file.txt
perl -i.bak -pe 's/old/new/g' file.txt


Python one-liners

python3 -c "import re; print(re.sub(r'\d{4}-\d{2}-\d{2}','DATE', open('file.txt').read()))"




Log Parsing & Aggregation

Extract IPs

awk '{print $1}' access.log | sort | uniq -c | sort -nr


Extract URLs

sed -n 's/.*"GET \([^ ]*\) .*/\1/p' access.log




Anonymize PII

sed -E 's/[0-9]{3}-[0-9]{2}-[0-9]{4}/XXX-XX-XXXX/g' file.txt





Combining Tools in Pipelines

Chain multiple tools for powerful workflows:

cat access.log | grep 'GET' | awk '{print $7}' | sort | uniq -c | sort -nr


Example: mask IPs and extract URLs:

sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log \
| sed -n 's/.*"GET \([^ ]*\) .*/\1/p'




	---------------------------------------------------------------------------------------------
	Shell script with grep, sed, awk and diff
	-----------------------------------------
```	
Imagine you have:

A baseline config file (baseline.conf) stored in Git (your “golden” config).

A live config file (/etc/myapp/config.conf) running in production.

We want to:

Extract only relevant lines (ignoring comments).

Normalize formatting (remove extra spaces).

Summarize key-value pairs.

Compare baseline vs live config.

Print a nice summary report.



Shell Script: check_config_drift.sh


#!/bin/bash
# Script: check_config_drift.sh
# Purpose: Detect config drift using grep, sed, awk, and diff

BASELINE="baseline.conf"
LIVE="/etc/myapp/config.conf"
TMP_BASELINE="/tmp/baseline_clean.conf"
TMP_LIVE="/tmp/live_clean.conf"

echo "Starting Config Drift Check..."

# 1. Extract relevant lines (ignore comments & blank lines) using grep
grep -Ev '^\s*#|^\s*$' "$BASELINE" > "$TMP_BASELINE.raw"
grep -Ev '^\s*#|^\s*$' "$LIVE" > "$TMP_LIVE.raw"


# 2. Normalize formatting (remove extra spaces around =) using sed
sed -E 's/\s*=\s*/=/' "$TMP_BASELINE.raw" > "$TMP_BASELINE"
sed -E 's/\s*=\s*/=/' "$TMP_LIVE.raw" > "$TMP_LIVE"

# 3. Summarize using awk (count parameters, show top 5)
echo " Baseline config summary:"
awk -F= '{print $1}' "$TMP_BASELINE" | sort | uniq -c | head -5

echo " Live config summary:"
awk -F= '{print $1}' "$TMP_LIVE" | sort | uniq -c | head -5

# 4. Compare using diff
echo " Comparing Baseline vs Live..."
DIFF_OUTPUT=$(diff -u "$TMP_BASELINE" "$TMP_LIVE")

if [ -z "$DIFF_OUTPUT" ]; then
    echo " No config drift detected!"
else
    echo "️ Config drift found!"
    echo "$DIFF_OUTPUT"
fi

# 5. Cleanup
rm -f "$TMP_BASELINE" "$TMP_LIVE" "$TMP_BASELINE.raw" "$TMP_LIVE.raw"

Example Input Files

baseline.conf

# Baseline config
host = db.example.com
port = 5432
debug = false
timeout = 30


/etc/myapp/config.conf

# Production config
host = db.example.com
port=5433
debug=true
timeout=30

 Example Run
$ ./check_config_drift.sh
Starting Config Drift Check...
Baseline config summary:
      1 debug
      1 host
      1 port
      1 timeout
Live config summary:
      1 debug
      1 host
      1 port
      1 timeout
Comparing Baseline vs Live...
Config drift found!
--- /tmp/baseline_clean.conf  2025-09-17 12:01:00
+++ /tmp/live_clean.conf      2025-09-17 12:01:00
@@ -1,4 +1,4 @@
 host=db.example.com
-port=5432
-debug=false
+port=5433
+debug=true
 timeout=30


What this script demonstrates:

grep → filters only relevant config lines
sed → normalizes whitespace for consistency
awk → summarizes keys & values
diff → highlights differences (config drift)