
 1. Find and Replace Text

The most common use is search and replace:

sed 's/error/warning/' file.txt
	Replaces the first occurrence of the word error with warning in each line.

sed 's/error/warning/g' file.txt
	Replaces all occurrences (g = global) of error with warning in each line.

 2. Editing Files in Place
sed -i 's/8080/9090/g' file.txt
	Changes port 8080 → 9090 directly inside the file (in-place edit).
	Useful for config updates in automation scripts.

 3. Delete Lines
sed '/^#/d' file.txt
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
sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2}/DATE/g' file.txt
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

To anonymize IPs in logs:
	sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log
		-E - extended regular expression 


To extract data, this gets URLs:
	sed -n 's/.*"GET \([^ ]*\) .*/\1/p' access.log
		-n: don't print unless mentioned 
		
		.*"GET \([^ ]*\) .*
		.* → match everything up to "GET .
		"GET → literally match the string GET (with a space).
		\([^ ]*\) →
		\( … \) → capture group in basic regex (in ERE you’d use (...)).
		[^ ]* → match zero or more characters that are NOT a space → so this grabs the requested path/URL.
		.* → match the rest of the line after the path.

		Replace with \1
			Refers to the first captured group after GET.
			So it prints only what was inside the parentheses — the path

Use sed in CI for environment variables:
	sed -e "s|__IMAGE__|$IMAGE|g" -e "s|__TAG__|$TAG|g" template.yaml > out.yaml
		-e: execute multiple sed commands 

To avoid slash escaping, you can use a different delimiter like |:
	sed 's|/old/path|/new/path|g'


For extended regular expressions, use -E:
	sed -E 's/.../.../'


For portability, -E works on both macOS BSD and GNU sed. It’s best to stick with -E for compatibility.

For batch renaming files, sed can’t rename directly, but this works:
	for f in *; do mv "$f" "$(echo "$f" | sed 's/old/new/')"; done


- jq or awk for JSON or complex data tasks.



Nice — here’s a thorough, practical guide to text manipulation with sed focused on real-world DevOps use cases. It’s Markdown so you can paste it into docs or a README.


To delete or insert lines based on a pattern, use:
	sed -i '/pattern/i\new line' file


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
```
2) Template substitution in CI/CD pipelines
```
Replace placeholders in Kubernetes manifest templates during CI:

IMAGE="myrepo/app:$TAG"
sed -E "s|__IMAGE__|${IMAGE}|g; s|__REPLICAS__|${REPLICAS}|g" deployment.tpl.yaml > deployment.yaml
kubectl apply -f deployment.yaml


Advice: For YAML edits prefer yq for structured edits; sed is fine for simple tokens.

```
3) In-place edits with backups (safe automation)

```
sed -i.bak -E 's/DEBUG=true/DEBUG=false/' /etc/myapp/config.ini
# verify, then remove backups if all good:
rm /etc/myapp/config.ini.bak
```

4) Redact sensitive info in logs (PII / IPs)
```
Anonymize IPv4 addresses:

sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/REDACTED_IP/g' access.log > access.redacted.log


Use Case: Shipping logs to third-party analytics while hiding IPs.
```
5) Extract fields from logs (parsing)
```
Get request path from Apache-like logs:

sed -n 's/.*"GET \([^ ]*\) .*/\1/p' access.log


Pipe to sort | uniq -c to produce hit counts.

```
6) Replace image tags for a rolling deploy
```
Dangerous if used blindly — prefer kubectl set image. But for CI templating:

sed -E "s|(image:\s*)([^:]+):([^[:space:]]+)|\1\2:${NEW_TAG}|" deployment.yaml > patched.yaml
kubectl apply -f patched.yaml
```
7) Replace a block (multiline) between markers
```
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
```
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
