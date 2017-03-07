/*M
.SH NAME
upm2ctosb - univariate polynomial over modular 2, coefficients to special bit representation

.SH SYNOPSIS
.nf
#include <_pol2.h>

pol upm2ctosb (p)
pol p;

.SH DESCRIPTION
p is an univariate polynomial with coefficients
in Z/2Z. upm2ctosb() transforms the coefficients
of p to special bit representation (see udpm2tosb()).
M*/
/*H
	Version 1	21.01.1996	Georg Lay
   DATE upm2ctosb     : 960501
H*/

#include <_pol2.h>

pol upm2ctosb (p)
 {
 list  _1,q,psb;
 init (_1,q,psb);

 if (p == 0) return (0);

 _1 = list2 (0,1);
 _1 = udpm2tosb (_1);

 q = lcopy (p);
 q = linv  (q);
 
 for (psb = _0; q != _0; q = lred2 (q)) 
    psb = lcomp2 (lsecond (q) ,_1, psb);
 return (psb);
 }
