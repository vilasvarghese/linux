BEGIN {
    FS=":" # Example: Process /etc/passwd
    print "User List Report"
    print "----------------"
}
{
    print "User:", $1, "Home:", $6, "Shell:", $NF
}
END {
    print "----------------"
    print "End of Report. Processed", NR, "users."
}

