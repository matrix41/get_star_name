#! /usr/bin/perl -w
use strict;
use warnings;
use feature qw(switch say); # need this for GIVEN-WHEN block to work
use Tie::IxHash;

# Define
my $filename = $ARGV[0];
my $thing1;
my $thing2;
chomp $filename;

# Declare new filehandle and associated it with filename
open (my $fh, '<', $filename) or die "\nCould not open file '$filename' $!\n";
my @array = <$fh>;
close ($fh);

# This FOR-loop will only process the first three lines of the file because I'm only 
# interested in grabbing the star name.  Doing this will also considerably speed 
# up my program if I don't have to loop through the rest of the file.  
for ( my $i = 0 ; $i <= 3 ; $i++ )
{
	if ( $array[$i] =~ /Star_name/ )
	{
        my @parts = split(/=/, $array[$i]); # split string on the equal sign 
        my $wholeText = $parts[1]; # get the contents of the right side of the equal sign 
        if ($wholeText =~ /\"$/)   #check the last character if " which is the end of the string
        {
            $wholeText =~ s/\"(.*)\"/$1/;   #extract the string, removed the quotes
        }

# This IF-block will find any star name where there is no space in between the catalog name 
# and the catalog number.  When it finds a match, the algorithm will copy the catalog name 
# to $1 and the catalog number to $2.  
        if ( $wholeText =~ /\D+\d+/ )
        {
            $wholeText =~ s/(\D+)(\d+)/$1$2/;
            $thing1 = $1;
            $thing2 = $2;
        }
        else
        {
            $wholeText =~ s/(\D+)\s+(\d+)/$1$2/;
            $thing1 = $1;
            $thing2 = $2;
        }
        $thing1 =~ s/\s+$//; # this line gets rid of any trailing space character in HD or HIP 
        $thing2 =~ s/^0+//g; # this line gets rid of leading zeros 
        print "$filename  $thing1 $thing2\n";
	}
}
