/*M
.SH NAME
upmisrpp - 
univariate polynomial over modular integers square root
principal part

.SH SYNOPSIS
.nf
#include <_pol2.h>

pol upmisrpp(M, P)
int M;
pol P; 

P1 = upmisrpp(M, P); 

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B P 
is a polynomial in k[X] of even degree
in sparse representation, whose leading coefficient is a square in k.
.TP 4
.B P1
is the principal part of the power series expansion of P^(1/2) in 1/X.

.SH SEE ALSO
.BR upmssrpp()

M*/

/*H
	Version 1	14.06.1994      A.Stein
H*/
/*cS
        upmisrpp ruft auf: linv, mpsqrt, miexp, miinv, miprod, pmidif, pmiprod
	Macros: lcomp2, lfirst, list2, lred
Sc*/


#include <_pol2.h>

pol upmisrpp(M,P)
int M;
pol P;
{
/*    if( issingle(M) ) return( upmssrpp(M,P) ); */
    {
	single e, eh;
	int A, Bf, Bh;
	pol B, H, P1=0;
	bind(M,P,P1);
	init(A,Bf,B,H);


	if (P) {
		eh = ( e = lfirst(P) ) / 2;
		P = lred(P);
		A = lfirst(P);
		P = lred(P);
		Bf = isum(M,1);
		A = ( imp2d(Bf) <= 1 ) ? (mpsqrt(M,A)) : ( miexp(M,A,ip2quot(Bf,2)) );
		P1 = list2(A,eh);
		B = _0;
		Bh = isum(A,A);
		Bh = irem(Bh,M);
		Bf = miinv(M,Bh);
		while (P != _0) {
			if ((e = lfirst(P)-eh) < 0) break;
			P = lred(P);
			A = lfirst(P);
			P = lred(P);
			A = miprod(M,Bf,A);
			if (B != _0) {
				H = list2(e,A);
				H = pmiprod(1,M,B,H);
				P = pmidif(1,M,P,H);
				}
			H = list2(2*e,miprod(M,A,A));
			P = pmidif(1,M,P,H);
			B = linv(B);
			Bh = isum(A,A);
			Bh = irem(Bh,M);
			B = lcomp2(Bh,e,B);
			B = linv(B);
			P1 = lcomp2(A,e,P1);
			}
		P1 = linv(P1);
		}


	return(P1);
    }
}
