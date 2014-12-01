#! /usr/bin/perl -w
use strict;
use warnings;
use feature qw(switch say); # need this for GIVEN-WHEN block to work
use Tie::IxHash;

# Define
my $s1;
my $s1b;
my $filename = $ARGV[0];
chomp $filename;

# Declare new filehandle and associated it with filename
open (my $fh, '<', $filename) or die "\nCould not open file '$filename' $!\n";
my @array = <$fh>;
close ($fh);

for ( my $i = 0 ; $i <= $#array ; $i++ )
{
	if ( $array[$i] =~ /Star_name/ )
	{
	    print $array[$i];
        my @parts = split(/=/, $array[$i]);
	    my $wholeText = $parts[1];
		if ($wholeText =~ /\"$/)   #check the last character if " which is the end of the string
		{
		   $wholeText =~ s/\"(.*)\"/$1/;   #extract the string, removed the quotes
		}
		print $wholeText;
	}
}


