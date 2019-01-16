#!/sbin/sh
#====================================================
#              FILE: set_prop.sh
#            AUTHOR: xpirt
#       DESCRIPTION: Change prop in file
#====================================================

FILE=/system/build.prop
prop=$1
arg=$2

if grep -Fq $prop $FILE ; then
    lineNum=`busybox sed -n "/${prop}/=" $FILE`
    echo $lineNum
    sed -i "${lineNum} c${prop}=${arg}" $FILE
    echo "to $prop set value $arg in build.prop"   
else
    echo "$prop does not exist in build.prop"   
    echo "appending to end of build.prop"
    echo $prop=$arg >> $FILE
fi;
