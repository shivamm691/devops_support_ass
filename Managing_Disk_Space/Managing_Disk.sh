#!/bin/bash

###################################################################
#Script Name 	:                                                                                        
#Description:script to audit the following hardware  spec                                                                             
#Args : 1        	                                                                                       #Author       	:Shivam Mishra                                            
#Email         	:shivamm691@gmail.com  
#lastUbate: 15-02-2022                                         
###################################################################
path="/data/audios/"
timestamp=$(date +%Y%m%d_%H%M%S)    
filename=deleted-files_$timestamp.log  
log=$path$filename
hour=${1:-40}

START_TIME=$(date +%s)

find $path -maxdepth 1 -name "*.wav"  -type f -mmin  +$((60*$hour))  -print -delete >> $log

END_TIME=$(date +%s)

ELAPSED_TIME=$(( $END_TIME - $START_TIME ))


echo "Backup :: Script End -- $(date +%Y%m%d_%H%M)" >> $log

echo "Elapsed Time ::  $(date -d 00:00:$ELAPSED_TIME +%Hh:%Mm:%Ss) "  >> $log