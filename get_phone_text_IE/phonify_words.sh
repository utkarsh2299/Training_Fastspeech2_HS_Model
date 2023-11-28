#!/bin/bash

input=$1

python3 en2cmudict.py -i $input -o lexicon_cmu
cp lexicon_cmu lexicon_cls
bash get_cmu_to_cls_mapping.sh
cp lexicon_cls lexicon_phone
bash get_cls_to_phone_mapping_updated.sh
sed -i 's/\[//g' lexicon_phone
sed -i 's/\]//g' lexicon_phone
sed -i 's/,//g' lexicon_phone
sed -i "s/'//g" lexicon_phone
sed -i "s/ //g" lexicon_phone
paste -d' ' $input lexicon_phone >lexicon_final
