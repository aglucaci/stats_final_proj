#RUN MEME ON HIV LANL
#NOTE: RUN FROM HYPHY DIRECTORY

BATCHFILE="/Users/alex/Documents/hyphy/res/TemplateBatchFiles/SelectionAnalyses/MEME.bf"
HYPHY="hyphy"
DATADIR="/Users/alex/Documents/stats_final_proj/Data"

echo Starting to run MEME.. Initialize.

#1



for file in $DATADIR/*.msa; do                                  
  #echo "file=$file"
  #echo $file

  #echo checking output file $DATADIR"/"$file".MEME.json"
  if [[ ! -e $file".MEME.json" ]]
  then
      echo Running MEME on $file
      #echo hyphy $BATCHFILE --code Universal --alignment $file --tree $file"_NJ.nwk"
      hyphy $BATCHFILE --code Universal --alignment $file --tree $file"_NJ.nwk"
  fi
done

