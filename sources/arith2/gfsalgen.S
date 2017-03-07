/*M
.SH NAME
gfsalgen - Galois-field with single characteristic arithmetic list generator

.SH SYNOPSIS
.nf
#include<_arith2.h>

list gfsalgen(p, n, H)  
single p, n; 
pol H;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B n
is an integer number, n > 0.
.TP 4
.B H
is either 0 or an univariate, monic and irreducible polynomial of degree n over Z/pZ in dense representation.
.PP
gfsalgen returns the arithmetic list, say AL, for GF(p^n), the finite group with p^n elements. AL = (g AL1), where
.PP
for H = 0, G is a randomly generated, univariate, monic and irreducible polynomial over Z/pZ of degree n, for H != 0, G is equal to H.
.PP
Let z be a root of G in GF(p^n), so that
z^0, ..., z^(n-1) forms a basis of GF(p^n) over Z/pZ, then
.PP
AL = (l_(2n-2) l_(2n-1) ... l_n) is a list of lenght n-1. For all i = n, ...,2n-1, l_i is the representation of z^i as a linear combination of z^0, ..., z^(n-1
). Every l_i is represented as an univariate and dense polynomial of degree < n over Z/pZ.

.SH NOTES
The polynomial G and the lists l_i have coefficients of typ 'modular single', which lie between 0 and p-1. Particularly G is not a polynomial over GF(p).
  
M*/
                                
/*H
	Version 1       04.12.1987             Pascale Serf
	Version 2       21.04.1988             neuer Eingabeparameter G. PS
	Version 3       14.06.1989             im Fall b) ist H Kopie von G
                                               V. Schwinn
   DATE gfsalgen      : 890501.890801.9301__
H*/


# include <_arith2.h>

list gfsalgen(p,n,G)
single p,n;
pol G;
{
	single i=0,j,n1;
	pol H, ZN, P, P1;
	list AL1 = _0;

	bind(G,AL1);
	init(H,ZN,P,P1);

    /***    Polynom wird erzeugt, falls noetig    ***/
	if ( G == 0 ) 
        { if ( n == 1 ) H = list2(1,1);
          else          H = upmsimgen(p,n);
        } 
        else H = lcopy( G );

    /***    AL1  wird gebildet    ***/
	if ( n != 1 ) {

		/*    dense-Darstellung von z^n in ZN    */
		ZN = ptodp(1,H);
		ZN = udpmsneg(p,ZN);
		ZN = lred2(ZN);
		while ( lfirst(ZN) == 0 ) {
			ZN = lred(ZN);
			i++;
		}
		ZN = lcomp(n-1-i,ZN);

		AL1 = lcomp(ZN,AL1);
		P = ZN;

		/*    Darstellung von z^(n+1),z^(n+2),...,z^(2*n-2), also
		      von z^n*z,z^(n+1)*z,...,z^(2*n-3)*z, jeweils in P  */
		n1 = 2*n - 2;
		for ( i=n+1 ; i<=n1 ; i++ ) {
			P = udpmsprod(p,list3(1,1,0),P);
			if ( lfirst(P) == n ) {
				P = lred(P);
				P1 = udpmsprod(p,list2(0,lfirst(P)),ZN);
				P = lred(P);
				j = 0;
				while ( lfirst(P) == 0 ) {
					P = lred(P);
					if ( P == _0 ) { P = 0; break; }
					j++;
				}
				if ( P ) P = lcomp(n-1-j,P);
				P = udpmssum(p,P1,P);
			}
			AL1 = lcomp(P,AL1);
		}
	}

    /***    AL = (H,AL1) wird als Funktionswert uebergeben    ***/
    /***    ( im Falle G != 0 eine Kopie von G ! )            ***/
    return(list2(H,AL1));

}
