/*M
.SH NAME
cweberf2 - complex Weber function f2

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cweberf2 (z)
complex z;

.SH DESCRIPTION
Provided that Imag(z) > 0,
cweberf2() returns the value of the complex Weber function f2.
M*/

/*H
	Version 1	01.07.1993	Georg Lay
   DATE cweberf2      : 931130
H*/

#include <_arith1.h>

complex cweberf2 (z)				/* f2 = sqrt(2)*eta(2z)/eta(z)		*/
complex z;					/* = sqrt(2)*etas(q^2)/etas(q)*q^(1/24)	*/
 {
 double zi,ln_q,fltoCfl();

 complex q,q2,q_24,eta,eta2,f2;
 bind(z); 
 init   (q,q2,q_24,eta,eta2,f2);

 q_24 = cexpsv (z,24);				/* q^(1/24)				*/

 zi = fltoCfl (cimag (z));
 ln_q = -2.0*M_PI*zi;				/* ln |q|				*/

 q = csexp (q_24,24);				/* q					*/
 q2 = csqr (q);					/* q^2					*/

 eta = cdedeetas (q,ln_q);
 eta2= cdedeetas (q2,2.0*ln_q);

 f2 = itofl (2);
 f2 = flsqrt (f2);
 f2 = ccri (f2,0);				/* sqrt (2)				*/
 f2 = cprod (f2,q_24);
 f2 = cprod (f2,eta2);
 f2 = cquot (f2,eta);

 return (f2);
 }

