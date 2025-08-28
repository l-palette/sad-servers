Briefly:

To see the process ID you can do `lsof` not only on port but also on file

---


Scenario: "Saint John": what is writing to this log file?

Level: Easy

Description: A developer created a testing program that is continuously writing to a log file /var/log/bad.log and filling up disk. You can check for example with tail -f /var/log/bad.log.
This program is no longer needed. Find it and terminate it. Do not delete the log file.

Test: The log file size doesn't change (within a time interval bigger than the rate of change of the log file).

The "Check My Solution" button runs the script /home/admin/agent/check.sh, which you can see and execute.

Time to Solve: 10 minutes.

OS: Debian 11

Root (sudo) Access: Yes

---

# Solution
```python3
#! /usr/bin/python3
# test logging

import random
import time
from datetime import datetime

with open('/var/log/bad.log', 'w') as f:
    while True:
        r = random.randrange(2147483647)
        print(str(datetime.now()) + ' token: ' + str(r), file=f)
        f.flush()
        time.sleep(0.3)
```

```bash
admin@ip-10-1-13-22:~$ tail -f /var/log/bad.log
2025-08-28 14:47:44.877711 token: 6516044
2025-08-28 14:47:45.178179 token: 447392021
2025-08-28 14:47:45.478636 token: 1640397243
2025-08-28 14:47:45.779099 token: 1979951495
2025-08-28 14:47:46.079564 token: 1790443438
2025-08-28 14:47:46.380029 token: 867423857
2025-08-28 14:47:46.680461 token: 1927203396
2025-08-28 14:47:46.980899 token: 1566081140
2025-08-28 14:47:47.281364 token: 1064133369
2025-08-28 14:47:47.581829 token: 1929126123
2025-08-28 14:47:47.882300 token: 636106040
2025-08-28 14:47:48.182754 token: 607302133
2025-08-28 14:47:48.483241 token: 12210357
2025-08-28 14:47:48.783728 token: 1296125306
2025-08-28 14:47:49.084223 token: 145022684
2025-08-28 14:47:49.384719 token: 587451268
2025-08-28 14:47:49.685204 token: 2102168826
2025-08-28 14:47:49.985720 token: 2079902442
2025-08-28 14:47:50.286192 token: 1839585513
2025-08-28 14:47:50.586672 token: 631134529
2025-08-28 14:47:50.887170 token: 404385526
2025-08-28 14:47:51.187659 token: 1395585197
2025-08-28 14:47:51.488150 token: 993456398
2025-08-28 14:47:51.788644 token: 113602393
2025-08-28 14:47:52.089123 token: 261165875
2025-08-28 14:47:52.389620 token: 1042641296
```

```bash
admin@ip-10-1-13-22:~$ sudo lsof /var/log/bad.log
COMMAND   PID  USER   FD   TYPE DEVICE SIZE/OFF   NODE NAME
badlog.py 590 admin    3w   REG  259,1    43171 265802 /var/log/bad.log
```

```bash
admin@ip-10-1-13-22:~$ sudo kill 590
admin@ip-10-1-13-22:~$ ls -lh /var/log/bad.log
-rw-r--r-- 1 admin admin 48K Aug 28 14:48 /var/log/bad.log
```

![img.png](images/img.png)