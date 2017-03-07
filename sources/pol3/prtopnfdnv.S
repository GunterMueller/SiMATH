/*M
.SH NAME
prtopnfdnv - polynomial over rationals to polynomial over number field with decreased  number of variables
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol prtopnfdnv(r, F, P)  
single r; 
pol F, P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number.
.TP 4
.B F
is a dense polynomial with zero t (say). t generates a number field, say K.
.TP 4
.B P
is a polynomial in the r+1 variables T, X1, ..., Xr over the rational numbers.
.PP
prtopnfdnv returns a polynomial in r variables over K, say Q, where
.IP
Q(X1,...,Xr) = P(t,X1,...,Xr),
.PP
so prtopnfdnv is the inverse function to pnftopr. 
 
.SH SEE ALSO
pnftopr

M*/
          
/*H
	Version 1	16.03.95	Wolfgang Schwarz
   DATE prtopnfdnv    : 951201
H*/

#include <_pol3.h>

pol prtopnfdnv(r,F,P)
single r;
pol F,P;
{	
	pol Q,A;
	single e;
	bind(F,P);
	init(Q,A);

/* Spezialfaelle */

 	if (!P) return(0);	
	if (!r) return(uprtonfel(F,P));

/* Fall r>1 */

	r--;
	Q=_0;
	while (P!=_0)
	{ 	e=lfirst(P);
		P=lred(P);
		A=prtopnfdnv(r,F,lfirst(P));
		P=lred(P);
		if (A) Q=lcomp2(A,e,Q);
	}
	return(linv(Q));
}	
