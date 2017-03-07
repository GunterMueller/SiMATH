/*M
.SH NAME
cweberf - complex Weber function f

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cweberf (z)
complex z;

.SH DESCRIPTION
Provided that Imag(z) > 0,
cweberf() returns the value of the complex Weber function f.
M*/

/*H
	Version 1	01.07.1993	Georg Lay
   DATE cweberf       : 931130
H*/

#include <_arith1.h>

complex cweberf (z)		
complex z;			
 {
 double zi,ln_q,fltoCfl();

 complex q_2,q,q_48,eta,f;
 bind   (z);
 init   (q_2,q,q_48,eta,f);

 q_48 = cexpsv (z,48);

 zi = fltoCfl (cimag (z));
 ln_q = -2.0*M_PI*zi;		

 q = csexp (q_48,24);

 q = cdif (0,q);
 q_2 = csqr (q);	

 eta = cdedeetas (q_2,ln_q);

 f= cdedeetas (q,ln_q/2.0);
 f = cquot (f,q_48);
 f = cquot (f,eta);

 return (f);
 }
