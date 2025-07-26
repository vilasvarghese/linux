 complete Linux curl command tutorial in .md (Markdown) format for easy -pasting:

markdown


# Linux `curl` Command Tutorial

The `curl` command is a powerful tool used to **transfer data from or to a server** using various protocols such as HTTP, HTTPS, FTP, and more. It is commonly used to make API calls, download files, and test endpoints.

---

##  Syntax

```
curl [OPTIONS] [URL] Commonly Used Options
Option	Description
-X	Specify request method (e.g., GET, POST, PUT, DELETE)
-d	Send data in a POST request
-H	Add custom headers
-o	Save output to a file
-O	Save with the same name as the remote file
-I	Fetch only HTTP headers (HEAD request)
-L	Follow redirects
-u	Provide username and password (HTTP authentication)
--cookie	Send cookies with request
--data-urlencode	Encode data before sending
-s	Silent mode (no progress meter or errors shown)
-k	Allow insecure SSL connections

Examples
1. Perform a simple GET request



curl https://example.com
2. Download a file and save it with a specific name



curl -o filename.html https://example.com
3. Download a file and keep the original name



curl -O https://example.com/file.zip
4. Make a POST request with data



curl -X POST -d "name=John&age=30" https://api.example.com/users
5. Send JSON data in a POST request



curl -X POST -H "Content-Type: application/json" \
-d '{"name":"John","age":30}' https://api.example.com/users
6. Set multiple custom headers



curl -H "Authorization: Bearer TOKEN" -H "Accept: application/json" https://api.example.com/data
7. Fetch only HTTP headers



curl -I https://example.com
8. Follow redirects automatically



curl -L https://short.url
9. Use HTTP Basic Authentication



curl -u username:password https://example.com/protected
10. Send cookies



curl --cookie "sessionid=123456" https://example.com/profile
📎 Practical Use Cases
Test API from terminal



curl -X GET https://jsonplaceholder.typicode.com/posts/1
Upload file (with POST)



curl -F "file=@myfile.txt" https://example.com/upload
Save API response to file



curl -s https://api.example.com/data -o response.json
Related Commands
wget – Non-interactive file downloader

httpie – Human-friendly alternative to curl

postman – GUI-based API testing tool

```