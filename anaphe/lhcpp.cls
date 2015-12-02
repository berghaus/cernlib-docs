%% lhcpp.cls
\def\fileversion{1}
\def\filedate{1999/02/11}
\def\docdate{1999/02/11}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lhcpp}[\filedate]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{cernman}}
\PassOptionsToClass{11pt,a4paper,dvips,twoside}{cernman}
\ProcessOptions
\LoadClass{cernman}

\let\Theindex\theindex
\renewcommand{\theindex}{\Theindex\raggedright}
\setcounter{topnumber}{4}
\setcounter{totalnumber}{4}
\renewcommand{\topfraction}{.98}
\renewcommand{\textfraction}{.02}
\setlength{\floatsep}{6pt plus 2pt minus 3pt}
\setlength{\textfloatsep}{6pt plus 2pt minus 3pt}
\usepackage{rotating}
\makeindex
\RequirePackage{url}
\RequirePackage{fancyvrb}
\DefineVerbatimEnvironment{verbatim}{Verbatim}
                          {fontsize=\small,xleftmargin=\parindent}
\DefineVerbatimEnvironment{listing}{Verbatim}{fontsize=\footnotesize}
% numbered
\DefineVerbatimEnvironment{nverbatim}{Verbatim}
  {fontsize=\small,numbers=left,xleftmargin=\parindent}
\DefineVerbatimEnvironment{cverbatim}{Verbatim}{fontsize=\small,%
  firstnumber=continue,numbers=left,xleftmargin=\parindent}
%
\DefineVerbatimEnvironment{ssverbatim}{Verbatim}{fontsize=\scriptsize}
\DefineVerbatimEnvironment{tverbatim}{Verbatim}{fontsize=\tiny}
\DefineVerbatimEnvironment{alltt}{Verbatim}%
                          {fontsize=\small,commandchars=\\\{\},%
                           xleftmargin=\parindent}
\DefineVerbatimEnvironment{nssAlltt}{Verbatim}%
                          {fontsize=\scriptsize,commandchars=\\\{\},%
                           numbers=left,xleftmargin=\parindent}
\DefineVerbatimEnvironment{Falltt}{Verbatim}%
                          {fontsize=\small,commandchars=\\\{\},%
                           frame=single,xleftmargin=0pt}
\DefineVerbatimEnvironment{nssverbatim}{Verbatim}
  {fontsize=\scriptsize,numbers=left,xleftmargin=\parindent}
%%%%%%%%%%%%%%% _ is now normal char in text %%%%%%%%%%%%%%%%
% Make _ other
\catcode`\_=12
% return _ to subscript function inside math
\def\_{\ifmmode\sb\else_\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\catcode`\$=12
\catcode`\~=12
\catcode`\^=12
\def\^{\ifmmode\sp\else^\fi}
%\catcode`\&=12

\endinput




