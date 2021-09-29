#!/bin/bash

input_file=names.txt
tra_data=$(tr -cd 'a-zA-Z \n' < $input_file | tr -s '[:space:]' | tr '[:upper:]' '[:lower:]'| sort)

while read first_name last_name;
do
 echo $first_name '-->'  $last_name
done < <(printf '%s\n' "$tra_data")

function proper_case () {
  first_char=$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]'`)
  remaining=$(echo $1 | cut -c2-)
  word="$first_char$remaining "
  echo $word
}



