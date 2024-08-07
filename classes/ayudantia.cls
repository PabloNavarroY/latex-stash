\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ayudantia}[2023/01/01 Ayudantia]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\newtoggle{ayudantia@print}

% Print Mode
\DeclareOption{print}{
  \PassOptionsToClass{10pt}{base}
  \toggletrue{ayudantia@print}
}

% pass undeclared options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}

\ProcessOptions\relax
\LoadClass{base}


% --------- package loading ---------
% Custom packages
\RequirePackage[\iftoggle{ayudantia@print}{bw}{}]{math-environments}

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


\gdef\ayudantia@year{}
\gdef\ayudantia@semester{}
\gdef\ayudantia@number{}
\gdef\ayudantia@course{}
\gdef\ayudantia@date{}
\gdef\ayudantia@author{}
\gdef\ayudantia@profesor{}
\newcommand{\ano}[1]{\gdef\ayudantia@year{#1}}
\newcommand{\semestre}[1]{\gdef\ayudantia@semester{#1}}
\newcommand{\numeroAyudantia}[1]{\gdef\ayudantia@number{#1}}
\newcommand{\ramo}[1]{\gdef\ayudantia@course{#1}}
\newcommand{\fecha}[1]{\gdef\ayudantia@date{#1}}
\newcommand{\autor}[1]{\gdef\ayudantia@author{#1}}
\newcommand{\profesor}[1]{\gdef\ayudantia@profesor{#1}}


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
    pdftitle={Ayudantía \ayudantia@number},
    pdfsubject={\ayudantia@course}
    pdfauthor={\ayudantia@author},
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
    \ayudantia@semester ~ Semestre \ayudantia@year \par
    Profesor:~ \ayudantia@profesor \par
    Ayudante:~ \ayudantia@author
  \end{varwidth}
  \par
  \vspace*{1em}
  \begin{center}
    {\large \ayudantia@course} \par
    \vspace*{1ex}
    {\Large \textbf{Ayudantía \ayudantia@number}} \par
    \vspace*{1ex}
    {\large \ayudantia@date}
  \end{center}
  \vspace*{1em}
}

% Lists
\newlist{preguntas}{enumerate}{1}
\setlist[preguntas, 1]{label=\arabic*)}
