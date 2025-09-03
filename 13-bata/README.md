Briefly:

```bash
find /proc/sys/ -type f -exec grep -l "net" {} +
```


`find /proc/sys/`: This specifies the directory to search in.
`-type f`: This restricts the search to files only.
`-exec`: This allows you to execute a command on the files found.
`grep -l "search_term"`: This searches for the specified term within the files. The -l option tells grep to only output the names of files containing the term.
`{}`: This is a placeholder for the files found by find.
`+`: This allows find to pass multiple files to grep at once, which is more efficient than running grep for each file individually.

---

# Task
Scenario: "Bata": Find in /proc

Level: Easy

Description: A spy has left a password in a file in /proc/sys . The contents of the file start with "secret:" (without the quotes).

Find the file and save the word after "secret:" to the file /home/admin/secret.txt with a newline at the end (e.g. if the file contents were "secret:password" do: echo "password" > /home/admin/secret.txt).

(Note there's no root/sudo access in this scenario).

Test: Running md5sum /home/admin/secret.txt returns a7fcfd21da428dd7d4c5bb4c2e2207c4

The "Check My Solution" button runs the script /home/admin/agent/check.sh, which you can see and execute.

Time to Solve: 10 minutes.

OS: Debian 11

Root (sudo) Access: No

---

# Solution

```bash
admin@ip-10-1-11-4:~$ find /proc/sys/ -type f -exec grep -l "secret:" {} +
grep: /proc/sys/fs/binfmt_misc/register: Permission denied
grep: /proc/sys/fs/protected_fifos: Permission denied
grep: /proc/sys/fs/protected_hardlinks: Permission denied
grep: /proc/sys/fs/protected_regular: Permission denied
grep: /proc/sys/fs/protected_symlinks: Permission denied
grep: /proc/sys/kernel/cad_pid: Permission denied
/proc/sys/kernel/core_pattern
grep: /proc/sys/kernel/unprivileged_userns_apparmor_policy: Permission denied
grep: /proc/sys/kernel/usermodehelper/bset: Permission denied
grep: /proc/sys/kernel/usermodehelper/inheritable: Permission denied
grep: /proc/sys/net/core/bpf_jit_harden: Permission denied
grep: /proc/sys/net/core/bpf_jit_kallsyms: Permission denied
grep: /proc/sys/net/core/bpf_jit_limit: Permission denied
grep: /proc/sys/net/ipv4/route/flush: Permission denied
grep: /proc/sys/net/ipv4/tcp_fastopen_key: Permission denied
grep: /proc/sys/net/ipv6/conf/all/stable_secret: Permission denied
grep: /proc/sys/net/ipv6/conf/default/stable_secret: Permission denied
grep: /proc/sys/net/ipv6/conf/docker0/stable_secret: Permission denied
grep: /proc/sys/net/ipv6/conf/ens5/stable_secret: Permission denied
grep: /proc/sys/net/ipv6/conf/lo/stable_secret: Permission denied
grep: /proc/sys/net/ipv6/route/flush: Permission denied
grep: /proc/sys/vm/compact_memory: Permission denied
grep: /proc/sys/vm/drop_caches: Permission denied
grep: /proc/sys/vm/mmap_rnd_bits: Permission denied
grep: /proc/sys/vm/mmap_rnd_compat_bits: Permission denied
grep: /proc/sys/vm/stat_refresh: Permission denied
```
![img.png](img.png)