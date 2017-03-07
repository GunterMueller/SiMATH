/*M
.SH NAME
ouspprmsp1dm - order of an univariate separable polynomial over polynomial ring over modular single prime, transcen-dence degree 1, Dedekind maximality test

.SH SYNOPSIS
.nf
#include<_arith4.h>

single ouspprmsp1dm(p, P, F) 
single p; 
pol P, F;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS. 
.TP 4
.B P
is a monic and irreducible polynomial of positive degree in (Z/pZ) [x].
.TP 4
.B F
F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x], deg(F) > 1. 
.PP
ouspprmsp1dm returns a single, say a, where
.TP 4
a = 0,
if the polynomial order of F over (Z/pZ) [x] is P-max-imal.
.TP 4
a = 1,
if the polynomial order of F over (Z/pZ) [x] is a proper subset of the P-maximal order.

M*/
           
/*H
	Version 1       10.12.89        	J.Schmitt
   DATE ouspprmsp1dm  : 901120
H*/

#include <_arith4.h>

single ouspprmsp1dm(p,P,F)
single p;
pol P,F;
{
	pol Pm,P0,P1,G,H;   
	list AL;
	single t;
	bind(P,F);
	init(Pm,P0,P1,G,H,AL);
                                                                   
	t  = pdegree(1,P);
	AL = gfsalgen(p,t,P);
	P0 = F; 
	Pm = _0;
	while ( P0 != _0 ) {
		t  = lfirst(P0);
		P0 = lred(P0);
		P1 = pmsrem(1,p,lfirst(P0),P);
		P0 = lred(P0);
		if (P1) Pm = lcomp2(P1,t,Pm);
	}
	Pm = linv(Pm);
	P0 = upgfsgsd(p,AL,Pm);
	P1 = pgfsquot(1,p,AL,Pm,P0);
	G  = pmsdif(2,p,F,pmsprod(2,p,P0,P1));
	H  = pmsupmsquot(2,p,G,P);

	if (H) {
		Pm = _0;
		while ( H != _0 ) {
			t = lfirst(H);
			H = lred(H);
			G = pmsrem(1,p,lfirst(H),P);
			H = lred(H);
			if (G) Pm = lcomp2(G,t,Pm);
		}
		if ( Pm != _0 ) H = linv(Pm);
		else H = 0;
	}

	G = upgfsgcd(p,AL,H,P1);
	t = pdegree(1,G);
	if (t) t = 1;
	return(t);
}
