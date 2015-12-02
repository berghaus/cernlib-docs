#!/bin/sh

# Copy XML Files from the subdocs directory
echo "Copying XML files to build directory..."
cp subdocs/*.xml build

# Process all files in the latex directory that end with .mod.xsl
echo "Extracting Documentation from mod.xsl files..."
echo "Generating autogen.ent / autogen.xml files..."

for afile in ../*.mod.xsl; do
	if [ -d "$afile" ]; then
		echo "Skipping directoy..."
	else
		echo "Extracting XSL Documentation from `basename $afile` to build/`basename $afile .mod.xsl`.xsldoc.xml"
		if make build/`basename $afile .mod.xsl`.xsldoc.xml 1>/dev/null 2>/dev/null ; then
			# echo "Adding Entity"
			echo "<!ENTITY  `basename $afile` SYSTEM \"`basename $afile .mod.xsl`.xsldoc.xml\">" >> build/autogen.ent
			echo "&`basename $afile`;" >> build/autogen.xml
		else
			echo "ERROR making"
			rm -f build/`basename $afile .mod.xsl`.xsldoc.xml 
			make build/`basename $afile .mod.xsl`.xsldoc.xml 
			exit
		fi
	fi
done

# "Well form"  autogen
echo "Well form  autogen.xml (add missing close tags)... "
echo "</book>" >> build/autogen.xml
echo "</webpage>" >> build/autogen.xml

echo "Generating HTML WebSite..."
if make web ; then
	echo "DONE!"
else
	echo "ERROR!"
fi
echo "Generating API Docs..."
if make doc ; then
	echo "DONE!"
else
	echo "ERROR!"
fi
