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