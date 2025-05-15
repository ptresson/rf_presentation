\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{irdbeamer}[IRD Beamer Presentation Template]
\LoadClass[aspectratio = 169]{beamer}
\usetheme{metropolis}

% Metropolis global options
% See: http://www.tug.org/texlive//devsrc/Master/texmf-dist/doc/latex/beamertheme-metropolis/metropolistheme.pdf
\metroset{sectionpage = progressbar}
\metroset{subsectionpage = progressbar}
% \metroset{progressbar = frametitle}
\metroset{progressbar = head}
\metroset{numbering = fraction}
\metroset{block = fill}

% Progress bar thickness
\setlength{\metropolis@titleseparator@linewidth}{2pt}
\setlength{\metropolis@progressonsectionpage@linewidth}{2pt}
\setlength{\metropolis@progressinheadfoot@linewidth}{2pt}


% Colorado School of Mines colors
\definecolor{silver}{RGB}{127, 127, 132}
% \definecolor{silver}{RGB}{200, 127, 132}
\definecolor{blue}{RGB}{0, 82, 155}
% \definecolor{darkblue}{RGB}{0, 51, 102}
\definecolor{darkblue}{RGB}{25, 43, 102}
\definecolor{white}{RGB}{255, 255, 255}
\definecolor{irdred}{RGB}{194, 14, 26}
\definecolor{irdblue}{RGB}{69, 112, 180}
\setbeamercolor{normal text}{fg = darkblue, bg = white}
\setbeamercolor{frametitle}{fg = darkblue, bg = white}
% \setbeamercolor{footer}{fg = white, bg = darkblue}
\setbeamercolor{titlefooter}{bg = white, fg = darkblue}
% \setbeamercolor{footer}{fg = darkblue, bg = white}
\setbeamercolor{footer}{fg = darkblue, bg = white}
% \setbeamercolor{alerted text}{fg = silver, bg = blue}
\setbeamercolor{alerted text}{fg = irdred, bg = blue}
\setbeamercolor{example text}{fg = blue, bg = white}

% Presentation mode
\RequirePackage{pgfpages}
\setbeamertemplate{note page}[plain]
% \setbeameroption{show notes on second screen = right}

% Replace enumerate from \note[item] with itemize
\def\beamer@setupnote{%
    \gdef\beamer@notesactions{%
        \beamer@outsideframenote{%
            \beamer@atbeginnote%
            \beamer@notes%
            \ifx\beamer@noteitems\@empty\else
                \begin{itemize}\itemsep=0pt\parskip=0pt%
                    \beamer@noteitems%
                \end{itemize}%
            \fi%
            \beamer@atendnote%
        }%
        \gdef\beamer@notesactions{}%
    }
}

% TiZ
\usetikzlibrary{tikzmark}
\usetikzlibrary{shapes, arrows, calc}
\tikzstyle{block} = [rectangle, draw, text width = 40mm, text centered, rounded corners, minimum height = 1.5\baselineskip]
\tikzstyle{line} = [draw, -latex']  

% Position blocks anywhere
\RequirePackage[absolute, overlay]{textpos}
\setlength{\TPHorizModule}{\paperwidth}
\setlength{\TPVertModule}{\paperheight}

% Custom blocks
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
\newtcolorbox{cublock}[1][Title]{
    enhanced,
    colback = white,
    colbacktitle = darkblue,
    coltitle = white,
    colframe = darkblue!30,
    boxrule = 1pt,
    titlerule = 0pt,
    arc = 5pt,
    title = {\strut#1},
    fonttitle = \bfseries,
    % fuzzy shadow = {0pt}{-2pt}{0pt}{0.4pt}{black}
}

% Units typesetting
% \RequirePackage[binary-units=true]{siunitx}
\RequirePackage[]{siunitx}
\sisetup{per-mode=symbol} % fractioned units
\sisetup{range-phrase=\,--\,} % range dash
\sisetup{range-units=single} % range units

% Math
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{nicefrac}
\RequirePackage{bm}

% Tables
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{adjustbox}
\RequirePackage{longtable}
\RequirePackage{ltablex}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{threeparttable}
\RequirePackage{colortbl}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Normal quotes
\RequirePackage{csquotes}
\MakeOuterQuote{"}

% More symbols
\RequirePackage{pifont}

% Captions
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup{labelformat = empty, skip = 10pt, justification = centering}
\captionsetup[subfigure]{labelformat = empty, skip = 10pt, justification = centering}

% Numbered ToC
\setbeamertemplate{section in toc}[sections numbered]
% \setbeamertemplate{subsection in toc}[subsections numbered]

% Extra slides as "appendix"
\RequirePackage{appendixnumberbeamer}
\renewcommand{\appendixname}{\texorpdfstring{\translate{Appendix}}{Appendix}}

% Define a command to store logos
\newcommand{\logos}{}

% Define a command to add logos
\newcommand{\addlogo}[1]{%
\protected@edef\logos{\logos \includegraphics[height=0.6cm]{#1}\hspace{1em}}%
}

\setbeamertemplate{footnote}{
  \parindent 1em\noindent%
  \raggedright
  \insertfootnotetext\par%
}

\newcommand{\nonumbernote}[1]{%
  \footnotetext[42]{#1}%
}

\renewcommand\footnoterule{}

% The opposite of '\uncover'
\def\beamer@startmycovered{%
  \def\opaqueness<##1>##2{%
    \only<##1>{%
      \beamer@actions{%
        \expandafter\xdef\csname beamer@oldcolorhook%
        \the\beamer@coveringdepth\endcsname{\beamer@colorhook}%
        \expandafter\xdef\csname beamer@oldpgfextension%
        \the\beamer@coveringdepth\endcsname{\beamer@pgfextension}%
        {\globalcolorstrue\colorlet{beamer@freeze\the\beamer@coveringdepth}{bg}}%
        \xdef\beamer@colorhook{!##2!beamer@freeze%
          \the\beamer@coveringdepth\beamer@colorhook}%
        \gdef\beamer@pgfextension{!##2opaque}%
        \color{.}%
      }%
      {%
        \xdef\beamer@colorhook{\csname beamer@oldcolorhook%
          \the\beamer@coveringdepth\endcsname}%
        \xdef\beamer@pgfextension{\csname beamer@oldpgfextension%
          \the\beamer@coveringdepth\endcsname}%
        \color{.}%
      }}}%
  \ifnum\beamer@slideinframe<\beamer@minimum%ok, at beginning
  {%
    \beamer@saveanother%
    \advance\beamer@minimum by-\beamer@slideinframe%
    \beamer@slideinframe=\beamer@minimum%
    \beamer@uncoverbeforeactions%
    \beamer@restoreanother%
  }%
  \else%
  {%
    \beamer@saveanother%
    \advance\beamer@slideinframe by-\beamer@minimum%
    \beamer@uncoverafteractions%
    \beamer@restoreanother%
  }%
  \fi%
  \beamer@do%
}
\long\def\beamer@makemycovered#1{\beamer@startmycovered#1\beamer@endcovered}
\def\cover{%
\alt{\beamer@makemycovered}{\beamer@fakeinvisible}}
\def\c@slideinframe{\beamer@slideinframe}

% Footer
\setbeamertemplate{footline}{%
    \begin{beamercolorbox}[wd = \textwidth, ht = .8cm, sep = 0.2cm]{footer}
        \includegraphics[height = 0.3cm]{logos/IRD.png}
        \quad
        \includegraphics[height = 0.3cm]{logos/AMAP-logo-only.png}
        \hfill
        \raisebox{0.22cm}{
            % \insertshortauthor
            % \quad
            % %|
            % \quad
            % \insertsubtitle
            % \quad
            % %|
            % \quad
            % %\insertsection
            % \quad
            %\textbullet
            %\quad
            \usebeamertemplate{frame numbering}
        }
        \hfill
    \end{beamercolorbox}%
}

% Keep footer in appendix
\AtBeginDocument{%
    \apptocmd{\appendix}{%
        \setbeamertemplate{footline}{%
        \begin{beamercolorbox}[wd = \textwidth, ht = .8cm, sep = 0.2cm]{footer}
            \includegraphics[height = 0.4cm]{logos/IRD.png}
            \quad
            \includegraphics[height = 0.4cm]{logos/AMAP-logo-only.png}
            \hfill
            % \includegraphics[height = 0.6cm]{logos/aems.pdf}
        \end{beamercolorbox}%
    }
    }{}{}
}

% % Use full section name in section pages
% \setbeamertemplate{section page}{
%     \centering
%     \begin{minipage}{22em}
%         \raggedright
%         \usebeamercolor[fg]{section title}
%         \usebeamerfont{section title}
%         \insertsection\\[-1ex]
%         \usebeamertemplate*{progress bar in section page}
%         \par
%         \ifx\insertsubsection\@empty\else%
%             \usebeamercolor[fg]{subsection title}%
%             \usebeamerfont{subsection title}%
%             \insertsubsection
%         \fi
%   \end{minipage}
%   \par
%   \vspace{\baselineskip}
% }

% Add footer to section pages
\AtBeginSection{
    {
        \setbeamertemplate{footline}{
            \begin{beamercolorbox}[wd = \textwidth, ht = .8cm, sep = 0.2cm]{footer}
                \includegraphics[height = 0.4cm]{logos/IRD.png}
                \quad
                \includegraphics[height = 0.4cm]{logos/AMAP-logo-only.png}
           % \begin{beamercolorbox}[wd = \textwidth, ht = 1cm, sep = 0.2cm]{footer}
           %      \includegraphics[height = 0.6cm]{logos/mines_banner.jpg}
                % \hfill
                % \raisebox{0.22cm}{
                %     \insertshortauthor
                %     \quad
                %     %|
                %     \quad
                %     \insertshortsubtitle
                % }
                \hfill
                % \includegraphics[height = 0.6cm]{logos/aems.pdf}
            \end{beamercolorbox}%
        }
        \frame{
            \sectionpage
        }
        \addtocounter{framenumber}{-1}
    }
}

% Add footer to subsection pages
\AtBeginSubsection{
    {
        \setbeamertemplate{footline}{
           \begin{beamercolorbox}[wd = \textwidth, ht = .8cm, sep = 0.2cm]{footer}
                \includegraphics[height = 0.4cm]{logos/IRD.png}
                \hfill
                % \includegraphics[height = 0.6cm]{logos/aems.pdf}
            \end{beamercolorbox}%
        }
        \frame{
            \sectionpage
        }
        \addtocounter{framenumber}{-1}
    }
}

% If one wants to modify the title page... here's the default code
\setbeamertemplate{title page}{%
    \begin{minipage}[b][\paperheight]{\textwidth}%
        \ifx\inserttitlegraphic\@empty\else\usebeamertemplate*{title graphic}\fi%
        \vfill%
        \ifx\inserttitle\@empty\else\usebeamertemplate*{title}\fi%
        \ifx\insertsubtitle\@empty\else\usebeamertemplate*{subtitle}\fi%
        \usebeamertemplate*{title separator}%
        \ifx\beamer@shortauthor\@empty\else\usebeamertemplate*{author}\fi%
        \ifx\insertdate\@empty\else\usebeamertemplate*{date}\fi%
        \ifx\insertinstitute\@empty\else\usebeamertemplate*{institute}\fi%
        \vfill%
        \vspace*{1mm}%
    \end{minipage}%
}

% Add footer to title page
\newcommand*{\copyrightnotice}[1]{\def\@copyrightnotice{#1}}
\renewcommand{\maketitle}[1][\item Welcome, everyone!]{
    \begingroup
        \setbeamercolor{normal text}{fg = white, bg = darkblue}
        \setbeamertemplate{footline}{
            \begin{beamercolorbox}[wd = \textwidth, ht = 1cm, sep = 0.2cm]{titlefooter}
            \tikz[baseline,overlay]{\draw[irdred,ultra thick] (-.2,.8cm) -- (\textwidth,.8cm);}
                % \includegraphics[height = 0.6cm]{logos/IRD_banner.png}
                % \quad
                % \quad
                % \includegraphics[height = 0.6cm]{logos/AMAP_banner.png}
                \logos
                % \includegraphics[height = 0.6cm]{logos/IRD_banner.png}
                % \quad
                % \quad
                % \includegraphics[height = 0.6cm]{logos/AMAP_banner.png}
                \hfill
                \ifdefined\@copyrightnotice
                    \raisebox{0.22cm}{
                        \begin{minipage}{0.65\paperwidth}
                            \begin{flushright}
                                Copyright~\copyright~by \insertshortauthor, \insertshortinstitute
                                \ifx\@copyrightnotice\@empty
                                \else
                                    \\
                                    \@copyrightnotice
                                \fi
                            \end{flushright}
                        \end{minipage}
                    }
                \fi
                % \includegraphics[height = 0.8cm]{logos/aems.pdf}
            \end{beamercolorbox}
        }
        \begin{frame}
            \usebeamertemplate{title page}
            \vspace*{-50pt}
        \end{frame}
        \note[itemize]{#1}
        \addtocounter{framenumber}{-1}
    \endgroup
}

% Table of Contents with "Outline" section name
\newcommand{\cutoc}{
    {
        \metroset{sectionpage = none}
        \section*{Outline}
    
        \begin{frame}{Outline}
            \tableofcontents[hideallsubsections]
        \end{frame}
    }
}

% Avoid overfull \vbox warnings
\vfuzz = 20pt
