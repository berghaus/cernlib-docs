# CERN latex2html control file, called by cernman, cernlib etc
#
# replacement for standard delimiters
# SPQR    added quote 27.9.93
#     removed do_cmd_setcounter 18.5.94  (duplicate of original)
    $delimiters = '\'\\s[\\\\<>().,#;:~/+-';
# 
# a replacement for the standard pre-processor, to deal with the
# `alltt' environment XMP
#
$xmp_env_rx = "\\s*{(XMP[A-z]*)}(.*)";

sub replace_verbatim {
    # Modifies $_
    s/$verbatim_mark(XMP)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(XMPt)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(verbatim)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(displaymath)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(equation)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(equation)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(math)(\d+)/<PRE><TT>$verbatim[\2]<\/TT><\/PRE>/go;
    s/$verbatim_mark(rawhtml)(\d+)/&revert_to_raw_tex($verbatim[\2])/ego;	# Raw HTML
    s/$verbatim_mark(XMP)(\d+)/&revert_to_raw_tex($verbatim[\2])/ego;	# Raw HTML
    s/$verbatim_mark(XMPt)(\d+)/&revert_to_raw_tex($verbatim[\2])/ego;	# Raw HTML
}


sub pre_process {
    # Modifies $_;
    s/\\\\/\\\\ /go;		# Makes it unnecessary to look for escaped cmds
    local($next, $esc_del);
    &normalize_language_changes;
    while (/\\begin$verbatim_env_rx\s*/o) {
	local($before, $contents, $after, $env);
	($before, $after, $env) = ($`, $', $1);
	if ($after =~ /\s*\\end{$env[*]?}/) { # Must NOT use the s///o option!!!
	    ($contents, $after) = ($`, $');
	    $verbatim[++$verbatim_counter] = $contents;
	    $after = join("",$verbatim_mark,$env,$verbatim_counter,$after);}
    	else {
	    warn "Cannot find \\end{$env}\n";
	}
	$_ = join("",$before,$after);
    }
    # Now do the \verb declarations
    while ((($del) = /\\verb[*]?(.)/)) {
	$esc_del = &escape_rx_chars($del);
	s/\\verb[*]?[$esc_del]([^$esc_del]*)[$esc_del]/$verb[++$verb_counter]=$1;
	$verb_delim[$verb_counter]=$del;join('',$verb_mark,$verb_counter)/e;
	}
#
# now special CERN XMP environments. Only \Ucom is translated
# inside here.
#
    while (/\\begin$xmp_env_rx\s*/o) {
	local($before, $contents, $after, $env, $title);
	($before, $after, $env, $title) = ($`, $', $1,$2);
	if ($after =~ /\s*\\end{$env[*]?}/) { 
	    ($contents, $after) = ($`, $');
            $contents =~ s/\\Ucom{([^}]*)}/<kbd>$1<\/kbd>/g;	
            $contents =~ s/\\lcb/{/g;	
            $contents =~ s/\\rcb/}/g;	
            $contents =~ s/\\bs/\\/g;	
            if (length($title) > 0 ) 
               { $title = "\\centerline{\\textbf{$title}}" ;}
	    $verbatim[++$verbatim_counter] = $contents;
	    $after = join("", $title . $verbatim_mark,$env,$verbatim_counter,$after);}
    	else {
	    warn "Cannot find \\end{$env}\n";
	}
	$_ = join("",$before,$after);
    }
    s/^%.*\n|([^\\])%.*\n/\1/go; # Remove Comments
}

#----------------------------------------
# commands translated
sub do_cmd_Action{
	local($_) = @_;
	join('',"<P><B>Action: </B><P>",$_);
}

sub do_cmd_Cdef {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &anchor_mylabel($2,$2);
}

sub do_cmd_Cind {
    local($_) = @_;
    &process_cernref($external_ref_mark);
}

sub do_cmd_Carg {
 &do_cmd_Cind;
}

sub do_cmd_Copt {
    local($_) = @_;
    &process_cernref($external_ref_mark);
}

sub do_cmd_Example {
    local($_) = @_;
    join('',"<P><B>Example</B><P>",$_);
}

sub do_cmd_Examples{
	local($_) = @_;
	join('',"<P><B>Examples:</B><P>",$_);
}

sub do_cmd_FCdef {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &anchor_mylabel($2,$2);
}

sub do_cmd_FCind {
    local($_) = @_;
    &process_cernref($external_ref_mark);
}

sub do_cmd_Filename {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    "$_";
}

sub do_cmd_Idesc{
	local($_) = @_;
	join('',"<P><B>Input parameter description:</B><P>",$_);
}

sub do_cmd_Lit {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}

sub do_cmd_NbDB{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',do {qq!<IMG ALIGN=TOP ALT="" 
    SRC="http://asis01.cern.ch:/CN/CERNTEX/icons/circledb$2.xbm">!;},$_);
}

sub do_cmd_NbDW{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',do {qq!<IMG ALIGN=TOP ALT="" 
    SRC="http://asis01.cern.ch:/CN/CERNTEX/icons/circled$2.xbm">!;},$_);
}

sub do_cmd_Odesc{
	local($_) = @_;
	join('',"<P><B>Output parameter description:</B><P>",$_);
}

sub do_cmd_Pdef {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &anchor_mylabel($2,$2);
}

sub do_cmd_Pdesc{
	local($_) = @_;
	join('',"<P><B>Parameter Description:</B><P>",$_);
}

sub do_cmd_Pind {
    local($_) = @_;
    &process_cernref($external_ref_mark);
}
sub do_cmd_Rarg {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}

sub do_cmd_Rdef {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &anchor_mylabel($2,$2);
}

sub do_cmd_Remarks{
	local($_) = @_;
	join('',"<P><B>Remarks:</B><P>",$_);
}

sub do_cmd_Remark{
	local($_) = @_;
	join('',"<P><B>Remark:</B><P>",$_);
}
sub do_cmd_Rind {
     local($_) = @_;
    &process_cernref($external_ref_mark);
}

sub do_cmd_Ropt {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}


sub do_cmd_SKUIP{ # @SKUIP #1 to index, #2 in bold #3 parameters
    local($_) = @_;
    local($anchor, $parameters);
    ($opta) = &get_next_optional_argument;
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
if (length($opta) > 0 ) {
    &anchor_mylabel($opta,"CALL $anchor $parameters");
	}
else
	{
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
	}
}

sub do_cmd_Section {
    local($_) = @_;
    local($rubbish);
    s/$next_pair_pr_rx/$rubbish = $2; ''/eo;
    &do_cmd_section_helper('H1');
}

sub do_cmd_Section {
    local($_) = @_;
    local($rubbish);
    s/$next_pair_pr_rx/$rubbish = $2; ''/eo;
    &do_cmd_section_helper('H1');
}

sub do_cmd_Sfuncii{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
}

sub do_cmd_Sfuncz{
    local($_) = @_;
    local($one, $two);
    s/$next_pair_pr_rx/$one = $2; ''/eo;
    s/$next_pair_pr_rx/$two = $2; ''/eo;
      join('',"<P>$two<P>",$_);
}

sub do_cmd_Sfunc{
    local($_) = @_;
    local($one, $two);
    s/$next_pair_pr_rx/$one = $2; ''/eo;
    s/$next_pair_pr_rx/$two = $2; ''/eo;
    &anchor_mylabel($one,$two);
}

sub do_cmd_Shubrii{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
}
sub do_cmd_Sbox{
    local($_) = @_;
    #  may be square brackets
    local($label, $dummy) = &get_next_optional_argument;
    s/$next_pair_pr_rx//o;
    $SBA = $2;
    s/$next_pair_pr_rx//o;
    $SBB = $2;
    s/$next_pair_pr_rx//o;
    $SBC = $2;
    join('',"<B>$SBB</B>$SBC",$_);
}
sub do_cmd_Sboxni{
    local($_) = @_;
    #  may be square brackets
    local($label, $dummy) = &get_next_optional_argument;
    s/$next_pair_pr_rx//o;
    $SBA = $2;
    s/$next_pair_pr_rx//o;
    $SBB = $2;
    join('',"<B>$SBA</B>$SBB",$_);
}

sub do_cmd_Shubrz{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    join('',do {qq/<P> CALL $anchor $parameters<P>/;},$_);
}

sub do_cmd_Shubr{
    local($_) = @_;
    local($anchor, $parameters);
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    &anchor_mylabel($anchor,"CALL $anchor $parameters");
}

sub do_cmd_Subsection {
    local($_) = @_;
    local($rubbish);
    s/$next_pair_pr_rx/$rubbish = $2; ''/eo;
    &do_cmd_section_helper('H2');
}

sub do_cmd_Ucom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',qq+<kbd>$&</kbd>+,$_);
}


#---------------------------------
# ENVIRONMENTS TRANSLATED
#


sub do_env_EnumZW {
    local($_) = @_;
    local($count) = 0;
    s|\\item|do {++$count; qq!<DT><IMG ALIGN=TOP ALT="" 
    SRC="http://asis01.cern.ch:/CN/CERNTEX/icons/circled$count.xbm"><DD>!}|eog;
  "<DL COMPACT>$_</DL>";
    }

sub do_env_EnumZB {
    local($_) = @_;
    local($count) = 0;
    s|\\item|do {++$count; qq!<DT><IMG ALIGN=TOP ALT="" 
    SRC="http://asis01.cern.ch:/CN/CERNTEX/icons/circledb$count.xbm"><DD>!}|eog;
  "<DL COMPACT>$_</DL>";
    }

#-----extra latex commands ----------------------
sub do_cmd_fbox {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$_);
}

sub do_cmd_framebox {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$_);
}

sub do_cmd_caption{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<kbd>$2</kbd>" .$_);
}

sub do_cmd_textem {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<i>$&</i>",$_);
}

sub do_cmd_textrm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"$&",$_);
}

sub do_cmd_textsl {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<ul>$&</ul>",$_);
}

sub do_cmd_emph {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<em>$&</em>",$_);
}

sub do_cmd_textit {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<i>$&</i>",$_);
}

sub do_cmd_textsc {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"$&",$_);
}

sub do_cmd_textbf {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<b>$&</b>",$_);
}


sub do_cmd_texttt {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}

sub do_cmd_mbox {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$2,$_);
}

sub post_latex_do_env_figure {
    local($_) = @_;
    print STDERR "back we come with $_\n" ; 
    join('',"<P>",$_,"<P>");
}

sub do_env_figure {
    local($_) = @_;
    join('',"<P>",$_,"<P>");
}

sub do_env_Fighere {
    local($_) = @_;
    join('',"<P>",$_,"<P>");
}

sub do_cmd_ICON { &do_cmd_epsfbox ; }
sub do_cmd_PAWf { &do_cmd_epsfbox ; }
sub do_cmd_PAWfR { &do_cmd_epsfbox ; }
sub do_cmd_MENU { &do_cmd_epsfbox ; }
sub do_cmd_PAWF { &do_cmd_epsfbox ; }
sub do_cmd_PAWFR { &do_cmd_epsfbox ; }

sub do_env_EnumZW { &do_env_itemize ;}
sub do_env_EnumZB { &do_env_itemize;} 
sub do_env_DLsf   { &do_env_DL ;}
sub do_env_DLsfc  { &do_env_DL ;}

sub do_cmd_LaTeX{
    join('',"LaTeX",@_[0]);
}

1;

#\newcommand{\NbDW}[1] a thing
#\newcommand{\NbDB}[1] a thing
#\newcommand{\Button}[1] a thing
#\newcommand{\Field}[1] a thing with text
