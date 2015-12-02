% Macros for the `general' DTD.
% Copyright (C) 1993, 1994 Gary Houston
% This program may be copied and modified under the terms of the 
% GNU General Public License version 2.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gfgeneral}[1994/08/13 gf General class]

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions

\LoadClass{article}

\RequirePackage{gftext}
\RequirePackage{gfhead}
\RequirePackage{gfdisplay}
\RequirePackage{gffig}
\RequirePackage{gfstructure}
\RequirePackage{gflink}

\setcounter{secnumdepth}{2}

% Start each \part and \section on a new page.
\renewcommand{\part}
 {\cleardoublepage\par      % New paragraph
  \addvspace{4ex}           % Adds vertical space above title.
  \@afterindentfalse        % Suppresses indent in first paragraph.  Change
  \secdef\@part\@spart}     % to \@afterindenttrue to have indent.

\renewcommand{\section}
 {\clearpage\@startsection {section}{1}{\z@}{-3.5ex plus -1ex minus 
  -.2ex}{2.3ex plus .2ex}{\normalfont\Large\bfseries}}

% Table of contents.
\renewcommand{\gftoc}{\cleardoublepage\tableofcontents}
\renewcommand{\gflof}{\cleardoublepage\listoffigures}

\newcommand{\address}[1]{{\normalfont\small#1\par}}

% Command for printing the index.
\newcommand{\printindex}{\InputIfFileExists{\jobname.ind}{}{}}

\renewenvironment{titlepage}
 {%
  \bgroup % keep definitions local
  \clearpage\thispagestyle{docnum}\c@page\z@
  \let\footnotesize\small \let\footnoterule\relax
  \null\vfil\begin{center}%
 }
 {%
  \end{center}\vfil\null\clearpage
  \pagestyle{plain}\pagenumbering{roman}
  \if@twoside\thispagestyle{empty}\c@page\z@\fi
  \egroup
 }

% Other titlepage elements.  The \par must be inside the inner brakets to
% get the linespacing right.
\renewcommand{\title}[1]{{\normalfont\LARGE #1\par}}
\renewcommand{\author}[1]{{\normalfont\large#1\par}}
\renewcommand{\date}[1]{{\normalfont\large #1\par}}

% Body of the document.
\newenvironment{body}
 {%
  \cleardoublepage
  \thispagestyle{plain}
  \pagenumbering{arabic}
 }
 {}

% Headings in various places.
\newcommand{\titlepheading}[1]{\par{\normalfont\large\bfseries#1}\par}
\newcommand{\abstractheading}[1]{\par{\normalfont\large\bfseries#1}\par}
\newcommand{\prefaceheading}[1]{\par{\normalfont\large\bfseries#1}\par}
\newcommand{\frontheading}[1]{\clearpage{\normalfont\large\bfseries#1}\par}
\newcommand{\backheading}[1]{\clearpage{\normalfont\large\bfseries#1}\par}
\newcommand{\subheading}[1]{\par{\normalfont\bfseries#1}\par}

% Topics
\newenvironment{topone}
{\par}
{\par}
\newenvironment{toptwo}
{\par}
{\par}
\newenvironment{topthree}
{\par}
{\par}
\newenvironment{topfour}
{\par}
{\par}

\newcommand{\topheading}[1]{\par\textbf{#1}\par}

% Abstract in title page.
\newenvironment{tabstract}
{\vfil}
{\vfil}
  
% Abstract elsewhere.
\renewenvironment{abstract}
{\cleardoublepage\null\vfil\begin{center}}
{\end{center}\null\vfil}

% Preface.
\newenvironment{preface}
{\cleardoublepage}
{}

% Bibliography.
\newenvironment{bibliog}
{\cleardoublepage}
{}

% Glossary.
\newenvironment{gfglossary}
{\cleardoublepage}
{}

\newcommand{\glossaryline}{\newline}

% Glossary list.
\newenvironment{glosslist}
{\par}
{\par}

\long\def\glossitem[#1]#2{\textbf{#1}\newline#2\par}

% Citations.
\newcommand{\cit}[1]{\emph{#1}}

% Definition list.
\newcommand{\dlinit}
{% initialize the temporary dimensions to zero
  \dimen1=\z@\dimen2=\z@\dimen3=\z@\dimen4=\z@\dimen5=\z@\dimen6=\z@
  \dimen7=\z@\dimen8=\z@\dimen9=\z@}
\newcommand{\dlheadtest}[2]
  {\setbox0=\hbox{\quad\bf#2}\ifdim\wd0>\dimen#1\dimen#1=\wd0\fi}
\newcommand{\dltest}[2]
  {\setbox0=\hbox{\quad#2}\ifdim\wd0>\dimen#1\dimen#1=\wd0\fi}
\newcommand{\dltitletag}[2]
 {\makebox[\the\dimen#1][l]{\quad\bfseries#2}}
\newcommand{\dltitletext}[1]
 {\makebox{\quad}%
  \parbox[t]{\the\dimen0}{\bfseries\noindent\ignorespaces#1\strut}%
 }
\newcommand{\dltag}[2]
 {\makebox[\dimen#1][l]{\quad#2}}
\newcommand{\dltext}[1]
 {\makebox{\quad}%
  \parbox[t]{\the\dimen0}{\noindent\ignorespaces#1\strut}%
 }
\newenvironment{dl}
 {\par\noindent
  \dimen0=\hsize
  \advance\dimen0 by -\dimen1
  \advance\dimen0 by -\dimen2
  \advance\dimen0 by -\dimen3
  \advance\dimen0 by -\dimen4
  \advance\dimen0 by -\dimen5
  \advance\dimen0 by -\dimen6
  \advance\dimen0 by -\dimen7
  \advance\dimen0 by -\dimen8
  \advance\dimen0 by -\dimen9
  \advance\dimen0 by -1em% em == quad
}
{}

% Put text in a box: from the TeXbook, Chapter 21.
% Used for framing figures.
\newcommand{\boxit}[1]
 {\vbox{\hrule\hbox{\vrule\kern3pt
  \vbox{\kern3pt#1\kern3pt}\kern3pt\vrule}\hrule}}

% Put top and bottom rules around text.
% Used for framing figures.
\newcommand{\ruleit}[1]
 {\vbox{\hrule\hbox{\kern3pt
  \vbox{\kern3pt#1\kern3pt}\kern3pt}\hrule}}

% Create an empty box: used for <artwork>.
\newcommand{\emptybox}[2]
 {\dimen0=#1\divide\dimen0 by 2\vbox to \dimen0{\vss
  \vtop to \dimen0{\vss\hbox to #2{}}}}

% Table elements.

% Macros to store and replace a few line-breaking parameters.
\newcommand{\storeskips}
 {\dimen2=\the\baselineskip
 \dimen3=\the\lineskip \dimen4=\the\lineskiplimit}

\newcommand{\oldskips}
 {\baselineskip=\dimen2
 \lineskip=\dimen3 \lineskiplimit=\dimen4}

% Highlight a row heading.
\newcommand{\rowhead}[1]{\hpone{#1}}

% Counter with number of columns in table.
\newcount\gencols

% Create a horizontal rule.
\newcommand{\rowrule}{\multispan{\the\gencols}\hrulefill\cr}

% Table environment. The parameter specifies the number of columns.
\newenvironment{gentable}[1]
{%
  \par\noindent
  % calculate the widths of the columns
  \dimen1=\hsize
  \divide\dimen1 by #1
  \advance\dimen1 by -2em	% Separate columns from lines with \quad.
  \storeskips			% Save line break parameters.
  % Calculate total number of columns, including vrules.
  \gencols=#1
  \multiply\gencols by 2
  \advance\gencols by 1
  \begingroup
  \offinterlineskip		% No interline space: fixes vertical lines.
  \halign\bgroup\vline##&&\quad\vtop{\noindent\hsize=\dimen1\oldskips##\strut}\quad&##\vline\cr
}
{%
  \egroup
  \endgroup
  \par\noindent
}

\newcommand{\linespar}{\@par}

{\catcode`\^^M=\active % these lines must end with %
  \gdef\setlines{\catcode`\^^M\active \let^^M\linespar %
}}

\newenvironment{lines}
{\leavevmode\newline
  \begingroup
  \parskip = 0pt
  \parindent = 0pt
  \emergencystretch = 0pt
  \setlines
  \@gobble
}
{\endgroup}

\newenvironment{xmp}
{\leavevmode\newline
  \begingroup
  \tt
  \parskip = 0pt
  \parindent = 0pt
  \emergencystretch = 0pt
  \setlines
  \@gobble
}
{\endgroup}
