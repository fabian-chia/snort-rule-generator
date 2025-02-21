#!/bin/bash

read -p "What kind of rule would you like to create?: 
a) alert
b) drop
c) pass
d) reject 
Enter: " RULETYPE
case $RULETYPE in

	a)
	choice="alert"
	
	;;


	b)
	choice="drop"
	;;

	c)
	choice="pass"
	;;

	d)
	choice="reject"
	;;
esac

function PROTOCOL()
{
read -p "What is the protocol you want to target
a) TCP
b) UDP
c) ICMP
: " PTCL
case $PTCL in 

a)
protocol="tcp"
;;

b)
protocol="udp"
;;

c) 
protocol="icmp"
;;

esac
}
PROTOCOL


function SOURCE()
{
read -p "Enter the source IP address of the packet you want to: 
a) custom IP
b) any
: " SOURCEIP

case $SOURCEIP  in

a) 
read -p "Enter the ip address of your custom ip: " sourceip
;;

b)
sourceip="any"
;;

esac
}
SOURCE






function SOURCER()
{
read -p "Enter the source port of the packet you want to: 
a) custom port
b) any
: " SOURCEPORT

case $SOURCEPORT  in

a) 
read -p "Enter your custom port: " customsrcport
sourceport="$customsrcport"
;;

b)
sourceport="any"
;;

esac
}
SOURCER


function DIRECTION()
{
read -p "Enter the direction of the packet you wish to detect
a) source to destination
b) both direction 
: " direction

case $direction in

a) 
direction="->"
;;

b)
direction="<>"
;;
esac
}
DIRECTION

function DESTINATION()
{
read -p "Enter the destination IP address of the packet you want to: 
a) custom IP
b) any
: " DESTIP

case $DESTIP  in

a) 
read -p "Enter the ip address of your custom ip: " destinationip
;;

b)
destinationip="any"
;;

esac
}
DESTINATION

function DESTINATIONPORT()
{
read -p "Enter the destination port of the packet you want to: 
a) custom IP
b) any
: " DESTPORT

case $DESTPORT in

a) 
read -p "Enter your custom destination port" destinationport
;;

b)
destinationport="any"
;;

esac
}
DESTINATIONPORT


read -p "Enter the message you want to see on your alert: " ALERT


read -p "Enter the SID of your alert your alert(The SID must be greater than 1000000): " SID



function CONTENT()
{
read -p "Which one of the content types would you like to choose from?
a) FTP failed login
b) custom content
c) none
: " contentchoice

case $contentchoice in
a)
content="530 Login incorrect"
;;

b)
read -p "Enter the custom string you want to look for: " USERSCONTENT
content="$USERSCONTENT"
;;

c)
echo "Here is the final snort rule that you can add into the rules"
echo "$choice $protocol $sourceip $sourceport $direction $destinationport $destinationip (msg:\"$ALERT\"; sid:$SID)"
exit
;;

*)
echo 'That was not one of the options, please select one of the given options above'
CONTENT
;;
esac

}
CONTENT
echo "$choice $protocol $sourceip $sourceport $direction $destinationport $destinationip (msg:\"$ALERT\";content:\"$content\"; nocase; sid:$SID)"

