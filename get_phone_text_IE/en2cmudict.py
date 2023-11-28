#!/bin/bash

from argparse import ArgumentParser
from g2p_en import G2p
from tqdm import tqdm

parser = ArgumentParser()
parser.add_argument('-i', '--input-file', type=str)
parser.add_argument('-o', '--output-file', type=str)

args = parser.parse_args()

print(args.input_file)
print(args.output_file)

g2p = G2p()

file_in = open(args.input_file, 'r')
file_ot = open(args.output_file, 'w')
for line in tqdm(file_in):
	line = line.strip()
	out = g2p(line)
	for i in range(4):
		out = [x.rstrip(str(i)) for x in out]
	file_ot.write(str(out)+'\n')

file_in.close
file_ot.close

