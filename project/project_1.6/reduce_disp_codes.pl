#!/usr/bin/perl

use File::Basename;

if ($#ARGV == -1)
{
	usage();
	exit;
}

my $filepath = $ARGV[0];
print "Opening file: $filepath\n";

my $WriteBuffer;
# run the loop on the argument file
while (<>)
{
# ^[\w\d?]+,(3|4
#^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,^[\w\d?]+,(2|20)

	# Match pattern of 8 CSV fields, then a 2 or 20.  Replace these with themselves.
	if (s/(^[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,)(2|20),/\1\2,/i)
	{
		$WriteBuffer .= $_; # Unchanged lines with 2 or 20 disposition code
	}
	elsif (s/(^[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,[\w\d?\.\-]+,)(\d+),/\1\060,/i)
	{
		$WriteBuffer .= $_; # change lines not matched by previous regex with same values, but a 0 for disposition code.  \060 == '0'
	}
	else
	{
		$WriteBuffer .= $_; # unchanged other lines
	}
}

# Get the file path, name and suffix
my ( $name, $path, $suffix ) = fileparse( $filepath, qr/\.[^.]*/ );

# Write the output file
my $outFileName = $path . $name . "_reduced.csv";
print "Writing file to: $outFileName\n";
open (OUTFILE, ">$outFileName") or die "Error: Could not open '$outFileName': $!\n";
print OUTFILE $WriteBuffer;
close OUTFILE;

#------------------------------------------------------------
# usage()
# Function to show usage information
#------------------------------------------------------------
sub usage
{
	print basename($0) . " - Script to reduce diagnostic codes.\n\n";
	print "Usage: " . basename($0) . " {med_data.csv}\n";
	print "med_data.csv\t-\tCSV file containing medical data\n";
	print "Must follow attribute format:\n";
	print "RecordID,PatientID,Record Count,Interval,Patient-Sex,Age,Patient-Race,Patient-Ethnicity,Patient-Disposition";
}
