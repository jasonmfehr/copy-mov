#!/usr/bin/perl

#perl script to directly copy movies from a video camera to the local disk

use 5.012;
use strict;
use warnings;
use Getopt::Std qw(getopts);
$|++;

my $SOURCE_DIRECTORY = "/Volumes/CAM_MEM/SD_VIDEO/";
my $DEFAULT_OUTPUT_DIRECTORY = "/Users/jasonfehr/Movies/transfer/";

my $output_directory;
my %opts;
my @file_stats;
my @file_modify_time;


#process output directory location from command line
getopts("o:", \%opts);
if(defined($opts{"o"})){
  $output_directory = $opts{"o"};
}else{
  $output_directory = $DEFAULT_OUTPUT_DIRECTORY;
}

#read all directories that contain movies
foreach my $dir (`ls -d $SOURCE_DIRECTORY/PR*`){
  chomp $dir;
  print "Reading directory '$dir'\n";
  
  #movies for each day are stored in the same directory, therefore we can use the last modified time 
  #from each directory (which assumes no on-camera editing has taken place)
  @file_stats = stat($dir);
  @file_modify_time = localtime($file_stats[9]);
  
  #loop through all movies in the directory
  foreach my $file (`ls $dir/MOV*.MOD`){
    my $dest_file;
    
    chomp $file;
    $file =~ /(MOV.*)\.MOD$/;
    
    #destination filename is in the format yyyy_mm_dd_MOVddd.MOD
    $dest_file = $output_directory . "/" . 
                 ($file_modify_time[5] + 1900) . "_" . 
                 td($file_modify_time[4] + 1) . "_" .
                 td($file_modify_time[3]) . "_" . 
                 $1 . ".MOD";
    
    print "copying '$file' to '$dest_file'\n";
    `cp $file $dest_file`;
  }
  print "\n";
}

#function to zero pad a number
sub td{
  my $digits = shift();
  
  return $digits < 10 ? "0$digits" : $digits;
}
