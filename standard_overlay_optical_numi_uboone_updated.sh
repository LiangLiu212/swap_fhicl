#!/bin/bash
#------------------------------------------------------------------
#
# Purpose: This script is intended to update the configuration
#          of the fhicl according to run number.
#
# Created: Liang Liu (liangliu@fnal.gov), 25-Nov-2024 
#
#------------------------------------------------------------------



# Make sure batch environment variables needed by this script are defined.

echo $FCL

if [ x$FCL = x ]; then
  echo "Variable FCL not defined."
  exit 1
fi

# Make sure fcl file $FCL exists.

if [ ! -f $FCL ]; then
  echo "Fcl file $FCL does not exist."
  exit 1
fi
# get the file that will be used as input for next stage
next_stage_input=`ls -t1 *.root | egrep -v 'celltree|hist|larlite|larcv|Supplemental|TGraphs' | head -n1`
echo $next_stage_input
run_number=`echo $next_stage_input | cut -d '-' -f3`
echo $run_number

TEMPLATE_FHILE="standard_overlay_optical_numi_uboone_updated"
PICKED_FHICL=""

if [ "$run_number" -ge "0003420"  ] && [  "0011048" -ge "$run_number"  ];    # in the run1 and run 2a run number interval; before full CRT
then
        echo "run run1 and run2a fhicl, standard_overlay_optical_numi_uboone_updated.fcl"
        PICKED_FHICL="standard_overlay_optical_numi_uboone_updated"
elif [ "$run_number" -ge "0011049"  ] && [  "0025769" -ge "$run_number"  ];   # run 2b and later; after full CRT
then
        echo "run run2b and later fhicl, standard_overlay_notpc_numi_uboone_updated.fcl"
        PICKED_FHICL="standard_overlay_notpc_numi_uboone_updated"
fi

#cat wrapper.fcl
mv wrapper.fcl backup_wrapper.fcl
cat backup_wrapper.fcl | sed "s/${TEMPLATE_FHILE}/${PICKED_FHICL}/g" > wrapper.fcl
#cat wrapper.fcl

#cat $FCL
#mv $FCL backup_${FCL}.fcl
#cat backup_${FCL}.fcl  | sed "s/${TEMPLATE_FHILE}/${PICKED_FHICL}/g" > $FCL
#cat $FCL

# change the fhicls in all Stage.fcl

echo "List all the Stage.fcl"
ls Stage*fcl

for fhicl_stage in Stage*fcl;
do
#        cat $fhicl_stage
        mv $fhicl_stage backup_${fhicl_stage}.fcl
        cat backup_${fhicl_stage}.fcl  | sed "s/${TEMPLATE_FHILE}/${PICKED_FHICL}/g" > $fhicl_stage
#        cat $fhicl_stage
done

