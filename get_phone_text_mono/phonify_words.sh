#!/bin/bash

unique_words=$1

rm lexicon_cls lexicon_phone

while IFS= read -r word; do
	valgrind ./unified-parser $word 1 0 0 0
	output=`cat wordpronunciation`
	echo $word $output >>lexicon_cls
done < $unique_words

cp lexicon_cls lexicon_phone
bash get_phone_mapped_text_updated.sh
