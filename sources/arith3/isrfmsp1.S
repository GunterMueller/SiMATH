/*M
.SH NAME
isrfmsp1 - is rational function over modular single prime, transcendence degree 1 ?

.SH SYNOPSIS
.nf
#include<_arith3.h>

single isrfmsp1(p, R) 
obj p, R;
         
.SH DESCRIPTION
.PP
isrfmsp1 returns
.TP 4
1,
if R can be deemed to be an univariate rational function over Z/pZ (p prime number, p < BASIS),
.TP 4
0,
else.

M*/
                       
/*H
	Version 1       18.04.1988      B. Weis
   DATE isrfmsp1      : 890501
H*/


#include <_arith3.h>

single isrfmsp1(p,R)
obj p, R;
{
    single a=0, h;
    bind(R);

    if (issprime(p,&h) == 1) {
	if (!R) a = 1;
	else  if (islist(R)  &&  llength(R) == 2  &&  ispms(1,p,lfirst(R))
	    &&  ispms(1,p,lsecond(R))  &&  lsecond(lsecond(R)) == 1
	    &&  !lfirst(upmsgcd(p,lfirst(R),lsecond(R)))) a = 1;
	}

/* Ausgabe */

    return(a);
}
