/*M
.SH NAME
upgfsmprem - univariate polynomial over Galois-field, monomial, polynomial, remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsmprem(p, AL, a, T, P) 
single p; 
list AL; 
gfel a; 
int T; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4     
.B a
is an element in GF(p^n), a != 0.
.TP 4
.B T 
is a positive integer number.
.TP 4
.B P
is an univariate polynomial over GF(p^n) of positive degree.
.PP
upgfsmprem returns a polynomial, say R, where
.IP
R(x) = (a*x)^T mod P(x).   
 
.SH SEE ALSO
gfsalgen

M*/
                                                          
/*H
	Version 1       15.07.88        J.Schmitt
	Version 2	25.09.91	integer-Exp. zugelassen.  JS
   DATE upgfsmprem    : 890501.8908__.9011__.930531
H*/


# include <_pol3.h>

pol upgfsmprem(p,AL,a,T,P)
single p;
list AL;
gfel a;
int T;
pol P;
{
	single n;
	int k,r;
	gfel b;
	pol B,X;
	bind(AL,a,T,P);
	init(k,r,b,B,X);

	n = lfirst(P);
	
	if ( icomp(T,n) < 0 ) {
		b = gfsexp(p,AL,a,T);
		B = list2(T,b);
		return(B);
	}
	if ( icomp(T,2) <= 0 ) {
		b = gfsexp(p,AL,a,T);
		B = list2(T,b);
		T = pgfsrem(1,p,AL,B,P);
		return(T);
	}

	k = 2;
	while ( icomp(k,T) <= 0 ) k = ip2prod(k,1);
	k = ip2quot(k,1);
	
	X = list2(1,a);
	B = list2(1,a);
	r = idif(T,k);
	do {
		B = pgfsprod(1,p,AL,B,B);
		if ( lfirst(B) >= n ) B = pgfsrem(1,p,AL,B,P);
		k = ip2quot(k,1);
		if ( icomp(r,k) >= 0 ) {
			B = pgfsprod(1,p,AL,X,B);
			if ( lfirst(B) >= n ) B = pgfsrem(1,p,AL,B,P);
			r = idif(r,k);
		}
	}
	while ( icomp(k,1) );
	return(B);
}
