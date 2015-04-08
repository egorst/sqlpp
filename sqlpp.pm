#!/usr/bin/env perl

use strict;
use lib $ENV{RLWRAP_FILTERDIR};
use RlwrapFilter;
use Term::ANSIColor;

our $transposeOutput = 0;
our $compactOutput   = 0;
our $toecho;

sub logit {
    my ($l) = shift;
    open my $LOG,">>sqlpp.log" or return;
    print $LOG $l,"\n";
    close $LOG;
}

sub handle_output {
    s/^(ORA\-\d+:.*)$/\e[31m$1\e[0m/mg;
    return $_;
}

sub handle_input {
    my $input = $_;
    logit("$input");
    if ($input =~ /set\s+transpose\s+on/i) {
        $transposeOutput = 1;
        $toecho = $input;
        return "";
    } elsif ($input =~ /set\s+transpose\s+off/i) {
	$transposeOutput = 0;
	$toecho = $input;
	return "";
    }
    logit("transposeoutput = $transposeOutput");
    $input;
}

sub handle_echo {
    my $e = '';
    if ($toecho) {
	$e = $toecho;
	$toecho = '';
    } else {
	$e = $_;
    }
    return $e;
}

our $ft = new RlwrapFilter;

$ft->output_handler(\&handle_output);

$ft->input_handler(\&handle_input);

$ft->echo_handler(\&handle_echo);

$ft->run;
