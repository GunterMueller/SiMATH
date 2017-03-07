/*M
.SH NAME
uprnfeval - univariate polynomial over rationals number field element evaluation

.SH SYNOPSIS
.nf
#include<_pol3.h>

nfel uprnfeval(P, F, a)  
pol P, F; 
nfel a; 
  
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the rational numbers.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for the representation of number field elements s. nfneg).
.PP
uprnfeval returns an element of K, say b, where
.IP
b = P(a).
  
.SH SEE ALSO
nfneg

M*/
                              
/*H
	Version 1       09.10.1992      Pascale Serf
   DATE uprnfeval     : 921130
H*/


# include <_pol3.h>

nfel uprnfeval(P,F,a)
pol P,F;
nfel a;
{
	/***    1.Fall : P = 0    ***/
	if ( !P ) return(0);

	/***    2.Fall : Grad(P) = 0    ***/
	{
	nfel a1;
	init(a1);

	if ( lfirst(P) == 0 ) {
	    a1 = lsecond(P);
	    a1 = rtonf(a1);
	    return(a1);
	}

	/***    3.Fall : Grad(P) >= 1    ***/
	/***    Polynomauswertung nach dem Hornerschema    ***/
	{
	nfel koeff;
	char ja=1;      /* gibt an, ob noch mit a multipliziert wird */
			/* ja = 0, falls Koeffizient a0 erreicht ist */
	bind(P,F,a);
	init(koeff);

	P = ptodp(1,P);
	P = lred(P);
	while ( P != _0 ) {
	    koeff = lfirst(P); P = lred(P);
	    if ( P == _0 ) ja = 0;
	    if ( koeff ) {
		koeff = rtonf(koeff);
		a1 = nfsum(F,a1,koeff);
	    }
	    if ( ja ) a1 = nfprod(F,a1,a);
	}

	return(a1);
	}
	}
}
