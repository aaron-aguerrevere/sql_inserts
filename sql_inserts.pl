#!/usr/bin/perl
# ------------------------------------------------------------------------------
# Script: 		CS-12534_Update.pl
# Description:	Perl script to create SQL to change PO Box addresses to 
#               street addresses
# ------------------------------------------------------------------------------

use strict;
use warnings;

my $strInputDir = "C:\\Users\\aguerrevere\\OneDrive - Legacy.com\\Documents\\";
my $strInputFile = $strInputDir . "CS-34367_emails.csv";
my $strOutputFile = $strInputDir . "CS-4367_Email_Insert_Deploy.SQL";
my $strCompleteFile       = "";
my $strCompleteRecord     = "";
my $strCobrand            = "";
my $strLocalAd2HTML       = "";
my $strNGOLeaderboard     = "";
my $strNGO300250          = "";
my $strFHAddr1            = "";
my $strFHAddr2            = "";
my $strFHCity             = "";
my $strFHState            = "";
my $strFHZip              = "";
my $strFHPhone1           = "";
my $strFHPhone2           = "";
my $strFHFax              = "";
my $strFHEmail            = "";
my $strFHURL              = "";
my $strPrePlanLink        = "";
my $strCMSLogin           = "";
my $strNewspaperId		  = "";
my $strWebsiteName		  = "";
my $strAdsTxtFetchURL	  = "";
my $strEmail			  = "";
my $intUpdateCnt          = 0;
my $strSQL                = "";
my $strEnableSQL          = "";

print "InputFile is $strInputFile\n";
# -----------------------------------------------------------------
# Open notice directory for reading, go there and get list of files
# -----------------------------------------------------------------
chdir($strInputDir);

# -------------------------
# Set up input file handle.
# -------------------------
open INFILE, "<" . $strInputFile || die "Input file open failed $!\n";
$strCompleteFile = join "", <INFILE>;
close INFILE;

# ---------------------------------
# Write header to the output file.
# ---------------------------------
open OUTFILE, ">>" . $strOutputFile || die "Output file open failed $!\n";

while($strCompleteFile =~ /(.*?)\n(.*)/is)
{
	$strCompleteRecord = $1;
	$strCompleteFile = $2;
	#print "strCompleteRecord = [$strCompleteRecord]\n";
	($strEmail) = split /\,/, $strCompleteRecord;
	$strEmail = Trim($strEmail);
#	$strFHURL = Trim($strFHURL);
#	$strLocalAd2HTML =~ s/\'/\'\'/gis;
#	$strNGOLeaderboard =~ s/\'/\'\'/gis;
#	$strNGO300250 =~ s/\'/\'\'/gis;
#	$strLocalAd2HTML =~ s/\"\"/\"/gis;
#	$strNGOLeaderboard =~ s/\"\"/\"/gis;
#	$strNGO300250 =~ s/\"\"/\"/gis;
#	$strFHName1 =~ s/\s+$//gi;
#	$strFHAddr1 =~ s/\'/\'\'/gis;
#	$strFHAddr2 =~ s/\'/\'\'/gis;
#	$strFHAddr1 =~ s/\"//gis;
#	$strFHAddr2 =~ s/\"//gis;
#	$strFHName1 = Trim($strFHName1);
#	$strFHName2 = Trim($strFHName2);
#	$strFHID = Trim($strFHID);
#	$strFHAddr1 = Trim($strFHAddr1);
#	$strFHAddr2 = Trim($strFHAddr2);
#	$strFHCity = Trim($strFHCity);
#	$strFHCity =~ s/\'/\'\'/gis;
#	$strFHState = Trim($strFHState);
#	$strFHZip = Trim($strFHZip);
#	$strFHPhone1 = Trim($strFHPhone1);
#	print "strNewspaperid = [$strNewspaperId]\n";
#	print "strCobrand = [$strCobrand]\n";
#	print "AdsTxtFetchURL = [$strAdsTxtFetchURL]\n";
#	print "strWebsiteName = [$strWebsiteName]\n";
#	print "strLocalAd2HTML = [$strLocalAd2HTML]\n";
#	print "strNGOLeaderboard = [$strNGOLeaderboard]\n";
#	print "strNGO300250 = [$strNGO300250]\n";
#	print "strFHAddr1 = [$strFHAddr1]\n";
#	print "strFHAddr2 = [$strFHAddr2]\n";
#	print "strFHCity = [$strFHCity]\n";
#	print "strFHZip = [$strFHZip]\n";
#	print "strFHPhone1 = [$strFHPhone1]\n\n";

	CreateSQL();
	$intUpdateCnt++;
}

close OUTFILE;
print "Updates created: $intUpdateCnt\n";


# -------------
# SUBROUTINES
# -------------
sub CreateSQL()
{
	$strSQL = "INSERT into tblEmailAlert (EmailAlertTypeId, Email, AffiliateId, FuneralHomeId, PersonId, LocationId, PersonPageId, GuestbookPersonId, IsActive, DateCreated, [Status], LastNotificationSent, ErrorMessage, ErrorTimeStamp)\n";
	$strSQL .= "VALUES (2, \'$strEmail\', 4511, NULL, NULL, NULL, NULL, NULL, 1, GetDate(), NULL, NULL, NULL, NULL)\n";

	print "$strSQL\n\n";
	print OUTFILE "$strSQL\n";
}


# ---------------------------------------------------------------------------
# Subroutine:	LeftTrim
# Purpose:		Trim all leading white space characters from a string.
#
# Parameters:	$strString1 - String to trim.
#
# Return:		String - String with leading white space characters removed.
# ---------------------------------------------------------------------------
sub LeftTrim
{
	# -------------------------------
	# Retrieve subroutine parameters.
	# -------------------------------
	my ($strString1) = @_;

	my $strString2 = $strString1;
	$strString2 =~ s/^\s+//gi;

	return $strString2;
}

# ---------------------------------------------------------------------------
# Subroutine:	RightTrim
# Purpose:		Trim all ending white space characters from a string.
#
# Parameters:	$strString1 - String to trim.
#
# Return:		String - String with ending white space characters removed.
# ---------------------------------------------------------------------------
sub RightTrim
{
	# -------------------------------
	# Retrieve subroutine parameters.
	# -------------------------------
	my ($strString1) = @_;

	my $strString2 = $strString1;
	$strString2 =~ s/\s+$//gi;

	return $strString2;
}

# ---------------------------------------------------------------------------
# Subroutine:	Trim
# Purpose:		Trim all beginning and ending white space characters from a string.
#
# Parameters:	$strString1 - String to trim.
#
# Return:		String - String with ending white space characters removed.
# ---------------------------------------------------------------------------
sub Trim
{
	# -----------------------------
	# Retrieve subroutine parameter
	# -----------------------------
	my ($strString1) = @_;

	my $strString2 = LeftTrim(RightTrim($strString1));

	return $strString2;
}
