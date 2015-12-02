# last mod. 11 jul 1997 mg
$MAX_SPLIT_DEPTH = 0;	# Stop making separate files at this depth
$MAX_LINK_DEPTH = 0;    # Stop showing child nodes at this depth   
$EXTRA_IMAGE_SCALE = 1.5;# Add more bits to gif images for better printing
$INFO = 0;
$ADDRESS = "Michel Goossens/IT-ASD (last mod. $address_data[1])";
$NO_NAVIGATION = 1;
sub do_cmd_vref {
   local($_) = @_;
   &process_ref($cross_ref_mark,$cross_ref_mark);
}
sub do_cmd_NbDW {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<B>$& </B>",$_);
}
sub do_cmd_NbDB {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<B>$& </B>",$_);
}
sub do_cmd_SysFdef {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}
sub do_cmd_SysFind {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<tt>$&</tt>",$_);
}
sub do_cmd_textem {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<em>$&</em>",$_);
}
sub do_cmd_Ucom {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $2;
    join ('', "<KBD>$command</KBD>", $_);
}
sub do_cmd_Lit {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $2;
    join ('', "<TT>$command</TT>", $_);
}
sub do_cmd_underline {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $command = $2;
    join ('', "<KBD>$command</KBD>", $_);
}
sub do_cmd_Sbox {
    local($_) = @_;
    local($anchor, $parameters);
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$par1 = $2; ''/eo;
    s/$next_pair_pr_rx/$par2 = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor, "<b>$par1</b> <TT>$par2</TT><BR>");
}
sub do_cmd_Sboxni {
    local($_) = @_;
    local($anchor, $parameters);
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters = $2; ''/eo;
    $subroutine_captions{$anchor} = $CURRENT_FILE;
    &anchor_mylabel($anchor, "<b>$anchor</b> <TT>$parameters</TT><BR>");
}
sub do_cmd_Key {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $entry = $2;
    join ('', "<TT>$entry</TT>", $_);
}
sub do_cmd_MacVar {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $entry = $2;
    join ('', "<TT>$entry</TT>", $_);
}

sub do_cmd_PICT {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $name = $2;
    join ('', "<P>Picture $name<p>", $_);
}
sub do_env_PICTf {
    local($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $name = $2;
    join ('', "<P>Picture $name<P>", $_);
}
sub do_cmd_PAWcind {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $entry = $2;
    join ('', "<TT>$entry</TT><p>", $_);
}
sub do_cmd_PAWcdef {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $command = $2;
    s/$next_pair_pr_rx//o;
    $params = $2;
    join ('', "<TT>$command $params</TT><BR>", $_);
}
sub do_cmd_PAWfind {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $entry = $2;
    join ('', "<TT>$entry</TT><BR>", $_);
}
sub do_cmd_PAWfdef {
    local ($_) = @_;
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx//o;
    $command = $2;
    s/$next_pair_pr_rx//o;
    $params = $2;
    join ('', "<TT>$params</TT><BR>", $_);
}
sub do_cmd_PAWfdefii{
    local($_) = @_;
    local($command1, $parameters1, $command2, $parameters2);
    s/$optional_arg_rx//o;
    s/$next_pair_pr_rx/$command1 = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters1 = $2; ''/eo;
    s/$next_pair_pr_rx/$command2 = $2; ''/eo;
    s/$next_pair_pr_rx/$parameters2 = $2; ''/eo;
    join ('',"<TT>$parameters1</TT><BR>".
             "<TT>$parameters2</TT><BR>");
}
sub do_cmd_IPAWCC {
    local($_) = @_;
    join('',"<TT>\/PAWC\/</TT>",$_);
}
sub do_cmd_IPAWCD {
    local($_) = @_;
    join('',"<TT>\/\/PAWC</TT>",$_);
}
sub do_cmd_Cind {
    local ($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Oind {
    local($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Sind {
    local($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_Ssind {
    local($_) = @_;
    &process_cernref ($external_ref_mark);
}
sub do_cmd_BW {
    local($_) = @_;
    join('',"Browsable window",$_);
}
sub do_cmd_CAP {
    local($_) = @_;
    join('',"Command Argument Panel",$_);
}
sub do_cmd_CDF {
    local($_) = @_;
    join('',"CDF",$_);
}
sub do_cmd_MAC1 {
    local($_) = @_;
    join('',"MAC",$_);
}
sub do_cmd_Motif {
    local($_) = @_;
    join('',"Motif",$_);
}
sub do_cmd_KUIPMotif {
    local($_) = @_;
    join('',"KUIP/Motif",$_);
}
sub do_cmd_OSFMotif {
    local($_) = @_;
    join('',"OSF\/Motif",$_);
}
sub do_cmd_INP {
    local($_) = @_;
    join('',"<B>Input Pad</B>",$_);
}
sub do_cmd_OW {
    local($_) = @_;
    join('',"<B>Object Window</B>",$_);
}
sub do_cmd_PNI {
    local($_) = @_;
    join('',"<B>Pamel</B> Interface",$_);
}
sub do_env_DinglistE {&do_env_enumerate;
}
sub do_cmd_epsfig {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $nb = $2;
    join ('', "<P><B>EPS Figure $nb</B><p>", $_);
}
sub do_cmd_epsfbox {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $nb = $2;
    join ('', "<P><B>EPS Figure $nb</B><p>", $_);
}
sub do_cmd_pawexfig {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $nb = $2;
    join ('', "<P><B>EPS Figure pawexa $nb</B><p>", $_);
}
sub do_cmd_pawtutfig {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $nb = $2;
    join ('', "<P><B>EPS Figure pawtut $nb</B><p>", $_);
}
sub do_cmd_num {
    local ($_) = @_;
    join ('', '#', $_);
}
sub do_cmd_Colon {
    local ($_) = @_;
    join ('', ':', $_);
}
sub do_cmd_lcb {
    local ($_) = @_;
    join ('', '\{', $_);
}
sub do_cmd_rcb {
    local ($_) = @_;
    join ('', '\}', $_);
}
sub do_cmd_lsqb {
    local ($_) = @_;
    join ('', '\[', $_);
}
sub do_cmd_rsqb {
    local ($_) = @_;
    join ('', '\]', $_);
}
sub do_cmd_bsol {
    local ($_) = @_;
    join ('', '\\', $_);
}
sub do_cmd_bs {
    local ($_) = @_;
    join ('', '\\', $_);
}
sub do_cmd_atsign {
    local ($_) = @_;
    join ('', '@', $_);
}
sub do_cmd_dollar {
    local ($_) = @_;
    join ('', '\$', $_);
}

### Adding commands to be ignored ########################################

# Add LaTeX commands to be ignored.
# Each command should be on a separate line and have the format:
#  <cmd_name>#{}# []# {}# [] etc. 
# {} marks a compulsory argument and [] an  optional one.
# Note that some commands may have arguments which should be left as
# text even though the command should be ignored (e.g. mbox, center, etc)

&ignore_commands( <<_IGNORED_CMDS_);
savebox # {}# []# [] 
fbox 
framebox # [] # []
raisebox # {} # [] # []
EPSFIGpath # {}
textrm
makeatletter
centerline
centering
HTML # {}
PAWmantrue 
message # {}
dominitoc
ifMENUtext
updefault
hyphenchar
fi
let
hbox
minitoc
fi%
KUIPmanfalse
break
linewidth
begingroup
bgroup
endgroup
egroup
extrarowheight
makeatother
VECTORfalse
clearpage
cleardoublepage
the
setlongtables
VECTORfalse
ifVECTOR
smallskipamount
ifKUIPman
raise8mm
ifPAWman
gdef
newif
jobname
condbreak # {}
else
quad
qquad
finalclearpage
finalnewpage
VECTORtrue
font
selectfont
epsfysize
newpage
clearpage
size # {} # {}
_IGNORED_CMDS_

### Adding commands to be processed by TeX ###############################

# Commands which need to be passed, ALONG WITH THEIR ARGUMENTS, to TeX.
# The syntax is the same as that for ignore_commands above.

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
_RAW_ARG_CMDS_
	
1;	# This must be the last line

