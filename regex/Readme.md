# Regular Expressions (Regex) – Simple Tutorial

Regular Expressions (Regex) are patterns used to search, match, and manipulate text. Think of them as **smart search filters** that help you find text patterns in strings.

---

## 1. Basic Characters

- `a` – matches the character **a**  
- `abc` – matches the exact sequence **abc**

 Example:  
Pattern: `cat`  
Matches: `cat`, `concatenate`  
Doesn’t Match: `dog`

---

## 2. Special Symbols

### Dot `.`
- Matches **any single character** (except newline).  
Example: `c.t` → matches `cat`, `cut`, `c@t`
	grep 'c.t' test.txt 

---

### Square Brackets `[]`
- Match **any character inside the brackets**.  
Example:  
- `[aeiou]` → matches any vowel  
- `[0-9]` → matches digits 0 to 9  
- `[A-Z]` → matches uppercase letters  


---

### Negation `[^ ]`
- Matches characters **not** in the brackets.  
Example: `[^0-9]` → matches any non-digit  

grep -E '[^0-9]' test.txt 


---

## 3. Quantifiers

- `*` → 0 or more times  
- `+` → 1 or more times  
- `?` → 0 or 1 time  
- `{n}` → exactly n times  
- `{n,}` → at least n times  
- `{n,m}` → between n and m times  



 Examples:  
- `a*` → `""`, `a`, `aa`, `aaa`  
- `a+` → `a`, `aa`, `aaa` (but not empty)  
- `a{2,4}` → `aa`, `aaa`, `aaaa`  

---

## 4. Anchors

- `^` → start of string  
- `$` → end of string  

 Example:  
- `^hello` → matches strings starting with "hello"  
- `world$` → matches strings ending with "world"  

---

## 5. Predefined Classes

- `\d` → digit (0–9)  
- `\D` → non-digit  
- `\w` → word character (letters, digits, `_`)  
- `\W` → non-word character  
- `\s` → whitespace (space, tab, newline)  
- `\S` → non-whitespace  

 Example:  
- `\d{3}` → matches 3-digit numbers like `123`, `456`  

---

Perl/PCRE shorthand		POSIX equivalent				Meaning
\d						[0-9] or [[:digit:]]			Digit 0–9
\D						[^0-9] or [^[:digit:]]			Non-digit
\w						[A-Za-z0-9_] or [[:alnum:]_]	Word char (letters, digits, underscore)
\W						[^A-Za-z0-9_] or [^[:alnum:]_]	Non-word char
\s						[[:space:]]						Whitespace (space, tab, newline, vertical tab, form feed, carriage return)
\S						[^[:space:]]					Non-whitespace

## 6. Grouping & Alternation

- `(abc)` → groups characters together  
- `|` → OR operator  

PCRE construct		POSIX Basic 		Regex (BRE)	POSIX Extended Regex (ERE, grep -E)	Notes
(abc) – grouping	\(abc\)				(abc)	BRE requires escaping parentheses
`					` – alternation(OR)	expr1|expr2	`expr1

 Examples:  
- `(cat|dog)` → matches either `cat` or `dog`  
- `(ha)+` → matches `ha`, `hahaha`, etc.  

---

## 7. Putting It All Together

Pattern:  

^\d{3}-\d{2}-\d{4}$


Explanation:  
- `^` → start of string  
- `\d{3}` → 3 digits  
- `-` → dash  
- `\d{2}` → 2 digits  
- `-` → dash  
- `\d{4}` → 4 digits  
- `$` → end of string  

Matches: `123-45-6789` (like a US SSN format)  

---

## 8. Practice Examples

- **Email:**  
	^[\w.-]+@[\w.-]+.\w+$

- **Phone (US):**  
^
\d
3


\d3\s\d{3}-\d{4}$

Example: `(123) 456-7890`  


- **Only letters:**  
^[A-Za-z]+$























# Regular Expressions – Practice Exercises

---

## Instructions
- Try to solve each problem by writing a regex pattern.  
- Test using [regex101.com](https://regex101.com) or Python’s `re` module.  
- Solutions are provided at the bottom — no peeking until you’ve tried 

---

## Part 1: Beginner

1. **Find all 3-letter words** in a sentence.  
   Example: `The cat ran far but dog won.` → `cat, ran, far, dog`

2. **Match all digits** in the text:  
   `"Order 123 shipped on 05/09/2025"` → `1, 2, 3, 0, 5, 0, 9, 2, 0, 2, 5`

3. **Match words starting with capital letters.**  
   Example: `Alice went to New York` → `Alice, New, York`

4. **Match only “cat” or “dog”.**

---

## Part 2: Intermediate

5. **Extract all email addresses.**  
   `"Contact: test@example.com, admin@mysite.org"`

6. **Match valid dates** in format `dd-mm-yyyy` or `dd/mm/yyyy`.  
   Example: `12-09-2025`, `01/01/1999`

7. **Extract phone numbers** that may start with `+91` or just `0`.  
   Examples: `+919876543210`, `09876543210`

8. **Match all hashtags** in a tweet.  
   Example: `#fun #coding #Regex101`

---

## Part 3: Advanced

9. **Extract IPv4 addresses.**  
   Example: `My server is 192.168.1.10 and gateway 10.0.0.1`

10. **Validate strong passwords** (at least 8 chars, one uppercase, one lowercase, one digit, one special char).  

11. **Extract quoted text** (anything inside double quotes).  
   Example: `He said "Hello World" and left.` → `"Hello World"`

12. **Extract HTML tags** from text.  
   Example: `<div>Hello</div>` → `<div>`, `</div>`

---

#  Solutions

### Part 1
1. `\b\w{3}\b`  
2. `\d`  
3. `\b[A-Z][a-zA-Z]*\b`  
4. `\b(cat|dog)\b`  

### Part 2
5. `[\w\.-]+@[\w\.-]+\.\w+`  
6. `\b\d{2}[-/]\d{2}[-/]\d{4}\b`  
7. `(?:\+91|0)?[0-9]{10}`  
8. `#\w+`  

### Part 3
9. `\b(?:\d{1,3}\.){3}\d{1,3}\b`  
10. `^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$`  
11. `"(.*?)"`  
12. `<[^>]+>`  

---

 **Tip:** Don’t just copy-paste — tweak regex patterns, break them down, and test edge cases.
Would you like me to also add a mini project-style challenge at the end (like parsing a log file or validating CSV rows with regex)? That can help connect the dots between theory and real-world use.









Here’s the full updated  content:



# Regular Expressions – Practice Exercises

---

##  Instructions
- Try to solve each problem by writing a regex pattern.  
- Test using [regex101.com](https://regex101.com) or Python’s `re` module.  
- Solutions are provided at the bottom — no peeking until you’ve tried 

---

## Part 1: Beginner

1. **Find all 3-letter words** in a sentence.  
   Example: `The cat ran far but dog won.` → `cat, ran, far, dog`

2. **Match all digits** in the text:  
   `"Order 123 shipped on 05/09/2025"` → `1, 2, 3, 0, 5, 0, 9, 2, 0, 2, 5`

3. **Match words starting with capital letters.**  
   Example: `Alice went to New York` → `Alice, New, York`

4. **Match only “cat” or “dog”.**


## Part 2: Intermediate

5. **Extract all email addresses.**  
   `"Contact: test@example.com, admin@mysite.org"`

6. **Match valid dates** in format `dd-mm-yyyy` or `dd/mm/yyyy`.  
   Example: `12-09-2025`, `01/01/1999`

7. **Extract phone numbers** that may start with `+91` or just `0`.  
   Examples: `+919876543210`, `09876543210`

8. **Match all hashtags** in a tweet.  
   Example: `#fun #coding #Regex101`

---

## Part 3: Advanced

9. **Extract IPv4 addresses.**  
   Example: `My server is 192.168.1.10 and gateway 10.0.0.1`

10. **Validate strong passwords** (at least 8 chars, one uppercase, one lowercase, one digit, one special char).  

11. **Extract quoted text** (anything inside double quotes).  
   Example: `He said "Hello World" and left.` → `"Hello World"`

12. **Extract HTML tags** from text.  
   Example: `<div>Hello</div>` → `<div>`, `</div>`

---

## Part 4: Mini Projects (Real-World Challenges)

13. **Log File Parsing (Apache Logs)**  
   Extract IP, date, method, URL, and status code from a log entry like:  
127.0.0.1 - - [15/Sep/2025:10:30:45 +0530] "GET /index.html HTTP/1.1" 200 1024



Goal: Regex should capture groups for:
- IP Address
- Timestamp
- HTTP Method
- URL
- Status Code  

14. **CSV Validation**  
Match valid CSV rows with 3 fields: `Name,Email,Age`.  
Example valid row:  
John Doe,john@example.com,25

css


15. **Extract JSON Keys**  
From a JSON snippet, extract all keys.  
Example:  
```json
{"name": "Alice", "age": 30, "email": "alice@test.com"}
Expected matches: name, age, email.

Scrape URLs
Extract all http:// or https:// URLs from text.


```


Solutions
--------------


Part 1
\b\w{3}\b	or (^|[^[:alnum:]_])[[:alnum:]_]{3}([^[:alnum:]_]|$)


\d	or [0-9]   # or  [[:digit:]]


\b[A-Z][a-zA-Z]*\b	or [0-9]   # or  [[:digit:]]


\b(cat|dog)\b	or (^|[^[:alnum:]])(cat|dog)([^[:alnum:]]|$)


Part 2
[\w\.-]+@[\w\.-]+\.\w+	or [[:alnum:]._-]+@[[:alnum:].-]+\.[[:alnum:]]+


\b\d{2}[-/]\d{2}[-/]\d{4}\b 	

(?:\+91|0)?[0-9]{10}

#\w+

Part 3
\b(?:\d{1,3}\.){3}\d{1,3}\b

^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$

"(.*?)"

<[^>]+>

Part 4 (Mini Projects)
^(\d{1,3}(?:\.\d{1,3}){3}) .* \[(.*?)\] "(GET|POST|PUT|DELETE) (.*?) HTTP/.*" (\d{3})

^[^,]+,[\w\.-]+@[\w\.-]+\.\w+,\d{1,3}$

"(.*?)":

https?:\/\/[^\s]+














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

## Negative Lookbehind `(?<!...)`
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



## 11. Match Nested Braces with Balancing Groups

 Pattern (PCRE/Oniguruma):
```regex
\{(?:[^{}]+|(?R))*\}
Use Case:

Parsing nested JSON-like structures or templating languages that use braces {...}.

Example: {"user": {"id": 1, "name": "Alex"}} → Matches the whole balanced block.
```

12. Password Validation with Lookahead
 Pattern:

```regex

^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$
Use Case:

Enforcing password policies in signup forms.

Requires uppercase, lowercase, number, special character, and min length.

Example: Hello@123 , password .
```
13. Detect Duplicate Words
 Pattern:

```regex

\b(\w+)\s+\1\b
Use Case:

Detecting typos in text where users accidentally repeat words.

Example: "This is is a mistake." → Highlights "is is".

Useful in proofreading tools.
```

14. Palindrome Matching (Fixed Length)
 Pattern (4 letters):

```regex

^(\w)(\w)\2\1$
Use Case:

Checking for short palindromes in DNA sequences or usernames.

Example: "abba", "1221".

Useful in bioinformatics or pattern analysis.

```
15. Conditional Matching
 Pattern:

```regex

^(a)?(?(1)b|c)$
Use Case:

Matching different rules based on context.

Example:

"ab"  if starts with a.

"c"  if no a.

Used in custom parsers where some fields are optional but change validation rules.
```

16. Quoted Strings with Escapes
 Pattern:

```regex

"([^"\\]*(\\.[^"\\]*)*)"
Use Case:

Extracting quoted strings from code or CSV files.

Handles escaped quotes: "He said \"hello\"" → Correctly matches the whole string.

Common in compiler design or data parsing.

```

17. Overlapping Matches with Lookahead
 Pattern:

```regex

(?=(\w{3}))
Use Case:

Finding all substrings of fixed length.

Example: "abcdef" → Matches abc, bcd, cde, def.

Useful in DNA sequencing, plagiarism detection, or sliding-window algorithms.

```
18. Possessive Quantifiers for Speed
 Pattern:

```regex

a*+b
Use Case:

Preventing backtracking performance issues in logs with long repetitive patterns.

Example: Searching "aaaaaaab" quickly without backtracking.

Useful in log analyzers or security filters to prevent ReDoS (Regex Denial of Service).
```

19. Inline Mode Modifiers
 Pattern:

```regex

(?i)hello
Use Case:

Making searches case-insensitive only where needed.

Example: "Hello", "HELLO", "hello" all match.

Used in search engines, chat filters, or form validations.

```

20. Match IPv6 Addresses
 Pattern:

```regex

^([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}$
Use Case:

Validating IPv6 addresses in networking apps, firewall rules, or server configs.

Example: "2001:0db8:85a3:0000:0000:8a2e:0370:7334".

Critical in cloud infrastructure and networking tools.
```

21. Date Validation (YYYY-MM-DD)
 Pattern:

```regex

^(?:(?:19|20)\d\d)-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12]\d|3[01])$
Use Case:

Ensuring valid date formats in databases or forms.

Example: 2025-09-15 , 2025-13-40 .

Used in financial apps, healthcare records, APIs.
```


----------------------------------------------------------------------
Complex regex examples 
----------------------------------------------------------------------


31. Extract Failed Login Attempts from Logs

```Regex

Failed\s+password\s+for\s+(invalid\s+user\s+)?(\w+)\s+from\s+([\d\.]+)


Use Case

Parse /var/log/auth.log to find failed SSH login attempts.

Captures:

Optional "invalid user"

Username

IP address

grep -Po 'Failed\s+password\s+for\s+(invalid\s+user\s+)?(\w+)\s+from\s+([\d\.]+)' /var/log/auth.log


 Helps detect brute-force attacks.
```

32. Validate Semantic Version Numbers

```Regex

^v?(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-(alpha|beta|rc)\.\d+)?$


Use Case

Ensure Docker tags or Helm chart versions follow SemVer.

Examples matched:

v1.0.0

2.3.4-beta.1

 Enforce consistent versioning in CI/CD pipelines.
```

33. Extract Pod Names with Environment Prefix

```Regex

^(dev|staging|prod)-[a-z0-9-]+-[a-z0-9]{5}$


Use Case

Match Kubernetes pod names like prod-nginx-app-5fd89.

Ensures pod naming convention: <env>-<service>-<hash>.

 Useful in cluster auditing and policy enforcement (OPA/Kyverno).
```
34. Identify IPs Not in Private Ranges

```Regex

^(?!10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1]))\d{1,3}(\.\d{1,3}){3}$


Use Case

Detect public IPs in config files (to avoid data leaks).

grep -Po '^(?!10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1]))\d{1,3}(\.\d{1,3}){3}$' configs/*


 Catch misconfigured public endpoints in IaC or YAML.
```
35. Extract AWS Resource ARNs

```Regex

^arn:aws:[a-z0-9-]+:[a-z0-9-]*:\d{12}:[^:\s]+(:[^:\s]+)*$


Use Case

Parse Terraform state files or logs to pull out AWS ARNs.

Example match:

arn:aws:iam::123456789012:user/DevOpsUser

 Helps with IAM audits and resource inventorying.
```
36. Find Hardcoded Secrets (API Keys)

```Regex

(?i)(api[_-]?key|secret|token)["']?\s*[:=]\s*["']?[A-Za-z0-9_\-]{20,}


Use Case

Detect secrets accidentally committed to Git repos.

grep -Po '(?i)(api[_-]?key|secret|token)["']?\s*[:=]\s*["']?[A-Za-z0-9_\-]{20,}' *.py


 Shift-left security for DevOps teams.

```
37. Extract Failed HTTP Requests from Access Logs

```Regex

\"(GET|POST|PUT|DELETE)\s+[^\"]+\"\s+(4\d{2}|5\d{2})\s


Use Case

Match log lines with 4xx or 5xx responses in Nginx/Apache logs.

grep -Po '\"(GET|POST|PUT|DELETE)\s+[^\"]+\"\s+(4\d{2}|5\d{2})\s' access.log


 Quickly identify error-prone API endpoints.

```
 38. Ensure Strong Password Policy

```Regex

^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{12,}$


Use Case

Validate Kubernetes Secret or Vault password strength.

 Enforces DevSecOps password policy.
```

 39. Extract CRON Expressions

```Regex

^(\*|[0-5]?\d)\s+(\*|1?\d|2[0-3])\s+(\*|[1-9]|[12]\d|3[01])\s+(\*|[1-9]|1[0-2])\s+(\*|[0-6])$


Use Case

Parse Kubernetes CronJob YAML to extract valid cron expressions.

 Helps validate scheduler jobs before deployment.

```
 40. Match Terraform Variable Declarations

```Regex

variable\s+"([a-zA-Z0-9_]+)"\s*{[^}]*}


Use Case

Extract all variables defined in .tf files.

grep -Po 'variable\s+"([a-zA-Z0-9_]+)"\s*{[^}]*}' *.tf
```