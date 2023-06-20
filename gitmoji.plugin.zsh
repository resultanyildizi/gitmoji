PLUGIN_FOLDER="$ZSH/custom/plugins/gitmoji"
RAW_FILE_NAME="$PLUGIN_FOLDER/emojis.raw"
JSON_FILE_NAME="$PLUGIN_FOLDER/emojis.json"
TEMP_FILE_NAME="$PLUGIN_FOLDER/keys.tmp"
GIT_EMOJIS_ENDPOINT="https://api.github.com/emojis"

download_emojis_json() {
  rm -rf $JSON_FILE_NAME
  curl $GIT_EMOJIS_ENDPOINT -o $JSON_FILE_NAME
}

create_raw_emojis() {
  $(cat $JSON_FILE_NAME | grep -o "\".*\":" > $TEMP_FILE_NAME)
  while read KEY; 
  do 
    EMOJI=$(echo $KEY | cut -d '"' -f2)
    echo :$EMOJI: >> $RAW_FILE_NAME 
  done < $TEMP_FILE_NAME 
}

generate_gh_emojis() {
  if [[ ! -a $RAW_FILE_NAME ]];
  then 
    download_emojis_json
    create_raw_emojis 
    rm $JSON_FILE_NAME
    rm $TEMP_FILE_NAME 
    return;
  fi

  LAST_UPDATED_SEC=$(date -r $RAW_FILE_NAME +%s)
  CURR_DATETIM_SEC=$(date +%s)

  (( FOURTEEN_DAYS_SEC = 60 * 60 * 24 * 14 ))
  (( DIFFERENCE_SEC = $CURR_DATETIM_SEC - $LAST_UPDATED_SEC ))

  if [[ $DIFFERENCE_SEC -gt $FOURTEEN_DAYS_SEC ]];
  then
    echo "Emojis are expired. We will download them now."
    download_emojis_json 
    create_raw_emojis 
    rm $JSON_FILE_NAME
    rm $TEMP_FILE_NAME 
  else
    return;
  fi
}

get_random_number() {
  local MAX=$1
  local SEED=$(date +%s)
  RANDOM=$(($SEED * $SEED))
  local RANDOM_NUMBER=$((RANDOM % MAX + 1))
  echo "$RANDOM_NUMBER"
}

get_random_emoji() {
 TOTAL=$(wc -l $RAW_FILE_NAME | grep -Eo "[0-9]+")
 RAND_LINE=$(get_random_number $TOTAL)

 let INDX=0
 while read EMOJI; 
 do 
   if [[ $INDX -eq $RAND_LINE ]];
   then echo $EMOJI;
   fi

   (( INDX = INDX + 1 )) 
 done < $RAW_FILE_NAME;
}

gitmoji() {
  generate_gh_emojis

  EMOJI=$(get_random_emoji)
  MSG=$1
  echo $EMOJI $MSG
}

gcamj() {
  GITMOJI=$(gitmoji $1)
  git commit --all --message $GITMOJI
}
