#!/usr/bin/env perl

use strict;
use lib $ENV{RLWRAP_FILTERDIR};
use RlwrapFilter;
use Term::ANSIColor;

sub handle_output {
    s/^(ORA\-\d+:.*)$/\e[31m$1\e[0m/mg;
    return $_;
}

our $ft = new RlwrapFilter;

$ft->output_handler(\&handle_output);

$ft->run;
