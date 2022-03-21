#!/bin/bash

# The file names
#21_say_hello.sh --> Greatings with time(IST)
#.password.txt --> User name andPasswords of users
#.answer_file.txt --> Testansers are kept here
#.question_bank.txt --> Questions for test are kept here

# The file paths
# Define all file paths here
welcome="/home/kathir/Linux_prj/command_line_test/21_say_hello.sh"
password="/home/kathir/Linux_prj/command_line_test/.testdata/.password.txt"
answers="/home/kathir/Linux_prj/command_line_test/.testdata/.answer_file.txt"
question_bank="/home/kathir/Linux_prj/command_line_test/.testdata/.question_bank.txt"
path="/home/kathir/Linux_prj/command_line_test/.testdata"


function menu_header()
{
	# Just to print welcome menu presntation
	while [ 1 ]
	do
		echo -e "1.Signin\n2.Signup\n3.Exit"
        read -p "Please choose your option: " option
		if [[ "$option" -eq 1 ]]
        then
			sign_in
        elif [[ "$option" -eq 2 ]]
	    then
			sign_up
	    elif [[ "$option" -eq 3 ]]
	    then
			exit 0
		else
			echo "Invalid option"
			continue
		fi
	done
}

function view_test_screen()
{
	# UI for view a test.
	# 1. Display all questions from test to user with options answered by user.
	# 2. If it was not answered by user, show message 
	# 3. Read answers from .txt file
	reset
	i=1
	echo "Your test results:"
	while read line
	do
		echo "$line"|tr "," "\n"
		answer=`head "-$i" "$answers"| tail -1`
		echo "Correct answer: ""$answer"
		user_ans=`head "-$i" "$path/.$1_answer.txt"|tail -1`
			echo "Your answer: ""$user_ans"
		i=`expr $i + 1`
		echo -e "\n"
    done < $question_bank
}

function test_screen()
{
	# UI for test.
	# 1. Pick and display question from question bank
	# 2. Answers stores to $1_answers.txt files
	reset
	echo -e "Answer the questions:\n"
   while read line
	do
		echo "$line"|tr "," "\n"
	    read -p "Choose your option: " option < "/dev/tty" 
		echo $option >> "$1_answers.txt"
		echo -e "\n"
	done < "$question_bank"
	i=1
	while read line
	do
		field=`expr $line + 1`
		if [[ "$field" -gt 0 && "$field" -le 4 ]]
		then
			ans=`head "-$i" "$question_bank"|tail -1|cut -d "," -f $field`
		else
			ans="You chose Invalid option...!"
		fi
		echo "$ans" >> "/home/kathir/Linux_prj/command_line_test/.testdata/.$1_answer.txt" 
	    i=`expr $i + 1`
	done < "$1_answers.txt"
	rm "$1_answers.txt"
}

function test_menu()
{
	# Provide a menu for user for taking test and viewing test.
	# Read input from user and call respective function
	while [ 1 ]
	do
		echo "Hey $1, What you like to do"
	    echo -e "1. Take a Test\n2. View your test\n3. Exit\n"
	    read -p "Choose your option: " option
		if [ "$option" -eq 1 ]
        then
			test_screen $1
         elif [ "$option" -eq 2 ]
	     then
	         view_test_screen $1
		 elif [ "$option" -eq 3 ]
		 then
		     exit 0
		 else
			 echo "Invalid option"
			 continue
	     fi
	 done
}
	
	

function sign_in()
{
	# For user sign-in
	# 1. Read all user credentials and verify
    reset
	while [ 1 ]
	do
		echo "Sign In screen"
        read -p "Enter user name: " name
	    read -sp "Enter your password: " psswd
        var=`grep $name $password`
		if [[ `(echo "$var" | cut -d " " -f 2)`=="$psswd" ]]
	    then
			break
        else
		    echo "Details mismatched"
		    continue
        fi
	done
	reset
    echo "Successfully logged in"
	echo -e "\n"
	echo "Welcome"
    test_menu $name
}
function sign_up()
{
	# For user sign-up
	# 1. Read all user credentials and verify
	# 2. Set minimum length and permitted characters for username and password, prompt error incase not matching
	# 3. Check for same user name already exists.
    reset 
 	echo "Sign_up screen"
	while [ 1 ]
	do
		echo "NOTE: User-name should contain only alphabets or alphanumerals"
		read -p "Enter user name: " name
		exists=`grep $name $password` 
		if [ "$?" -eq 0  ]
		then
			echo "User name already exist, try with different name"
			continue
		fi
		if [ -z "$(echo -n "$name" | tr -d 'a-zA-Z0-9')" ]
		then
			break
		else
			continue
		fi
	done
	echo "NOTE: Password must have 8 character of lower & upper case alphabets, a number and symbol in it"
    while [ 1 ]
	do
		read -sp "Enter password: " psswd
		length=`echo "$psswd"|wc -c`
	    result=`echo "$psswd" | grep "[a-z]" | grep "[A-Z]" | grep "[0-9]" | grep "[@#$%^&*]"`
		if [[ "$?" -ne 0 || "$length" -ne 9 ]]
		then
			echo "NOTE: Password must have 8 character of lower & upper case alphabets, a number and symbol in it"
			continue
		fi
		echo -e "\n"
		read -sp "Re-enter password: " re_psswd 
		if [ "$psswd" != "$re_psswd" ]
	    then
			echo "Password not matched"
			continue
		else
			echo -e "\n" 
			break
		fi
	done
	echo "$name" "$psswd" >> $password
	echo "Registration successfull"
	menu_header
}
#Script starts here 
$welcome
menu_header

