Briefly:
/var/www dir must have execute permissions for others
index.html must have read permissions for others
---
# Task
Description: There's a web server running on this host but curl localhost returns the default 404 Not Found page.

Fix the issue so that a file is served correctly and the message Welcome to the Real Site! is returned.

Root (sudo) Access: True

Test: Running curl localhost should return HTTP 200 with the message Welcome to the Real Site!.

The "Check My Solution" button runs the script /home/admin/agent/check.sh, which you can see and execute.

Time to Solve: 15 minutes.

# Solution

```bash
admin@ip-10-1-13-238:~$ curl localhost
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx/1.18.0</center>
</body>
</html>
```

```bash
admin@ip-10-1-13-238:~$ 
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2025-09-09 17:23:02 UTC; 14min ago
       Docs: man:nginx(8)
    Process: 604 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 636 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 640 (nginx)
      Tasks: 3 (limit: 522)
     Memory: 12.6M
        CPU: 59ms
     CGroup: /system.slice/nginx.service
             ├─640 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─641 nginx: worker process
             └─642 nginx: worker process

Sep 09 17:23:01 ip-10-1-13-238 systemd[1]: Starting A high performance web server and a reverse proxy server...
Sep 09 17:23:02 ip-10-1-13-238 systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argument
Sep 09 17:23:02 ip-10-1-13-238 systemd[1]: Started A high performance web server and a reverse proxy server.
```

```bash
Sep 09 17:53:36 ip-10-1-13-59 systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argument
```

```bash
admin@ip-10-1-13-59:/$ sudo ls -la /var/www/html/
total 12
drwxr-xr-x 2 www-data www-data 4096 Jul 21 13:59 .
drwxr-xr-- 3 root     root     4096 Jul 21 13:59 ..
lrwxrwxrwx 1 root     root       33 Jul 21 13:59 index.html -> /opt/site-content/real_index.html
-rw-r--r-- 1 root     root      612 Jul 21 13:59 index.nginx-debian.html
admin@ip-10-1-13-59:/$ 
```


```bash
admin@ip-10-1-13-48:~$ sudo tail /var/log/nginx/error.log
2025/07/21 13:59:19 [notice] 1730#1730: using inherited sockets from "6;7;"
2025/09/09 18:16:40 [crit] 741#741: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
2025/09/09 18:16:40 [crit] 741#741: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
2025/09/09 18:17:12 [crit] 758#758: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
2025/09/09 18:17:12 [crit] 758#758: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
admin@ip-10-1-13-48:~$ 
```

```bash
sudo chmod o+x /var/www
drwxr-xr-x  3 root root  4096 Jul 21 13:59 /var/www
```

Now there is a different error
```bash
admin@ip-10-1-13-140:~$ sudo systemctl restart nginx.service 
admin@ip-10-1-13-140:~$ curl localhost
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.18.0</center>
</body>
</html>
admin@ip-10-1-13-140:~$ sudo cat /var/log/nginx/error.log 
2025/07/21 13:59:19 [notice] 1730#1730: using inherited sockets from "6;7;"
2025/09/10 04:47:15 [crit] 618#618: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
2025/09/10 04:47:15 [crit] 618#618: *1 stat() "/var/www/html/" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
2025/09/10 04:50:44 [error] 718#718: *1 open() "/var/www/html/index.html" failed (13: Permission denied), client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", host: "localhost"
```

```bash
admin@ip-10-1-13-59:/$ ls -la /opt/site-content/real_index.html
-rw-r----- 1 root root 34 Jul 21 13:59 /opt/site-content/real_index.html
admin@ip-10-1-13-59:/$ 
```

```bash
admin@ip-10-1-13-48:~$ sudo !!
sudo cat /opt/site-content/real_index.html
<h1>Welcome to the Real Site!</h1>admin@ip-10-1-13-48:~$ 
```
```bash
sudo chmod o+r /opt/site-content/real_index.html
```
или
```bash
sudo chown root:www-data /opt/site-content/real_index.html
```
![img.png](img.png)