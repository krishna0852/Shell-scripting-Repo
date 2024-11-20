#!/bin/bash 

echo "Enter a value to check even or odd"

read checkNumber

[ $((checkNumber %2)) -eq 0 ] && echo $checkNumber is Even || echo $checkNumber is Odd

#&&: This is a logical AND operator. It means the command after && will only be executed if the previous command (the condition [ $((checkNumber % 2)) -eq 0 ]) succeeds (returns 0 or true).

#||: This is a logical OR operator. It means the command after || will be executed if the previous command (the echo "$checkNumber is even" part) fails (returns a non-zero exit status)