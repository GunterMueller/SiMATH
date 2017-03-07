/*M
.SH NAME
pgfstopgf2 - polynomial over Galois-field with single characteristic to polynomial over Galois-field with characteristic 2
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfstopgf2(r, G, P)  
single r; 
obj G; 
pol P;
           
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).      
.TP 4
.B P
is a polynomial in r variables, with basis coefficients represented as sparse polynomials of degree < n over Z/2Z (type gfel).
.PP
pgfstopgf2 returns P, represented as a polynomial over GF(2^n), i.e. the basis coefficients are represented as univariate polynomials over Z/2Z of degree < n in special bit representation (type gf2el).

.SH SEE ALSO
.nf
udpm2tosb
pgf2topgfs 
M*/
                                       
/*H
	Version  1      19.05.1993      S.Schmitt
   DATE pgfstopgf2    : 931130
H*/
 
#include <_pol3.h>

pol pgfstopgf2( r, G, P )
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

	if (r == 0)     Q=gfseltogf2el(G,P);

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0) 
		{ 	e = lfirst(P);
			a = lsecond(P);
			P = lred2(P);
			a = pgfstopgf2(r,G,a);
			if(a)   Q = lcomp2(a,e,Q);
		}
		if(Q==_0)  Q=0;
		else  Q = linv(Q);
	}
	return(Q);
}

