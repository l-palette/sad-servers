Briefly:



---

# Task
Description: A web application relies on the PostgreSQL 13 database present on this server. 
However, the connection to the database is not working. 
Your task is to identify and resolve the issue causing this connection failure.
The application connects to a database named app1 with the user app1user and the password app1user.
Test: Running PGPASSWORD=app1user psql -h 127.0.0.1 -d app1 -U app1user -c '\q' succeeds (does not return an error).
# Solution
```bash
admin@ip-10-1-13-92:~$ PGPASSWORD=app1user psql -h 127.0.0.1 -d app1 -U app1user -c '\q'
psql: error: FATAL:  pg_hba.conf rejects connection for host "127.0.0.1", user "app1user", database "app1", SSL on
FATAL:  pg_hba.conf rejects connection for host "127.0.0.1", user "app1user", database "app1", SSL off
admin@ip-10-1-13-92:~$ 
```
in pg_hba.conf i deleted reject policies
```bash
host    all             all             all                     reject
host    all             all             all                     reject
```
![img.png](img.png)