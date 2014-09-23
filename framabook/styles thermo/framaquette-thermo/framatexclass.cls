% Classe FramateX inspiré très fortement par la framaquette
% de Vincent Lozano & de Didier Roche, retravaillé par
% David Dauvergne (la Poule ou l'Œuf),  puis par Christophe
% Masutti (Framasoft), ré-organisé par Olivier Cleynen

% Dernière modification le 2014-09-05


% =================================================================================================
% MÉTA (déclarations, pré-requis)
% =================================================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{framatexclass}[2008/11/06]


%-----------------------------------------------------------------------
% Code conditionnel: version en ligne = pdf avec liens couleur; sinon version "papier"

\newif\ifversionenligne
\versionenlignetrue

\newif\ifminisommaire
\minisommairetrue

\newif\if@versionreport \@versionreportfalse


%-----------------------------------------------------------------------
% Déclaration des options de la classe

\DeclareOption{draft}{\brouillontrue\PassOptionsToClass{draft}{book}}
\DeclareOption{versionpapier}{\versionenlignefalse} 
\DeclareOption{versionenligne}{\versionenlignetrue}
\DeclareOption{sansminisommaire}{\minisommairefalse}
\DeclareOption{versionreport}{\@versionreporttrue}

\if@versionreport
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\else
\DeclareOption*{\PassOptionsToClass{mer\CurrentOption}{book}}
\fi

% Exécution des options

\ProcessOptions
\if@versionreport
\LoadClass[a4paper]{report}
\else
\LoadClass[a4paper,twoside,12pt]{book}
\fi


%-----------------------------------------------------------------------
% There be UTF8 - encodage d’entrée

\RequirePackage[utf8]{inputenc}


%-----------------------------------------------------------------------
% Outils logiques et de formatage utilisés plus bas

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{float}
\RequirePackage{framed}


%-----------------------------------------------------------------------
% Compatibilité avec les imprimeurs
% PDF 1.3 (en particulier pour éviter les calques produits avec pdf 1.4)
% À compiler avec pdflatex

\pdfminorversion=3


% =================================================================================================
% Dimensions générales
% =================================================================================================

\usepackage{geometry}
\geometry{paperwidth=148mm,paperheight=210mm,twoside,inner=25mm,outer=20mm,top=20mm,bottom=20mm}



% =================================================================================================
% Corps du livre (texte, polices, paragraphes)
% =================================================================================================


%-----------------------------------------------------------------------
% Langage (gestion du français, compatibilité avec french, raccourcis)

\usepackage[greek, frenchb]{babel} % Grec pour pouvoir impressionner les gens avec \textgreek{ἐνέργεια}
\selectlanguage{francais}
\frenchspacing

\let\Numero\No
\let\numero\no
\ifx\undefined\up
\let\up\fup
\fi

\newcommand{\pluspetqu}{<}
\newcommand{\plusgrtqu}{>}
\newcommand{\eperlu}{\&}
\newcommand{\diese}{\#}
\newcommand{\et}{&}


%----------------------------------------------------------------------
% Polices de caractères

\RequirePackage{textcomp,relsize}
\RequirePackage{mflogo,bbm,pifont}
%\RequirePackage{fouriernc}
\RequirePackage{times}
\RequirePackage{helvet}
\RequirePackage[LGRx,T1]{fontenc}  % LGRx so we can type smart-ass greek words with \textgreek{ἐνέργεια}
%\RequirePackage{xspace}	% Espaces
\RequirePackage{soul}		% Pour souligner

% Pour reconfigurer txttt dans le texte (police machine à écrire)
\renewcommand{\texttt}[1]{\begin{sffamily}{#1}\end{sffamily}}


%-----------------------------------------------------------------------
% Graphiques (images, imports, figures)

\RequirePackage{picins}		% figure dans un paragraphe
%\RequirePackage{subfigure}	% subfigure dans figure
\RequirePackage{wrapfig}
\RequirePackage{graphicx}
%\RequirePackage[labelsep=none]{caption} % Description des figures (légendes)

% Tableaux
\RequirePackage{array,multirow,colortbl,longtable,multicol}


%-----------------------------------------------------------------------
% Maths

\RequirePackage{amsmath,mathrsfs}


%-----------------------------------------------------------------------
% Paragraphes 

% réglages dits "continentaux" d’indentation début et de saut interparagraphe

\setlength{\parskip}{4pt plus 4pt minus 2pt}
\parindent 8pt

% Saut interligne
%\renewcommand{\baselinestretch}{1.2}  % mieux vaut uiliser le package setspace
\usepackage{setspace}           % Change l'interligne en épargnant les footnotes, captions, etc.
\setstretch{1.1}                % Attention, c'est presque de l'interligne double (??)

% Veuves et orphelines

\widowpenalty=10000 % empêche au maximum la coupure avant la dernière ligne
\clubpenalty=10000  % empêche au maximum la coupure après la première ligne
\raggedbottom       % empêche l'étirement des ressorts verticaux

% Lettrines

\usepackage{lettrine}

%-----------------------------------------------------------------------
% Couleurs
% Ces déclarations doivent être faites avant la définition des encarts
% et la définition de la coloration syntaxique Java

\RequirePackage{color}
\RequirePackage{xcolor}
\definecolor{fondgrisclair}{RGB}{232,232,232}


%-----------------------------------------------------------------------
% Hyperref, pour faire des liens (internes ou externes), 
% y compris en faisant des références
% Voir aussi déclarations en fin de ce document.

\usepackage{hyperref}
\hypersetup{colorlinks=true,
				citecolor=black,
				filecolor=black,
				linkcolor=black,
				urlcolor=black,
				bookmarks=false}


%-----------------------------------------------------------------------
% Encarts

\newlength{\marginencart}

	% Environnement encart fond gris

	\newenvironment{encart}{%
	 \def\FrameCommand{\fcolorbox{fondgrisclair}{fondgrisclair}} %première couleur = cadre, la seconde = fond
	 \setlength{\fboxrule}{10pt}	% épaisseur du cadre
	 \setlength{\fboxsep}{0pt}		%distance du texte par rapport au cadre
	 \MakeFramed{\setlength{\hsize}{\textwidth-0.8pt-20pt-2\marginencart} \FrameRestore}}%
	{\endMakeFramed}

	% Titre de l'encart gris
	\newcommand{\titrencartgris}[1]
	{\noindent{{\textbf{#1}}}}

	% Encarts avec icones
	\newcommand{\titrencart}[1]
	{\indent{{\textsc{#1}}}}

	\newenvironment{leftbarencart}{%
	  \def\FrameCommand{\color{black}\vrule width 0.8pt \hspace{10pt}}%
	  \setlength{\marginencart}{25pt}
	  \MakeFramed {\setlength{\hsize}{\dimexpr\textwidth-0.8pt-10pt-2\marginencart} \FrameRestore}}%
	 {\endMakeFramed}
	 
	% création d'une image pour le premier paragraphe d'un encart
	% L'image se choisit au moment de créer l'encart dans le texte
	% (voir dans le dossier /images)
	\newlength{\padnota}
	\newlength{\larnota}
	\newlength{\indnota}
	\newlength{\largligne}

	\newcommand{\encarticone}[1]{
	\setlength{\padnota}{5pt}
	\setlength{\larnota}{10mm}
	\setlength{\indnota}{-10pt}
	\setlength{\largligne}{\textwidth-\indnota}
	\parshape=2
	\indnota\largligne
	0pt\textwidth\noindent%
	\raisebox{-\larnota+3mm}[0pt][0pt]{%
	  \makebox[0pt][r]{%
	  \includegraphics[width=8mm,height=8mm]{images/encarts/#1}%
	  \hspace*{\padnota}}}%
	}

	% figure dans l'encart
	\newlength{\enccaptionbottomskip}
	\newlength{\enccaptiontopskip}
	\newlength{\encfigtopskip}
	\setlength{\enccaptionbottomskip}{12pt}
	\setlength{\enccaptiontopskip}{5pt}
	\setlength{\encfigtopskip}{15pt}

	\newenvironment{encfig}{%
	  \refstepcounter{figure}%
	  \vskip\encfigtopskip%
	  }%
	{%
	  }

	\newcommand{\enccaptionfig}[1]{%
	  \\[\enccaptiontopskip]%
	  \figurename~\thefigure{} \CaptionSeparator #1\\[\enccaptionbottomskip]}

	\newenvironment{enctab}{%
	  \refstepcounter{table}%
	  \vskip\encfigtopskip%
	  }%
	{%
	  }
	  
	% table dans l'encart
	\newcommand{\enccaptiontab}[1]{%
	  \\[\enccaptiontopskip]%
	  \tablename~\thetable{} \CaptionSeparator #1\\[\enccaptionbottomskip]}



%-----------------------------------------------------------------------
% Pour insérer du code

\usepackage{verbatim}
\usepackage{listings}

% Configuration du package listing pour la coloration syntaxique java

\definecolor{javared}{rgb}{0.6,0,0} % for strings
\definecolor{javagreen}{rgb}{0.25,0.5,0.35} % comments
\definecolor{javapurple}{rgb}{0.5,0,0.35} % keywords
\definecolor{javadocblue}{rgb}{0.25,0.35,0.75} % javadoc

\lstset{language=Java,
	basicstyle=\sffamily\footnotesize,
	keywordstyle=\color{javapurple}\bfseries,
	stringstyle=\color{javared},
	commentstyle=\color{javagreen},
	morecomment=[s][\color{javadocblue}]{/**}{*/},
	xleftmargin=20pt,
	xrightmargin=20pt,
	numbers=left,
	numberstyle=\tiny\color{black}, %Numeros de ligne
	stepnumber=1, % le pas des numeros de ligne
	numbersep=10pt,
	breaklines=true,
	tabsize=4,
	%frame=single,
	showspaces=false,
	showstringspaces=false
	inputencoding=utf8, % utf8 dans listing
	extendedchars=true, % utf8 dans listing
	literate={à}{{\`a}}1 {é}{{\'e}}1 {è}{{\`e}}1 {ê}{{\^e}}1 {â}{{\^a}}1 {î}{{\^i}}1 {ê}{{\^e}}1 {É}{{\'E}}1 {À}{{\`A}}1 {«}{{\og}}1 {»}{{\fg{}}}1 {ô}{{\^o}}1 {ù}{{\`u}}1 {û}{{\^u}}1 {ç}{{\c{c}}}1 {Ç}{{\c{C}}}1, %put1 d'utf8 dans listing
}


%---------------------------------------------------------------------
% Pour changer les marges localement (merci Marie Paul ;-)

\newenvironment{changemargin}[2]{\begin{list}{}{%
\setlength{\leftmargin}{0pt}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\addtolength{\leftmargin}{#1}%
\addtolength{\rightmargin}{#2}%
}\item }{\end{list}}

\newenvironment{agrandirmarges}[2]{%
  \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{0pt plus 1pt}%
      \checkoddpage%
      \ifcpoddpage
        \setlength{\leftmargin}{-#1}\setlength{\rightmargin}{-#2}
      \else
        \setlength{\leftmargin}{-#2}\setlength{\rightmargin}{-#1}
      \fi}\item }%
  {\end{list}}


%-----------------------------------------------------------------------
% Citations

\RequirePackage{csquotes}

\renewenvironment{quotation}{\begin{list}{}{%
\itshape
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{0pt}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{0pt plus 1pt}%
\addtolength{\leftmargin}{1.2cm}%
\addtolength{\rightmargin}{1.2cm}%
}\item }{\end{list}}


%-----------------------------------------------------------------------
% listes

\RequirePackage{enumerate}
\renewenvironment{itemize}{\setlength{\parskip}{0pt}}{\endlist}


% =================================================================================================
% Éléments autour du corps (index, tables des matières, appendices, méta-trucs etc.)
% =================================================================================================


%-----------------------------------------------------------------------
% Table des figures

\renewcommand{\listoffigures}[1]{%
	\setlength{\parskip}{0pt plus 1.0pt}%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
      \chapter*{#1
      	\@mkboth{#1}{#1}}%suppression de uppercase
    \@starttoc{lof}%
    \if@restonecol%
        \twocolumn%
    \fi%
    \setlength{\parskip}{4pt plus 4pt minus 2pt}%
}


%-----------------------------------------------------------------------
% liste des tableaux 

\renewcommand{\listoftables}[1]{%
	\setlength{\parskip}{0pt plus 1.0pt}%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
      \chapter*{#1
      	\@mkboth{#1}{#1}}%suppression de uppercase
    \@starttoc{lot}%
    \if@restonecol%
        \twocolumn%
    \fi%
    \setlength{\parskip}{4pt plus 4pt minus 2pt}%
}


%-----------------------------------------------------------------------
% Table des matières

\renewcommand{\tableofcontents}[1]{\footnotesize%
  \setcounter{tocdepth}{2}
  \setlength{\parskip}{1.0pt plus 2.0pt}
  \if@twocolumn
  \@restonecoltrue\onecolumn
  \else
  \@restonecolfalse
  \fi
  \chapter*{#1
    \@mkboth{#1}{#1}}%suppression de uppercase
  \@starttoc{toc}%
  \if@restonecol%
  \twocolumn%
  \fi%
  \setlength{\parskip}{4pt plus 4pt minus 2pt}
}


%-----------------------------------------------------------------------
% Index

% la création de l'index se fait sans makeindex 
% mais en utilisant le package makeidx

\RequirePackage{makeidx,index}


\makeatletter
\renewenvironment{theindex}
               {\columnseprule \z@
                \columnsep 35\p@
                \begin{multicols}{2}%
                \parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem
                \footnotesize
                \raggedright}
               {\end{multicols}}
\makeatother

% titre 4 et 5
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

\makeatletter
\newcounter{subsubsubsection}[subsubsection]
\renewcommand\thesubsubsubsection{\thesubsubsection .\@arabic\c@subsubsubsection}
\newcommand\subsubsubsection{\@startsection{subsubsubsection}{4}{\z@}%
                                     {-2.25ex\@plus -1ex \@minus -.2ex}
                                     {0.1ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand*\l@subsubsubsection{\@dottedtocline{4}{10.0em}{4.1em}}
\newcommand*{\subsubsubsectionmark}[1]{}

\newcounter{subsubsubsubsection}[subsubsubsection]
\renewcommand\thesubsubsubsection{\thesubsubsubsection .\@arabic\c@subsubsubsubsection}
\newcommand\subsubsubsubsection{\@startsection{subsubsubsubsection}{5}{\z@}%
                                   {-2.25ex\@plus -1ex \@minus -.2ex}
                                   {0.1ex \@plus .2ex}%
                                   {\normalfont\normalsize\bfseries}}

\newcommand*\l@subsubsubsubsection{\@dottedtocline{5}{10.0em}{4.1em}}
\newcommand*{\subsubsubsubsectionmark}[1]{}

\renewcommand\paragraph{\@startsection{paragraph}{6}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{7}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\renewcommand*\l@paragraph{\@dottedtocline{6}{10em}{5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{7}{12em}{6em}}
\def\toclevel@subsubsubsection{4}
\def\toclevel@subsubsubsection{5}
\def\toclevel@paragraph{6}
\def\toclevel@subparagraph{7}
\makeatother


%-----------------------------------------------------------------------
% Appendices + pour changer le nom des chapitres en annexes

\usepackage[toc,page]{appendix} 

\let\appendixORIG\appendix
\renewcommand{\appendix}{%
  \appendixORIG%
  \renewcommand{\chaptername}{\appendixname}%
}


%-----------------------------------------------------------------------
% Footnotes (notes de bas de page)

% Réinitialiser le compteur de notes de bas de page à chaque page
\RequirePackage[perpage]{footmisc} 


%-----------------------------------------------------------------------
% Épigraphe

\usepackage{epigraph}

% configuration des épigraphes
% épaisseur trait de séparation
\renewcommand{\epigraphrule}{0pt} 

% taille du texte de l'épigraphe
% \renewcommand{\epigraphsize}{\footnotesize}

% largeur de l'épigraphe
\setlength{\epigraphwidth}{.5\textwidth}


% =================================================================================================
% Titres, numérotation
% Entêtes, pieds de page
% =================================================================================================


% Ces incantations sont déplacées dans le package .sty suivant :

\usepackage{framatex_entete_titres}



% =================================================================================================
% Misc/Divers
% =================================================================================================

% Début du document. Doit-on vraiment mettre tous ces éléments là, d’ailleurs ?
\AtBeginDocument{%
	\sloppy % Ce sloppy sera actif jusq’uau \end{document}
	\renewcommand{\figurename}{F\textsc{igure} }
	\renewcommand{\tablename}{T\textsc{able} }

	\def\appendixpage{\vspace*{8cm}
	\begin{center}
	\Huge\textbf{Annexes}
	\end{center}
	}
	\def\appendixname{Annexe}

	\frontmatter	
}

% Fin du document
\AtEndDocument{}

% Nombre de poules
\newcommand{\pouleVersion}{0.1}

% hyperref qui pète les ouilles
\def\Hy@WarningNoLine#1{}
\def\Hy@Warning#1{}


% Mystérieuse définition de distance
\setlength{\doublerulesep}{\arrayrulewidth}


%-----------------------------------------------------------------------
% Fin de ce fichier

\endinput
