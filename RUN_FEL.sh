#RUN MEME ON HIV LANL
#NOTE: RUN FROM HYPHY DIRECTORY

BATCHFILE="/Users/alex/Documents/hyphy/res/TemplateBatchFiles/SelectionAnalyses/FEL.bf"
HYPHY="hyphy"
DATADIR="/Users/alex/Documents/stats_final_proj/Data"



echo Starting to run FEL.. Initialize.

for file in $DATADIR/*.msa; do                                  
  if [[ ! -e $file".FEL.json" ]]
  then
      echo Running FEL on $file
     
      hyphy $BATCHFILE --code Universal --alignment $file --tree $file"_NJ.nwk"
  fi
done

