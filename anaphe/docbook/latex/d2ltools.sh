#!/bin/zsh

PARENTDIR=`pwd`

function export_tarball ()
{
	echo "###############################################"
	echo "DB2LaTeX - Ramon Casellas casellas@aist.enst.fr"
	echo "###############################################"
	echo $PARENTDIR
	modified=`cvs update 2>&1 | grep M` 
	
		echo "$modified"
		if [ "$modified" != "" ] ; then
			echo "CVS update: modified files, proceed (y/n)?"
			read $continue
			if [ "$continue" = "n" ] ; then
				exit 1
			fi
			if [ "$continue" = "N" ] ; then
				exit 1
			fi
		fi
		
		# No commits pending, or user proceeds... 
		echo "Exporting cvs module docbook/latex..."
		export CVSROOT=/opt/cvs
		cd $PARENTDIR
		mkdir -p tmp;cd tmp
		mkdir -p docbook
		if [ "$1" = "CURRENT" ]
		then
			# As of Today
			echo "Exporting as `date +%Y%m%d`"
			cvs export  -D `date +%Y%m%d` -d docbook/latex sgml/xsl/docbook/latex > /dev/null 2>&1
		else
			echo "Exporting as $1 $2"
			cvs export  $1 $2 -d docbook/latex sgml/xsl/docbook/latex > /dev/null 2>&1
		fi

		echo "Creating Symlinks in testdocs directories..."
		cd $PARENTDIR/tmp/docbook/latex/testdocs
		./setup.sh

		cd $PARENTDIR/tmp/docbook/latex/packages
		if [ "$1" = "CURRENT" ]; then 
			echo "Updating .spec file vith version `date +%Y%m%d` in destination directory ..."
			sed -e "s/RCASVERSION/`date +%Y%m%d`/" \
				docbook-style-xsl-db2latex.spec.template > \
				docbook-style-xsl-db2latex.spec
		else
			echo "Updating .spec file vith version $2 in destination directory ..."
			sed -e "s/RCASVERSION/$2/" \
				docbook-style-xsl-db2latex.spec.template > \
				docbook-style-xsl-db2latex.spec
		fi

		echo "Packaging tarball..."
		cd $PARENTDIR/tmp
		if [ "$1" = "CURRENT" ]; then 
			tar cvfz $PARENTDIR/packages/db2latex-`date +%Y%m%d`.tar.gz docbook/latex > /dev/null 2>&1 
		else
			tar cvfz $PARENTDIR/packages/db2latex-$2.tar.gz docbook/latex > /dev/null 2>&1 
		fi
		cd $PARENTDIR
		rm -rf tmp/docbook

		cd $PARENTDIR/packages
		if [ "$1" = "CURRENT" ]; then
			echo "Updating .spec file vith version `date +%Y%m%d`  ..."
			sed -e "s/RCASVERSION/`date +%Y%m%d`/" \
				docbook-style-xsl-db2latex.spec.template > \
				docbook-style-xsl-db2latex.spec
		else
			echo "Updating .spec file vith version $2 ..."
			sed -e "s/RCASVERSION/$2/" \
				docbook-style-xsl-db2latex.spec.template > \
				docbook-style-xsl-db2latex.spec
		fi
}

function cvs_tag_current ()
{
	echo -n "Enter symbolic rtag (e.g. FEBRUARY2001RC2 )"
	read tag
	echo "RTagging sgml/xsl/docbook/latex as $tag"
	cvs rtag -fF $tag sgml/xsl/docbook/latex
}




function main ()
{
      # Test syntax.
      # if [ $# = 0 ]; then
      #        echo $"Usage: d2ltools tool "
      #        return 1
      #fi
	echo "###############################################"
	echo "DB2LaTeX - Ramon Casellas casellas@aist.enst.fr"
	echo "###############################################"
	echo 
  	echo "[1] Tag current CVS repository with a symbolic name. "
  	echo "[2] Export today's tarball from CVS. "
	echo "[3] Export a given tag/symbolic name."
	echo "[4] Export a given date."
	echo "[5] Generate HTML ChangeLog Directory."
	echo "[6] Generate ChangeLog file."
	echo "[0] quit."

	read answer
	if [ "$answer" = "1" ] ; then
		cvs_tag_current		
	      return 1
	elif [ "$answer" = "2" ] ; then
		export_tarball CURRENT
	      return 2 
	elif [ "$answer" = "3" ] ; then
		echo -n "Enter symbolic rtag (e.g. FEBRUARY2001RC2 )"
		read symbolic
		export_tarball -r $symbolic 
	      return 3 
	elif [ "$answer" = "4" ] ; then
		echo -n "Enter date rtag (e.g. 20010214 )"
		read date
		export_tarball -D $date
	      return 4 
	elif [ "$answer" = "5" ] ; then
		echo "Generating Log"
		/opt/bin/cvs2html -o changelog/index.html
	      return 5 
	elif [ "$answer" = "6" ] ; then
		echo "Generating Log"
		#/opt/bin/cvs2cl.pl -l "-d'20010215<`date +%Y%m%d`'" 
	      return 5 
  	fi
}

main
exit 0
