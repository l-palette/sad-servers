


# Task

Description: There are four Linux users working together in a project in this server: abe, betty, carlos, debora.

First, they have asked you as the sysadmin, to make it so each of these four users can read the project files of the other users in the /home/admin/shared directory, but none of them can modify a file that belongs to another user. Users should be able modify their own files.

Secondly, they have asked you to modify the file shared/ALL so that any of these four users can write more content to it, but previous (existing) content cannot be altered.

Root (sudo) Access: True

Test: All users (abe, betty, carlos, debora) can write to their own files. None of them can write to another user's file.
All users can add more content (append)) to the shared/project_ALL file but none can change its current content.
The "Check My Solution" button runs the script /home/admin/agent/check.sh, which you can see and execute.

Time to Solve: 15 minutes.

# Solution
Now they cant read others files
```bash
admin@ip-10-1-13-104:~$ ls -lah shared/
total 28K
drwxr-xr-x 2 admin  admin  4.0K Feb  2  2025 .
drwxr-xr-x 6 admin  admin  4.0K Feb  2  2025 ..
-rw-r--r-- 1 root   admin    38 Feb  2  2025 ALL
-rw-r----- 1 abe    abe      27 Feb  2  2025 project_abe
-rw-r----- 1 betty  betty    29 Feb  2  2025 project_betty
-rw-r----- 1 carlos carlos   30 Feb  2  2025 project_carlos
-rw-r----- 1 debora debora   30 Feb  2  2025 project_debora
```

I can add them to a group with other permissions
```bash
/home/admin/shared
```

```bash
sudo groupadd project

sudo usermod -a -G project abe
sudo usermod -a -G project betty
sudo usermod -a -G project carlos
sudo usermod -a -G project debora
```

I added everything because ...
```bash
sudo chmod u=rwx,g=rwx,o= /home/admin/shared
```

Current directories permissions changed
```bash
admin@ip-10-1-13-104:~$ ls -lah shared/
total 28K
drwxrwx--- 2 admin  admin  4.0K Feb  2  2025 .
drwxr-xr-x 6 admin  admin  4.0K Feb  2  2025 ..
-rw-r--r-- 1 root   admin    38 Feb  2  2025 ALL
-rw-r----- 1 abe    abe      27 Feb  2  2025 project_abe
-rw-r----- 1 betty  betty    29 Feb  2  2025 project_betty
-rw-r----- 1 carlos carlos   30 Feb  2  2025 project_carlos
-rw-r----- 1 debora debora   30 Feb  2  2025 project_debora
admin@ip-10-1-13-104:~$ 
```

Change the group for the folder
```bash
sudo chgrp project /home/admin/share
drwxrwx--- 2 admin  project 4.0K Feb  2  2025 .
```

This sets the SGID (Set Group ID) bit, ensuring any new files created in the directory inherit the project group ownership.
```bash
sudo chmod g+s /home/admin/shared
drwxrws--- 2 admin project 4.0K Feb  2  2025 shared
```

```bash
sudo chmod u=rw,g=r,o= /home/admin/shared/*
```

```bash
sudo chgrp project /home/admin/shared/ALL
sudo chmod u=rw,g=rw,o=r /home/admin/shared/ALL
```

Append only
```bash
sudo chattr +a /home/admin/shared/ALL
```

![img.png](img.png)