/*M
.SH NAME
upinfseval - univariate polynomial over integers number field element, sparse representation, evaluation

.SH SYNOPSIS
.nf
#include<_pol3.h>

nfel upinfseval(P, F, a)  
pol P, F; 
nfel a;
  
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial over the rational numbers, deg(F) >=1. F generates a number field, say K.
.TP 4
.B P
is an univariate polynomial over the integer numbers.
.TP 4
.B a
is an element of K, represented by an univariate sparse polynomial over the rational numbers of degree smaller than the degree of F.
.PP
upinfseval returns a number field element, say b, represented in the same way as a, where
.IP
b = P(a).

.SH SEE ALSO
upinfeval

M*/
                                            
/*H
	Version 1       15.07.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
   DATE upinfseval    : 890501
H*/


# include <_pol3.h>

nfel upinfseval(P,F,a)
pol P,F;
nfel a;
{
	nfel a1,koeff;
	char ja=1;      /* gibt an, ob noch mit a multipliziert wird */
			/* ja = 0, falls Koeffizient a0 erreicht ist */

	bind(P,F,a);
	init(a1,koeff);

	/***    1.Fall : P = 0    ***/
	if ( !P ) return(0);

	/***    2.Fall : Grad(P) = 0    ***/
	if ( lfirst(P) == 0 ) {
	    a1 = lsecond(P);
	    a1 = itonfs(a1);
	    return(a1);
	}

	/***    3.Fall : Grad(P) >= 1    ***/
	/***    Polynomauswertung nach dem Hornerschema    ***/
	P = ptodp(1,P);
	P = lred(P);
	while ( P != _0 ) {
	    koeff = lfirst(P); P = lred(P);
	    if ( P == _0 ) ja = 0;
	    if ( koeff ) {
		koeff = itonfs(koeff);
		a1 = nfssum(F,a1,koeff);
	    }
	    if ( ja ) a1 = nfsprod(F,a1,a);
	}

	return(a1);

}
