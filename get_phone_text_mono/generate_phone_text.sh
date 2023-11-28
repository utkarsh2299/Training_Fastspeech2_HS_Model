#!/bin/bash

# Script to generate phone text from character-based text
# Requires directory get_phone_text_
#
# Input required: text_char (cleaned text). File ID followed by space. It is assumed that the text has been cleaned. Replace " ," with "," etc.
#
# Example
# test_001 आयआयटी मद्रास स्पीच लॅब एएसआर सिस्टम आवृत्ती 1 कोटी वापरून उपशीर्षके स्वयंचलितपणे तयार केली गेली आहेत.
# test_002 ही आजची रूपरेषा आहे
#
#
# Output: text_phone
#
# Run as: bash generate_phone_text.sh
#
# Wrapper written by Anusha Prakash (IIT Madras, India) 24/02/2023

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

# Obtain phone-based output for every word. Note: Unified parser and all associated files to be present in this directory (You can replace this by the parallel Lex & Yacc parser or the Python parser to make this step faster)
echo "Running unified parser ..."
bash phonify_words.sh unique_words
echo "... Done"
cat lexicon_phone | cut -d " " -f1 >col1
cat lexicon_phone | cut -d " " -f2- >col2
sed -i 's/0//g' col2
sed -i 's/(//g' col2
sed -i 's/)//g' col2
sed -i 's/!//g' col2
sed -i 's/\"//g' col2
sed -i "s/'//g" col2
sed -i "s/^set wordstruct//g" col2
sed -i "s/ //g" col2
paste -d' ' col1 col2 >lexicon_final
rm col1 col2

echo "Obtaining phone-based text ..."
# Obtain final phone-based text
perl convert_text_to_phone_mapped.pl
paste -d' ' fileID text_phone_mapped_raw >text_phone_sans_punc
sed -i 's/ $//g' text_phone_sans_punc
perl include_punc_in_phone_text.pl
sed -i 's/ $//g' text_phone
echo "... Finally done!!"
