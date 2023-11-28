#!/usr/bin/perl

open(F1, "<text_raw");
open(W, ">text_phone_mapped_raw");
while($line=<F1>) {
	chomp($line);
	#print "$line\n";
	@words=split(" ", $line);
	foreach $word(@words) {
		#print "$word\n";
		$newline=`grep \"\^$word \" lexicon_final`;
		#print "$newline\n";
		if ($newline) {
			chomp($newline);
			@new_words=split(" ", $newline);
			print W "$new_words[1] ";
		}
		else {
			print "Word $word not present in lexicon....exiting now\n";
			exit 1;
		}
	}
	print W "\n";
}
close W;
close F1;
