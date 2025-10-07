##  Basics – Matching Simple Text
1. `cat` → matches "cat" in "my cat is cute".
	grep cat test.txt 
2. `dog` → matches "dog" in "hotdog".
	grep dog test.txt 
3. `hello` → matches "hello" in "hello world".
	grep hello test.txt 
4. `abc123` → matches "abc123" in "xyzabc123".
	grep abc123 test.txt 
5. `foo|bar` → matches either "foo" or "bar".
	grep 'foo|bar' test.txt
		will not work 
	grep -E 'foo|bar' test.txt
		will work 
		-E: Extended Regular Expressions
		
		
---

##  Character Classes
	
	grep pattern test.txt 
	
	[] - matches any character in the set 
6. `[aeiou]` → matches any vowel in "regex".
	grep '[aeiou]' file.txt 
7. `[0-9]` → matches any digit (same as `\d`).
8. `[A-Z]` → matches capital letters only.
9. `[^0-9]` → matches any character that is not a digit.
10. `[a-zA-Z]` → matches both lowercase and uppercase letters.

---

##  Predefined Classes


	grep -P pattern test.txt
		perl regex. This is not working on windows. 


11. `\d` → matches a digit (`0-9`).
12. `\D` → matches a non-digit.
13. `\w` → matches word characters (`a-z`, `A-Z`, `0-9`, `_`).
14. `\W` → matches non-word characters.
15. `\s` → matches whitespace (spaces, tabs, newlines).
16. `\S` → matches non-whitespace.

---

##  Quantifiers

	grep -E pattern test.txt 

17. `a+` → one or more "a"s (matches "aaa").
18. `a*` → zero or more "a"s (matches "", "a", "aa").
19. `a?` → zero or one "a".

Below are perl compliant and will not work by default 
20. `\d{3}` → exactly 3 digits (e.g., "123").
21. `\d{2,4}` → between 2 and 4 digits.
22. `\d{2,}` → at least 2 digits.

instead 
	grep '[0-9]' test.txt 
	grep '[:digit:]' test.txt 
	grep '[:digit:]{3' test.txt 
	grep '[:digit:]{2,4}' test.txt 
	grep '[:digit:]{2,}' test.txt 
	

---

##  Anchors
23. `^hello` → matches "hello" only at the start of a line.
24. `world$` → matches "world" only at the end of a line.
25. `^$` → matches an empty line.

---

##  Groups and Capturing
	this doesn't work in windows 
26. `(abc)` → captures "abc" as a group.
27. `(foo|bar)` → matches "foo" or "bar".
28. `([0-9]{4})-([0-9]{2})-([0-9]{2})` → captures YYYY-MM-DD.
29. `(\w+)@(\w+)\.(\w+)` → captures parts of an email.
30. `(\d+)\s*(ms|s)` → captures "200ms" or "5s" as time.

---

##  Real World Strings
31. `https?://\S+` → matches a URL starting with http/https.
32. `[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}` → email address.
33. `\+?[0-9]{1,3}-[0-9]{10}` → phone number with optional country code.
34. `#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})` → hex color code.
35. `[0-9]{1,3}(\.[0-9]{1,3}){3}` → IPv4 address.

---

##  Assertions (Lookaheads/Lookbehinds)
	Pearl compliant  - use grep -P in a compliant machine 
36. `foo(?=bar)` → matches "foo" only if followed by "bar".
	
	Instead use grep -o 'foobar' test.txt  | sed 's/bar//'

37. `foo(?!bar)` → matches "foo" only if NOT followed by "bar".
	grep 'foo' test.txt | grep -v 'foobar'
38. `(?<=ID:)\d+` → matches digits only if preceded by "ID:".
39. `(?<!\$)\d+` → matches digits not preceded by `$`.

---

##  Practical DevOps Use Cases
40. `ERROR.*` → find error logs in `app.log`.
41. `WARN|ERROR` → find warnings and errors.
42. `^\s*#` → match commented lines in config files.
	Not working 
43. `\.(jpg|png|gif)$` → match image file names.
44. `^[a-z0-9_-]{3,16}$` → validate usernames.
45. `^.{8,}$` → validate passwords of at least 8 characters.
46. `CPU:\s*\d+%` → extract CPU usage from logs.
	instead grep -E 'CPU:[[:space:]]*[[:digit:]]+%' test.txt
47. `memory\s*=\s*\d+MB` → find memory configs.
		grep -E 'memory[[:space:]]*=[[:space:]]*[[:digit:]]+MB' test.txt
48. `version\s*=\s*\d+\.\d+\.\d+` → extract semantic versions.
	replace \s and \d 
49. `user_id=(\d+)` → capture user IDs from logs.
50. `service_[A-Z]+\s+status=200` → match healthy service logs.