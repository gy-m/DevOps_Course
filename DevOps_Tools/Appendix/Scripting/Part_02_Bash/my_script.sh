 #!/bin/bas

# To run this script on windows, I used "Git-Bash"
# The Command: ./my_script.sh

declare -i char_num=0
declare nomeric_valid=false
declare alphabet_small_valid=false
declare alphabet_big_valid=false


# creating variable for the user input
user_input="$@"

# todo: gain better understanding in this section
echo $user_input | awk -v ORS="" '{ gsub(/./,"&\n") ; print }' | \

# count the number of chars
# and check if there are enought number of alpha small, alpha big and nomeric chars
while read char
do
	echo "The char is: $char and the number of the char is: $char_num"
	char_num=char_num+1

	# check for nomeric char 
	if [[ "$char" = [0-9] ]]; then
		nomeric=true
		# atleast one is enought to declare validity
		nomeric_valid=true
	else
		nomeric=false
	fi
	echo "Nomeric flag: $nomeric"

	# check for alphanetical char - small letters
	if [[ "$char" = [a-z] ]]; then
		alphabet_small=true
		# atleast one is enought to declare validity
		alphabet_small_valid=true
	else
		alphabet_small=false
	fi
	echo "alphanetical smalll letters flag: $alphabet_small"

	# check for alphanetical char - big letters
	if [[ "$char" = [A-Z] ]]; then
		alphabet_big=true
		# atleast one is enought to declare validity
		alphabet_big_valid=true
	else
		alphabet_big=false
	fi
	echo "alphanetical big letters flag: $alphabet_big"

done

# calculating the number of characters
char_num=${#user_input}
echo "The number of characters: $char_num"

if [ $char_num -lt 10 ]; then
	echo "less than 10 characters"
else
	echo "Equal or more than 10 characters"
fi

# TODO: why are all those vairables flase? what happens in the while so after it every thing earased?
echo "alphabet_small_valid: $alphabet_small_valid"
echo "alphabet_big_valid: $alphabet_big_valid"
echo "nomeric_valid: $nomeric_valid"

# defining colors
red=`tput setaf 1`
green=`tput setaf 2`

# printint the answear
if [[ "$alphabet_small_valid" = true && "$alphabet_big_valid" = true && "$nomeric_valid" = true ]] ;
then
	echo "${green}The password is valid" 
	exit 0
else

	echo "${red}The password is invalid" 
	exit 1
fi


