#!/bin/bash

# remove files
rm s*.txt

input_file=names.txt
tra_data=$(tr -s " " < $input_file |tr -cd 'a-zA-Z \n' | tr '[:upper:]' '[:lower:]'| sort)

function proper_case () {
 first_char=$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]')
 remaining=$(echo $1 | cut -c2-)
 word="$first_char$remaining "
 echo $word
}

function formatted_numbers () {
  number_file=Phones.txt
  formatted_phones=$(tr -cd '0-9\n' < $number_file | sed 's/^[0+|61]*/+61/g')
  while read phone_num;
  do
   if [[ $phone_num =~ ^\+614[0-9]{8}$ ]] 
   then  
      phone_value="VALID" 
   else 
      phone_value="INVALID"
   fi   
   echo $phone_num $phone_value >> sphone.txt
  done < <(printf '%s\n' "$formatted_phones")
}

function check_email () {
    e_mail=$(tr -s 'A-Z' 'a-z' < Emails.txt | tr -s  "." | tr -s  "@" | sort | sed  's/.au.au/.au/g')  
    echo "$e_mail" >> semail.txt

}


function do_concat () {
  while IFS=',' read name phone email  
  do
    echo "Name:" $name >> project.txt
    echo "Phone number:" $phone >> project.txt
    echo "Email:" $email >> project.txt
    echo "=====================================" >> project.txt
  done < <(paste -d ','  snames.txt sphone.txt semail.txt)   
}



# full name
while read first_name last_name;
do
 formatted_first_name="$(proper_case $first_name)"
 formatted_last_name="$(proper_case $last_name)"
 full_name="$formatted_first_name $formatted_last_name"
 echo $full_name >> snames.txt 
done < <(printf '%s\n' "$tra_data")

# correct phone
formatted_numbers

# check email
check_email

# concat file
do_concat




