/*M
.SH NAME
cmodinv - complex modular invariant j, q-expansion

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cmodinv (q, ln_q)
complex q;
double ln_q;

.SH DESCRIPTION
For 0 < |q| < 1 and q = e^(2*pi*i*t) with i*i = -1,
ln_q is an approximation of  Re(ln(q)) = Re(2*pi*i*t).
The q-expansion of module invariant j is being approximated,
i.e. cmodinv() returns an approximation of j.

.SH SEE ALSO
cmodinvj
M*/

/*H
        Version 1       01.07.1993	Georg J. Lay
	Version 2	15.01.1993	Benutzt cisum. GJL
   DATE cmodinv       : 931130.941201
H*/

#include <_arith1.h>

complex cmodinv (q,ln_q)	/* zur Definition der Weberschen Funktion f2	*/
complex q;			/* und Dedekinds eta siehe Weber Algebra III	*/
double  ln_q;
 {
 complex  eta,f2,j,q2;
 bind    (q);
 init    (eta,f2,j,q2);

 eta = cdedeetas (q,ln_q);
 
 q2 = csqr (q);
 f2 = cdedeetas (q2,2.0*ln_q);

 f2 = cquot  (f2,eta);
 f2 = csexp  (f2,24);
 f2 = cprod  (f2,q);

 f2 = ciprod (f2,4096);

 j = cisum (f2,16);
 j = csexp (j,3);
 j = cquot (j,f2);

 return (j);
 }
