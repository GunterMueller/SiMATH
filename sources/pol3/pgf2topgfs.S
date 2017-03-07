/*M
.SH NAME
pgfstopgfs - polynomial over Galois-field with characteristic 2 to polynomial over Galois-field with single characteristic
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2topgfs(r, G, P)  
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
is a polynomial in r variables over GF(2^n), i.e. the coefficients of P are represented as univariate polynomials over Z/2Z of degree < n in special bit-representation (type gf2el).
.PP
pgf2topgfs returns the polynomial P, with coefficients represented as sparse-polynomials over Z/2Z (type gfel).

.SH SEE ALSO
udpm2tosb

M*/
                    
/*H
	Version  1      19.05.1993      S.Schmitt
   DATE pgf2topgfs    : 931130
H*/
 
#include <_pol3.h>

pol pgf2topgfs( r,G,P )
single r;
obj G;
pol P;
{ 	pol Q;
	obj a, e;	
	init( Q, a, e );
	bind(G, P);

/* P = 0 */

	if(P==0)   Q=0;


/* r gleich 0 */

	if (r == 0)     Q=gf2eltogfsel(G,P);

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0) 
		{ 	e = lfirst(P);
			a = lsecond(P);
			P = lred2(P);
			a = pgf2topgfs(r,G,a);
			if(a)   Q = lcomp2(a,e,Q);
		}
		if(Q==_0) Q=0;
		else  Q = linv(Q);
	}
	return(Q);
}
