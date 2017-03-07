/*M
.SH NAME
upmsbfact - univariate polynomial over modular singles factorization, Berlekamp algorithm

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsbfact(p, P, d)  
single p, d; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is a monic, univariate and square-free polynomial over Z/pZ with degree > 0.    
P is not allowed to have an irreducible factor f (say), with deg(f) < d.        
.PP                                                                          
upmsbfact returns a list L consisting of all irreducible, monic factors with degree > 0.    
                                                   
M*/

/*H
	Version 1       10.06.1987              Pascale Serf
	Version 2       09.11.1987              calloc --> malloc
						mamsnsb static deklariert
							PS
	Version 3       30.05.1988              neu: Parameter d;
						     mamsnsb ausgegliedert;
						     J.Schmitt
   DATE upmsbfact     : 890501
H*/


# include <_pol2.h>

list upmsbfact(p,A,d)
single p,d;
pol A;
{
	single n,a,i,j;
	list Q,Q1,P,B,B1,C,L;

	bind(A);
	init(Q,Q1,P,B,B1,C,L);

/*    Spezialfall : Grad(A) == 1    */
	if ( lfirst(A) == 1 ) return(list1(A));

/*    allgemeiner Fall : Grad(A) >= 2    */

	/*    Bildung der Matrix Q - I    */
	n = lfirst(A);
	Q = upmsbqp(p,A);
	Q = macup(n,Q);
	Q1 = Q;
	for ( i=0 ; i<=n-1 ; i++ ) {
		P = lfirst(Q1);
		for ( j=1 ; j<=i ; j++ ) P = lred(P);
		a = lfirst(P);
		a = msdif(p,a,1);
		lsfirst(P,a);
		Q1 = lred(Q1);
	}

	/*    Berechnung einer Nullraumbasis von Vektoren fuer Q und
	      Umwandlung in Polynome    */
	Q  = matransp(Q);
	B1 = mamsnsb(p,Q);
	B = _0;
	do {
		C = lfirst(B1); B1 = lred(B1);
		C = linv(C);
		i = n - 1;
		while ( lfirst(C) == 0 ) {
			i--;
			C = lred(C);
		}
		C = lcomp(i,C);
		C = dptop(1,C);
		B = lcomp(C,B);
	}
	while ( B1 != _0 );

	/*    eigentliche Faktorisierung    */
	L = upmsbfls(p,A,B,d);

	return(L);

}
