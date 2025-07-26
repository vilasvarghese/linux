Markdown

# Linux `wget` Command Tutorial

The `wget` command is a free utility for non-interactive download of files from the web. It supports HTTP, HTTPS, and FTP protocols, as well as retrieval through HTTP proxies. Being non-interactive means it can work in the background, even if the user logs out, which makes it ideal for downloading large files or for use in scripts.

## Basic Syntax

```
wget [OPTION]... [URL]...
URL: The URL of the file or resource you want to download.

Key Features of wget
Non-interactive: Can download files without user intervention, suitable for scripting and background operations.

Recursive download: Can download entire websites (with care).

Resumption: Can resume interrupted downloads.

Supports HTTP, HTTPS, FTP: Covers most common web protocols.

Proxies: Works with HTTP proxies.

Timestamps: Can check remote timestamps to avoid re-downloading unchanged files.

Examples and Use Cases
1. Basic File Download
Download a single file from a URL. By default, wget saves the file in the current directory with its original filename.



wget [https://example.com/files/document.pdf](https://example.com/files/document.pdf)
2. Download a File with a Different Name
Use the -O (or --output-document=) option to specify a different local filename.



wget -O my_report.pdf [https://example.com/files/document.pdf](https://example.com/files/document.pdf)
3. Download to a Specific Directory
Use the -P (or --directory-prefix=) option to specify the directory where the file should be saved.



wget -P /home/user/downloads [https://example.com/files/archive.zip](https://example.com/files/archive.zip)
4. Resume an Incomplete Download
If a download is interrupted (e.g., network error), you can resume it using the -c (or --continue) option. wget will check the local file size and continue from where it left off.



wget -c [https://example.com/large_software_update.tar.gz](https://example.com/large_software_update.tar.gz)
5. Download in the Background
Use the -b (or --background) option to send wget to the background immediately after startup. Output will be redirected to wget-log in the current directory.



wget -b [https://example.com/very_large_dataset.zip](https://example.com/very_large_dataset.zip)
You can check the progress in wget-log.

6. Limit Download Speed
Use the --limit-rate= option to restrict the download speed. This is useful to avoid saturating your network connection. You can specify units like k for KB, m for MB.



wget --limit-rate=500k [https://example.com/video_file.mp4](https://example.com/video_file.mp4)
7. Download an Entire Website (Recursive Download)
This is a powerful but potentially dangerous feature if used without caution, as it can download a vast amount of data.

-r (or --recursive): Turn on recursive retrieving.

-l N (or --level=N): Specify recursion maximum depth (default is 5 for HTTP/HTTPS). -l inf for infinite.

-np (or --no-parent): Don't ascend to the parent directory.

-k (or --convert-links): After downloading, convert the links in the document to make them suitable for local viewing.

-p (or --page-requisites): Download all files that are necessary to display HTML pages (e.g., images, CSS, JavaScript).



wget -r -l 1 -np -k -p [https://example.com/blog/](https://example.com/blog/)
This command attempts to download the blog section of example.com one level deep, converting links for local viewing, and getting all page requisites, without going up to the parent example.com directory.

8. Download Multiple Files Listed in a File
Use the -i (or --input-file=) option to read URLs from a local file. Each URL should be on a new line.

First, create a file named urls.txt:

[https://example.com/file1.txt](https://example.com/file1.txt)
[https://example.com/image.png](https://example.com/image.png)
ftp://ftp.example.org/pub/data.tgz
Then, run wget:



wget -i urls.txt
9. Bypass Certificate Checks (Use with Caution!)
If you encounter SSL certificate issues (e.g., self-signed certificates), you can ignore them using --no-check-certificate. Use this only if you understand the security implications and trust the source.



wget --no-check-certificate [https://self-signed-site.com/resource.pdf](https://self-signed-site.com/resource.pdf)
10. Set a User-Agent String
Some websites block wget or serve different content based on the User-Agent header. You can specify a custom User-Agent.



wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" [https://example.com/special_content.html](https://example.com/special_content.html)
11. Silent Mode (No Output to Terminal)
Use the -q (or --quiet) option to suppress wget's output to the terminal, except for error messages.



wget -q [https://example.com/silent_download.txt](https://example.com/silent_download.txt)
This is useful when wget is used within scripts and you don't want its output cluttering the console.

12. Retrieve a File via FTP
wget can also download files from FTP servers.



wget ftp://ftp.example.org/pub/software/latest.tar.gz
For anonymous FTP, no additional credentials are needed. For authenticated FTP, you can include credentials in the URL or use options:



# Using credentials in URL (less secure as it might appear in history)
wget ftp://user:password@ftp.example.org/private/file.txt

# Using options
wget --ftp-user=myuser --ftp-password=mypass ftp://ftp.example.org/private/file.txt
Tips for Using wget
Check wget-log: If running wget in the background, remember to check the wget-log file (or whatever file specified with -o) for progress and errors.

Be Mindful of Bandwidth: Recursive downloads can consume significant bandwidth and disk space. Always use -l (level) and -np (no parent) with -r.

Respect robots.txt: wget by default respects robots.txt files. If you need to bypass it (e.g., for archival purposes on a site you own), use -e robots=off. However, this is generally not recommended unless you have explicit permission.

wget is a powerful and flexible tool for file downloading from the command line, indispensable for scripting, automated tasks, and server environments.
```