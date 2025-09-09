Briefly:



---

# Task
Description: There's a process reading from the named pipe `/home/admin/namedpipe`.

If you run this command that writes to that pipe:


```bash
/bin/bash -c 'while true; do echo "this is a test message being sent to the pipe" > /home/admin/namedpipe; done' &
```

And check the reader log with `tail -f reader.log`

You'll see that after a minute or so it works for a while (the reader receives some messages) and then it stops working (no more received messages are printed to the reader log or it takes a long time to process one). Troubleshoot and fix (for example changing the writer command) so that the writer keeps sending the messages and the reader is able to read all of them.

Root (sudo) Access: False

Test: There should be a process running where a message is being sent to the pipe and that while that is running, another message can be sent to the pipe and read back.

# Solution

The `&` at the end of a command tells the shell to run that command in the background.
When you run a command with `&`, the shell responds by printing the job number and process ID:
```bash
[1] 12345
```


I created a pipe
```bash
mkfifo mypipe
```

Now I need to create a process to write to this file

```bash
echo "abacaba" > mypipe
```

It won't work until I start the reader process

```bash
cat mypipe
```

Nothing is being written to pipe until it's read from there

Reader reads every two seconds
```bash
nohup /bin/bash -c 'while true; do
  if read line < /home/admin/namedpipe; then
    echo "$(date) Received: $line" >> /home/admin/reader.log
  fi
  sleep 2
done' &>/dev/null &
```

So we have to modify the writer from this
```bash
/bin/bash -c 'while true; do echo "this is a test message being sent to the pipe" > /home/admin/namedpipe; done' & 
```

to this

```bash
/bin/bash -c 'while true; do echo "this is a test message being sent to the pipe" > /home/admin/namedpipe; sleep 2; done' & 
```

![img.png](img.png)