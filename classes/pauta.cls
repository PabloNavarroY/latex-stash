\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pauta}[2023/01/01 Pauta]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\newtoggle{pauta@print}

% Print Mode
\DeclareOption{print}{
  \PassOptionsToClass{10pt}{base}
  \toggletrue{pauta@print}
}

% pass undeclared options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}

\ProcessOptions\relax
\LoadClass{base}


% --------- package loading ---------
% Custom packages
\RequirePackage[\iftoggle{pauta@print}{bw}{}]{math-environments}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}

\RequirePackage{varwidth}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
% \RequirePackage[justification=centering]{caption}
\RequirePackage{hyperref}
% \RequirePackage{float}
% \RequirePackage{subcaption}
% \RequirePackage{fancyvrb}
% \RequirePackage{tikz}

\RequirePackage{subfiles}


\gdef\pauta@year{}
\gdef\pauta@semester{}
\gdef\pauta@number{}
\gdef\pauta@course{}
\gdef\pauta@date{}
\gdef\pauta@author{}
\gdef\pauta@profesor{}
\newcommand{\ano}[1]{\gdef\pauta@year{#1}}
\newcommand{\semestre}[1]{\gdef\pauta@semester{#1}}
\newcommand{\interrogacion}[1]{\gdef\pauta@number{#1}}
\newcommand{\ramo}[1]{\gdef\pauta@course{#1}}
\newcommand{\fecha}[1]{\gdef\pauta@date{#1}}
\newcommand{\autor}[1]{\gdef\pauta@author{#1}}
\newcommand{\profesor}[1]{\gdef\pauta@profesor{#1}}


\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=blue,
  filecolor=magenta,
  urlcolor=cyan,
  pdfstartview=FitH,
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={Ayudantía \pauta@number},
    pdfsubject={\pauta@course}
    pdfauthor={\pauta@author},
  }
}


\renewcommand{\maketitle} {
  \noindent
  \begin{varwidth}{0.4\textwidth}
    \includegraphics[width=2cm]{images/logo-uc.png}
  \end{varwidth}
  \hspace*{.05cm}
  \begin{varwidth}{0.7\textwidth} \sc
    Pontificia Universidad Católica de Chile \par
    Facultad de Matemáticas \par
    \pauta@semester ~ Semestre \pauta@year \par
    Profesor:~ \pauta@profesor \par
    Ayudante:~ \pauta@author
  \end{varwidth}
  \par
  \vspace*{1em}
  \begin{center}
    {\large \pauta@course} \par
    \vspace*{1ex}
    {\Large \textbf{Pauta \pauta@number}} \par
    \vspace*{1ex}
    {\large \pauta@date}
  \end{center}
  \vspace*{1em}
}

% Lists
\newlist{preguntas}{enumerate}{1}
\setlist[preguntas, 1]{label=(\arabic*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}
