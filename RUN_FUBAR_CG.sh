#RUN FUBAR ON HIV LANL
#NOTE: RUN FROM HYPHY DIRECTORY

BATCHFILE="/Users/alex/hyphy/res/TemplateBatchFiles/SelectionAnalyses/FUBAR.bf"
HYPHY="./hyphy"
DATADIR="/Users/alex/Documents/stats_final_proj/Data"

echo Starting to run FUBAR.. Initialize.

#1

for file in $DATADIR/*.msa; do
  #echo "file=$file"
  #echo $file
  #echo checking output file $DATADIR"/"$file".MEME.json"
  
  if [[ ! -e $file".FUBAR_CG.json" ]]
  then
      echo Running FUBAR on $file
      #echo hyphy $BATCHFILE --code Universal --alignment $file --tree $file"_NJ.nwk"
      
      $HYPHY $BATCHFILE --code Universal --method Collapsed-Gibbs --alignment $file --tree $file"_NJ.nwk" --output $file".FUBAR_CG.json" --cache $file".FUBAR_CG.cache"
  fi
done
