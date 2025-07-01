#load "dark2.pal"
load 'xyborder.cfg'
load 'grid.cfg'

#load ARG3
nplots=ARG1
title(n)=word(ARG2,n)

file(x) = sprintf("tmp%d.dat",x)
plot for [j=1:nplots] file(j) ls j lw 2 t title(j)
pause -1
