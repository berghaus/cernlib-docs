# **********************************************************************
ZFILES=aaaa.ps.Z base.ps.Z cons.ps.Z draw.ps.Z geom.ps.Z hits.ps.Z iopa.ps.Z \
kine.ps.Z phys.ps.Z trak.ps.Z xint.ps.Z zzzz.ps.Z

.SUFFIXES: .tex .ps .ps.Z .dvi

.ps.ps.Z:
	cp $(*).ps $(*).save
	-rm $(*).ps.Z
	compress $(*).ps
	mv $(*).save $(*).ps
	touch $(*).ps.Z

.dvi.ps:
	dvips -o $(*).ps $*

.tex.dvi:
	-latex $*
	bibtex $(*).1
	-makeindex $(*)
	latex $*
	latex $*

geant_manual:   geant_tex geant_ps geantall_dvi geantall_ps

#geant_tex: *.tex *.sty *.bib 
#	ls -lt *.tex *.sty *.bib > filelist
#	rcp $? filelist cernlib@asis01:/asis/share/cern/doc/tex.dir/geant
#	touch geant_tex

#geant_ps: $(ZFILES)
#	rcp $(?) cernlib@asis01:/asis/share/cern/doc/ps.dir/geant
#	touch geant_ps

#geantall_ps:    geantall.ps.Z
#	rcp $(?) cernlib@asis01:/asis/share/cern/doc/ps.dir/geant/geant.ps.Z
#	touch geantall_ps

#geantall_dvi:     geantall.dvi eps/*.eps
#	rcp geantall.dvi cernlib@asis01:/asis/share/cern/doc/tex.dir/geant
#	rcp `echo $(?) | grep eps` eps/cnastit.eps \
#	-rcp `echo $(?) | grep eps` cernlib@asis01:/asis/share/cern/doc/tex.dir/geant/eps
#	touch geantall_dvi

geantall.dvi: aaaa*.tex base*.tex cons*.tex draw*.tex geom*.tex hits*.tex \
iopa*.tex kine*.tex phys*.tex trak*.tex xint*.tex zzzz*.tex
	latex $*
	bibtex $(*).1
	bibtex $(*).2
	bibtex $(*).3
	bibtex $(*).4
	bibtex $(*).5
	bibtex $(*).6
	bibtex $(*).7
	bibtex $(*).8
	bibtex $(*).9
	bibtex $(*).10
	bibtex $(*).11
	bibtex $(*).12
	makeindex $(*)
	latex $*
	latex $*

aaaa.dvi:     aaaa*.tex

base.dvi:     base*.tex

cons.dvi:     cons*.tex

draw.dvi:     draw*.tex

geom.dvi:     geom*.tex

hits.dvi:     hits*.tex

iopa.dvi:     iopa*.tex

kine.dvi:     kine*.tex

phys.dvi:     phys*.tex

trak.dvi:     trak*.tex

xint.dvi:     xint*.tex

zzzz.dvi:     zzzz*.tex
