/*M
.SH NAME
madelsc - matrix delete several columns

.SH SYNOPSIS
.nf
#include<_matr1.h>

single madelsc(pM, I)
matrix *pM;
list I;

.SH DESCRIPTION
madelsc() deletes the columns listed in J
from the matrix *pM and returns 0.

.PP
.TP 4
.B M
is an mxn matrix.
.TP 4
.B J
is a list of column indices 1 <= j1 < j2 < ... < jl <= n.
M*/
/*H
	Version 1	18.03.1992	Georg Lay
   DATE madelsc       : 920331
H*/

#include <_matr1.h>

single madelsc (pM,I)
matrix	       *pM;
list		   I;
 {
 list   i,l,h;
 single cnt_del;

 if (*pM == _0)  return (0);

 for (l = *pM; l != _0; l = lred (l))
   {
   cnt_del = 0;
   
   for (i = I; i != _0; i = lred (i))
     {
     h = lfirst (l);
     ledel (&h,lfirst (i) - cnt_del++);
     lsfirst (l,h);
     }
   }

 if (lfirst (*pM) == _0) *pM = _0;

 return (0);
 }
