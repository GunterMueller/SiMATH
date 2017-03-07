/*M
.SH NAME
madelsr - matrix delete several rows

.SH SYNOPSIS
.nf
#include<_matr1.h>

single madelsr(pM, I)
matrix *pM;
list I;

.SH DESCRIPTION
madelsr() deletes the rows listed in I
from the matrix *pM and returns 0.

.PP
.TP 4
.B M
is an mxn matrix.
.TP 4
.B I
is a list of row indices 1 <= i1 < i2 < ... < ik <= m.
M*/
/*H
	Version 1	18.03.1992	Georg Lay
   DATE madelsr       : 920331
H*/

#include <_matr1.h>

single madelsr (pM,I)
matrix	       *pM;
list		   I;
 {
 list   i;
 single cnt_del;

 if (*pM == _0) return (0);

 cnt_del = 0;

 for (i = I; i != _0; i = lred (i))
   ledel (pM,lfirst (i) - cnt_del++);
   
 return (0);
 }













