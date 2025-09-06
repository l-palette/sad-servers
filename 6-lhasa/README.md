Briefly:



---

# Task
Description: There's a file /home/admin/scores.txt with two columns (the first number is a line number and the second one is a test score for example).

Find the average (more precisely; the arithmetic mean: sum of numbers divided by how many numbers are there) of the numbers in the second column (find the average score).

Use exactly two digits to the right of the decimal point. i.e., use exaclty two "decimal digits" without any rounding. Eg: if average = 21.349 , the solution is 21.34. If average = 33.1 , the solution is 33.10.

Save the solution in the /home/admin/solution file, for example: echo "123.45" > ~/solution

# Solution

**`awk`** - scripting programming language used in unix for processing text

```bash
awk '{action}' your_file_name.txt

awk '/regex pattern/{action}' your_file_name.txt
```

![img.png](img.png)