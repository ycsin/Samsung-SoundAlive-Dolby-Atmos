#!/sbin/sh
#====================================================
#       FILE: set_floating.sh
#       AUTHOR: ImbaWind @ XDA
#       BASED ON: xpirt @ XDA's  set_prop.sh
#       DESCRIPTION: Change prop in floating_feature.xml
#       USAGE: set_floating.sh <prop> <arg>
#====================================================

FILE=/system/etc/floating_feature.xml
prop=$1
arg=$2
echo $prop1
if grep -F "<"$prop">" $FILE ; then
    lineNum=`busybox sed -n "/<${prop}>/=" $FILE`
    echo $lineNum
    sed -i "${lineNum} c<${prop}>${arg}</${prop}>" $FILE
else
    echo "New properties"
    lineNum=`busybox sed -n "/<\/SecFloatingFeatureSet>/=" $FILE`
    sed -i  "${lineNum} c<${prop}>${arg}</${prop}>" $FILE
    echo "</SecFloatingFeatureSet>" >> $FILE
fi;