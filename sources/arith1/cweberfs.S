/*M
.SH NAME
cweberfs - complex Weber functions f, f1 and f2

.SH SYNOPSIS
.nf
#include<_arith1.h>

list cweberfs (z)
complex z;

.SH DESCRIPTION
Provided that Imag(z) > 0,
cweberfs() returns the list (f,f1,f2) of approximations of the Weber functions f,f1 and f2 at the point z.
A call to cweberfs() is faster than three separate calls of cweberf, cweberf1 and cweberf2.
M*/

/*H
	Version 1	15.01.1994	Georg J. Lay
   DATE cweberfs      : 941201
H*/

#include <_arith1.h>

complex cweberfs (z)		
complex z;			
 {
 double zi,ln_q,fltoCfl();

 complex q_2,q,q_48,eta_2,f,f1,f2;
 bind   (z);
 init   (q_2,q,q_48,eta_2,f,f1,f2);

 q_48 = cexpsv (z,48);			/* q^{1/48}			*/

 zi = fltoCfl (cimag (z));
 ln_q = -2.0*M_PI*zi;		

 q   = csexp (q_48,24);
 q_2 = csqr  (q);	

 eta_2 = cdedeetas (q_2,ln_q);

 f1 = cdedeetas (q,ln_q/2.0);
 f1 = cquot (f1,q_48);
 f1 = cquot (f1,eta_2);			/* f1 = eta (z/2) / eta (z)	*/

 q = cneg (q);

 f = cdedeetas (q,ln_q/2.0);
 f = cquot (f,q_48);
 f = cquot (f,eta_2);			/* f = 1^{-1/48} * eta ((z+1)/2) / eta (z)	*/

 f2 = itofl (2);
 f2 = flsqrt(f2);
 f2 = ccri (f2,0);
 f2 = cquot (f2,f);
 f2 = cquot (f2,f1);			/* es ist f*f1*f2 = sqrt{2}	*/

 return (list3 (f,f1,f2));
 }
