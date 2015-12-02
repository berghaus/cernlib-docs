#!/usr/local/bin/perl
#
# Sebastian Rahtz, 04/03/1997
#
# Read "repere" output from hyperref and generate pdftex
# bookmark entries
#
$slash="/";
while (<>) {
 ($id,$title) = /\((.*)\) <(.*)>/;
 $title =~ s/\\//g;
 $titles{$id}=$title;
 $level= tr/\./\./;
 $curids[$level]=$id;
 $thisone=$curids[$level-1];
 $realcounts{$thisone}++;
 push(@ids,$id);
}
foreach $x (@ids)
{
 $count=$realcounts{$x};
 print "\\pdfoutline goto name {\\hyper\@hash $x} ";
 if ($count > 0) { print " count -$count "; }
 print " {$titles{$x}}\n";
}
;
