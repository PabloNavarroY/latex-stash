\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tarea}[2023/01/01 Clase para tareas]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\newtoggle{tarea@print}

% Print Mode
\DeclareOption{print}{
  \PassOptionsToClass{10pt}{base}
  \toggletrue{tarea@print}
  \toggletrue{tarea@toc}
}

% pass undeclared options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}

\ProcessOptions\relax
\LoadClass{base}


% --------- package loading ---------
\RequirePackage{xstring}

% Custom packages
\RequirePackage[\iftoggle{tarea@print}{bw}{}]{math-environments}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\RequirePackage{cancel}

\RequirePackage{varwidth}
\RequirePackage{hyperref}
\RequirePackage{enumitem}

\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=\iftoggle{tarea@print}{false}{true},
  citecolor=blue,
  linkcolor=blue
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={\@class}
  }
}


\gdef\@author{\empty}
\gdef\@class{\empty}
\gdef\@profesor{\empty}
\gdef\@ayudante{\empty}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}


\renewcommand{\maketitle} {
  % Left side
  \noindent
  \begin{varwidth}{.45\linewidth}
    \IfStrEq{\@class}{}{}{\textbf{\@class}\par}
    \IfStrEq{\@profesor}{}{}{\textbf{Profesor:} \@profesor\par}
    \IfStrEq{\@ayudante}{}{}{\textbf{Ayudante:} \@ayudante\par}
  \end{varwidth}
  \hfill
  % Right side
  \begin{varwidth}{.45\linewidth}
    \begin{flushright}
      \noindent\IfStrEq{\@author}{}{}{\@author\par}
      \noindent\@date\par
    \end{flushright}
  \end{varwidth}

  \vspace*{1em}
  \begin{center}
    \Large\textbf{\@title}
  \end{center}
  \vspace*{1em}
}


% --------- Lists ---------
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% --------- Commands ---------
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
