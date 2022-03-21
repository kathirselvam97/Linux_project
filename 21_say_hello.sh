#!/bin/bash

<<Documentation
 Name             : Kathiravan s
 Date             : 16-12-2021
 Assignment no    : 21
 Assignment title : Print greetings based on time
 Description      : 1)Get the hours and meridian in a variable
                    2)If meridian is AM, Get into that case block and print according to condtions
                    3)If meridian is PM, Get into that case block and print according to condtions
 Sample output    : Good Night user, Have nice day!
                    This is Wednesday 15 in December of 2021 (11:12:12 PM)
Documentation


hours=`date +%r|cut -d ":" -f 1`  #Cut only the hour
meridian=`date +%r|cut -d " " -f 2` #Cut the meridian to get results accurately
user=`whoami`
echo "Hey,"
case $meridian in       #Use meridian and switch input
	"AM")                                           #If meridain is AM
		if [ $hours -ge 05 -a $hours -lt 12 ]   #Check hour is between 5 and 12
		then
	        echo "Good Morning, Welcome"   #if conditions true, then print message
			echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		else
		    echo "Good Night, Welcome"  #If time is between 12 and 5 print the message 
	        echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		fi
		;;
	"PM")                                            #If meridian is pm, enter
		if [ $hours -ge 09 -a $hours -lt 12 ]    #If the time is between 9 and 12
		then
			echo "Good Night, Welcome" #Print the message
			echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		elif [ $hours -ge 02 -a $hours -lt 05 ]     #If the time is between 2 and 5
	    then
			echo "Good Afternoon, Welcome"  #Print the message
			echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		elif [ $hours -ge 05 -a $hours -lt 09 ]       #If the time is between 5 and 9
		then
			echo "Good Evening, Welcome"  #Print the message
			echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		else
			echo "Good Noon, Welcome"   #Print the message if no condition passes
			echo "This is `date "+%A %d"` in `date +%B` of `date "+%Y (%r)"`"
		fi
		;;
esac
