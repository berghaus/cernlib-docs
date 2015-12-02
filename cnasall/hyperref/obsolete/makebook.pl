#!/usr/local/bin/perl
#
# Sebastian Rahtz, 21/02/1996
#
# Read "repere" output from hyperref and generate pdfmark
# bookmark entries
#
$slash="/";
while (<>) {
 ($id,$title) = /\((.*)\) <(.*)>/;
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
 print "[";
 if ($count > 0) {
  print "/Count $count ";
 }
 print "/Dest $slash$x /Title ($titles{$x}) /OUT pdfmark\n";
}
;