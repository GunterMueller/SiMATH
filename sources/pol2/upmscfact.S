/*M
.SH NAME
upmscfact - univariate polynomial over modular singles complete factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmscfact(p, P)  
single p;  
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a monic, univariate polynomial over Z/pZ, with degree of P > 0.
.PP
upmscfact returns a list L consisting of all monic, irreducible factors of P.

M*/

/*H
	Version 1       19.06.1987      Pascale Serf
	Version 2       30.05.1988      neu: upmsddfact  J.Schmitt
   DATE upmscfact     : 890501.9203__
H*/


# include <_pol2.h>

list upmscfact(p,A)
single p;
pol A;
{
	list L,L1,L2,L3,L4,M;
	pol P,P1;
	single e,i,l;

	bind(A);
	init(L,L1,L2,L3,L4,M,P,P1);

	/*    Spezialfall : Grad(A) = 1    */
	if ( lfirst(A) == 1 ) return(list1(A));

	/*    allgemeiner Fall : Grad(A) >= 2    */
	M = _0;
	L = upmssfact(p,A);
	while ( L != _0 ) {
		L1 = lfirst(L); L = lred(L);
		e  = lfirst(L1);
		P = lsecond(L1);
		L2 = _0;
		if (lfirst(P)>1) L3 = upmsddfact(p,P);
		else L3=list2(P,1);
		while (L3!=_0) {
				P1 = lfirst(L3); L3=lred(L3);
				l  = lfirst(L3); L3=lred(L3);
				L4 = upmsbfact(p,P1,l);
				while (L4!=_0) {
						 L2=lcomp(lfirst(L4),L2);
						 L4=lred(L4);
				}
		}

		while ( L2 != _0 ) {
			P = lfirst(L2); L2 = lred(L2);
			for ( i=1 ; i<=e ; i++ ) M = lcomp(P,M);
		}
	}
	return(M);

}
