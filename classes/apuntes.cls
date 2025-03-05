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
\LoadClass{base}

% --------- package loading ---------
\RequirePackage{xstring}

% Custom packages
\RequirePackage[\iftoggle{apuntes@print}{bw}{}]{math-environments}
\RequirePackage[\iftoggle{apuntes@print}{invisible}{}]{fancy-dates}

\RequirePackage{geometry}
\RequirePackage{varwidth}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}
\RequirePackage{calc}
\usetikzlibrary{calc}
\RequirePackage{tikz-cd}

% Figure magic
% \usepackage{graphicx,wrapfig,float,caption}
% \DeclareGraphicsExtensions{.pdf,.png,.jpg}

% todo notes
\RequirePackage[\iftoggle{apuntes@todo}{status=draft}{}]{fixme}
\newcommand{\todo}[2][]{\fxnote[nomargin,\ifblank{#1}{inline}{#1}]{#2}}

\RequirePackage{subfiles}

% Hyperref options
\hypersetup {
  pdfstartview=FitH,
  colorlinks=\iftoggle{apuntes@print}{false}{true},
  citecolor=blue,
  linkcolor=blue,
  urlcolor=blue,
  anchorcolor=blue,
  citecolor=blue,
  filecolor=blue,
  linkcolor=blue,
  menucolor=blue,
  linktocpage=true,
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={\@class \@title},
    pdfauthor={\@author},
    pdfsubject={Apuntes}
  }
}

\geometry{
  % margin=1in,
  paper=\base@pagesize,
  marginparsep=.02\paperwidth,
  marginparwidth=.2\paperwidth,
  inner=.11\paperwidth,
  voffset=-1in,
  headheight=.02\paperheight,
  headsep=.03\paperheight,
  footskip=20pt,
  textheight=.795\paperheight,
  textwidth=.62\paperwidth
}

% Class parameters
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

% -------------------------------- Page style ---------------------------------
% \fancypagestyle{generalpagestyle}{
%   \fancyhf{}
%   \renewcommand{\headrulewidth}{.5pt}
%   \fancyhead[OR,EL]{\thepage}
%   \fancyhead[ER]{\footnotesize \@class\ - \@title}
%   \fancyhead[OL]{\footnotesize \@author}
% }
% \pagestyle{generalpagestyle}

\newlength{\myoddoffset}
\setlength{\myoddoffset}{\marginparwidth + \marginparsep}
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
\renewcommand{\subsectionmark}[1]{\markright{#1}{}}

% General page style
\fancypagestyle{fancynotes}{
  \fancyhf{}
  \fancyheadoffset[rh]{\myoddoffset}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[L]{\textsc{\leftmark}}
  \fancyhead[R]{\footnotesize \textit{\rightmark} \thepage}
}

% Page style for part pages
\fancypagestyle{fancypart}{
  \fancyhf{}
  \fancyfootoffset[rh]{\myoddoffset}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[L]{\footnotesize \thepage}
}

% Page layout
% FIXME: Revisar todas estas cosas
\renewcommand{\baselinestretch}{1.0}\normalsize
\setlength\lineskip{1\p@}
\setlength\parindent{1.2\parindent}
\setlength\normallineskip{1\p@}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\widowpenalty 1000
\clubpenalty 1000

\setcounter{topnumber}{4}
\renewcommand\topfraction{1}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.6}
\setcounter{totalnumber}{5}
\renewcommand\textfraction{0}
\renewcommand\floatpagefraction{1}
\addtolength\textheight{\topskip}

\marginparpush 6\p@
\topmargin   .05\paperheight

\setlength\arraycolsep{2\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

% No dots in the table of contents
\renewcommand{\@dotsep}{10000}

% Footer and header of the body
% the command ``\pagestyle{myplain}'' must be inserted
% just after ``\begin{document}''

% FIXME:
\newcommand\ps@myplain{
\pagenumbering{arabic}
\renewcommand\@oddfoot{\hfill-- \thepage\ --\hfill}
\renewcommand\@oddhead{}}
\let\ps@plain=\ps@myplain

% no header or footer in the title page
\newcommand\ps@titlepage{\renewcommand\@oddfoot{}\renewcommand\@oddhead{}}

% ----------------------------- Title page format ------------------------------
\newcommand{\titleformat}[1]{\textbf{\Large{#1}}}
\newcommand{\siglaformat}[1]{\textbf{\scriptsize{#1}}}
\newcommand{\authorformat}[1]{\textsc{\normalsize{#1}}}
\newcommand{\dateformat}[1]{\small{#1}}

\renewcommand{\maketitle} {
  \pagestyle{empty}
  \thispagestyle{titlepage}
  \newgeometry{
    marginparwidth=0pt,
    marginparsep=0pt,
    textwidth=.8\paperwidth,
    hoffset=0in,
    voffset=0in
  }
  \setcounter{page}{0}
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
        [thick] (-\n2,\n1) -- (\n2,\n1) node (S) [midway, fill=white] {\siglaformat{\@class}};
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

  \newpage
  \pagestyle{myplain}
  \pagenumbering{roman}
  % Lists of contents
  \iftoggle{apuntes@toc}{
    % \vspace*{-1em}
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
  \setcounter{footnote}{0}
  \restoregeometry
  \pagestyle{myplain}
  % \pagenumbering{arabic}

  % \newpage
  \pagestyle{fancynotes}
}


% Lists
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% Commands
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
