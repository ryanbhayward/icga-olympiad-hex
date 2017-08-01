% Class icga
% Article style for the Journal of the International Computer game Association
% Derived from article.cls
% Jeroen Donkers, Floris Wiesman (November 2004)
% -----------------------------------------
% if no BibTex is used then
% use option [NoBibtex] in combination with /cite.
% ---------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{icga}[2004/11/08]
\typeout{ICGA Article class - derived from article  08/11/2004}
% -----------------------
\LoadClass[10pt]{article}
% -----------------------
\RequirePackage{ifthen} \RequirePackage{times}
\RequirePackage{float}
% adapted to newest version of geometry.sty (v3.2):
\RequirePackage{fancyhdr}
\RequirePackage[a4paper,top=1.8cm,bottom=2.54cm,outer=3.0cm,textwidth=6in,twoside,includefoot,includehead,nofoot]{geometry}
%------------------------
\newif\if@bibtex
\@bibtextrue
\DeclareOption{NoBibtex}{\@bibtexfalse}
\ProcessOptions
% -----------------------
\global\let\@affiliation\@empty%
\global\let\affiliation\relax%
\def\affiliation#1{\global\def\@affiliation{#1}}%
% -----------------------
\global\let\@issue\@empty%
\global\let\issue\relax%
\def\issue#1{\global\def\@issue{#1}}%
% -----------------------
\global\let\@runningtitle\@empty%
\global\let\runningtitle\relax%
\def\runningtitle#1{\global\def\@runningtitle{#1}}%
% -----------------------
\renewcommand\maketitle{\par
  \begingroup
%    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
%    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
%    \long\def\@makefntext##1{\parindent 1em\noindent
%            \hb@xt@1.8em{%
%                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \thispagestyle{plain}\@thanks
  \endgroup
%  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\large\bfseries \uppercase{\@title} \par}%
    \vskip 1.5em%
    { \lineskip .5em%
      \itshape
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1em%
      \@affiliation%
  \end{center}%
  \par
  \vskip 2em}
% -----------------------
\renewcommand\refname{REFERENCES}
\renewcommand\abstractname{ABSTRACT}
\renewenvironment{abstract}{%
  \begin{center}%
  {\abstractname\vspace{\z@}}%
  \end{center} \quotation \parskip .7em}%
  {\endquotation}%
\renewenvironment{quotation}
     {\list{}{\listparindent 0pt%
      \itemindent    \listparindent
      \rightmargin   \leftmargin
      \parsep        \z@ \@plus\p@}%
      \item\relax}
      {\endlist}
%------------------------
\renewcommand\appendix{
  \section{APPENDICES}
  \par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesectionhdr{APPENDIX \@Alph\c@section:}
  \gdef\thesubsectionhdr{APPENDIX \thesection.\arabic{subsection}:}
  \gdef\thesubsubsectionhdr{APPENDIX \thesubsection.\arabic{subsection}:}
  \gdef\thesection{\@Alph\c@section}
}

%------------------------
\renewcommand{\@seccntformat}[1]{\csname the#1hdr\endcsname\hspace{1em}}
\newcommand{\thesectionhdr}{\arabic{section}.}
\newcommand{\thesubsectionhdr}{\thesection.\arabic{subsection}}
\newcommand{\thesubsubsectionhdr}{\thesubsection.\arabic{subsubsection}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\normalsize\bfseries\uppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
% -----------------------
\renewcommand\@makecaption[2]{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\bfseries #1}: #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\bfseries #1}: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
% ------------------------
%\floatstyle{boxed}
%\restylefloat{table}
%\restylefloat{figure}
% -----------------------
\parskip .7em   % Extra vertical space between paragraphs.
\parindent 0pt  % Width of paragraph indentation.
\itemsep 0em    % Extra vertical space, in addition to
                % \parskip, added between list items.
\topsep 0pt %   Extra vertical space, in addition to
            % \parskip, added above and below list and
            % paragraphing environments.
\partopsep 0pt  % Extra vertical space, in addition to

% ------------------------
\pagestyle{fancyplain}
\renewcommand\headrulewidth{0pt}
\def\kopsize{\small}
\rhead[\kopsize \@issue]{\kopsize \thepage}
\lhead[\kopsize \thepage]{}
\chead[\kopsize ICGA Journal]{\kopsize \@runningtitle}
\cfoot[]{}
\issue{Submitted}
\runningtitle{}
%
%-----------------------
% Including ADAPTED umcite.sty here
%--------------------------
% umcite.tex based on rlcite and rlxcite
% Adds to LaTeX four macros to make it possible to cite as follows:
% \citec renders `Van den Bosch {\em et~al}. (1989)'
% \cited renders `(Van den Bosch {\em et~al}., 1989)'
% \citee renders `Van den Bosch {\em et~al}., 1989'
% \citef renders `(1989)'
% \citeg renders `1989'
% Last change: Oktober 2000 J. Donkers
\def\@namedef#1{\expandafter\def\csname #1\endcsname}

% Definition of a \harmsbibitem, arguments should be in this order:
% 1. full authors 2. The authors, 3. The year 4. The label 5. The text.
% E.g. \harmsbibitem{Knuth}{Knuth}{1901}{knuth01}{Knuth D. E. (1901). Text ...}
\def\harmsbibitem#1#2#3#4#5{\item\if@filesw
      \immediate\write\@auxout{\string\harmsbibcite{#4}{#2}{#3}{#1}
      }\fi\ignorespaces%
        #5}
% macro wrap
\def\icgabibitem#1#2#3#4#5{\harmsbibitem{#1}{#2}{#3}{#4}{#5}}
% macro for et-al in icgabibitem
\newcommand{\etal}{{\noexpand\em ~et~al.}}

% 1. label 2. The authors, 3. The year 4. Full authors.
\def\harmsbibcite#1#2#3#4{%
        \global\@namedef{c@#1}{\@harmsbiblabelc{\sellabel{#1}{#2}{#4}}{#3}}
        \global\@namedef{d@#1}{\@harmsbiblabeld{\sellabel{#1}{#2}{#4}}{#3}}
        \global\@namedef{e@#1}{\@harmsbiblabele{\sellabel{#1}{#2}{#4}}{#3}}
        \global\@namedef{f@#1}{\@harmsbiblabelf{#2}{#3}}
        \global\@namedef{g@#1}{\@harmsbiblabelg{#2}{#3}}
        \global\@namedef{first@#1}{TRUE}
        }
% this construction causes that the first appearance of a three-author citation
% shows all three authors, but the other appearances show 'et-al'.
\def\sellabel#1#2#3{\def\res{#2}%
\def\a{TRUE}\edef\b{\csname first@#1\endcsname}%
\ifx\a\b\def\res{#3}\fi\global\@namedef{first@#1}{false}%
\res}

% better names for the citations
\def\citeaby{\@ifnextchar [{\@tempswatrue\@harmscitexc}{\@tempswafalse\@harmscitexc[]}}
\def\citebay{\@ifnextchar [{\@tempswatrue\@harmscitexd}{\@tempswafalse\@harmscitexd[]}}
\def\citeay{\@ifnextchar [{\@tempswatrue\@harmscitexe}{\@tempswafalse\@harmscitexe[]}}
\def\citeby{\@ifnextchar [{\@tempswatrue\@harmscitexf}{\@tempswafalse\@harmscitexf[]}}
\def\citey{\@ifnextchar [{\@tempswatrue\@harmscitexg}{\@tempswafalse\@harmscitexg[]}}

\def\citec{\@ifnextchar [{\@tempswatrue\@harmscitexc}{\@tempswafalse\@harmscitexc[]}}
\def\cited{\@ifnextchar [{\@tempswatrue\@harmscitexd}{\@tempswafalse\@harmscitexd[]}}
\def\citee{\@ifnextchar [{\@tempswatrue\@harmscitexe}{\@tempswafalse\@harmscitexe[]}}
\def\citef{\@ifnextchar [{\@tempswatrue\@harmscitexf}{\@tempswafalse\@harmscitexf[]}}
\def\citeg{\@ifnextchar [{\@tempswatrue\@harmscitexg}{\@tempswafalse\@harmscitexg[]}}

\def\@harmscitexc[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@harmscitec{\@for\@citeb:=#2\do
    {\@citea\def\@citea{,\penalty\@m\ }\@ifundefined
       {c@\@citeb}{{\bf Undefined reference}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
{\csname c@\@citeb\endcsname}}}{#1}}

\def\@harmscitexd[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@harmscited{\@for\@citeb:=#2\do
    {\@citea\def\@citea{;\penalty\@m\ }\@ifundefined
       {d@\@citeb}{{\bf Undefined reference}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
{\csname d@\@citeb\endcsname}}}{#1}}

\def\@harmscitexe[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@harmscitee{\@for\@citeb:=#2\do
    {\@citea\def\@citea{;\penalty\@m\ }\@ifundefined
       {e@\@citeb}{{\bf Undefined reference}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
{\csname e@\@citeb\endcsname}}}{#1}}

\def\@harmscitexf[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@harmscitef{\@for\@citeb:=#2\do
    {\@citea\def\@citea{;\penalty\@m\ }\@ifundefined
       {f@\@citeb}{{\bf Undefined reference}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
{\csname f@\@citeb\endcsname}}}{#1}}

\def\@harmscitexg[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@harmsciteg{\@for\@citeb:=#2\do
    {\@citea\def\@citea{;\penalty\@m\ }\@ifundefined
       {g@\@citeb}{{\bf Undefined reference}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
{\csname g@\@citeb\endcsname}}}{#1}}

% improved the handling of brackets in multiple citations.
\def\@harmscitec#1#2{{#1\if@tempswa , #2\fi}}
\def\@harmscited#1#2{({#1\if@tempswa , #2\fi})}
\def\@harmscitee#1#2{{#1\if@tempswa , #2\fi}}
\def\@harmscitef#1#2{({#1\if@tempswa #2\fi})}
\def\@harmsciteg#1#2{{#1\if@tempswa #2\fi}}

\def\@harmsbiblabelc#1#2{#1\ (#2)}
\def\@harmsbiblabeld#1#2{#1, #2}
\def\@harmsbiblabele#1#2{#1, #2}
\def\@harmsbiblabelf#1#2{#2}
\def\@harmsbiblabelg#1#2{#2}

\def\url#1{%
\hyphenchar\font=47
#1%
\hyphenchar\font=45
}

\if@bibtex
\renewcommand{\@biblabel}[1]{}% empty label
\renewenvironment{thebibliography}[1]
     {\section{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{}%
           {\settowidth\labelwidth{0}%
            \@openbib@code
            \leftmargin 0pt
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\else
\renewenvironment{thebibliography}[1]
     {\section{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\fi
%------------------------------
%------ end of umcite style
%------------------------------
\bibliographystyle{icgacite}
