#!/usr/bin/env perl

use strict;
use lib $ENV{RLWRAP_FILTERDIR};
use RlwrapFilter;
use Term::ANSIColor;

our $transposeOutput = 0;
our $compactOutput   = 0;

sub handle_output {
    s/^(ORA\-\d+:.*)$/\e[31m$1\e[0m/mg;
    return $_;
}

sub handle_input {
    $_;
}

sub handle_echo {
    $_;
}

our $ft = new RlwrapFilter;

$ft->output_handler(\&handle_output);

$ft->input_handler(\&handle_input);

$ft->echo_handler(\&handle_echo);

$ft->run;
