%% 
%% This is file `cernman.cls', generated 
%% on <1994/4/19> with the docstrip utility (1).
%% 
%% The original source files were:
%% 
%% cernman.dtx  (with options: `cls')
%% Copyright (C) 1994 Michel Goossens and Sebastian Rahtz. All rights reserved. 
%% You can use this style for what you like, 
%% but no permission is granted to distribute a 
%% modified version of this file under its original name. 
%% 
\def\fileversion{4}
\def\filedate{1994/01/10}
\def\docdate{1994/01/10}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cernman}[\filedate]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\PassOptionsToClass{twoside}{report}
\ProcessOptions
\LoadClass{report}
\RequirePackage{pifont}
\RequirePackage{color}
\RequirePackage{array,tabularx}
\RequirePackage{verbatim}
\RequirePackage[dvips]{graphicx,epsfig}
\RequirePackage{epsfig}
\RequirePackage{varioref}
\RequirePackage{multicol}
\RequirePackage{here}
\RequirePackage{xspace}
\RequirePackage{calc,ifthen}
\RequirePackage{makeidx}

\renewcommand{\rmdefault}{ptm}

\@mparswitchtrue

\extrarowheight2pt
\arrayrulewidth.6pt

%%%%%%%%%%%%%%% _ is now normal char in text %%%%%%%%%%%%%%%%
% Make _ other
\catcode`\_=12
% return _ to subscript function inside math
\def\_{\ifmmode\sb\else_\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\textem\emph
\newcommand{\eg}{e.g.,\xspace} %FMi
\newcommand{\ie}{i.e.,\@\xspace} %FMi
\newcommand{\etc}{etc.\@\xspace} %FMi

%\def\TT{\fontfamily{\ttdefault}\fontseries{m}\fontshape{n}\selectfont}
\let\TT\ttfamily
\newcommand{\Lcs}[1]{{\TT\char'134#1}}
\newcommand{\Lenv}[1]{{\TT#1}}
\let\Lsty\Lenv
\let\Lopt\Lenv
\def\endash{--}
\def\emdash{\endash-}
\def\thinskip{\hskip 0.16667em\relax}
\def\d@sh#1#2{\unskip#1\thinskip#2\thinskip\ignorespaces}
\newcommand{\dash}{\d@sh\nobreak\endash}
\newcommand{\Dash}{\d@sh\nobreak\emdash}
\def\@minisanitize{\@makeother\$\@makeother\&%
  \@makeother\#\@makeother\^\@makeother\_\@makeother\%\@makeother\~}
\newcommand{\Lit}{\begingroup\@minisanitize\@Lit}
\def\@Lit#1{\TT#1\endgroup}
\newcommand{\Ucom}[1]{\mbox{{\TT\underline{#1}}}}

\def\MakeSubhead{%
 \@ifstar%
  {\@MakeSubhead[]}%
  {\@MakeSubhead[y]}%
}
\def\@MakeSubhead[#1]{%
  \@ifnextchar[%
  {\@@MakeSubhead[#1]}%
  {\@@MakeSubhead[#1][]}%
}
\def\@@MakeSubhead[#1][#2]#3{% post, text, name
        \def\head@temp{#2}%
        \ifx\head@temp\empty
           \def\@@Head{#3}%
        \else
           \def\@@Head{#2}%
        \fi
        \def\head@temp{#1}%
        \ifx\head@temp\empty
          \expandafter\xdef\csname #3\endcsname{%
            \noexpand\par\noexpand\smallskip\noexpand\textbf
            \noexpand\bgroup\@@Head: \noexpand\egroup
           }%
        \else
          \expandafter\xdef\csname #3\endcsname{%
            \noexpand\par\noexpand\smallskip\noexpand\textbf
            \noexpand\bgroup\@@Head: \noexpand\egroup
            \noexpand\par\noexpand\medskip
           }%
        \fi
}
\newdimen\@DL@itemwidth
\settowidth{\@DL@itemwidth}{12345678}
\def\@DLfont{\bfseries}
\def\@@denselist{%
    \setlength{\itemsep}{0pt}%
    \setlength{\topsep}{0pt}%
}
\def\@@openlist{%
    \setlength{\itemsep}{0pt}%
    \setlength{\topsep}{.2\baselineskip}%
}

\newenvironment{DLgen}[1]{%
    \settowidth{\@DL@itemwidth}{#1}%
    \begin{list}{}{%
    \renewcommand{\makelabel}[1]{{\@DLfont##1}\hfil}%
    \settowidth{\labelwidth}{{\@DLfont#1\quad}}%
    \setlength{\leftmargin}{\labelwidth}%
    \setlength{\itemindent}{0pt}%
    \setlength{\labelsep}{0pt}%
    \setlength{\parsep}{0pt}%
}}
    {\end{list}}
\newenvironment{DL}[1]{\@@openlist
  \begin{DLgen}{#1}}%
 {\end{DLgen}}
\newenvironment{DLtt}[1]{\def\@DLfont{\ttfamily}%
  \@@openlist
  \begin{DLgen}{#1}}%
 {\end{DLgen}}
\newenvironment{DLc}[1] {\@@denselist
  \begin{DLgen}{#1}}%
 {\end{DLgen}}
\newenvironment{DLttc}[1]{\@@denselist
  \def\@DLfont{\ttfamily}%
  \begin{DLgen}{#1}}%
 {\end{DLgen}}
\newcounter{cOL}
\newenvironment{OL}{% Ordered list
\begin{list}{\hfill{\bf\arabic{cOL}}\hskip6pt}%
   {\setlength{\labelsep}{0pt}%
    \setlength{\itemsep}{2pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{.5\baselineskip}%
    \usecounter{cOL}}}{\end{list}}
\newenvironment{OLc}{% Dense order list
\begin{list}{\hfill{\bf\arabic{cOL}}\hskip6pt}%
   {\setlength{\labelsep}{0pt}% horizontal separation between term and item
    \labelsep0pt\itemsep0pt\topsep0pt\partopsep0pt\parskip0pt\parsep0pt
    \usecounter{cOL}}}{\end{list}}
\newenvironment{UL}{% Unnumbered list
\begin{list}{}
   {\setlength{\labelsep}{0pt}% horizontal separation between term and item
    \setlength{\itemsep}{2pt}% vertical separation between two items
    \setlength{\parsep}{0pt}% vertical separation two paragraphs in an item
    \setlength{\topsep}{.5\baselineskip}% vertical separation text/list
    \renewcommand{\makelabel}{\hfill--\hskip6pt}}}%
{\end{list}}
\newenvironment{ULc}{% Dense unnumbered list
\begin{list}{}{%
    \labelsep0pt\itemsep0pt\topsep0pt\partopsep0pt\parskip0pt\parsep0pt
    \renewcommand{\makelabel}{\hfill--\hskip6pt}}}%
{\end{list}}
\let\Otemize =\itemize
\let\Onumerate =\enumerate
\let\Oescription =\description
\def\Nospacing{\itemsep=0pt\topsep=0pt\partopsep=0pt\parskip=0pt\parsep=0pt}
\newenvironment{Itemize}{\Otemize\Nospacing}{\endlist}
\newenvironment{Enumerate}{\Onumerate\Nospacing}{\endlist}
\newenvironment{Description}{\Oescription\Nospacing}{\endlist}
\newenvironment{Note}{{\bf Note:}\par}{\par}
\newenvironment{Notes}{{\bf Notes:}\begin{list}{}{%
      \labelsep0pt\itemsep0pt\topsep0pt\partopsep0pt\parskip0pt\parsep0pt
      \renewcommand{\makelabel}{\hfill--\hskip6pt}}}%
    {\end{list}}
\def\ps@headings{%
   \let\@mkboth\markboth
   \def\@oddfoot{}%
   \def\@evenfoot{}%
   \def\@evenhead{\rmfamily\thepage\hfil \textit{\leftmark}}%
   \def\@oddhead{\hbox{}\textit{\rightmark}\hfil\rmfamily\thepage}%
   \def\chaptermark##1{\markboth{%
       \ifnum \c@secnumdepth>\m@ne
          \@chapapp\ \thechapter. \
       \fi
       ##1}{}%
   }%
   \def\sectionmark##1{%
      \markright{%
       \ifnum \c@secnumdepth >\z@
         \thesection. \
       \fi
       ##1}
   }%
}
\pagestyle{headings}
\newcommand{\ttsc}[1]{{\TT\textsc{#1}}}
\newcommand{\ttbf}[1]{{\TT\textbf{#1}}}
\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1cm}
\setlength{\textwidth}{160mm}
\setlength{\evensidemargin}{25mm}
\setlength{\oddsidemargin}{25mm}
\setlength{\marginparwidth}{25mm}
\setlength{\marginparsep}{25mm}
\setlength{\marginparpush}{25mm}
\setlength{\topmargin}{2cm}
\setlength{\headheight}{5mm}
\setlength{\headsep}{8mm}
\setlength{\footskip}{9mm}
\ifcase \@ptsize\relax % 10 pt
 \setlength{\baselineskip}{13pt}
 \setlength{\textheight}{48\baselineskip}
\or                    % 11 pt
 \setlength{\baselineskip}{14pt}
 \setlength{\textheight}{45\baselineskip}
\or                    % 12 pt
 \setlength{\baselineskip}{15pt}
 \setlength{\textheight}{41\baselineskip}
\fi
\def\@makechapterhead#1{             % Heading for \chapter command
  { \parindent 0pt \raggedright
    \ifnum \c@secnumdepth >\m@ne     % IF secnumdepth > -1 THEN
      \Large\bfseries \@chapapp{}
      \thechapter:\ \fi              % Print 'Chapter' and number.
    #1\par
    \nobreak                         % TeX penalty to prevent page break.
    \vskip 10pt                      % Space between title and text.
  } }
\def\@makeschapterhead#1{             % Heading for \chapter* command
  { \parindent 0pt \raggedright
    \Large \bfseries                  % Title.
    #1\par
    \nobreak                          % TeX penalty to prevent page break.
    \vskip 10pt                       % Space between title and text.
  } }
\def\section{\@startsection {section}%
  {1}{\z@}{-2.ex plus -1ex minus -.2ex}{2ex plus .2ex}{\large\bfseries}}
\def\subsection{\@startsection{subsection}%
  {2}{\z@}{-2ex plus -1ex minus -.2ex}{1.5ex plus .2ex}{\large\bfseries}}
\def\subsubsection{\@startsection{subsubsection}%
  {3}{\z@}{-2ex plus-1ex minus -.2ex}{1.5ex plus .2ex}{\normalsize\bfseries}}
\def\paragraph{\@startsection{paragraph}%
  {4}{\z@}{2ex plus 1ex minus .2ex}{-1em}{\normalsize\bfseries}}
\def\subparagraph{\@startsection{subparagraph}%
  {5}{\parindent}{2ex plus 1ex minus .2ex}{-1em}{\normalsize\bfseries}}

\newenvironment{Tabhere}%
    {\begin{table}[H]}
    {\end{table}}
\newenvironment{Fighere}%
    {\begin{figure}[H]}
    {\end{figure}}

\long\def\@makecaption#1#2{\vskip10pt
   \setbox\@tempboxa\hbox{#1: #2}
   \ifdim \wd\@tempboxa >\hsize   % IF longer than one line:
       #1: #2\par                 %   THEN set as ordinary paragraph.
     \else                        %   ELSE  center.
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}
   \fi\par\vspace*{10pt}}

\def\tableofcontents{\section*{Table of Contents}\@starttoc{toc}}
\def\listoffigures{\section*{List of Figures}\@starttoc{lof}}
\def\listoftables{\section*{List of Tables}\@starttoc{lot}}
\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}% Align with section titles
\let\l@table\l@figure

\MakeSubhead*{Action}
\MakeSubhead{Example}
\MakeSubhead{Examples}
\MakeSubhead{Remark}
\MakeSubhead{Remarks}
\MakeSubhead[Input parameter description]{Idesc}
\MakeSubhead[Output parameter description]{Odesc}
\MakeSubhead[Parameter description]{Pdesc}

%\def\Cind{\@ifnextchar[{\@Cind}{\@@Cind}}% Command reference
%\def\@Cind[#1]#2{\ifx\empty#2\else{\ttfamily #2}\fi%
%     \ifx\empty#1\else\index{#1@{\ttfamily #1}}\fi}% Optional parameter
%\def\@@Cind#1{\ifx\empty#1\else{\ttfamily #1}\index{#1@{\ttfamily#1}}\fi}% Straight to index
\newcommand{\Cind}[2][!*!,!]{% #1 (optional) to index, #2 to text
 \ifthenelse{\equal{#1}{!*!,!}}%
   {\ifthenelse{\equal{#2}{}}{}{\texttt{#2}\Inref{#2}}}%no optional arg.
   {\ifthenelse{\equal{#1}{}}{}{\Inref{#1}}%   optional argument
    \ifthenelse{\equal{#2}{}}{}{\texttt{#2}}}%  test #1 and #2 independently
}
\def\Inref#1{\index{#1@{\protect\ttfamily\space #1}}}

\def\Cdef#1{%
  \texttt{#1}\index{#1@{\ttfamily #1}|textbf}}

\let\Carg\Cind
\let\Copt\Cind
\let\Cargdef\Cdef
\let\Coptdef\Cdef
\let\FCdef\Cdef
\let\FCind\Cind
\let\Rargdef\Cdef
\let\Rdef\Cdef
\let\Rarg\Cind
\let\Rind\Cind
\def\Ropt#1{\Cind{'#1'}}
\def\Roptdef#1{\Cdef{'#1'}}
\let\Command\Lit
\let\Param\Lit
\let\Pind\Cind
\let\Pdef\Cdef
\def\Sidef#1{\textbf{#1}}

\newcommand{\Bbfm}{\mbox{\boldmath}}
\newcommand{\Ebfm}{\mbox{\unboldmath}}
\newcommand{\Dstm}{\displaystyle}
\newcommand{\Tstm}{\textstyle}
\newcommand{\Sstm}{\scriptstyle}
\newcommand{\SSstm}{\scriptscriptstyle}
\newcommand{\Rule}{\rule[-.9ex]{0ex}{3.1ex}}

\newenvironment{XMP}{%  All characters verbatim but { } \
   \pagebreak[2]\begingroup\trivlist \item[]\if@minipage\else\vskip\parskip\fi
   \leftskip\@totalleftmargin\rightskip\z@
   \parindent\z@\parfillskip\@flushglue\parskip\z@
   \@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par}
   \obeylines \ttfamily \catcode``=13 \@noligs
   \@makeother\ \@makeother\$\@makeother\&\@makeother\#\@makeother\^
   \@makeother\^^K\@makeother\_\@makeother\^^A\@makeother\%\@makeother\~
   \frenchspacing\@vobeyspaces\footnotesize}{\endtrivlist\pagebreak[2]\endgroup
}% End of environment XMP

\newenvironment{XMPt}[1]{%  All characters verbatim but { } \
   \pagebreak[2]
   \begin{center}
   \mbox{}\\[-1cm]
   \makebox[\linewidth][l]{\vrule width .4pt height 0mm depth 3mm \hrulefill
   \vrule width .4pt height 0mm depth 3mm}\\[-1.5ex]
   \mbox{\bf\footnotesize#1}
   \end{center}
   \vspace*{-5mm}
   \nopagebreak
   \begin{XMP}}% beginning XMP environment
   {\end{XMP}\nopagebreak\vspace*{-2.5ex}  % end XMP environment followed by bottom line
   \makebox[\linewidth][l]{\vrule width .4pt height 2mm depth 0mm \hrulefill
   \vrule width .4pt height 2mm depth 0mm}
   \vskip1ex\par\pagebreak[2]
}% End of environment XMPt

\newenvironment{XMPzskip}{%  All characters verbatim but { } \
   \begingroup\partopsep\z@\parsep\z@\listparindent\z@\topsep\z@
   \leftskip\@totalleftmargin\rightskip\z@
   \parindent\z@\parfillskip\@flushglue\parskip\z@
   \trivlist\partopsep\z@\parsep\z@\listparindent\z@\topsep\z@
   \item[]\leftskip\@totalleftmargin\rightskip\z@
   \parindent\z@\parfillskip\@flushglue\parskip\z@
   \@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par}
   \obeylines \ttfamily \catcode``=13 \@noligs
   \@makeother\ \@makeother\$\@makeother\&\@makeother\#\@makeother\^
   \@makeother\^^K\@makeother\_\@makeother\^^A\@makeother\%\@makeother\~
   \frenchspacing\@vobeyspaces\footnotesize}{\endtrivlist\endgroup
}% End of environment XMPzskip

\newenvironment{XMPfont}[1]{% integer font size as parameter
  \begin{XMP}
  \ttfamily\fontsize{#1}{1.2#1pt}\selectfont\hyphenchar\the\font-1}%
  {\end{XMP}%
}% ***** end of environment{XMPfont}

\newenvironment{XMPfrac}[1]{% font as parameter
  \begin{XMP}
    \font\Localfont=pcrr7t at #1pt%
    \Localfont\baselineskip1.2\fontdimen6\font\hyphenchar\the\font-1}%
  {\end{XMP}%
}% ***** end of environment{XMPfrac}

\def\XMPin{\@ifnextchar [{\@XMPin}{\@XMPin[.49]}}
\def\@XMPin[#1]#2{\par\begin{minipage}[t]{#1\linewidth}\vspace*{5mm}\begin{XMPt}{#2}}
\def\endXMPin{\end{XMPt}\end{minipage}\hfill}
\def\XMPout{\@ifnextchar [{\@XMPout}{\@XMPout[.49]}}
\def\@XMPout[#1]#2{\begin{minipage}[t]{#1\linewidth}\vspace*{5mm}\begin{XMPt}{#2}}
\def\endXMPout{\end{XMPt}\end{minipage}\vspace{.5\baselineskip}\par}
\def\Ptitle#1{%
  \special{ps: /Printstring (#1) def}%
  \includegraphics{/afs/cern.ch/project/cnas_doc/sources/cnasall/cnastit.eps}%
}

%%%%%%%%%%%%%%%%%%%%%% Box commands  %%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{boxgray}{gray}{.9}

\newlength{\mylen}
\newsavebox{\mybox}

\newcommand{\Sbox}[4][ ]{\Sboxni[#1]{#3}{#4}% #2 is label
  \label{#2}\index{#3@{\ttfamily #3}|Sidef}%
}% ***** end of \newcommand{\Sbox}

\newcommand{\Sboxni}[3][ ]{\par% margin note, highlight, parameters
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \settowidth{\mylen}{\quad\textbf{\small #2}}
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1\ }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\textbf{\small #2}  & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{Sboxni}

\newcommand{\SCubr}[3][ ]{\par
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \settowidth{\mylen}{\quad\texttt{#2}}
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1\ }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\texttt{#2}  & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{SCubr}

\newcommand{\SCubrii}[5][ ]{\par%#1 tag #2 abb. 1 #3 contents 1 #4 abb. 2 #5 contents 2
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\textbf{\small #1\ }}%
        \makebox[\linewidth][l]{\rule[-.9ex]{0ex}{3.1ex}%
           \quad\texttt{#2}\hspace{8pt}\texttt{#3}%
             \textrm{\quad and\quad}%
           \quad\texttt{#4}\hspace{8pt}\texttt{#5}%
        }% end of makebox
   }% end of colorbox
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \label{#4}\index{#4@{\ttfamily #4}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{\SCubrii}

\newcommand{\Sfunc}[3][ ]{\par% Definition of function
   \def\@@Sfunc##1=##2(##3){% Function to parse last argument
     \sbox{\mybox}{\quad\texttt{##1 = }\textbf{\small ##2}}%
     \gdef\@@Farg{(##3)}%
   }% end of definition of \@@Sfunc
   \@@Sfunc#3
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \settowidth{\mylen}{\usebox{\mybox}}%
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}%
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1\ }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \usebox{\mybox} & \ttfamily \@@Farg
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{Sfunc}

\newcommand{\Sfuncz}[2]{\par% like Sfunc but not definition of function
   \def\@@Sfunc##1=##2(##3){% Function to parse last argument
     \sbox{\mybox}{\quad\texttt{##1 = }\textbf{\small ##2}}%
     \gdef\@@Farg{(##3)}%
   }% end of definition of \@@Sfunc
   \@@Sfunc#2
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \settowidth{\mylen}{\usebox{\mybox}}%
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}%
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1\ }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \usebox{\mybox} & \ttfamily \@@Farg
        \end{tabular}%
   }% end of colored box
   \index{#1@{\ttfamily #1}}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{Sfuncz}

\newcommand{\Sfuncii}[5][ ]{\par%#1 tag #2 abb. 1 #3 contents 1 #4 abb. 2 #5 contents 2
   \def\@@Sfunc##1=##2(##3){% Function to parse last argument
     \sbox{\mybox}{\quad\texttt{##1 = }\textbf{\small ##2}}%
     \gdef\@@Farg{(##3)}%
   }% end of definition of \@@Sfunc
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\textbf{\small #1\ }}%
        \makebox[\linewidth][l]{\rule[-.9ex]{0ex}{3.1ex}%
            \@@Sfunc#3\usebox{\mybox}\hspace{8pt}\texttt{\@@Farg}%
              \textrm{\quad and\quad}%
            \@@Sfunc#5\usebox{\mybox}\hspace{8pt}\texttt{\@@Farg}%
        }% end of makebox
   }% end of colorbox
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \label{#4}\index{#4@{\ttfamily #4}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{\Sfuncii}

\newcommand{\Shubr}[3][ ]{\par% Definition of subroutine
   \settowidth{\mylen}{\quad\texttt{CALL }\textbf{\small #2}}
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1\ }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             {\quad\texttt{CALL }\textbf{\small #2}} & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{Shubr}

\newcommand{\Shubrz}[2]{\par% like Shubr but not definition of subroutine
   \settowidth{\mylen}{\quad\texttt{CALL }\textbf{\small #1}}
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \begin{tabular}{@{}lp{\mylen}@{}}
             {\quad\texttt{CALL }\textbf{\small #1}} & \ttfamily #2
        \end{tabular}%
   }% end of colored box
   \index{#1@{\ttfamily #1}}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{Shubrz}

\newcommand{\Shubrii}[5][ ]{\par%#1 tag #2 abb. 1 #3 contents 1 #4 abb. 2 #5 contents 2
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\textbf{\small #1\ }}%
        \makebox[\linewidth][l]{\rule[-.9ex]{0ex}{3.1ex}%
           \quad\texttt{CALL }\textbf{\small#2}\hspace{8pt}\texttt{#3}%
             \textrm{\quad and\quad}%
           \quad\texttt{CALL }\textbf{\small#4}\hspace{8pt}\texttt{#5}%
        }% end of makebox
   }% end of colorbox
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \label{#4}\index{#4@{\ttfamily #4}|Sidef}%
   \nopagebreak\par\medskip\par
   \endgroup
}% ***** end of \newcommand{\Shubrii}
\newwrite\@PAWout
\openout\@PAWout=\jobname.KUIP
\newcommand{\SKUIP}[3][!*!]{\par% #1 to index, #2 in bold #3 parameters
   \settowidth{\mylen}{\quad\textbf{\small #2}}
   \setlength{\mylen}{\linewidth-2\tabcolsep-\mylen}
   \pagebreak[2]\begingroup\setlength{\fboxsep}{0mm}
   \medskip
   \colorbox{boxgray}{%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\textbf{\small #2} & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \ifthenelse{\equal{#1}{!*!}}%
       {\index{#2@\texttt{#2}|Sidef}}%
       {\index{#1@\texttt{#1 (#2)}|Sidef}}%
   \nopagebreak\par\medskip\par
   \endgroup
   \label{ref:#2}
   \immediate\write\@PAWout{SKUIP:#1 (#2) #3 
   \string& \string\pageref\string{ref:#2\string}\string\\ }
}% ***** end of \newcommand{SKUIP}

\parindent=0pt
\parskip.2\baselineskip plus2pt minus2pt
%\parskip.2\baselineskip\relax%mg May 8th 1996 plus2pt 
\def\Filename#1{}

\newcommand{\amp}{{\TT\char'046}}
\newcommand{\apos}{{\TT\char'023}}
\newcommand{\Ast}{{\TT\char'052}}
\newcommand{\bsol}{{\TT\char'134}}
\newcommand{\bs}{{\TT\char'134}}
\newcommand{\Circ}{{\TT\char'136}}
\newcommand{\Colon}{{\TT\char'072}}
\newcommand{\commat}{{\TT\char'100}}
\newcommand{\dollar}{{\TT\char'044}}
\newcommand{\excl}{{\TT\char'041}}
\newcommand{\us}{{\TT\char'137}}
\newcommand{\hyphen}{{\TT\char'055}}
\newcommand{\lcub}{{\TT\char'173}}
\newcommand{\lpar}{{\TT\char'050}}
\newcommand{\lsqb}{{\TT\char'133}}
\newcommand{\lsb}{{\TT\char'133}}
\newcommand{\lsquo}{{\TT\char'022}}
\newcommand{\num}{{\TT\char'043}}
\newcommand{\percnt}{{\TT\char'045}}
\newcommand{\period}{{\TT\char'056}}
\newcommand{\quest}{{\TT\char'077}}
\newcommand{\quot}{{\TT\char'042}}
\newcommand{\rcub}{{\TT\char'175}}
\newcommand{\rpar}{{\TT\char'051}}
\newcommand{\rsqb}{{\TT\char'135}}
\newcommand{\rsb}{{\TT\char'135}}
\newcommand{\rsquo}{{\TT\char'023}}
\newcommand{\semi}{{\TT\char'073}}
\newcommand{\sol}{{\TT\char'057}}
\newcommand{\Tilde}{{\TT\char'176}}
\newcommand{\verbar}{{\TT\char'174}}
\newcommand{\sbl}{{\TT\char'040}}

\let\percent\percnt
\let\lcb\lcub
\let\rcb\rcub
\let\lsb\lsqb
\let\rsb\rsqb
\def\lab{{\TT\char`<}}
\def\rab{{\TT\char`>}}
\let\atsign\commat
\let\US\horbar

\newcommand{\CERNLIB}{\texttt{cmz}\index{CERNLIB}}
\newcommand{\CMZ}{\texttt{cmz}\index{CMZ}}
\newcommand{\COMIS}{\texttt{comis}\index{COMIS}}
\newcommand{\CSPACK}{\texttt{cspack}\index{CSPACK}}
\newcommand{\FATMEN}{\texttt{fatmen}\index{FATMEN}}
\newcommand{\GEANT}{\texttt{geant}\index{GEANT}}
\newcommand{\GKS}{\texttt{gks}\index{GKS}}
\newcommand{\HBOOK}{\texttt{hbook}\index{HBOOK}}
\newcommand{\HEPDB}{\texttt{hepdb}\index{HEPDB}}
\newcommand{\HIGZ}{\texttt{higz}\index{HIGZ}}
\newcommand{\HPLOT}{\texttt{hplot}\index{HPLOT}}
\newcommand{\KUIP}{\texttt{kuip}\index{KUIP}}
\newcommand{\MINUIT}{\texttt{minuit}\index{MINUIT}}
\newcommand{\PATCHY}{\texttt{patchy}\index{PATCHY}}
\newcommand{\PAW}{\texttt{paw}\index{PAW}}
\newcommand{\PAWPP}{\texttt{paw++}\index{PAW++}}
\newcommand{\WWW}{\texttt{www}\index{WWW}}
\newcommand{\SIGMA}{\texttt{sigma}\index{SIGMA}}
\newcommand{\VAXTAP}{\texttt{vaxtap}\index{VAXTAP}}
\newcommand{\ZEBRA}{\texttt{zebra}\index{ZEBRA}}
\endinput



{
\catcode`\p=12
\catcode`\t=12
\gdef\numonly#1pt{\gdef\@@xx{#1}}
}
\newcommand{\Prix}{%
  \@tempcnta=\c@page\advance\@tempcnta by 2
  \@tempdima=\@tempcnta pt\@tempdima=.05\@tempdima
  \expandafter\numonly\the\@tempdima
  \vfill
  \textit{Printed at CERN. Price \@@xx\ Swiss Centimes}
}
\def\condbreak#1{%
  \par\@tempdima=#1
  \ifdim\pagetotal>0pt
    \advance\@tempdima by -\pagegoal
    \advance\@tempdima by \pagetotal
    \ifdim\@tempdima>0pt
      \newpage
    \fi
  \fi
}
\endinput
%% 
%% End of file `cernman.cls'.
%%%%%START%%%%%%% this is the new definition %%%%%%%%%%%
\definecolor{boxgray}{gray}{.9}
\newlength{\mylen}
\renewcommand{\SCubr}[3][ ]{\par
   \settowidth{\mylen}{\quad\texttt{#2}}
   \setlength{\mylen}{\linewidth-4\tabcolsep-\mylen}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1 }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\texttt{#2}  & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \medskip\par
}% ***** end of \newcommand{SCubr}

% Make _ other
\catcode`\_=12
% return _ to subscript function inside math
\def\_{\ifmmode\sb\else_\fi}

%%%%%END%%%%%%%%% this is the new definition %%%%%%%%%%%
\definecolor{boxgray}{gray}{.9}
\newlength{\mylen}
\renewcommand{\SCubr}[3][ ]{\par
   \settowidth{\mylen}{\quad\texttt{#2}}
   \setlength{\mylen}{\linewidth-4\tabcolsep-\mylen}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1 }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\texttt{#2}  & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \medskip\par
}% ***** end of \newcommand{SCubr}
\definecolor{boxgray}{gray}{.9}
\newlength{\mylen}
\renewcommand{\SCubr}[3][ ]{\par
   \settowidth{\mylen}{\quad\texttt{#2}}
   \setlength{\mylen}{\linewidth-4\tabcolsep-\mylen}
   \medskip
   \colorbox{boxgray}{%
        \makebox[0mm][r]{\texttt{\small #1 }}%
        \begin{tabular}{@{}lp{\mylen}@{}}
             \quad\texttt{#2}  & \ttfamily #3
        \end{tabular}%
   }% end of colored box
   \label{#2}\index{#2@{\ttfamily #2}|Sidef}%
   \medskip\par
}% ***** end of \newcommand{SCubr}

