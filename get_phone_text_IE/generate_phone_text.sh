#!/bin/bash

# Script to generate phone text from character-based text
# Requires directory get_phone_text_IE 
#
# pip install g2p_en 
#
# Input required: text_char (cleaned text). File ID followed by space. It is assumed that the text has been cleaned. Replace " ," with "," etc.
#
# Example
# test_001 Hello World! How are you?
# test_002 It is a beautiful day today.
#
#
# Output: text_phone
#
# Note that this code process words considering case sensitivity
#
# Run as: bash generate_phone_text.sh
#
# Wrapper written by Anusha Prakash (IIT Madras, India) 13/03/2023

# Cleaning up:
rm fileID text_raw unique_words lexicon_* text_phone_mapped_raw text_phone_sans_punc text_phone 

cat text_char | cut -d " " -f1 >fileID
cat text_char | cut -d " " -f2- >text_raw

# Minimal cleaning of text, i.e., removing commas, full stop, question mark, exclamation marks
sed -i 's/,//g' text_raw
sed -i 's/\.//g' text_raw
sed -i 's/?//g' text_raw
sed -i 's/!//g' text_raw
sed -i "s/[[:space:]]\+/ /g" text_raw
sed -i 's/ $//g' text_raw

# Obtain unique word list
echo "Obtain unique words in the text file"
tr ' ' '\n' <text_raw | sort | uniq >unique_words
echo "... Done"

# Obtain phone-based output for every word. Note: Requires English G2P rules (https://github.com/Kyubyong/g2p)
echo "Phonifying words ..."
bash phonify_words.sh unique_words
echo "... Done"

echo "Obtaining phone-based text ..."
# Obtain final phone-based text
perl convert_text_to_phone_mapped.pl
paste -d' ' fileID text_phone_mapped_raw >text_phone_sans_punc
sed -i 's/ $//g' text_phone_sans_punc
perl include_punc_in_phone_text.pl
sed -i 's/ $//g' text_phone
echo "... Finally done!!"
