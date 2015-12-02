# initialize routine definition and index entries.
    @rdef =();
    @rind =();
sub do_cmd_Cernhead{
    local ($_) = @_;
    s/$any_next_pair_pr_rx/$TITLE = $2; ''/e;
    $TITLE =~ s/\n/ /g;
    $TITLE =~ s/  */ /g;

    $doc_head  = "<H2>$doc_routid: $TITLE</H2>\n";
    $doc_head .= "<table border>\n";
    $doc_head .= "<tr><td align=left>Author(s): $doc_author  ";
    $doc_head .= "<td align=left>Library: $doc_library \n";
    $doc_head .= "<tr><td align=left>Submitter: $doc_submitter  ";
    $doc_head .= "<td align=left>Submitted: $doc_submitted  \n";
    $doc_head .= "<tr><td align=left>Language: $doc_language  ";
    $doc_head .= "<td align=left>Revised: $doc_revised  \n";
    $doc_head .= "</table>\n";
    $doc_head .= "<BR>\n";
    if (length($doc_keywords)) {
        $doc_keywords =~ s/\<\#\d+\#\>//g;  #Delete <#n#>
        $doc_keywords =~ tr/A-Z/a-z/;            
        $doc_head .= "<!-- KEY VALUE=\"XYXY\" -->\n";
        @keywords=($doc_keywords);
    }
    join ('', $doc_head, $_);
}
sub do_cmd_Rdef {
    local ($_) = @_;
    s/$next_pair_pr_rx/$anchor = $2; ''/eo;
    push(@keywords,$anchor);
    push(@rdef,$anchor);
    &anchor_mylabel($anchor, "<TT>$anchor</TT>");
}
sub do_cmd_Rind {
    local($_) = @_;
    local($name, $number);
    s/$next_pair_pr_rx/$name = $2; ''/eo;
    s/$next_pair_pr_rx/$number = $2; ''/eo;
    push(@keywords,$name,$number);
    push(@rind,$name,$number);
    $number =~ tr/A-Z/a-z/;
    join('',"<A HREF=\"../$number/top.html\">$name<\/A>",$_);
}
sub do_cmd_Routid {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    $doc_routid = $&;
    $_;
}
sub do_cmd_Writekeys {
    $doc_routid =~ s/\<\#\d+\#\>//g;    #Delete <#n#>
    $low_rout = $doc_routid;
    $low_rout =~ tr/A-Z/a-z/;           #Change to lower case
    $doc_author =~ s/\<\#\d+\#\>//g;    #Delete <#n#> where n is a number
    $doc_submitter =~ s/\<\#\d+\#\>//g; #Delete <#n#>
    $doc_submitted =~ s/\<\#\d+\#\>//g; #Delete <#n#>
    $doc_version =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $low_ver = $doc_version;            #Change to lower case
    $low_ver =~ tr/A-Z/a-z/;            
    $doc_library =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $doc_language =~ s/\<\#\d+\#\>//g;  #Delete <#n#>
    $doc_revised =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $doc_submitted =~ s/(\d+).(\d+).(\d\d\d\d)/$3.$2.$1/g; #Reverse date
    $doc_revised =~ s/(\d+).(\d+).(\d\d\d\d)/$3.$2.$1/g;   #Reverse date
    $CATEGORY = $doc_routid;
    $CATEGORY =~ s/\d+//g;              #Remove a number from id
    $doc_library =~ s/\or\s/-/g;
    $doc_library =~ s/\s/-/g;
    $doc_library =~ s/\--/ /g;
    @keywords = sort @keywords;
    open(OUT,">entry") || die "cannot create keys";
    print OUT "<DT>$doc_version ($doc_routid) ";
    print OUT "<A HREF=\"./shortwrups/$low_rout/top.html\">HTML</A>, ";
    print OUT "<A HREF=\"./psdir/$low_rout.ps.gz\">PS</A></DT>\n";
    print OUT "<DD>$TITLE</DD>";
    close(OUT);

    open(OUT,">form") || die "cannot create form";
    print  OUT "Category: ShortWrups\n";
    print  OUT "Subcategory: $CATEGORY\n";
    print  OUT "\n";
    print  OUT "Name: $doc_version\n";
    print  OUT "Reference: $doc_routid\n";
    print  OUT "Subject: $TITLE\n";
    print  OUT "\n";
    print  OUT "Author: $doc_author\n";
    print  OUT "Responsible: Jamie SHIERS\n";
    print  OUT "Ccid: 03635\n";   
    print  OUT "\n";
    print  OUT "Submitted: $doc_submitted\n";
    print  OUT "Revised: $doc_revised\n";
    print  OUT "\n";
    print  OUT "Library: $doc_library\n";
    print  OUT "Language: $doc_language\n";
    
    if ($nb = @rdef) {
       print  OUT "Rdef: ";
       foreach $rdef (@rdef) {print OUT "$rdef "};
       print OUT "\n";
    }

    if ($nb = @rind) {
       print  OUT "Rind: ";
       foreach $rind (@rind) {print OUT "$rind "};
       print OUT "\n";
    }
    print  OUT "Keywords: $doc_keywords\n";
    print  OUT "Url: http://consult.cern.ch/shortwrup/$low_rout\n";
    close(OUT);
    open(OUT,">keys") || die "cannot create keys";
    foreach $keywords (@keywords) {print OUT "$keywords "};
    close(OUT);

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
}

1;

