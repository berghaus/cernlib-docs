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

    $doc_head = "<table border>";
    #$doc_head .= "<a name=\"$doc_routid\">";
    #$doc_head .= "Routine ID: $doc_routid";
    #$doc_head .= "</a>\n";
    $doc_head .= "<tr><td align=left>Author(s): $doc_author  ";
    $doc_head .= "<td align=left>Library: $doc_library \n";
    $doc_head .= "<tr><td align=left>Submitter: $doc_submitter  ";
    $doc_head .= "<td align=left>Submitted: $doc_submitted  \n";
    $doc_head .= "<tr><td align=left>Language: $doc_language  ";
    $doc_head .= "<td align=left>Revised: $doc_revised  \n";
    $doc_head .= "</table>\n";
    $doc_head .= "<BR>\n";
    if (length($doc_keywords)) {
        $doc_head .= "<!-- KEY VALUE=\"$doc_keywords\" -->\n";
    }
    open(OUT,">BLA") || die "cannot create";
    print  OUT "\<DT\>\<A HREF=\"XXXX/XXXX.html\"\>\$doc\_version\</A\>\n";
    print  OUT "\<DD\>$TITLE\n";
    close(OUT);
    $doc_routid=~ tr/A-Z/a-z/;          #Change to lower case
    $doc_author =~ s/\<\#\d+\#\>//g;    #Delete <#n#> where n is a number
    $doc_submitter =~ s/\<\#\d+\#\>//g; #Delete <#n#>
    $doc_submitted =~ s/\<\#\d+\#\>//g; #Delete <#n#>
    $doc_version =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $doc_library =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $doc_language =~ s/\<\#\d+\#\>//g;  #Delete <#n#>
    $doc_revised =~ s/\<\#\d+\#\>//g;   #Delete <#n#>
    $doc_keywords =~ s/\<\#\d+\#\>//g;  #Delete <#n#>
    $TITLE =~ s/\w\d+//g;               #Delete the id number
    $low_ver = $doc_version;            #Change to lower case
    $low_ver =~ tr/A-Z/a-z/;            
    $doc_submitted =~ s/(\d+).(\d+).(\d\d\d\d)/$3.$2.$1/g; #Reverse date
    $doc_revised =~ s/(\d+).(\d+).(\d\d\d\d)/$3.$2.$1/g;   #Reverse date
    $CATEGORY = $doc_routid;
    $CATEGORY =~ s/\d+//g;              #Remove a number from id
    $doc_library =~ s/\or\s/-/g;
    $doc_library =~ s/\s/-/g;
    $doc_library =~ s/\--/ /g;
    open(OUT,">../form/$doc_routid.form") || "cannot creante";
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
    print  OUT "Keywords: $doc_keywords\n";
    print  OUT "Url: http://consult.cern.ch/shortwrup/$low_ver\n";
    
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

    join ('', &make_section_heading($TITLE, 'H2'), $doc_head, $after);
}
sub do_cmd_Rind {
    local($_) = @_;
    local($name, $number);
    s/$next_pair_pr_rx/$name = $2; ''/eo;
    s/$next_pair_pr_rx/$number = $2; ''/eo;
    $number =~ tr/A-Z/a-z/;
    join('',"<A HREF=\"../$number/$number.html\#$name\">$name<\/A>",$_);
}
1;
