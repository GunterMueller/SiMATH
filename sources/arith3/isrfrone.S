/*M
.SH NAME
isrfrone - is rational function over rationals one

.SH SYNOPSIS
.nf
#include<_arith3.h>

single isrfrone(r, A)  
single r; 
rfunc A;
     
.SH DESCRIPTION
.TP 4
.B r
is an integral number, 0 <= r < BASIS.
.TP 4
.B A
is a rational function in r variables over the rational numbers.
.PP
isrfrone returns
.TP 4
1,
if A = 1,
.TP 4
0,
else.

M*/
                
/*H
	Version 1	30.12.1992	Th. Weis
   DATE isrfrone      : 930115
H*/

#include <_arith3.h>

single isrfrone(r,A)
single r;
rfunc  A;
{
  if ( !A )  return(0);

  {
    pol    ZA,NA;

    bind(A);
    init(ZA,NA);

    ZA = lfirst(A);
    NA = lsecond(A);
    return(oequal(ZA,NA));
  }
}
