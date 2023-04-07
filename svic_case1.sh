echo -n "Enter the name of an animal: "
read animal
echo -n "The $animal has "
case ${animal} in
horse | dog | cat) echo -n "four";;
man | kangaroo ) echo -n "two";;
*) echo -n "an unknown number of";;
esac
echo " legs."
