\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2024/01/01 Clase para apuntes]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\newtoggle{apuntes@print}
\newtoggle{apuntes@toc}
\newtoggle{apuntes@clases}
\newtoggle{apuntes@todo}

% Print Mode
\DeclareOption{print}{
  \PassOptionsToClass{10pt}{base}
  \toggletrue{apuntes@print}
  \toggletrue{apuntes@toc}
}

% include lists of contents
\DeclareOption{toc}{\toggletrue{apuntes@toc}}
\DeclareOption{clases}{\toggletrue{apuntes@clases}}
\DeclareOption{todo}{\toggletrue{apuntes@todo}}

% pass undeclared options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}

\ProcessOptions\relax
\LoadClass[twoside]{base}

% --------- package loading ---------
\RequirePackage{xstring}

% Custom packages
\RequirePackage[\iftoggle{apuntes@print}{bw}{}]{math-environments}
\RequirePackage[\iftoggle{apuntes@print}{invisible}{}]{fancy-dates}

\RequirePackage{varwidth}
\RequirePackage{calc}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
% \RequirePackage{needspace} % needspace for dynamic line breaking
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tikz-cd}

% todo notes
\RequirePackage[\iftoggle{apuntes@todo}{status=draft}{}]{fixme}
\newcommand{\todo}[2][]{\fxnote[nomargin,\ifblank{#1}{inline}{#1}]{#2}}

\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=\iftoggle{apuntes@print}{false}{true},
  citecolor=blue,
  linkcolor=blue
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={\@class \@title},
    pdfauthor={\@author},
    pdfsubject={Apuntes}
  }
}


\gdef\@author{}
\gdef\@class{}
\gdef\@profesor{}
\gdef\@emailprofesor{}
\gdef\@ayudante{}
\gdef\@emailayudante{}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\emailprofesor}[1]{\gdef\@emailprofesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}
\newcommand{\emailayudante}[1]{\gdef\@emailayudante{#1}}


\fancypagestyle{generalpagestyle}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{.5pt}
  \fancyhead[OR,EL]{\thepage}
  \fancyhead[ER]{\footnotesize \@class\ - \@title}
  \fancyhead[OL]{\footnotesize \@author}
}
\pagestyle{generalpagestyle}

\newcommand{\titleformat}[1]{\textbf{\Large{#1}}}
\newcommand{\siglaformat}[1]{\textbf{\scriptsize{#1}}}
\newcommand{\authorformat}[1]{\textsc{\normalsize{#1}}}
\newcommand{\dateformat}[1]{\small{#1}}
\renewcommand{\maketitle} {
  \thispagestyle{plain}
  \begin{center}
    \begin{tikzpicture}
      % Título y sigla
      \node at (0,0) (T) {\titleformat{\@title}};
      \draw let
      \p1 = ($(T.south) - (0,.1)$),
      \n1 = {-veclen(\p1)},
      \p2 = ($0.6*(T.east)$),
      \n2 = {veclen(\p2)}
      in
      [thick] (-\n2,\n1) -- (\n2,\n1) node (S) [midway, fill=white]{\siglaformat{\@class}};
    \end{tikzpicture}
    \par\vspace*{-.5ex}
    \authorformat{\@author}

    % Profesor y ayudante
    \IfStrEq{\@profesor\@ayudante}{}{}{
      \vspace*{1em}
      \begin{varwidth}{0.4\textwidth}
        \begin{flushright}
          \IfStrEq{\@profesor}{}{}{\textbf{Profesor:}}\par
          \IfStrEq{\@ayudante}{}{}{\textbf{Ayudante:}}\par
        \end{flushright}
      \end{varwidth}
      \begin{varwidth}{0.8\linewidth}
        \@profesor\IfStrEq{\@profesor}{}{}{\IfStrEq{\@emailprofesor}{}{}{~(\emph{\@emailprofesor})}}\par
        \@ayudante\IfStrEq{\@ayudante}{}{}{\IfStrEq{\@emailayudante}{}{}{~(\emph{\@emailayudante})}}\par
      \end{varwidth}
    }

    % Fecha
    \IfStrEq{\@date}{}{}{
      \vspace*{1em}
      \dateformat{\@date}
    }
  \end{center}

  % Lists of contents
  \iftoggle{apuntes@toc}{
    \vspace*{-1em}
    \tableofcontents
  }{}
  \iftoggle{apuntes@clases}{
    \newpage
    \listofclases
  }{}
  \iftoggle{apuntes@todo}{
    \newpage
    \listoffixmes
  }{}
  \newpage
}


% Lists
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% Commands
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
