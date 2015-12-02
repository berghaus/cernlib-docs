
all: hyperref test

repere: repere.lex
	flex -8 repere.lex
	gcc -o repere lex.yy.c -lfl
	rm lex.yy.c

hyperref: 
	latex hyperref.ins
	latex hyperref.dtx

test:
	latex test
	latex test

install:
	latex hyperref.ins
	(TEXMF=`kpsewhich -expand-var '$TEXMFMAIN'`;mv *.sty *.cfg ${TEXMF}/tex/latex/hyperref)


clean:
	-rm *.aux *.toc *.idx *.drv *.sty  *.dvi *.log *.rep *.lof *.brf *.tmp *.ist *.ilg *.ind *.cfg

