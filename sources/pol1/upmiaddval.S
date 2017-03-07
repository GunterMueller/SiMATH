/*M
.SH NAME
upmiaddval - univariate polynomial over modular integer prime additive valuation

.SH SYNOPSIS
.nf
#include<_pol1.h>

single upmiaddval( p, P1, P )  
int p; 
pol P1, P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prim number.
.TP 4
.B P, P1
are univariate polynomials over Z/pZ.
deg(P1) > 0,   P != 0.
.PP                                                                             
upmsaddval returns a non negative single, say w, for which exists an univariate 
polynomial (say P2) over Z/pZ, coprime to P1, so that                           
.IP                                                                             
P = P1^w * P2                                                                   
.PP                                                                             
holds.                                                                          
                
M*/

/*H
	Version 1 	14.08.91	J.Schmitt
   DATE upmiaddval    : 910915
H*/

#include<_pol1.h>

single upmiaddval( p, P1, P )
int p;
pol P1,P;
{
	single w;
	pol P2;
	init(P2);
        bind(p,P1,P);

	P2 = 0;  
	w  = 0;
	while ( !P2 ) {
	        P = pmiqrem( 1, p, P, P1, &P2 );
		if (!P2) w = w + 1;
	}
	return( w );
}
