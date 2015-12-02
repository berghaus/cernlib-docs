#
# special sectioning commands
#
%section_commands = ('addcontentsline', 2, 'CNLart', 3, %section_commands);
#%section_headings = ('CNLart', 'H2', %section_headings);
&generate_sectioning_subs;

sub do_cmd_CNLart {
    local ($after) = @_;
    local($tmp) = $after;
    $tmp =~ s/$next_pair_rx//o;
    $cnl_index{'subject'} = $&;
    # Get rid of bracket id's and \newlines
    $cnl_index{'subject'} =~ s/$O\d+$C//go;
    $cnl_index{'subject'} =~ s/\\[\w]+ / /go;
    $cnl_index{'subject'} =~ s/  //go;
    $cnl_index{'node'} = $CURRENT_FILE;
    &do_cmd_section_helper ('H2', 'CNLart');
}

# handle different commands
# e.g text within \command{text}

sub do_cmd_addcontentsline {
    local($after) = @_;
    $after =~ s/$next_pair_rx//o;
    $after =~ s/$next_pair_rx//o;
    # The next line has to have $next_pair_rx instead of $next_pair_pr_rx
    $after =~ s/$next_pair_rx/do {$TITLE = $2; ''}/eo;
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
    join ('', &make_section_heading($TITLE, 'H2'), $after);
}

sub do_cmd_etc {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"etc.",$_);
}
sub do_cmd_PS {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"PS",$_);
}
sub do_cmd_ie {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"ie.",$_);
}
sub do_cmd_hspace {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>  </tt>",$_);
}
sub do_cmd_eg {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"eg.",$_);
}
sub do_cmd_Loption {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"<\/tt>",$_);
}
sub do_cmd_Prog {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<i>",$&,"<\/i>",$_);
}

# Phantom just places simple spaces. Could do something smarter
sub do_cmd_phantom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join ('', "<tt>     </tt>", $_);
}
sub do_cmd_Larg {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<b>", $&, "</b>", $_);
}
sub do_cmd_Largb {
    &do_cmd_Larg;
}
sub do_cmd_Largs {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"[",$&,"]",$_);
}
sub do_cmd_Program {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<i>",$&,"<\/i>",$_);
}
sub do_cmd_Lcs {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"\\",$&,"",$_);
}
sub do_cmd_Lenv {
    local($_) = @_;
     s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"<\/tt>",$_);
}
sub do_cmd_Lclass {
    local($_) = @_;
     s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"<\/tt>",$_);
}
sub do_cmd_Lpack {
    local($_) = @_;
     s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"<\/tt>",$_);
}
sub do_cmd_Ucom {
    local($_) = @_;
     s/$next_pair_pr_rx//o;
    join('',"<tt>",$&,"<\/tt>",$_);
}
sub do_cmd_Email {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<a href=\"mailto\:",$&,"\">",$&,"</a>",$_);
}
sub do_cmd_lcb {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"{",$_);
}
sub do_cmd_rcb {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"}",$_);
}
sub do_cmd_CNLaut {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $cnl_index{'author'} = $&;
    $cnl_index{'author'} =~ s/\~/ /go;

    join('',"<b>",$&,"<\/b>",$_);
}
sub do_cmd_Contact {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<b>",$&,"<\/b>",$_);
}

# Plain BDef attaches several other BDefs. Do not handle this at all

sub do_env_BDef {
    join('','<PRE><STRONG>\n', @_, '\n</STRONG></PRE>');
}
sub do_cmd_BDefC {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    join('',"\\$command", $_);
}
sub do_cmd_BDefCm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"\\$command\{$mandatory1\}", $_);
}
sub do_cmd_DefCm {
    &do_cmd_BDefCm;
}
sub do_cmd_DefCmm {
    &do_cmd_BDefCmm;
}
sub do_cmd_BDefCmm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    join('',"\\$command\{$mandatory1\}\{$mandatory2\}", $_);
}

sub do_cmd_BDefCmmm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory3 = $&;
    join('',"\\$command\{$mandatory1\}\{$mandatory2\}\{$mandatory3\}", $_);
}
sub do_cmd_BDefCmmmm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory3 = $&;
    join('',"\\$command\{$mandatory1\}\{$mandatory2\}\{$mandatory3\}\{$mandatory4\}", $_);
}

sub do_cmd_BDefCo {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    join('',"\\$command\[$optional1\]", $_);
}
sub do_cmd_BDefCom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"\\$command\[$optional1\]\{$mandatory1\}", $_);
}
sub do_cmd_BDefComo {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    join('',"\\$command\[$optional1\]\{$mandatory1\}[$optional2]", $_);
}
sub do_cmd_BDefCmo {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    join('',"\\$command\{$mandatory1\}\[$optional1\]", $_);
}
sub do_cmd_BDefCmom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    join('',"\\$command\{$mandatory1\}\[$optional1\]\{$mandatory2\}", $_);
}
sub do_cmd_BDefCmomm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory3 = $&;
    join('',"\\$command\{$mandatory1\}\[$optional1\]\{$mandatory2\}\{$mandatory3\}", $_);
}
sub do_cmd_DefCmomm {
    &do_cmd_BDefCmomm;
}
sub do_cmd_DefComm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory3 = $&;
    join('',"\\$command\[$optional1\]\{$mandatory1\}\{$mandatory2\}\{$mandatory3\}", $_);
}
sub do_cmd_BDefComm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    join('',"\\$command\[$optional1\]\{$mandatory1\}\{$mandatory2\}", $_);
}
sub do_cmd_BDefCoom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"\\$command\[$optional1\]\[$optional2\]\{$mandatory1\}", $_);
}
sub do_cmd_BDefCooom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    s/$next_pair_pr_rx//o;
    $optional3 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"\\$command\[$optional1\]\[$optional2\]\[$optional3\]\{$mandatory1\}", $_);
}

sub do_cmd_DefCooom {
    &do_cmd_BDefCooom;
}
sub do_cmd_DefEooom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    s/$next_pair_pr_rx//o;
    $optional3 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"<tt>\\</tt>begin\{$command\}\[$optional1\]\[$optional2\]\[$optional3\]\{$mandatory1\}", $_);
}

sub do_cmd_BDefCmoom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    join('',"\\$command\{$mandatory1\}\[$optional1\]\[$optional2\]\{$mandatory2\}", $_);
}
sub do_cmd_DefCmoom {
    &do_cmd_BDefCmoom;
}
sub do_cmd_BDefCmooom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $optional2 = $&;
    s/$next_pair_pr_rx//o;
    $optional3 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory2 = $&;
    join('',"\\$command\{$mandatory1\}\[$optional1\]\[$optional2\]\[$optional3\]\{$mandatory2\}", $_);
}

sub do_cmd_DefCoom {
    &do_cmd_BDefCoom;
}

# Environment shorthands

sub do_cmd_DefEom {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $optional1 = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"<tt>\\</tt>begin{$command}\[$optional1\]\{$mandatory1\}<br>", $_);
}
sub do_cmd_DefEm {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    s/$next_pair_pr_rx//o;
    $mandatory1 = $&;
    join('',"<tt>\\</tt>begin{$command}\{$mandatory1\}<br>", $_);
}

sub do_cmd_meta {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    join ('', '&lt;', $&, '&gt;<br>', $_);
}

sub do_cmd_LBEG {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    join('',"<tt>\\</tt>begin\{$command\}", $_);
}    
sub do_cmd_LEND {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    join('',"<tt>\\</tt>end\{$command\}", $_);
}    
sub do_cmd_LmEND {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $&;
    join('',"<tt>\\</tt>end\{$command\}", $_);
}    

#
# Handling Artsep is part of the indexing scheme produced for
# Bernd Pollermann eg. we produce a separate file called
# 'keywords' which follow the following format:
#
#.cm CAT: CNL
#.cm NAM: Name of the article (for example: CNL219   1.1 General)
#.cm EXP: Subject
#.cm DAT: Date
#.cm A/R: Author name and group
#.cm KEY: keyword1 keyword2
#.cm KEY: keyword3 keyword4
#.cm WEB: URL
#.cm END:
#
# This assumes that there is ALWAYS an \Artsep command after each
# CNLart in the original Latex markup
#
# Use a list which tells all the keywords in the article
# We clear it every time we're here!
#
sub do_cmd_Artsep {
    local($_) = @_;
    if (!open (KEYWORDS, ">>keywords")) {
	open (KEYWORDS, ">keywords") || die "Could not create keywords file\n";
    }
    # Get rid of processed bracket id's
    $cnl_index{'author'} =~ s/$OP\d+$CP//go;
    $cnl_index{'keywords'} =~ s/$OP\d+$CP//go;
    $cnl_index{'keywords'} =~ s/\n//go;
    # The contents of CNLnum and CNLtit are placed into $new_command
    @tmp = split(/:/, $new_command{'CNLnum'});
    $cnl_index{'num'} = $tmp[2];
    chop $cnl_index{'num'};
    @tmp = split(/:/, $new_command{'CNLtit'});
    $cnl_index{'title'} = $tmp[2];
    chop $cnl_index{'title'};
    # Write the entry to the file
    print (KEYWORDS ".cm CAT: CNL\n");
    print (KEYWORDS ".cm NAM: CNL$cnl_index{'num'} $cnl_index{'title'}\n");
    print (KEYWORDS ".cm EXP:$cnl_index{'subject'}\n");
    print (KEYWORDS ".cm DAT: " . `date`);
    print (KEYWORDS ".cm A/R: $cnl_index{'author'}\n");
    print (KEYWORDS ".cm KEY:$cnl_index{'keywords'}\n");
    print (KEYWORDS ".cm WEB: http://wwwcn.cern.ch/cnl/$cnl_index{'num'}/$cnl_index{'node'}\n");
    print (KEYWORDS ".cm END: \n\n");
    close (KEYWORDS);
    $cnl_index{'author'} = "";
    $cnl_index{'keywords'} = "";
    $cnl_index{'num'} = "";
    $cnl_index{'title'} = "";
    $t = "";
}

sub do_cmd_Rind {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<i>",$&,"<\/i>", $_);
}

# the keywords in CNLkey are separated by blanks.
# Convert them into the following representation:
# <!-- KEY VALUE="keyword1,keyword2,..." -- >

sub do_cmd_CNLkey {
    local($_) = @_;
    local($keywords,$result);
    s/$next_pair_pr_rx//o;
    $cnl_index{'keywords'} .= " " . $&;
    $rest = $_;
    @keywords = split (/ /, $&);
    $result = "<!-- KEY VALUE=\"";
    foreach $word (@keywords) {
	$result .= $word . ",";
    }
#     remove the last ,
    chop $result;
    $result .= "\" -->";
    join('',$result,$rest);
}
sub do_cmd_rightline {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$&,"<br>",$_);
}
sub do_cmd_URL {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<a href=\"",$&,"\">",$&,"<\/a>",$_);
}
sub do_cmd_break {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<br>",$_);
}
sub do_cmd_LaTeX3{
    join('',"LaTeX3",@_[0]);
}
sub do_cmd_LaTeXe{
    join('',"LaTeXe",@_[0]);
}
sub do_cmd_LaTeXo{
    join('',"LaTeX 2.09",@_[0]);
}

sub do_cmd_MF {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    join('', "<i>METAFONT</i>", $_);
}

# Map the lists with Capital letters to the default routines

sub do_env_Itemize {
    &do_env_itemize;
}
sub do_env_Enumerate {
    &do_env_enumerate;
}

# cut off the amount of columns which follows multicols keyword
sub do_env_multicols {
    local($_) = @_;
    s/$any_next_pair_rx//o;
    join('',$_);
}
sub do_env_DL {
    local($_) = @_;
    s/$next_pair_rx//;
    s/$item_description_rx/<DT>\1\n<DD>/g;
    # and just in case the description is empty ...
    s/\\item/<DT><DD>/g;
    "<DL COMPACT>$_<\/DL>";
}
sub do_env_DLtt  { &do_env_DL }
sub do_env_DLttc { &do_env_DL }
sub do_env_DLc   { &do_env_DL }
sub do_env_DLgen { &do_env_DL }

sub do_env_CNLabs {
    local ($_) = @_;
    join ('', "<i>", $_, "</i>");
}

1;
