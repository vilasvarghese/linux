#!/bin/bash
# Script: check_config_drift.sh
# Purpose: Detect config drift using grep, sed, awk, and diff

BASELINE="baseline.conf"
LIVE="config.conf"
TMP_BASELINE="baseline_clean.conf"
TMP_LIVE="live_clean.conf"

echo "Starting Config Drift Check..."

# 1. Extract relevant lines (ignore comments & blank lines) using grep
grep -Ev '^\s*#|^\s*$' "$BASELINE" > "$TMP_BASELINE.raw"

#-E → use Extended Regular Expressions (ERE) (so | works as OR without needing \|).
#-v → invert match (i.e., exclude lines matching the regex).
#'^\s*#|^\s*$' → the regex pattern or This matches comment lines.
	#^ → beginning of the line.
	#\s* → zero or more whitespace characters.
	## → a literal hash.
	#This matches comment linesgrep -Ev '^\s*#|^\s*$' "$LIVE" > "$TMP_LIVE.raw"


# 2. Normalize formatting (remove extra spaces around =) using sed
sed -E 's/\s*=\s*/=/' "$TMP_BASELINE.raw" > "$TMP_BASELINE"
sed -E 's/\s*=\s*/=/' "$TMP_LIVE.raw" > "$TMP_LIVE"
	#s/.../.../ → standard substitute command in sed.
	#\s* → zero or more whitespace characters (in GNU sed with -E or -r; POSIX sed doesn’t support \s).
	#= → a literal equals sign since we are looking for spaces around =
	#\s* → again, zero or more whitespace after =.


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