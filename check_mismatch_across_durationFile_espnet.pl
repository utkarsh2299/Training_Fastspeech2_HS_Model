#!/usr/bin/perl

# # Script to check mismatch between the duration file from hybrid segmentation and direct calculation from the wav files.
#
# Inputs required: (1) Path to wavfiles with required sampling rate ($wavPath) (2) duration_file_HS_without_space (3) Modify sampling rate ($fs) and shift samples ($n_shift) as required
#
# Output: mismatched_espnet_dur_files
#
# Run as: perl check_mismatch_across_durationFile_espnet.pl
#
# Written and Modified by Anusha Prakash (IIT Madras, India) 24/02/2023

use POSIX qw/ceil/;
use List::Util qw(sum);

#Path to duration file
$durFile = "duration_file_HS";
#$durFile = "duration_info/dur_temp";

# Path to wav folder
$wavPath = "/tts/database/unzipped_folders/networks_tts_arun/arun/DATABASE/Hindi/male/english/wav/";

# Name of list of mismatched files
$mismatchFile = "mismatched_espnet_dur_files";

system("rm $mismatchFile");
open(W1, ">$mismatchFile");
open(W2, ">$mismatchFile_log");

# Frame attributes
$fs=48000;
$n_shift=512;

$numEqual = 0;
$espnetMore = 0;
$durFileMore = 0;

open(F1, "<$durFile");
while($file=<F1>) {
	chomp($file);
	@fields = split(/ /, $file);
	#$fileID = $fields[0];
	$fileID = shift @fields;
		;
	# Calculate number of frames from sox samples
	$wavFile = $wavPath.$fileID.".wav";
	
	$soxSamp = `soxi $wavFile | grep \"Duration\" | cut -d \" \" -f11`;

	#print "$soxSamp";
	chomp($soxSamp);
	$espnetFrames = ceil($soxSamp/$n_shift);
	print W2 "$fileID $espnetFrames ";

	# Calculate total frames in the duration file
	$durFileFrames = sum(@fields);
	print W2 "$durFileFrames\n";

	if ($espnetFrames > $durFileFrames) {
		$espnetMore = $espnetMore + 1;
		print W1 "$fileID\n";
	}
	elsif ($espnetFrames < $durFileFrames) {
		$durFileMore = $durFileMore + 1;
		print W1 "$fileID\n";
	}
	else {
		$numEqual = $numEqual + 1;
	}
}
close F1;
close W1;
close W2;

print "==== Frame mismatch statistics ====\n";
print "Equal number of frames = $numEqual\n";
print "Espnet has more frames = $espnetMore\n";
print "Duration file has more frames = $durFileMore\n";
