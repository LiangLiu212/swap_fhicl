#!/bin/bash
#------------------------------------------------------------------
#
# Purpose: Following the copy.fcl to check the crt status
#          
#
# Created: Liang Liu (liangliu@fnal.gov), 25-Nov-2024 
#
#------------------------------------------------------------------


# Make sure batch environment variables needed by this script are defined.

# get the file that will be used as input for next stage
next_stage_input=`ls -t1 *.root | egrep -v 'celltree|hist|larlite|larcv|Supplemental|TGraphs' | head -n1`
echo $next_stage_input
run_number=`echo $next_stage_input | cut -d '-' -f3`
echo $run_number
echo ${next_stage_input:0:-28}.root

ifdh cp /pnfs/uboone/resilient/users/liangliu/crt/check_crt_merge.py . 
chmod u+x check_crt_merge.py
check_crt_merge.py -f ${next_stage_input:0:-28}.root

crt_status=$?
echo "the crt status $crt_status"

echo "$crt_status" > crt_status.txt

