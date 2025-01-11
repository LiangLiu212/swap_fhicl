#! /bin/bash
#------------------------------------------------------------------
#
# Purpose: This script is intended to update the configuration
#          of the fhicl using the initilization source hook. It
#          makes a wrapper fcl file that overrides certain fcl
#          parameters used by module WireCellAnaTree and
#          WireCellEventWeightTree, specifically:
#        
#          physics.analyzers.wcpselection.FileType: "data_extbnb_run3_G1"
#          physics.analyzers.wcpweights.FileType: "data_extbnb_run3_G1"
#
# Created: Wenqiang Gu, 14-Jan-2021
#         
# Updated: Liang Liu,   03-Jan-2025
#          Unified this script for all runs
#
#------------------------------------------------------------------

# Make sure batch environment variables needed by this script are defined.

if [ x$FCL = x ]; then
  echo "Variable FCL not defined."
  exit 1
fi

# Make sure fcl file $FCL exists.

if [ ! -f $FCL ]; then
  echo "Fcl file $FCL does not exist."
  exit 1
fi

# Rename the existing fcl file $FCL to something else.

mv $FCL mix_wrapper.fcl

# Generate wrapper according to run_number
# get the file that will be used as input for next stage
next_stage_input=`ls -t1 *.root | egrep -v 'celltree|hist|larlite|larcv|Supplemental|TGraphs' | head -n1`
echo $next_stage_input
# get the run number
run_number=`echo $next_stage_input | cut -d '-' -f3`
echo $run_number

FT_STREAM="run1"

if [ "$run_number" -ge "3420"  ] && [  "8316" -ge "$run_number"  ];    # in the run1 run number interval
then
        echo "run run1 fhicl"
        FT_STREAM="run1"
elif [ "$run_number" -ge "0008317"  ] && [  "0011048" -ge "$run_number"  ];   # in the run2 run number interval
then
        echo "run run2a fhicl"
        FT_STREAM="run2"
elif [ "$run_number" -ge "0011049"  ] && [  "0013696" -ge "$run_number"  ];   # in the run2 run number interval
then
        echo "run run2b fhicl"
        FT_STREAM="run2"
elif [ "$run_number" -ge "0013697"  ] && [  "0014116" -ge "$run_number"  ];    # in the run3 run number interval
then
        echo "run run3a fhicl"
        FT_STREAM="run3"
elif [ "$run_number" -ge "14117"  ] && [  "0018960" -ge "$run_number"  ];    # in the run3 run number interval
then
        echo "run run3b fhicl"
        FT_STREAM="run3"
elif [ "$run_number" -ge "0018961"  ] && [  "0019752" -ge "$run_number"  ];  # in the run4 run number interval, run4a has four epochs, we may need to split it
then
        echo "run run4a fhicl"
        FT_STREAM="run4"
elif [ "$run_number" -ge "0019753"  ] && [  "0021285" -ge "$run_number"  ];  # in the run4 run number interval, run4b has four epochs, we may need to split it
then
        echo "run run4b fhicl"
        FT_STREAM="run4"
elif [ "$run_number" -ge "0021286"  ] && [  "0022269" -ge "$run_number"  ];  # in the run4 run number interval, run4c has four epochs, we may need to split it
then
        echo "run run4c fhicl"
        FT_STREAM="run4"
elif [ "$run_number" -ge "0022270"  ] && [  "0024319" -ge "$run_number"  ];  # in the run4 run number interval, run4d has four epochs, we may need to split it
then
        echo "run run4d fhicl"
        FT_STREAM="run4"
elif [ "$run_number" -ge "0024320"  ] && [  "0025768" -ge "$run_number"  ];  # in the run5 run number interval
then
        echo "run run5 fhicl"
        FT_STREAM="run5"
fi




cat <<EOF > $FCL
#include "mix_wrapper.fcl"

physics.analyzers.wcpselection.IsNuMI:               true
physics.analyzers.wcpweights.IsNuMI:                 true

physics.analyzers.wcpselection.WeightLabel:          "eventweightSep24::EventWeightSep24"
physics.analyzers.wcpweights.WeightLabel:            "eventweightSep24::EventWeightSep24"
physics.analyzers.wcpweights.MCEventWeightLabels:  [ "eventweightSep24::EventWeightSep24"
                                                    ,"eventweightSep24::EventWeightSep24ExtraGENIE1"
                                                    ,"eventweightSep24::EventWeightSep24ExtraGENIE2"
                                                    ,"eventweightSep24::EventWeightSep24ExtraGENIE3"
                                                    ,"eventweightSep24::EventWeightSep24ExtraGENIE4"
                                                    ,"eventweightSep24::EventWeightSep24ExtraGENIE5" ]
physics.analyzers.wcpselection.SaveLeeWeights:       false
physics.analyzers.wcpweights.SaveLeeWeights:         false

physics.analyzers.wcpweights.GenieKnobs:        [ "All_UBGenie"
                                                , "AxFFCCQEshape_UBGenie"
                                                , "DecayAngMEC_UBGenie"
                                                , "NormCCCOH_UBGenie"
                                                , "NormNCCOH_UBGenie"
                                                , "RPA_CCQE_UBGenie"
                                                , "RootinoFix_UBGenie"
                                                , "ThetaDelta2NRad_UBGenie"
                                                , "Theta_Delta2Npi_UBGenie"
                                                , "TunedCentralValue_UBGenie"
                                                , "VecFFCCQEshape_UBGenie"
                                                , "XSecShape_CCMEC_UBGenie"
                                                , "expskin_FluxUnisim"
                                                , "horncurrent_FluxUnisim"
                                                , "kminus_PrimaryHadronNormalization"
                                                , "kplus_PrimaryHadronFeynmanScaling"
                                                , "kzero_PrimaryHadronSanfordWang"
                                                , "nucleoninexsec_FluxUnisim"
                                                , "nucleonqexsec_FluxUnisim"
                                                , "nucleontotxsec_FluxUnisim"
                                                , "piminus_PrimaryHadronSWCentralSplineVariation"
                                                , "pioninexsec_FluxUnisim"
                                                , "pionqexsec_FluxUnisim"
                                                , "piontotxsec_FluxUnisim"
                                                , "piplus_PrimaryHadronSWCentralSplineVariation"
                                                , "reinteractions_piminus_Geant4"
                                                , "reinteractions_piplus_Geant4"
                                                , "reinteractions_proton_Geant4"
                                                , "splines_general_Spline"
                                                , "xsr_scc_Fa3_SCC"
                                                , "xsr_scc_Fv3_SCC" ]

physics.analyzers.wcpselection.FileType: "prodgenie_numi_nu_overlay_${FT_STREAM}"
physics.analyzers.wcpweights.FileType: "prodgenie_numi_nu_overlay_${FT_STREAM}"

physics.end_paths: [ stream1, ana ]

services.TFileService.fileName: 	"reco_stage_2_hist.root"
microboone_tfile_metadata.JSONFileName: ["reco_stage_2_hist.root.json"]

EOF

# Make sure IFDH service is configured in fcl file.

if ! lar --debug-config=/dev/stdout -c $FCL | grep -q IFDH:; then
  cat <<EOF >> $FCL
services.IFDH:
{
}

EOF
fi

cat $FCL
