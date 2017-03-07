/*M
.SH NAME
pigf2evalfvs - polynomial over integers Galois-field with characteristic 2 element evaluation first variable special version
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pigf2evalfvs(r, G, P)  
single r; 
obj G; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a polynomial in r variables over Z.
.PP
Let F denotes the finite field determined by G and let f denotes the generating element of F.
.PP
pigf2evalfvs returns a polynomial in r-1 variables over F, which arises by the substitution of the first variable found in the list of variable names belonging to  P by f.
  
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1	03.06.93	S.Schmitt
   DATE pigf2evalfvs  : 931130
H*/


#include <_pol3.h>

pol pigf2evalfvs(r,G,P)
single r;
obj G;
pol P;
{	obj k, e;
	pol Q;
	init( k, e, Q );	
	bind( G, P );

/* P gleich 0 */

	if (P == 0) Q = 0;

/* r gleich 1 */

	else if (r == 1) 
	{	P=pitopms(1,P,2);
		P=ptodp(1,P);
		Q=udpm2togf2el(G,P);
	}

/* allgemeiner Fall: P ungleich 0, r ungleich 1*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0)
	 	{ 	e = lfirst(P);
			k = lsecond(P);
			P = lred2(P);
			k = pigf2evalfvs(r,G,k);
			if(k) Q = lcomp2(k,e,Q);
		}
		if( Q == _0 ) Q = 0;
		else Q = linv(Q);
	}

/* Ausgabe */

	return(Q);
}	
