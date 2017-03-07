/*M
.SH NAME
upgf2rand - univariate polynomial over Galois-field with characteristic 2 randomize

.SH SYNOPSIS
.nf
#include <_pol3.h>

upgf2rand(G,n,j)
pol G;
single n,j;

P = upgf2rand(G,n,j);

.SH DESCRIPTION
upgf2rand() returns a random monic univariate Polynomial over GF(2^n) of degree n
with j coefficients (esp. non vanishing constant term).
.TP 4
.B G
is an irreducible, univariate polynomial in special
bit representation (see udpm2tosb() for a description).
G is a generating polynomial for GF(2^n).
.TP 4
.B n
is a single with n > 1.
.TP 4
.B j
is a single with n+2 > j > 2.
.TP 4
.B P
is a monic univariate Polynomial over GF(2^n) of degree n with j non vanishing
coefficients and with P(0) not equal zero.
M*/
/*H
        Version 1       07.10.1996      Joachim Schmitt	
	DATE upgf2rand	: 961201
H*/

#include <_pol3.h>

pol upgf2rand(G,n,j)

pol G;
single n,j;
{
        pol P,H,H2;
	single jn,i,k;
	bind(G);
	init(P,H,H2);

	n = n - 1;
	j = j - 2;
	if(j<=(n/2)) {
		P = 0;
		while(!P) {
			for(i=1;i<=j;i++) {
				k = irand(n);
				k = k + 1;
				H = list2(k,1);
				P = pisum(1,P,H);
			}
			if (llength(P)!=(2*j)) P = 0;
		}
		H = list4(n+1,1,0,1);
		P = pisum(1,P,H);
	}
	else {
		jn = n - j;
		P = _0;
		while(P==_0) {
			for(i=1;i<=n;i++) P = lcomp2(i,1,P);
			for(i=1;i<=jn;i++) {
				k = irand(n);
				k = k + 1;
				H = list2(k,1);
				P = pmssum(1,2,P,H);
			}
			if (llength(P)!=(2*j)) P = _0;
		}
		H = list4(n+1,1,0,1);
		P = pisum(1,P,H);
	}
	if(pdegree(1,G)>1) {
		H = lred(P);
		lsfirst(H,list2(0,1));
		while(lred(H)!=_0) {
			H = lred2(H);
			H2 = 0;
			while(!H2) H2 = gf2elrand(G);
			lsfirst(H,H2);
		}
	}
	else {
		H = lred(P);
		lsfirst(H,list2(0,1));
		while(lred(H)!=_0) {
			H = lred2(H);
			lsfirst(H,list2(0,1));
		}
	}
	return(P);
}
