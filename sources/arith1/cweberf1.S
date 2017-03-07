/*M
.SH NAME
cweberf1 - complex Weber function f1

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cweberf1 (z)
complex z;

.SH DESCRIPTION
Provided that Imag(z) > 0,
cweberf1() returns the value of the complex Weber function f1.
M*/

/*H
	Version 1	01.07.1993	Georg Lay
   DATE cweberf1      : 931130
H*/

#include <_arith1.h>

complex cweberf1 (z)				/* f1 = eta(z/2)/eta(z)		*/
complex z;					/* = etas(q^(1/2))/etas(q)*q^(-1/48)	*/
 {
 double zi,ln_q,fltoCfl();

 complex q_2,q,q_48,eta,f1;
 bind   (z);
 init   (q_2,q,q_48,eta,f1);

 q_48 = cexpsv (z,48);				/* q^(1/48)				*/

 zi = fltoCfl (cimag (z));
 ln_q = -2.0*M_PI*zi;				/* ln |q|				*/

 q_2 = csexp (q_48,24);				/* q^(1/2)				*/
 q = csqr (q_2);				/* q					*/

 eta = cdedeetas (q,ln_q);

 f1= cdedeetas (q_2,ln_q/2.0);
 f1 = cquot (f1,q_48);
 f1 = cquot (f1,eta);

 return (f1);
 }
