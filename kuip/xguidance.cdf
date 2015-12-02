>Name MYDEF

>Menu MYMENU
>Guidance
This is the menu for my own commands

* The next directive signals the end of the guidance text.
>Help_item MYCMD
>Guidance
* Lines starting with * are ignored.
This is the first sentence of the first paragraph.  The HELP menus 
show the first phrase of the first paragraph.  The phrase
finishes at the first line ending with a '.' which is only now.
The first paragraph is still continuing here but this 
sentence does not appear in the HELP menu.
.
Consecutive lines are formatted into paragraphs.
The maximum line width used for terminal output is determined 
by the SET/COLUMNS command (usually 80 columns).

Because blank lines are ignored the start of a new paragraph has to be 
indicated by a line containing only a '.' in the first column.
.
A '.' at the end of a line indicates a sentence ending period and 
adds an additional space for improved readability.
Abbreviations like e.g. or etc. should therefore not appear 
at the end of a line.
For consistency the extra space between sentences belonging to 
the menu phrase should be added by hand.

 Text not starting in the first column is verbatim
             material and will not be reformatted.
.
       This should       be used 

                    for
          examples  and  tables.
Again extra space between verbatim lines has to be indicated by '.' lines.
For terminal output a verbatim block is always separated by 
a blank line from the surrounding paragraphs.

>User_help MYUHLP
