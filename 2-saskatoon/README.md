Briefly:
- `sort`: Sorts the extracted IP addresses.
- `uniq -c`: Counts how many times each unique IP address appears.
- `sort -nr`: Sorts the counts in descending order. 
- `head -n 1`: Retrieves the IP address with the highest count.
- `awk '{print $2}'`: Extracts just the IP address from the output.
---

# Task

Scenario: "Saskatoon": counting IPs.

Level: Easy

Type: Do

Tags: bash  

Description: There's a web server access log file at /home/admin/access.log. The file consists of one line per HTTP request, with the requester's IP address at the beginning of each line.

Find what's the IP address that has the most requests in this file (there's no tie; the IP is unique). Write the solution into a file /home/admin/highestip.txt. For example, if your solution is "1.2.3.4", you can do echo "1.2.3.4" > /home/admin/highestip.txt

Root (sudo) Access: False

Test: The SHA1 checksum of the IP address sha1sum /home/admin/highestip.txt is 6ef426c40652babc0d081d438b9f353709008e93 (just a way to verify the solution without giving it away.)

Time to Solve: 15 minutes.

---

# Solution

```bash
wc -l /home/admin/access.log
```

```bash
cut -d ' ' -f 1
```


```bash
awk '{print $1}'
```



```bash
tail -f /home/admin/access.log

admin@ip-172-31-27-155:/$ tail -f /home/admin/access.log
66.249.73.135 - - [20/May/2015:21:05:11 +0000] "GET /blog/tags/xsendevent HTTP/1.1" 200 10049 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
198.46.149.143 - - [20/May/2015:21:05:29 +0000] "GET /blog/geekery/disabling-battery-in-ubuntu-vms.html?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+semicomplete%2Fmain+%28semicomplete.com+-+Jordan+Sissel%29 HTTP/1.1" 200 9316 "-" "Tiny Tiny RSS/1.11 (http://tt-rss.org/)"
198.46.149.143 - - [20/May/2015:21:05:34 +0000] "GET /blog/geekery/solving-good-or-bad-problems.html?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+semicomplete%2Fmain+%28semicomplete.com+-+Jordan+Sissel%29 HTTP/1.1" 200 10756 "-" "Tiny Tiny RSS/1.11 (http://tt-rss.org/)"
82.165.139.53 - - [20/May/2015:21:05:15 +0000] "GET /projects/xdotool/ HTTP/1.0" 200 12292 "-" "-"
100.43.83.137 - - [20/May/2015:21:05:01 +0000] "GET /blog/tags/standards HTTP/1.1" 200 13358 "-" "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)"
63.140.98.80 - - [20/May/2015:21:05:28 +0000] "GET /blog/tags/puppet?flav=rss20 HTTP/1.1" 200 14872 "http://www.semicomplete.com/blog/tags/puppet?flav=rss20" "Tiny Tiny RSS/1.11 (http://tt-rss.org/)"
63.140.98.80 - - [20/May/2015:21:05:50 +0000] "GET /blog/geekery/solving-good-or-bad-problems.html?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+semicomplete%2Fmain+%28semicomplete.com+-+Jordan+Sissel%29 HTTP/1.1" 200 10756 "-" "Tiny Tiny RSS/1.11 (http://tt-rss.org/)"
66.249.73.135 - - [20/May/2015:21:05:00 +0000] "GET /?flav=atom HTTP/1.1" 200 32352 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
180.76.6.56 - - [20/May/2015:21:05:56 +0000] "GET /robots.txt HTTP/1.1" 200 - "-" "Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20100101 Firefox/6.0.2"
46.105.14.53 - - [20/May/2015:21:05:15 +0000] "GET /blog/tags/puppet?flav=rss20 HTTP/1.1" 200 14872 "-" "UniversalFeedParser/4.2-pre-314-svn +http://feedparser.org/"
```

regex="^(\d{,3}\.\d{,3}\.\d{,3}\.\d{,3})"

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log
200.31.173.106
173.192.238.58
78.57.150.9
78.57.150.9
62.4.19.142
46.105.14.53
66.249.73.135
95.108.158.230
180.76.5.114
198.46.149.143
198.46.149.143
157.56.92.158
66.249.73.135
5.10.83.21
204.62.56.3
204.62.56.3
204.62.56.3
204.62.56.3
```

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log | sort
93.104.161.108
93.104.161.108
93.104.161.108
93.104.161.108
93.104.161.108
93.104.161.108
93.104.161.108
93.104.161.108
93.114.45.13
93.114.45.13
93.114.45.13
93.114.45.13
93.114.45.13
93.114.45.13
93.129.45.32
93.129.45.32
93.139.195.61
93.139.195.61
93.139.195.61
93.139.195.61
93.139.195.61
93.139.195.61
93.152.153.38
93.152.153.38
93.152.153.38
```

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log | sort | uniq 
98.245.87.136
98.248.53.169
98.252.226.135
98.64.39.111
98.85.3.179
99.100.25.83
99.101.69.97
99.11.114.240
99.146.78.102
99.151.9.144
99.158.0.150
99.17.221.6
99.171.108.193
99.179.126.76
99.188.185.40
99.237.56.116
99.252.100.83
99.33.244.41
99.6.61.4
```

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log | sort | uniq -c
      2 98.245.87.136
      5 98.248.53.169
     10 98.252.226.135
      1 98.64.39.111
      2 98.85.3.179
      1 99.100.25.83
      5 99.101.69.97
      2 99.11.114.240
      1 99.146.78.102
      1 99.151.9.144
      6 99.158.0.150
      2 99.17.221.6
      6 99.171.108.193
      1 99.179.126.76
      1 99.188.185.40
      2 99.237.56.116
     26 99.252.100.83
      9 99.33.244.41
      6 99.6.61.4
```

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log | sort | uniq -c | sort -nr | head -n 1 
482 66.249.73.135
```

```bash
grep -oP '^\d{1,3}(?:\.\d{1,3}){3}' /home/admin/access.log | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'  > /home/admin/highestip.txt
```

```bash
admin@ip-172-31-27-155:/$ sha1sum /home/admin/highestip.txt
6ef426c40652babc0d081d438b9f353709008e93  /home/admin/highestip.txt
```

![img.png](img.png)