#!/usr/bin/perl

use strict;
use Time::Local;
use Time::localtime;
use File::stat;


my $VERBOSE=1;
my $wdir="/tmp/Test/";
my $suf="txt";
my $old_m=1;

my $today=localtime;
my $today_u=timelocal($today->sec,$today->min,$today->hour,$today->mday,$today->mon,$today->year);
my $old_s=$old_m*60;
my $old_time=$today_u-$old_s;

print "today_u=$today_u\told_time=$old_time\n" if $VERBOSE;

if (-d $wdir){
print "$wdir exist. Work it\n" if $VERBOSE;

open (FILE, '>', "$wdir$today_u.$suf") or die $!;
print FILE "$today_u\n";
close FILE;

opendir (DIR, $wdir) or die $!;
while (my $file = readdir (DIR)){
    next if ($file =~ m/^\./);
    my $n_file = stat("$wdir$file");
    my $last_m_file = $n_file->mtime;
    print "Work at $wdir$file\n" if $VERBOSE;
    if ($last_m_file < $old_time) {
	print "File modified at $last_m_file old time $old_time\n" if $VERBOSE;
	print "File $wdir$file is too old. Delete!\n" if $VERBOSE;
	unlink ("$wdir$file");    
    }
}
closedir DIR;
}
else{
print "$wdir don't exist!\n" if $VERBOSE;
}




