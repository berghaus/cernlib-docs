% Macros for HTML.
% Copyright (C) 1993, 1994, 1996 Gary Houston
% This program may be copied and modified under the terms of the 
% GNU General Public License version 2.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gfhtml}[1996/06/22 gf HTML class]

\renewcommand{\@date}{\empty}
\renewcommand{\@author}{\empty}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions

\LoadClass{article}

\RequirePackage{gftext}
\RequirePackage{gfstructure}
\RequirePackage{gfdisplay}
\RequirePackage{gfhead}

% URLs are usually too wide, and whitespace should not be stretched, so...
\raggedright

% Separate paragraphs with blank space, no indentation.  \raggedright also
% suppresses indentation.
\parindent 0pt
\parskip 9pt

\renewcommand\maketitle{%
  \newpage
  \global\@topnum\z@   % Prevents figures from going to top of page.
  \thispagestyle{empty}% Don't number the first page.
  \null
  \vskip 2em%
  \begin{center}
    {\LARGE \@title \par}%
  \end{center}
  \par
  \vskip 1.5em%
}

\long\def\address#1{\textit{#1}}
\newcommand{\anchor}[1]{{\itshape#1}}

% The hyphenation character is changed from "-" to "/" when typesetting
% URLs.
\newcommand{\url}[1]{\code{URL}{{\upshape\hyphenchar\font=`\/<URL:#1>\hyphenchar\font=`\-}}}

\newcommand{\urn}[1]{\code{URN}{#1}}
\newcommand{\xref}[1]{(page \pageref{#1})}

% PostScript image inclusion.
\newcommand{\img}[2]
 {%
  \if#1b\vbox{\hbox{\includegraphics{#2}}}%
  \else
  \if#1t\leavevmode\raise\baselineskip
    \vtop{\vfil\hbox{\includegraphics{#2}}}%
  \else
  \if#1c$\vcenter{\hbox{\includegraphics{#2}}}$
  \fi\fi\fi
 }
% Alternative when PostScript image not available.
\newcommand{\altimg}[1]{[Image\if\empty#1\else{}: #1\fi]}

% table captions.  first argument is the horizontal alignment (l, c, r),
% second argument is the caption.
\newcommand{\tablecaption}[2]
	{\dimen255=\textwidth
	\divide\dimen255 by 3
	\makebox[\textwidth][#1]{\parbox{\dimen255}{\textit{#2}}}}

% for table headings.
\newcommand{\tablehead}[1]
	{\textbf{#1}}

% Unstructured definition list.
% \udltest is called on each term before typesetting the list to allow the
% width of the terms column to be calculated.

% Initialise a new list.
\newcommand{\udlinit}
 {% Width of the terms column.
  \dimen0=0pt
  % Maximum width of the terms column.
  \dimen2=\hsize
  \divide\dimen2 by 3
  % Flag to keep track of whether a term has been seen.
  \def\@gotterm{0}%
 }

% Check whether the width of the column of terms is increased
% by the given term.
\newcommand{\udltest}[1]
 {\settowidth{\dimen1}{\quad#1}%
  \ifdim\dimen1>\dimen0
    \ifdim\dimen1>\dimen2
      \dimen0=\dimen2
    \else
      \dimen0=\dimen1
    \fi
  \fi
  \ignorespaces
 }

% Print a definition term.
\newcommand{\udltag}[1]
 {\if\@gotterm 1\newline\fi
  \settowidth{\dimen1}{#1}%
  \ifdim\dimen1>\dimen0
    #1\newline
    \makebox[\the\dimen0][l]{}%
  \else
    \makebox[\the\dimen0][l]{#1}%
  \fi
  \def\@gotterm{1}%
  \ignorespaces
 }

% Print definition text.  Wraps within its column if needed.
\newcommand{\udltext}[1]
 {%
  % Insert space if there wasn't a matching term.
  \if\@gotterm 0\makebox[\the\dimen0][l]{}\fi
  \def\@gotterm{0}%
  \dimen1=\hsize
  \advance\dimen1 by -\dimen0
  \parbox[t]{\the\dimen1}{\noindent\ignorespaces#1\strut}%
 }

% Could put extra space etc., here.  Take care with nested lists.
% The argument should be "normal" or "compact".
\newenvironment{udl}[1]
  {\par}
  {}

% Horizontal rule.
\newcommand{\hr}{\vskip\parskip\hrule height 2pt}

% Linebreak.  A simple \newline fails if someone does </ul>\n<br>.
\newcommand{\br}{\ifhmode\newline\fi}

% The \cite command is not used, since it fails in section titles and
% possibly other places.  In any case the number of the citation is
% already known.
\newcommand{\hcite}[1]{[#1]}

% Print the URL of the document.
\newcommand{\base}[1]
 {\docnum{#1}%
  \thispagestyle{docnum}%
 }

% Handle the <cite> element.  It seems better not to move the citation
% to the end.
\newcommand{\citehere}[1]
 {
  \textit{#1}
 }

% Strong text.  This is not supposed to be typeset the same as emphasised
% text.
\newcommand{\strong}[1]
 {
  \textbf{#1}
 }

% Environment enclosing <form> contents.  An optional argument provides
% the URL which actions the form.
\newenvironment{htmlform}[1][\empty]
 {\par
  [Begin Form%
  \if\empty#1\else: #1\fi
  ]\newline%
 }
 {[End Form]\par}
