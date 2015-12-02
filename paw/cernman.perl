# This file converts styles specific to cernman.sty styles file
# This has been reorganized by JS 10.1.1995
# Authors of this file
# Sebastian Rahtz   SR
# Janne Saarela     JS
# Michel Goossens   MG

# This file contains
# 1. Inclusion of master labels for cross referencing
# 2. Environment translation rules
# 3. Command translation rules
# 4. Subroutines enhanced for cross referencing

# list of master labels from global cernlib

#$WWW="/afs/cern.ch/project/cnas_doc/sources/CNASDOC/WWW";
$WWW="/afs/cern.ch/user/j/jsaarela/manuals";

$MASTERLABELS = "/afs/cern.ch/user/j/jsaarela/manuals/master-labels.pl";
#$MASTERLABELS = "/afs/cern.ch/project/cnas_doc/sources/latex2html/master-labels.pl";

if ( -r "$MASTERLABELS") {
    print "Including masterlabels for crossreferencing...\n";
    require("$MASTERLABELS");
} else {
    print "Could not open masterlabels.\n";
}

#
# set these variables for the cross referencing
#
$TOPDIR = `cd ..; pwd`;
$TOPDIR = `basename $TOPDIR`;
chop($TOPDIR);
print "Starting from $TOPDIR\n";

#
# special sectioning commands
#
%section_commands = ('Makehead', 1, 'Cernhead', 1, %section_commands);

#
# Environment translation rules begin
#
# cut off the amount of columns which follows multicols keyword
sub do_env_multicols {
    local($_) = @_;
    s/$any_next_pair_rx//o;
    join('',$_);
}
# remove the parameters
sub do_env_bibunit {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    join ('', $_);
}
sub do_env_UL {
    &do_env_itemize;
}
sub do_env_ULc {
    &do_env_itemize;
}
sub do_env_DinglistE {
    &do_env_enumerate;
}

# pass figure and Fighere on

sub do_env_figure {
    local($_) = @_;
    s/$optional_arg_rx//;
    join('', $_);
}

sub do_env_Fighere {
    join('',"<P>", @_, "<P>");
}

sub do_env_OL {
    &do_env_enumerate;
}

# Handle all descriptions lists which basically look like
# \begin{DL}{1234...}
# \end{DL}

sub do_env_DL {
    local($_) = @_;
    # remove the specifier after begin
    s/$next_pair_rx//;
    # replace all item texts with HTML counterparts
    s/$item_description_rx/<DT>\1\n<DD>/g;
    # and just in case the description is empty ...
    s/\\item/<DT><DD>/g;
    # finally return a description list
    "<DL COMPACT>$_</DL>";
}
sub do_env_DLtt  { &do_env_DL }
sub do_env_DLttc { &do_env_DL }
sub do_env_DLc   { &do_env_DL }
sub do_env_DLgen { &do_env_DL }

sub do_env_Lenv {
    local($_) = @_;
     s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"</tt>",$_);
}
sub do_env_Lsty { &do_env_Lenv }
sub do_env_Lopt { &do_env_Lenv }


#
# Command translation rules begin
#

sub do_cmd_putbib {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    join ('', $_);
}

# The following are quite GEANT/CERNLIB specific. Save the value into
# variable and present them with Makehead

sub do_cmd_Origin {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_origin = $&;
    $_;
}
sub do_cmd_Submitter {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_submitter = $&;
    $_;
}
sub do_cmd_Submitted {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_submitted = $&;
    $_;
}
sub do_cmd_Revised {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_revised = $&;
    $_;
}
sub do_cmd_Revision {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_revision = $&;
    $_;
}
sub do_cmd_Routid {
    local ($_) = @_;
    /$next_pair_pr_rx/;
    $doc_routid = $2;
    &process_cernref($external_refmark);
}
sub do_cmd_Version {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_version = $&;
    $_;
}
sub do_cmd_Language {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_language = $&;
    $_;
}
sub do_cmd_Library {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_library = $&;
    $_;
}
sub do_cmd_Keywords {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_keywords = $&;
    $_;
}
sub do_cmd_Author {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_author = $&;
    $_;
}

# Makehead used in GEANT manual
sub do_cmd_Makehead {
    local ($after) = @_;
    $latex_body .= "\\stepcounter{Makehead}\n";
    # The next line has to have $next_pair_rx instead of $next_pair_pr_rx
    $after =~ s/$next_pair_rx/do {$TITLE = $2; ''}/eo;
    if (length($doc_routid)) {
	$TITLE = $doc_routid . " " . $TITLE;
    }
    $TITLE =~ s/\\(label|index)$any_next_pair_rx//;    
    $TITLE = &translate_commands(&translate_environments($TITLE));
    $_ = $TITLE; &extract_pure_text;
    $TITLE = $_;
    # This is the LaTeX section number read from the $FILE.aux file
    @tmp = split(/$;/,$encoded_section_number{&encode_title($_)});
    $section_number = shift(@tmp);
    $section_number = "" if ($section_number eq "-1");
    $encoded_section_number{&encode_title($_)} = join($;, @tmp);
    $TITLE = "$section_number " . $_;
    $TITLE =~ s/<P>//g;		# Remove newlines

    if (length($doc_routid)) {
	$doc_routid =~ s/\W//g; # Remove non alphanumeric characters
	$ref_files{$doc_routid} = $CURRENT_FILE;
    }

    $doc_head = "";
    if ($HTML3) {
	$doc_head = "<table border><th colspan=2>";
	$doc_head .= "<a name=\"$doc_routid\">";
	$doc_head .= "Routine ID: $doc_routid";
	$doc_head .= "</a>\n";
	$doc_head .= "<tr><td align=left><b>Author(s):</b> $doc_author";
	$doc_head .= "<td align=right><b>Submitted:</b> $doc_submitted\n";
	$doc_head .= "<tr><td align=left><b>Origin:</b> $doc_origin";
	$doc_head .= "<td align=right><b>Revised:</b> $doc_revised\n";
	$doc_head .= "</table>\n";
    } else {	
	if (length($doc_origin)) {
	    $doc_head .= "<b>Origin:</b> $doc_origin<br>\n";
	}
	if (length($doc_submitter)) {
	    $doc_head .= "<b>Submitter:</b> $doc_submitter<br>\n";
	}
	if (length($doc_submitted)) {
	    $doc_head .= "<b>Submitted:</b> $doc_submitted<br>\n";
	}
	if (length($doc_revised)) {
	    $doc_head .= "<b>Revised:</b> $doc_revised<br>\n";
	}
	if (length($doc_revision)) {
	    $doc_head .= "<b>Revision:</b> $doc_revision<br>\n";
	}
	if (length($doc_routid)) {
	    $doc_head .= "<b>Routid:</b> $doc_routid<br>\n";
	}
	if (length($doc_version)) {
	    $doc_head .= "<b>Version:</b> $doc_version<br>\n";
	}
	if (length($doc_library)) {
	    $doc_head .= "<b>Library:</b> $doc_library<br>\n";
	}
	if (length($doc_language)) {
	    $doc_head .= "<b>Language:</b> $doc_language<br>\n";
	}
	if (length($doc_keywords)) {
	    $doc_head .= "<!-- KEY VALUE=\"$doc_keywords\" -->\n";
	}
    }
    $doc_origin = "";
    $doc_submitted = "";
    $doc_revised = "";
    $doc_origin = "";
    $doc_routid = "";
    $doc_version = "";
    $doc_library = "";
    $doc_language = "";
    $doc_keywords = "";

    join ('', &make_section_heading($TITLE, 'H2'), $doc_head, $after);
}

# Cernhead used in short writeups    
sub do_cmd_Cernhead {
    local ($after) = @_;
    $latex_body .= "\\stepcounter{Cernhead}\n";
    # The next line has to have $next_pair_rx instead of $next_pair_pr_rx
    $after =~ s/$next_pair_rx/do {$TITLE = $2; ''}/eo;
    if (length($doc_routid)) {
	$TITLE = $doc_routid . " " . $TITLE;
    }
    $TITLE =~ s/\\(label|index)$any_next_pair_rx//;    
    $TITLE = &translate_commands(&translate_environments($TITLE));
    $_ = $TITLE; &extract_pure_text;
    $TITLE = $_;
    # This is the LaTeX section number read from the $FILE.aux file
    @tmp = split(/$;/,$encoded_section_number{&encode_title($_)});
    $section_number = shift(@tmp);
    $section_number = "" if ($section_number eq "-1");
    $encoded_section_number{&encode_title($_)} = join($;, @tmp);
    $TITLE = "$section_number " . $_;
    $TITLE =~ s/<P>//g;		# Remove newlines

    if (length($doc_routid)) {
	$doc_routid =~ s/\W//g; # Remove non alphanumeric characters
	$ref_files{$doc_routid} = $CURRENT_FILE;
    }

    $doc_head = "";
    if ($HTML3) {
	$doc_head = "<table border><th colspan=2>";
	$doc_head .= "<a name=\"$doc_routid\">";
	$doc_head .= "Routine ID: $doc_routid";
	$doc_head .= "</a>\n";
	$doc_head .= "<tr><td align=left><b>Author(s):</b> $doc_author";
	$doc_head .= "<td align=right><b>Library:</b> $doc_library\n";
	$doc_head .= "<tr><td align=left><b>Submitter:</b> $doc_submitter";
	$doc_head .= "<td align=right><b>Submitted:</b> $doc_submitted\n";
	$doc_head .= "<tr><td align=left><b>Language:</b> $doc_language";
	$doc_head .= "<td align=right><b>Revised:</b> $doc_revised\n";
	$doc_head .= "</table>\n";
    } else {
	if (length($doc_origin)) {
	    $doc_head .= "<b>Origin:</b> $doc_origin<br>\n";
	}
	if (length($doc_submitter)) {
	    $doc_head .= "<b>Submitter:</b> $doc_submitter<br>\n";
	}
	if (length($doc_submitted)) {
	    $doc_head .= "<b>Submitted:</b> $doc_submitted<br>\n";
	}
	if (length($doc_revised)) {
	    $doc_head .= "<b>Revised:</b> $doc_revised<br>\n";
	}
	if (length($doc_revision)) {
	    $doc_head .= "<b>Revision:</b> $doc_revision<br>\n";
	}
	if (length($doc_routid)) {
	    $doc_head .= "<b>Routid:</b> $doc_routid<br>\n";
	}
	if (length($doc_version)) {
	    $doc_head .= "<b>Version:</b> $doc_version<br>\n";
	}
	if (length($doc_library)) {
	    $doc_head .= "<b>Library:</b> $doc_library<br>\n";
	}
	if (length($doc_language)) {
	    $doc_head .= "<b>Language:</b> $doc_language<br>\n";
	}
	if (length($doc_keywords)) {
	    $doc_head .= "<!-- KEY VALUE=\"$doc_keywords\" -->\n";
	}
    }
    $doc_author = "";
    $doc_origin = "";
    $doc_submitted = "";
    $doc_revised = "";
    $doc_origin = "";
    $doc_routid = "";
    $doc_version = "";
    $doc_library = "";
    $doc_language = "";
    $doc_keywords = "";

    join ('', &make_section_heading($TITLE, 'H2'), $doc_head, $after);
}

sub do_cmd_SKUIP {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $command = $2;
    # following line deletes the possible rubbish inside the command
    $command =~ s/$next_pair_pr_rx//o;
    s/$next_pair_pr_rx//o;
    $params = $2;
    join ('', "<strong>CALL $command $params</strong><p>", $_);
}
sub do_cmd_excl {
    local ($_) = @_;
    join ('', '!', $_);
}

sub do_cmd_Structure {
    local ($_) = @_;
    join ('', "\n<p><b>Structure:</b><p>", $_);
}
sub do_cmd_Usage {
    local ($_) = @_;
    join ('', "\n<p><b>Usage:</b><p>", $_);
}
sub do_cmd_Restrict {
    local ($_) = @_;
    join ('', "\n<p><b>Restrictions:</b><p>", $_);
}
sub do_cmd_Accuracy {
    local ($_) = @_;
    join ('', "\n<p><b>Accuracy:</b><p>", $_);
}
sub do_cmd_Errorh {
    local ($_) = @_;
    join ('', "\n<p><b>Error handling:</b><p>", $_);
}
sub do_cmd_Refer {
    local ($_) = @_;
    join ('', "\n<p><b>References:</b><p>", $_);
}
sub do_cmd_Method {
    local ($_) = @_;
    join ('', "\n<p><b>Method:</b><p>", $_);
}
sub do_cmd_Structure {
    local ($_) = @_;
    join ('', "\n<p><b>Structure:</b><p>", $_);
}
sub do_cmd_Notes {
    local ($_) = @_;
    join ('', "\n<p><b>Notes:</b><p>", $_);
}
sub do_cmd_Timing {
    local ($_) = @_;
    join ('', "\n<p><b>Timing:</b><p>", $_);
}

sub do_cmd_DEFARG {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $arg1 = $&;
    s/$next_pair_pr_rx//o;
    $arg2 = $&;
    s/$next_pair_pr_rx//o;
    $arg3 = $&;
    s/$next_pair_pr_rx//o;
    $arg4 = $&;
    $out = sprintf ("<i>%-10s</i> %2s \"%20s\" %s", $arg1, $arg2, $arg3, $arg4);
    join('',"<pre>  $out</pre>",$_);
}

sub do_cmd_DEFCMD {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $arg1 = $&;
    s/$next_pair_pr_rx//o;
    $arg2 = $&;
    s/$next_pair_pr_rx//o;
    $arg3 = $&;
    s/$next_pair_pr_rx//o;
    $arg4 = $&;
    s/$next_pair_pr_rx//o;
    $arg5 = $&;
    $out = sprintf ("<b>$arg4 $arg5</b>", $arg1, $arg2, $arg3, $arg4);
    join('',"<br><pre>$out</pre>",$_);
}

sub do_cmd_DEFOPT {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $arg1 = $&;
    s/$next_pair_pr_rx//o;
    $arg2 = $&;
    $arg2 =~ s/\\n//g;
    $out = sprintf ("<i>%-10s</i> %s", $arg1, $arg2);
    join ('', "<pre>  $out</pre>", $_);
}

sub do_cmd_Bn {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<B>",$&,"</B>", $_);
}

sub do_cmd_Bnii {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $first = $&;
    s/$next_pair_pr_rx//o;
    join('',"<B>$first,",$&,"</B>", $_);
}

# anchors

sub do_cmd_Rind {
    local ($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Sind {
    local ($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Pind {
    local ($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Rarg {
    local ($_) = @_;
    &process_cernref ($external_ref_mark);
}

# anchor endpoints

sub do_cmd_Rdef {
    local ($_) = @_;
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    &anchor_mylabel($anchor, "<b>$anchor</b>");
}
sub do_cmd_Shubr {
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor, "<b>CALL $anchor $parameters<\/b><\/br>");
}
sub do_cmd_Shubrz {
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor,"<b>CALL $anchor $parameters<\/b><\/br>");
}
sub do_cmd_Shubrii{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor,"<b>CALL $anchor $parameters<\/b><\/br>");
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor,"<b>CALL $anchor $parameters<\/b><\/br>");
}
sub do_cmd_Sfunc {
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$all = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor, "<B>$all<\/B><\/br>");
}
sub do_cmd_Sfuncii{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$all = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor,"<b>$all<\/b><\/br>");
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$all = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor,"<b>$all<\/b><\/br>");
}
sub do_cmd_Lcs {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"\\",$&,"",$_);
}
sub do_cmd_PROMPT {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"PAW> ",$_);
}

sub do_cmd_Command {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"</tt", $_);
}

sub do_cmd_Param { &do_cmd_Command }
sub do_cmd_Action {
    local($_) = @_;
    join('',"<P><B>Action: </B>",$_);
}
sub do_cmd_Example {
    local($_) = @_;
    join('',"<P><B>Example: </B><P>",$_);
}
sub do_cmd_Examples {
    local($_) = @_;
    join('',"<P><B>Examples: </B><P>",$_);
}
sub do_cmd_Remark {
    local($_) = @_;
    join('',"<P><B>Remark: </B><P>",$_);
}
sub do_cmd_Remarks {
    local($_) = @_;
    join('',"<P><B>Remarks: </B><P>",$_);
}
sub do_cmd_Odesc {
    local($_) = @_;
    join('',"<P><B>Output parameter description: </B><P>",$_);
}
sub do_cmd_Idesc {
    local($_) = @_;
    join('',"<P><B>Input parameter description: </B><P>",$_);
}
sub do_cmd_Pdesc {
    local($_) = @_;
    join('',"<P><B>Parameter description: </B><P>",$_);
}
sub do_cmd_Ptitle {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $TITLE = $2 if ($TITLE eq $default_title);
    join('',$_);
}
sub do_cmd_PAW {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"PAW", $_);
}
sub do_cmd_HBOOK {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"HBOOK", $_);
}
sub do_cmd_HPLOT {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"HPLOT", $_);
}
sub do_cmd_CWN {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"CWN", $_);
}
sub do_cmd_RWN {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"RWN", $_);
}
sub do_cmd_PAWLIB {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"PAWLIB", $_);
}
sub do_cmd_SIGMA {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"SIGMA", $_);
}
sub do_cmd_COMIS {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"COMIS", $_);
}
sub do_cmd_CMZ {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"CMZ", $_);
}
sub do_cmd_ZEBRA {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"ZEBRA", $_);
}
sub do_cmd_PAWPP {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"PAWPP", $_);
}
sub do_cmd_MINUIT {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"MINUIT", $_);
}
sub do_cmd_CERNLIB {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"CERNLIB", $_);
}
sub do_cmd_KUIP {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"KUIP", $_);
}
sub do_cmd_HIGZ {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"HIGZ", $_);
}
sub do_cmd_PATCHY {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"HIGZ", $_);
}

sub do_cmd_eg {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"eg.",$_);
}

# additional subroutines
sub process_cernref {
    local($ref_mark) = @_;
    s/$next_pair_pr_rx//o;
    local($label) = $2;
    $label =~ s/\W//g; # Remove non alphanumeric characters
    if ($label) {
# $latex_labels{"userdefined$label"} = $label;
	join('',"<A HREF=$ref_mark#$label>$label<\/A>",$_);
    } else {
	warn "Cannot find label argument after <$last_word>\n";
	$_;
    }
}

sub anchor_mylabel {
    # Uses $CURRENT_FILE defined in translate
    # Modifies entries in %ref_files defined in translate
    local($label,$contents)   = @_;
    $label =~ s/\W//g; # Remove non alphanumeric characters
    # Associate the label with the current file
    $ref_files{$label} = $CURRENT_FILE;
    join('',"<A NAME=$label>$contents</A>",$_);
}

sub replace_external_references {
# slightly modified
    # Modifies $_
    local($label);
    s/$external_ref_mark#(\w+)>/
	do {$label = $1; "$external_labels{$label}#$label>"}/geo;
}
if ( -r "labels.pl") {
    require "labels.pl";
}

sub save_labels_in_file {
    print "\nMaster labels from $FILE ($TOPDIR):\n";
    local ($dir,$nlink);
    local($label,$file);
    local($dev,$ino,$mode,$subcount);
    open (LABELS,">labels.pl");
    while (($label,$file) = each %ref_files) {
	print LABELS "\$external_labels{\"$label\"} =" .
	    "\"../../$TOPDIR/$FILE/$file\"; \n"
	    }
    # also do the cites
    while (($label,$entry) = each %cite_info) {
	print LABELS "\$extcite_info{\"$label\"} =" .
	    "\"$entry\"; \n"
	    }
    print LABELS "\n1;\n";
    close(LABELS);
    #
    # we only update the master list if we have write access to it
    #
    if ( -w "$MASTERLABELS") {
	print "\n ... writing master labels ... \n";
	&save_labels_in_masterfile
	}

}

sub save_labels_in_masterfile {
    open(MASTER,">$MASTERLABELS");
    ($dev,$ino,$mode,$nlink) = stat("$WWW") unless $nlink;
    opendir(DIR,"$WWW") || die("cannot stat $WWW");
    local(@filenames)= readdir(DIR);
    closedir(DIR);
    if ($nlink > 2) {
	$subcount = $nlink - 2;
	for (@filenames) {
	    next if $_ eq '.';
	    next if $_ eq '..';
	    stat("$WWW/$_") ;
	    next unless -d _;
	    print "\n> examining $_";
	    $upper = $_;
	    ($dev,$ino,$mode,$nlink) = stat("$WWW/$_") unless $nlink;
	    opendir(DIR,"$WWW/$_") || die("cannot stat $WWW/$_");
	    local(@underfilenames) = readdir(DIR);
	    closedir(DIR);
	    if ($nlink > 2) {
		$subcount = $nlink - 2;
		for (@underfilenames) {
		    next if $_ eq '.';
		    next if $_ eq '..';
		    stat("$WWW/$upper/$_") ;
		    next unless -d _;
		    print ">>$_";
		    if (-f "$WWW/$upper/$_/labels.pl") {
			print "\n [$WWW/$upper/$_/labels.pl]\n";
			open(LL,"$WWW/$upper/$_/labels.pl") ;
			while (<LL>) {
			    if ( /^1;/) {
			    } else {
				print MASTER;
			    }
			}
			close(LL);
		    }
		}
	    }
	}
    }
    print MASTER "\n1;\n";
    close(MASTER);
}
1;
