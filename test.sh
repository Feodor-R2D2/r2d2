#!/bin/sh

VERBOSE="yes"
wdir="/tmp/Test/"
suf="txt"
old_m=1

today=`date +%s`
old_s=`expr $old_m '*' 60`
old_time=`expr $today - $old_s`

if [ $VERBOSE = yes ] 
then 
echo "today=$today\told=$old_time" 
fi 

if [ -d $wdir ]
then
if [ $VERBOSE = yes ] 
then 
echo "$wdir exist, work!" 
fi 
 
file="$wdir$today.$suf"

if [ ! -f $file ]
then
if [ $VERBOSE = yes ] 
then 
echo "Create file $file" 
fi 
`echo $tuday > $file`
else
echo "$file exist !!"
fi
for t_file in `ls $wdir`
do 
t_file_last=`date -r $wdir$t_file +%s`
if [ $t_file_last -lt $old_time ]
then
if [ $VERBOSE = yes ]
then
echo "File $wdir$t_file\t is to old, last modified=$t_file_last\t old_time=$old_time" 
echo "Remove it!!!"
`rm $wdir$t_file`
fi
fi
done

else 
echo "dir $wdir not exist, don't work!"
fi


