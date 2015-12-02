# LATEX2E.PERL by  Sebastian Rahtz. 3.1.94
package LaTeX2e;

sub main'LaTeX2e_translation {
    @_[0];
}

package main;

&ignore_commands( <<_IGNORED_CMDS_);
documentclass # [] # {} # []
usepackage # [] # {} # []
NeedsTeXFormat # {} # []
listfiles
suppressfloats
fbox
protect
mdseries
special
endflushleft
message
hoffset
jobname
_IGNORED_CMDS_

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
_RAW_ARG_CMDS_

