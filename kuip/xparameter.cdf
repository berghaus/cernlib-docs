>Name MYDEF
>Menu MYMENU

>Command ECHO
>Action XECHO
>Parameters
STRING    'Mandatory string' C
+
NUMBER    'Small negative number'  I D=0    R=-10:0
MINUS     'Optional string'        C D=MN   Minus
POSITIVE  'Positive real'          R D=1.23 R=0:  Slider=1:2.00

OPTION    'Implicit option'        C D=' '
-          Blank option value
--         Option value '-' can make trouble.
-1         Same is true for digits.

CHARSET   'Self documenting option values in Range attribute' _
                                C Option  D=NATIVE  R=NATIVE,ASCII,EBCDIC

FORMAT    'Formatting rules'    C Option  D=LINE
-LINE      The full explanation text has to be on a single logical line. _
           The underscore can be used to join several physical lines _
           into one logical line.
-BLANKS    Leading blanks are ignored. _
           Indentation can be used to make the CDF more readable. _
           Multiple blanks are replaced by a single blank.

>Guidance
Echo command line arguments to demonstrate exception rules
for option assignments.
