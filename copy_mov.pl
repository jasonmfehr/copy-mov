#!/usr/bin/perl

my @files = `ls -ld /Volumes/CAM_MEM/SD_VIDEO/PR* | tr -s " "`;
foreach(@files){
  chomp;
  $file = $_;
  $file =~ /(\S*)\s(\S*)\s(\S*)\s(\S*)\s(\S*)\s(\S*)\s(\S*)\s(\S*)\s(\S*)/;
  $month = $6;
  $day = $7;
  $year = $8;
  $fn = $9;

  if($year =~ /:/){
    $year = "2012";
  }

  if($month eq "Jan"){
    $month = "01";
  }
  if($month eq "Feb"){
    $month = "02";
  }
if($month eq "Mar"){
$month = "03";
} 
if($month eq "Apr"){
$month = "04";
}
if($month eq "May"){
$month = "05";
}
if($month eq "Jun"){
$month = "06";
}
if($month eq "Jul"){
$month = "07";
}
if($month eq "Aug"){
$month = "08";
}
if($month eq "Sep"){
$month = "09";
}
if($month eq "Oct"){
$month = "10";
}
if($month eq "Nov"){
$month = "11";
}
if($month eq "Dec"){
$month = "12";
}

if($day =~ /^\d$/){
  $day = "0" . $day;
}

  @allfiles = `ls $fn | grep MOD`;
  foreach(@allfiles){
    chomp;
    $dest_file = $year . "_" . $month . "_" . $day . "_" . $_;
    print "copying '$fn/$_' to '//Users/jasonfehr/Movies/transfer/$dest_file'\n";
    `cp $fn/$_ //Users/jasonfehr/Movies/transfer/$dest_file`;
  }
  print "$year $month $day\n";
}
