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

if [ "$run_number" -ge "3420"  ] && [  "8316" -ge "$run_number"  ];    # in the run1 run number interval
then
        echo "run run1 fhicl"
        cat $FCL
        mv $FCL backup_${FCL}.fcl
        cat backup_${FCL}.fcl  | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/g" > $FCL
        cat $FCL
        cat wrapper.fcl
        mv wrapper.fcl backup_wrapper.fcl
        cat backup_wrapper.fcl | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/g" > wrapper.fcl
        cat wrapper.fcl
elif [ "$run_number" -ge "8317"  ] && [  "13696" -ge "$run_number"  ];   # in the run2 run number interval
then
        echo "run run2 fhicl"
        cat $FCL
        mv $FCL backup_${FCL}.fcl
        cat backup_${FCL}.fcl  | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/g" > $FCL
        cat $FCL
        cat wrapper.fcl
        mv wrapper.fcl backup_wrapper.fcl
        cat backup_wrapper.fcl | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/g" > wrapper.fcl
        cat wrapper.fcl
elif [ "$run_number" -ge "0013697"  ] && [  "0018960" -ge "$run_number"  ];    # in the run3 run number interval
then
        echo "run run3 fhicl"
        cat $FCL
        mv $FCL backup_${FCL}.fcl
        cat backup_${FCL}.fcl  | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run3_overlay_cc0pinp_numi/g" > $FCL
        cat $FCL
        cat wrapper.fcl
        mv wrapper.fcl backup_wrapper.fcl
        cat backup_wrapper.fcl | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run3_overlay_cc0pinp_numi/g" > wrapper.fcl
        cat wrapper.fcl
elif [ "$run_number" -ge "0018961"  ] && [  "24319" -ge "$run_number"  ];  # in the run4 run number interval, TODO: run4 has four epochs, we may need to split it
then
        echo "run run4 fhicl"
        cat $FCL
        mv $FCL backup_${FCL}.fcl
        cat backup_${FCL}.fcl  | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run4_overlay_cc0pinp_numi/g" > $FCL
        cat $FCL
        cat wrapper.fcl
        mv wrapper.fcl backup_wrapper.fcl
        cat backup_wrapper.fcl | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run4_overlay_cc0pinp_numi/g" > wrapper.fcl
        cat wrapper.fcl
elif [ "$run_number" -ge "24320"  ] && [  "25769" -ge "$run_number"  ];  # in the run5 run number interval
then
        echo "run run5 fhicl"
        cat $FCL
        mv $FCL backup_${FCL}.fcl
        cat backup_${FCL}.fcl  | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run4_overlay_cc0pinp_numi/g" > $FCL
        cat $FCL
        cat wrapper.fcl
        mv wrapper.fcl backup_wrapper.fcl
        cat backup_wrapper.fcl | sed "s/run_neutrinoselectionfilter_run1_overlay_cc0pinp_numi/run_neutrinoselectionfilter_run4_overlay_cc0pinp_numi/g" > wrapper.fcl
        cat wrapper.fcl
fi

