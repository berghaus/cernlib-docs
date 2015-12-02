# LaTeX2HTML 97.1a (August 26th, 1997)
# Associate sections original text with physical files.


$key = q/0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0/;
$section_info{$key} = '0%:%'."$dir".q|top.html%:%Complete Elliptic Integrals of First, Second, and Third Kind%:%| unless ($section_info{$key}); 
$noresave{$key} = "$nosave";
$done{"${dir}top.html"} = 1;

1;

