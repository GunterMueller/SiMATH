/*M
.SH NAME
upmsbqp - univariate polynomial over modular singles, Berlekamp Q polynomials construction

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsbqp(p, P)  
single p; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is an polynomial in one variable (say x) over Z/pZ of degree >= 2.              
.PP                                                                             
upmsbqp returns a list of univariate polynomials, say Qi (0 <= i <= deg(P)-1), over Z/pZ, where
.IP                                                                             
Qi is the remainder on dividing x^(p*i) by P.                                   
                                                          
M*/

/*H
	Version 1       04.06.1987      Pascale Serf
	Version 2       05.05.88        lcopy() u. bind(A) entfernt.  RB
   DATE upmsbqp       : 890501
H*/


# include <_pol2.h>

list upmsbqp(p,A)
single p;
pol A;
{
	single k,m,n,i;
	pol A1,B,C,X;
	list Q;

	init5(A1,B,C,X,Q);

	/*    Initialisierung    */
	k = 2;
	while ( k <= p ) k = k + k;
	k /= 2;
	n = lfirst(A);
	A1 = ptodp(1,A);
	C = list2(0,1);                 /*    C <-> 1    */
	Q = list1(C);

	/*    Berechnung von B = Q[1]    */
	X = list3(1,1,0);
	B = X;
	m = p - k;
	do {
		B = dpmsprod(1,p,B,B);
		if ( lfirst(B) >= n ) B = udpmsrem(p,B,A1);
		k /= 2;
		if ( m >= k ) {
			B = dpmsprod(1,p,X,B);
			if ( lfirst(B) >= n ) B = udpmsrem(p,B,A1);
			m -= k;
		}
	}
	while ( k != 1 );
	Q = lcomp(dptop(1,B),Q);

	/*    Berechnung von Q[2],...,Q[n-1]    */
	for ( C=B, i=2 ; i<=n-1 ; i++ ) {
		C = dpmsprod(1,p,B,C);
		if ( lfirst(C) >= n ) C = udpmsrem(p,C,A1);
		Q = lcomp(dptop(1,C),Q);
	}

	return(linv(Q));
}
