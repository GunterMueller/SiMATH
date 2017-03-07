/*M
.SH NAME
flqrem - floating quotient and remainder

.SH SYNOPSIS
.nf
#include<_arith1.h>

int flqrem(A,B,pQ,pR)
floating A,B,*pR;
int *pQ;

.SH DESCRIPTION
flqrem() calculates quotient and remainder (*pQ, *pR) and returns 0.
.PP
.TP 4
.B *pR
 = A mod B
.TP 4
.B *pQ
 = [A/B]
.PP
There are 3 cases for the value of B.

.nf
    if B>0, then 0 <= *pR < B
    if B<0, then 0 >= *pR > B,
    if B=0, then *pR = A
M*/
/*H
        Version 1       16.01.1993      Georg Lay
   DATE flqrem        : 930531
H*/

#include <_arith1.h>

int flqrem (A,B, pQ, pR)
int	    A,B,*pQ,*pR;
 {
 if (B == 0)
   {
   *pQ = 0;
   *pR = A;
   }
 else
   {
   *pR = Cfltofl (0.5);
   *pQ = flquot  (A,B);
   *pQ = fldif   (*pQ,*pR);
   *pQ = flround (*pQ);
   *pR = itofl  (*pQ);
   *pR = flprod (*pR,B);
   *pR = fldif  (A,*pR);   
   }
 return (0);
 }
