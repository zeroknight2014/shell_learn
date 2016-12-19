#!/bin/bash
# author: zohnliu
# description: shell tips
# created_at: 2016-12-19
# modefied_at: 2016-12-19

# # is used for comments.

# 1.Variables
foo=3
((foo = 3))  #wrong foo = 3 
echo $foo ${foo} #reference the value of a variable,use $
unset foo # delete a variable
echo $foo
#foo= x y z # wrong  
#foo=x y z #wrong
foo=" x y z" #right

# 2.array
# there is no need to declare a variable as an array, just use every variable as an array
foo[0]="first"
foo[1]="second"
echo ${foo[0]} ${foo[1]} $foo # $foo is an implict reference to $foo[0]

foo=("a a a" "bbb" "c cc") # use parentheses to create an array
echo ${foo[0]} ${foo[1]}
echo ${foo[@]}
echo ${foo[*]} # you should konw @ and * 's diffences.

# copy array
foo=("a 1" "b 2" "c 3")
bar=(${foo[@]})
baz=("${foo[@]}")
echo ${bar[1]}
echo ${baz[1]}

#get array lenth
echo ${#foo[@]} # you should not use ${#foo}, it is equal with ${#foo[0]}

# special variables
echo $0 #prints the shell script name
echo $1 #prints the first argument
echo $2 #prints the second argument
echo $10 #prints then first argument, follewed by 0
echo ${10} #print the tenth argument
echo $# #the number of argument
echo $* #get all arguments as a string 
echo $@ #get all arguments as an array
echo $$ #the shell script's running process PID
echo $! #the most recently backgrouded process 's PID 
echo $? #the most recently backgrouded process 's exit code, 0 or 1 or others.

# operations on variables
foo="I am a cat, and she is a cat."
echo ${foo/cat/dog} # replace the first matched.
echo ${foo//cat/dog} # replace all matched.
echo ${foo//cat} # replace matched with nothing.

minipath="/usr/bin:/bin:/sbin"
echo ${minipath#/usr} #removes the shortest prefix, prints /bin:/bin:/sbin 
echo ${minipath#*/bin} #prints :/bin:/sbin
echo ${minipath##*/bin} # '##' removes the longest prefix, prints :/sbin

# % is the same like #, except for suffixes instead of prefixes.
echo ${minipath%/usr*} #prints nothing.
echo ${minipath%/bin*} #prints /usr/bin:
echo ${minipath%%/bin*} #prints /usr 

# ${var:start_posion:lenth}, actual print is from start_position + 1
string="I'm a string."
echo ${string:6:6} #prints string 
array=(a b c d e f g h i j)
echo ${array[@]:3:2} #print d e

unset foo
unset bar
echo ${foo-abc}   # prints abc
echo ${bar:-xyz}  # prints xyz

foo=""
bar=""
echo ${foo-123}
echo ${bar:-456}

alpha=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
char=alpha[12]
echo ${!char}

# 2.String and quoting
# '' single quote create literal strings, "" double quotes create interpolated strings.
world=Earth
foo='Hello, $world!'
bar="Hello, $world!"
echo $foo"\n"            # prints Hello, $world!\n
echo $bar$'\n'            # prints Hello, Earth!

# 3.Scope
# set environment, use export
# father shell's var can be used in child shell, but child shell can not use in father shell.

# 4.Expressions and arithmetic
expr 3 + 12      # prints 15
expr 3 * 12      # (probably) crashes: * expands to all files 
expr 3 \* 12     # prints 36
(( x = 3 + 12 )); echo $x    # prints 15
(( x = 3 * 12 )); echo $x    # prints 36

# declare variables explicitly and attach a type to them
declare -i number
number=2+4*10
echo $number        # prints 42
another=2+4*10
echo $another       # prints 2+4*10
number="foobar"
echo $number        # prints 0

# 5.Files and redirection
# To dump the contents of a file into STDIN (instead of accepting user input), use the < operator
# To dump the output of a command into a file, use the > operator
# To append to the end of a file, use the >> operator
# To specify the contents of STDIN literally, in a script, use the <<endmarker notation
# To redirect error output (STDERR), use the operator 2>, such as httpd 2> error.log
# STDIN is channel 0, STDOUT is channel 1, while STDERR is channel 2

# 6.Pipes and Process
# outputing-command | inputing-command
# To execute a command in the background, use the & postfix operator: time-consuming-command &
# To fetch the process id, use the $! 
# To wait process,  wait $pid 

# 7.Globs and patterns
# Glob patterns have several special forms:
# * matches any string.  ? matches a single character.  [chars] matches any character in chars.[a-b] matches any character between a and b.
#  rm file[0-9][0-9][0-9]
# echo {0,1}{0,1}{0,1}    # prints 000 001 010 011 100 101 110 111

# 8.Control structures
if true 
then
  echo "true"
fi
foo=2
if [[ $foo = 1 ]]; then
  echo "1"
elif [[ $foo = 2 ]];then
	echo "2"
fi

case $foo in 
	1)
		echo "case 1"
		;;
	2)
		echo "case 2"
		;;
	(3)
		echo "case 3"
		;;
	(4|5)
		echo "case 4|5"
		;;
	*)
		echo "get out."
		;;
esac


while false 
do
	echo "while true."
done

foo=("1" "2" "3")
for f in ${foo[@]}
do
	echo $f
done

# 9.subroutines
function name_fuc1(){
	echo "fuc1"
}

name_fuc2(){
	echo "fuc2"
}

name_fuc1
name_fuc2















