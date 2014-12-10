#! /usr/bin/perl -w
use strict;
use warnings;
use feature qw(switch say); # need this for GIVEN-WHEN block to work
use Tie::IxHash;

# Define
my $s1;
my $s1b;
my $filename = $ARGV[0];
my $thing1;
my $thing2;
chomp $filename;

# Declare new filehandle and associated it with filename
open (my $fh, '<', $filename) or die "\nCould not open file '$filename' $!\n";
my @array = <$fh>;
close ($fh);

for ( my $i = 0 ; $i <= 3 ; $i++ )
{
	if ( $array[$i] =~ /Star_name/ )
	{
#	    print $array[$i];
        my @parts = split(/=/, $array[$i]); # split string on the equal sign 
	    my $wholeText = $parts[1]; # get the contents of the right side of the equal sign 
		if ($wholeText =~ /\"$/)   #check the last character if " which is the end of the string
		{
		   $wholeText =~ s/\"(.*)\"/$1/;   #extract the string, removed the quotes
		}
#		print "$filename  $wholeText";

        if ( $wholeText =~ /\D+\d+/ )
        {
            $wholeText =~ s/(\D+)(\d+)/$1$2/;
            $thing1 = $1;
            $thing2 = $2;
        }

        $thing1 =~ s/\s+$//; # this line gets rid of space character in HD or HIP 
        $thing2 =~ s/^0+//g; # this line gets rid of leading zeros 
		print "$filename  $thing1 $thing2\n";
	}
}
