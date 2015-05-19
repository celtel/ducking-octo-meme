%
% fig2dev (version 3.2.5d) -L (m)mp version 0.05 --- Preamble
%

%
% mp output driver options:
%  -L mp
%

% +MP-ADDITIONAL-HEADER
verbatimtex
%&latex
\documentclass{article}
\begin{document}
etex
% -MP-ADDITIONAL-HEADER


%SetFigFont macros for latex
verbatimtex
%
\begingroup\makeatletter\ifx\SetFigFont\undefined%
\gdef\SetFigFont#1#2#3#4#5{%
  \reset@font\fontsize{#1}{#2pt}%
  \fontfamily{#3}\fontseries{#4}\fontshape{#5}%
  \selectfont}%
\fi\endgroup%
\ifx\SetFigFontSize\undefined%
\gdef\SetFigFontSize#1#2{%
  \fontsize{#1}{#2pt}%
  \selectfont}%
\fi%
etex

% Now draw the figure
beginfig(0)
% Some reasonable defaults
  labeloffset:=0;
  truecorners:=1;
  bboxmargin:=0;
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt port 1 etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((960.94,505.70))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (102.05, 500.03)
    --(184.25, 548.22);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (218.27,534.05)--(184.25,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (867.40, 553.89)
    --(887.24, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (320.31, 553.89)
    --(496.06, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (323.15, 542.55)
    --(399.69, 460.35);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (436.54, 460.35)
    --(496.06, 548.22);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (320.31,534.05)--(283.46,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (532.91,534.05)--(496.06,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (532.91, 553.89)
    --(552.76, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (436.54,443.34)--(399.69,474.52);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (654.80, 553.89)
    --(830.55, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (657.64, 542.55)
    --(734.17, 460.35);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (771.02, 460.35)
    --(830.55, 548.22);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (654.80,534.05)--(617.95,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (867.40,534.05)--(830.55,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (771.02,443.34)--(734.17,474.52);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (595.28, 553.89)
    --(615.12, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (989.29, 553.89)
    --(1165.04, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (992.13, 542.55)
    --(1068.66, 460.35);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (1105.51, 460.35)
    --(1165.04, 548.22);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (989.29,534.05)--(952.44,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (1201.89,534.05)--(1165.04,565.23);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=1;
  pickup pencircle scaled 0.94;
  path p,pb,sw,nw,ne,se;
  pair ll,ul,ur,lr;
  p = (1105.51,443.34)--(1068.66,474.52);
  ur = urcorner p; ll = llcorner p;
  ul = ulcorner p; lr = lrcorner p;
  sw = fullcircle scaled 13.23 shifted (ll+(6.61,6.61));
  nw = fullcircle scaled 13.23 shifted (ul+(6.61,-6.61));
  ne = fullcircle rotated 180 scaled 13.23 shifted (ur+(-6.61,-6.61));
  se = fullcircle rotated 180 scaled 13.23 shifted (lr+(-6.61,6.61));
  pb = buildcycle(sw,ll--ul,nw,ul--ur,ne,ur--lr,se,lr--ll);
  draw pb withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (929.76, 553.89)
    --(949.61, 553.89);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (96.38, 579.40)
    --(184.25, 551.06);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (1201.89, 551.06)
    --(1221.73, 551.06);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (184.25, 579.40)
    --(566.93, 579.40)
    --(711.50, 420.66)
    --(807.87, 420.66)
    --(909.92, 579.40)
    --(1210.39, 579.40);
  draw p withcolor (0.00,0.00,0.00) dashed evenly scaled 1.21;
% Draw arrowhead type 0
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path arr;
  arr = (1200.06, 576.57)
      --(1209.51, 579.40)
      --(1200.06, 582.24);
  draw arr withcolor (0.00,0.00,0.00);
% End polyline object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (184.25, 593.57)
    --(1213.23, 593.57);
  draw p withcolor (0.00,0.00,0.00);
% Draw arrowhead type 0
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path arr;
  arr = (1202.90, 590.74)
      --(1212.35, 593.57)
      --(1202.90, 596.41);
  draw arr withcolor (0.00,0.00,0.00);
% End polyline object
% Begin text object
  picture q;
  q=thelabel.urt("..." infont "ptmr" scaled (37pt/fontsize defaultfont),(0,0));
  picture p;
  p = q rotated 0.00;
  label.urt(p,((909.92,551.06))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt loop f+1 etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((408.19,517.04))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  q=thelabel.urt("..." infont "ptmr" scaled (37pt/fontsize defaultfont),(0,0));
  picture p;
  p = q rotated 0.00;
  label.urt(p,((575.43,551.06))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt loop i etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((742.68,517.04))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt loop 1 etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((1077.17,517.04))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFontSize{26}{31.3}%
    }%
  etex;
  q = btex \mpsetfnt $\pi_i$ etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((756.85,378.14))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFontSize{26}{31.3}%
    }%
  etex;
  q = btex \mpsetfnt ingress port A etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((96.38,602.08))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFontSize{26}{31.3}%
    }%
  etex;
  q = btex \mpsetfnt ingress port B etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((93.54,460.35))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFontSize{26}{31.3}%
    }%
  etex;
  q = btex \mpsetfnt $\pi_0$ etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((745.51,624.76))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)/2+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt port f+1 etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((286.30,505.70))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin text object
  picture q;
  verbatimtex
   \def\mpsetfnt{%
       \SetFigFont{22}{27.0}{\rmdefault}{\mddefault}{\itdefault}%
    }%
  etex;
  q = btex \mpsetfnt port i etex;
  picture p;
  p = q rotated 0.00;
  label.urt(p,((615.12,505.70))+xpart (lrcorner q - llcorner q)*(-cosd 0.00,-sind 0.00)+llcorner p) withcolor (0.00,0.00,0.00);
% End text object
% Begin polyline object
  linecap:=0;
  linejoin:=0;
  pickup pencircle scaled 0.94;
  path p;
  p = (218.27, 548.22)
    --(283.46, 548.22);
  draw p withcolor (0.00,0.00,0.00);
% End polyline object
endfig;
end
