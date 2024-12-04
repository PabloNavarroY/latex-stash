\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{base}[2024/01/01 Clase base]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\def\base@ptsize{12pt}
\def\base@pagesize{letterpaper}
\def\base@font{Libertinus}

% font size (default: 12pt)
\DeclareOption{10pt}{\def\base@ptsize{10pt}}
\DeclareOption{11pt}{\def\base@ptsize{11pt}}
\DeclareOption{12pt}{\def\base@ptsize{12pt}}

% font (default: lmodern)
\DeclareOption{lmodern}{\def\base@font{LatinModern}}
\DeclareOption{charter}{\def\base@font{CharterBT}}
\DeclareOption{libertinus}{\def\base@font{Libertinus}}
\DeclareOption{cmbright}{\def\base@font{ComputerModernBright}}

% page size (default: letterpaper)
\DeclareOption{letterpaper}{\def\base@pagesize{letterpaper}}
\DeclareOption{legalpaper}{\def\base@pagesize{legalpaper}}

% pass undeclared options to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass[\base@ptsize]{article}


% --------- package loading ---------
\RequirePackage{xstring}

\RequirePackage[spanish]{babel}

% Font
\IfStrEqCase{\base@font}{
  {LatinModern}{
    \RequirePackage{lmodern}
    \RequirePackage[T1]{fontenc}
  }
  {Libertinus}{
    \RequirePackage{libertinus}
    \RequirePackage{libertinust1math}
    \RequirePackage[T1]{fontenc}
  }
  {CharterBT}{
    \RequirePackage[bitstream-charter]{mathdesign}
    \RequirePackage[T1]{fontenc}
  }
  {ComputerModernBright}{
    \RequirePackage{cmbright}
    \RequirePackage[OT1]{fontenc}
  }
}

\RequirePackage[
  margin=2cm,
  tmargin=2.5cm,
  headheight=15pt,
  paper=\base@pagesize,
]{geometry}
