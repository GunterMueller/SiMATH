/*M
.SH NAME
isrfr - is rational function over the rationals ?

.SH SYNOPSIS
.nf
#include<_arith3.h>

single isrfr(r, R) 
obj r, R;
        
.SH DESCRIPTION
isrfr returns 
.TP 4
1,
if R can be deemed to be a rational function in r variables (0<= r < BASIS) over the rational numbers.
.TP 4
0,
else.

M*/
                      
/*H
	Version 1       15.03.1988      B. Weis
   DATE isrfr         : 890501
H*/


#include <_arith3.h>

single isrfr(r,R)
obj r, R;
{
    single a=0;
    pol h1, h2;
    bind(R);

    if (isatom(r)  &&  r >= 0) {
	if (!R) a = 1;
	else  if (islist(R)  &&  llength(R) == 2  &&  ispi(r,lfirst(R))
	    &&  ispi(r,lsecond(R))  &&  pisign(r,lsecond(R)) == 1
	    &&  ispione(r,pigcdcf(r,lfirst(R),lsecond(R),&h1,&h2))) a = 1;
	}

/* Ausgabe */

    return(a);
}
