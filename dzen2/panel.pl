#!/usr/bin/env perl 
use strict;
use warnings;
use utf8;

my @mpc = split(/\n/, `mpc -f '%artist%--%title%'`);
my @status = split( / /, $mpc[1] );

# Playing status
my $play = $status[0];
if ( $play =~ /playing/ ) {
    $play = '>';
}
elsif ( $play =~ /paused/ ) {
    $play = '||';
}
else {
    $play = '[]';
}

$status[5] =~ s/\((.+)\)/$1/g;
my $percent = `echo $status[5] | dzen2-dbar`;
chomp($percent);
my @vol = split(/ /, $mpc[2]);
my $volume = $vol[1];

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
    localtime(time);

$min = "0" . $min if length($min) == 1;

my $active = `xdotool getwindowfocus getwindowname`;
chomp($active);

my @cur = split(/ /, `wmctrl -d | grep \\\*`);

my $music_string = $mpc[0] . "[ $play ]" . $percent . "\n";
my $page = $cur[0] + 1;
$music_string .= " [" . $page . "] ";
$music_string .= "{$active}";
$music_string .= " [$hour:$min]";
$music_string .= " Vol: $volume";
print " " . $music_string;

