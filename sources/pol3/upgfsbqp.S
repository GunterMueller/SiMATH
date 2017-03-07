/*M
.SH NAME
upgfsbqp - univariate polynomial over Galois-field with single characteristic Berlekamp Q polynomials construction

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsbqp(p, AL, P)  
single p; 
list AL; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is an univariate polynomial over GF(p^n). Let m denote the degree of P, then m had to be greater or equal to 2.
.PP
upgfsbqp returns a list (Q[0], ..., Q[m-1]), where
.TP 4
Q[i] 
is the remainder of the polynomial division of x^((p^n)*i) by P(x).

.SH SEE ALSO
gfsalgen

M*/
                               
/*H
	Version 1       13.04.88              J.Schmitt
   DATE upgfsbqp      : 890501.9203__
H*/


# include <_pol3.h>

list upgfsbqp(p,AL,P)
single p;
list AL;
pol P;
{
	single m,i,n;
	int q,k,t;
	pol A1,B,C,X;
	list Q;

	bind(P,AL);
	init(q,k,t,A1,B,C,X,Q);

	/*    Initialisierung    */
	A1=lfirst(AL);
	n=lfirst(A1);

	q=iexp(p,n);
	k = 2;
	while ( icomp(k,q)!=1 ) k = isum(k,k);
	k = iquot(k,2);
	m = lfirst(P);
	C = list2(0,list2(0,1));              /*    C <-> 1    */
	Q = list1(C);

	/*    Berechnung von B = Q[1]                */
	X = list2(1,list2(0,1));
	B = X;
	t = idif(q,k);
	do {
		B = pgfsprod(1,p,AL,B,B);
		if ( lfirst(B) >= m ) B = pgfsrem(1,p,AL,B,P);
		k = iquot(k,2);
		if ( icomp(k,t)!=1 ) {
			B = pgfsprod(1,p,AL,X,B);
			if ( lfirst(B) >= m ) B = pgfsrem(1,p,AL,B,P);
			t = idif(t,k);
		}
	}
	while ( icomp(k,1) != 0 );

	Q = lcomp(B,Q);


	/*    Berechnung von Q[2],...,Q[m-1]    */
	C = B;
	for ( i=2 ; i<=m-1 ; i++ ) {
		C = pgfsprod(1,p,AL,B,C);
		if ( lfirst(C) >= m ) C = pgfsrem(1,p,AL,C,P);
		Q = lcomp(C,Q);
	}

	return(linv(Q));
}
