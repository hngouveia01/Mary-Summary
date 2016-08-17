use strict;
use warnings;

open(FILE, "<texto")
	or die("The program has failed opening the file");
	
my $count = 0;
	
while(my $line = <FILE>){
	if($line =~ /\(\d{3}\)/){
		print("The number sequence has been found inside the sentence: $line\n");
	}
	$count++;
	($count >= 20) ? last : next;
}

close(FILE); 
