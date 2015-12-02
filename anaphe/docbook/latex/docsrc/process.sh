#!/bin/sh

# Process all files in the latex directory
rm autogen/*
echo "Copying parent document..."
cp subdocs/parent.xml autogen/parent.xml
for afile in ../*.mod.xsl; do
	if [ -d "$afile" ]; then
		echo "Skipping directoy..."
	else
		echo "Extracting XSL Documentation from `basename $afile` to autogen/`basename $afile .mod.xsl`.xsldoc.xml"
		if make autogen/`basename $afile .mod.xsl`.xsldoc.xml; then
			echo "Adding Entity"
			echo "<!ENTITY  `basename $afile` SYSTEM \"../autogen/`basename $afile .mod.xsl`.xsldoc.xml\">" >> autogen/autogen.ent
			echo "&`basename $afile`;" >> autogen/parent.xml
		else
			exit
		fi
	fi
done
echo "</book>" >> autogen/parent.xml
echo "Generating HTML documentation..."
make
