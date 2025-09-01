Briefly:

---

# Task
Scenario: "The Command Line Murders"

Level: Easy

Type: Do

Tags: bash  

Description: This is the Command Line Murders with a small twist as in the solution is different

Enter the name of the murderer in the file /home/admin/mysolution, for example echo "John Smith" > ~/mysolution

Hints are at the base of the /home/admin/clmystery directory. Enjoy the investigation!

Root (sudo) Access: False

Test: md5sum ~/mysolution returns 9bba101c7369f49ca890ea96aa242dd5

(You can always see /home/admin/agent/check.sh to see how the solution is evaluated).

Time to Solve: 20 minutes.

---

# Solution
Let's check the files in the folder mystery
```bash
ls /home/admin/clmystery
admin@ip-10-1-12-72:~/clmystery$ ls
LICENSE.md  cheatsheet.md   hint1  hint3  hint5  hint7  instructions
README.md   cheatsheet.pdf  hint2  hint4  hint6  hint8  mystery
```

```bash
admin@ip-10-1-12-193:~/clmystery/mystery$ grep "CLUE" crimescene
CLUE: Footage from an ATM security camera is blurry but shows that the perpetrator is a tall male, at least 6'.
CLUE: Found a wallet believed to belong to the killer: no ID, just loose change, and membership cards for Rotary_Club, Delta SkyMiles, the local library, and the Museum of Bash History. The cards are totally untraceable and have no name, for some reason.
CLUE: Questioned the barista at the local coffee shop. He said a woman left right before they heard the shots. The name on her latte was Annabel, she had blond spiky hair and a New Zealand accent.
```

There are two female Annabels:
```bash
admin@ip-10-1-12-193:~/clmystery/mystery$ head -n 10 people && echo "--" &&grep "Annabel" people
***************
To go to the street someone lives on, use the file
for that street name in the 'streets' subdirectory.
To knock on their door and investigate, read the line number
they live on from the file.  If a line looks like gibberish, you're at the wrong house.
***************

NAME    GENDER  AGE     ADDRESS
Alicia Fuentes  F       48      Walton Street, line 433
Jo-Ting Losev   F       46      Hemenway Street, line 390
--
Annabel Sun     F       26      Hart Place, line 40
Oluwasegun Annabel      M       37      Mattapan Street, line 173
Annabel Church  F       38      Buckingham Place, line 179
Annabel Fuglsang        M       40      Haley Street, line 176
```

```bash
admin@ip-10-1-12-78:~/clmystery$ find mystery -name "Hart_Place"
mystery/streets/Hart_Place
admin@ip-10-1-12-78:~/clmystery$ head -n 40 mystery/streets/Hart_Place | tail -n 1
SEE INTERVIEW #47246024
admin@ip-10-1-12-78:~/clmystery$ find mystery -name "Buckingham Place"
admin@ip-10-1-12-78:~/clmystery$ find mystery -name "Buckingham_Place"
mystery/streets/Buckingham_Place
admin@ip-10-1-12-78:~/clmystery$ head -n 179 mystery/streets/Buckingham_Place | tail -n 1
SEE INTERVIEW #699607
```


```bash
admin@ip-10-1-12-78:~/clmystery$ find mystery -name "interviews" -type d
mystery/interviews
admin@ip-10-1-12-78:~/clmystery/mystery/interviews$ cat interview-699607
Interviewed Ms. Church at 2:04 pm.  Witness stated that she did not see anyone she could identify as the shooter, that she ran away as soon as the shots were fired.

However, she reports seeing the car that fled the scene.  Describes it as a blue Honda, with a license plate that starts with "L337" and ends with "9"
admin@ip-10-1-12-78:~/clmystery/mystery/interviews$ cat interview-47246024
Ms. Sun has brown hair and is not from New Zealand.  Not the witness from the cafe.
admin@ip-10-1-12-78:~/clmystery/mystery/interviews$ 
```


```bash
admin@ip-10-1-12-78:~/clmystery/mystery$ head -n 35 vehicles 
***************
Vehicle and owner information from the Terminal City Department of Motor Vehicles
***************

License Plate T3YUHF6
Make: Toyota
Color: Yellow
Owner: Jianbo Megannem
Height: 5'6"
Weight: 246 lbs

License Plate EZ21ECE
Make: BMW
Color: Gold
Owner: Norbert Feldwehr
Height: 5'3"
Weight: 205 lbs

License Plate CQN2TJE
Make: Mazda
Color: Red
Owner: Alexandra Jokinen
Height: 5'11"
Weight: 227 lbs
```

```bash
grep -P "License Plate L337\w*9" vehicles
grep -oP "License Plate L337[A-Z0-9]*9" vehicles

admin@ip-10-1-13-173:~/clmystery/mystery$ grep -oP "License Plate L337[A-Z0-9]*9" vehicles
License Plate L337ZR9
License Plate L337P89
License Plate L337GX9
License Plate L337QE9
License Plate L337GB9
License Plate L337OI9
License Plate L337X19
License Plate L337539
License Plate L3373U9
License Plate L337369
License Plate L337DV9
License Plate L3375A9
License Plate L337WR9
```

```bash
admin@ip-10-1-13-173:~/clmystery/mystery$ grep -A 5 "License Plate L337[A-Z0-9]*9" vehicles
License Plate L337ZR9
Make: Honda
Color: Red
Owner: Katie Park
Height: 6'2"
Weight: 189 lbs
--
License Plate L337P89
Make: Honda
Color: Teal
Owner: Mike Bostock
Height: 6'4"
Weight: 173 lbs
--
```


```bash
grep -A 5 "License Plate L337[A-Z0-9]*9" vehicles | grep -B 2 -A 3 "Make: Honda" | grep -B 3 -A 2 "Color: Blue" | grep -B 5 -A 1 "Height: 6'[0-9]"
```

```bash
admin@ip-10-1-11-124:~/clmystery/mystery$ grep -A 5 "License Plate L337[A-Z0-9]*9" vehicles | grep -B 2 -A 3 "Make: Honda" | grep -B 3 -A 2 "Color: Blue" | grep -B 5 -A 1 "Height: 6'[0-9]"
--
License Plate L337QE9
Make: Honda
Color: Blue
Owner: Erika Owens
Height: 6'5"
--
--
--
License Plate L337DV9
Make: Honda
Color: Blue
Owner: Joe Germuska
Height: 6'2"
--
--
License Plate L3375A9
Make: Honda
Color: Blue
Owner: Jeremy Bowers
Height: 6'1"
--
--
License Plate L337WR9
Make: Honda
Color: Blue
Owner: Jacqui Maher
Height: 6'2"
```

```bash
admin@ip-10-1-11-124:~/clmystery/mystery$ grep -oP "Joe Germuska.*|Jeremy Bowers.*|Erika Owens.*|Jacqui Maher.*" people
Joe Germuska    M       65      Plainfield Street, line 275
Erika Owens     F       56      Trapelo Street, line 98
Jacqui Maher    F       40      Andover Road, line 224
Jeremy Bowers   M       34      Dunstable Road, line 284
```

```bash
find mystery -name "*Rotary*" -o -name "*Delta*" -o -name "*Library*" -o -name "*Museum*"
-o - This is the logical OR operator for the find command

    It allows you to combine multiple search criteria
    Files matching ANY of the conditions will be included in results

./memberships/Terminal_City_Library
./memberships/Delta_SkyMiles
./memberships/Museum_of_Bash_History
./memberships/Rotary_Club
```

```bash
files=(./memberships/Terminal_City_Library ./memberships/Delta_SkyMiles ./memberships/Museum_of_Bash_History ./memberships/Rotary_Club)

for name in "Joe Germuska" "Jeremy Bowers"; do
  count=0
  for file in "${files[@]}"; do
    if grep -q "$name" "$file"; then
      ((count++))
    fi
  done
  if [ $count -eq 4 ]; then
    echo "$name is in all 4 files"
  else
    echo "$name is in $count files"
  fi
done
```
![img.png](img.png)