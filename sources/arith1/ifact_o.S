/*M
.SH NAME
ifact_o - integer factorization, old version

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifact_o(N)
int N;

.SH DESCRIPTION
For N >0 ifact_o() returns the list L = (p1 , ... , pr)
of all prime factors of N with p1 <= ... <= pr.
M*/

/*H
	Version 1       19.11.1990      Pascale Serf (altes ifact)
   DATE ifact_o       : 901120
H*/


# include <_arith1.h>

list ifact_o(N)
int N;
{
	list F,F1;
	int M,M1,A,B,C,R,P,pQ,pR;
	single s;

	bind(N);
	init6(F,F1,M,M1,A,B); init5(C,R,P,pQ,pR);

	/***    Vorbesetzung    ***/
	F = _0;

	/*    Spezialfall : N < 2^30    */
	if ( N < BASIS ) return(sfact(N));

	/*    Spezialfall : 2^30 <= N < 2^60    */
	if ( ilog2( N ) <= 60 ) return(ifact60(N));

	/***    kleine Primteiler von N    ***/
	F = ispd(N,&M);
	if ( M == 1 ) return(F);
	F = linv(F);
	A = 1000;

	/***    M Primzahl ?    ***/
m1 :    if ( M < BASIS ) {
		M1 = M - 1;
		R = msexp(M,3,M1);
	}
	else {
		M1 = idif(M,1);
		R = miexp(M,3,M1);
	}
	if ( R == 1 ) {
		/***    Selfridge primality test    ***/
		F1 = ifact_o(M1);
		s = ispt(M,M1,F1);
		if ( s == 1 ) {
			F = lcomp(M,F);
			return(linv(F));
		}
	}

	/***    Suche nach mittleren Primteilern von M    ***/
m2 :    if ( M < BASIS ) {
		F = lconc(linv(sfact(M)),F);
		return(linv(F));
	}
	if ( ilog2( M ) <= 60 ) {
		F = lconc(linv(ifact60(M)),F);
		return(linv(F));
	}
	else {
		C = isqrt(M);
		B = imax(5000,isquot(C,3));
		if ( icomp(A,B) > 0 ) goto m3;
		impds(M,A,B,&P,&M);
		if ( P != 1 ) {
			A = P;
			F = lcomp(P,F);
			iqrem(M,P,&pQ,&pR);
			while ( pR == 0 ) {
				M = pQ;
				F = lcomp(P,F);
				iqrem(M,P,&pQ,&pR);
			}
			if ( M == 1 ) return(linv(F));
			goto m1;
		}
		A = B;
	}

	/***    Suche nach grossen Primteilern von M    ***/
m3 :    if ( M < BASIS ) {
		F = lconc(linv(sfact(M)),F);
		return(linv(F));
	}
	if ( ilog2( M ) <= 60 ) {
		F = lconc(linv(ifact60(M)),F);
		return(linv(F));
	}
	else {
		B = C;
		ilpds(M,A,B,&P,&M);
		if ( P != 1 ) F = lcomp(P,F);
		F = lcomp(M,F);
		return(linv(F));
	}

}
