/*M
.SH NAME
gf2algen - Galois-field with characteristic 2 arithmetic list generator

.SH SYNOPSIS
.nf
#include<_arith2.h>

list gf2algen(n,H)  
single n; 
pol H;
 
.SH DESCRIPTION
.TP 4
.B n
is an integer number, n > 0.
.TP 4
.B H 
is either 0 or an univariate, monic and irreducible polynomial of degree n over Z/2Z in dense representation.
.PP
gf2algen returns the arithmetic list for GF(2^n), say AL. AL = (G AL1), where
.PP
for H = 0, G is a randomly generated, univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb), for H != 0, G is the polynomial H in special bit-representation.
.PP
Let z be a root of G in GF(2^n), so that 
z^0, ..., z^(n-1) forms a basis of GF(2^n) over Z/2Z, then
.PP
AL = (l_(2n-2) l_(2n-1) ... l_n) is a list of lenght n-1. For all i = n, ...,2n-1, l_i is the representation of z^i as a linear combination of z^0, ..., z^(n-1). Every l_i is represented as an univariate polynomial of degree < n over Z/2Z in special bit-representation.
 
.SH SEE ALSO
udpm2tosb

M*/
                                  
/*H
	Version 1	06.03.1992	A.Stein       
   DATE gf2algen      : 920331
H*/

# include <_arith2.h>

list gf2algen(n,H)
single n;
pol H;
{
	single i, j, n1, f, u, d, konst = 1 << 29;
	obj ZN2, P2, P2h;
	pol G;
	list AL1 = _0;

	bind(H,ZN2,AL1);
	init(G,P2);

    /*    Polynom wird erzeugt, falls noetig    */

	if ( !H ) {
 	       	G = ( n == 1 )? ( list2(1,1) ) : ( upm2imgen(n) );
		G = ptodp(1,G);	
        } 
        else G = lcopy( H ); 
	G = udpm2tosb(G);

    /*    AL1  wird gebildet    */

	if ( n != 1 ) {
		ZN2 = lcopy(G);
		ZN2 = lred(ZN2);
		f = 1 << ( n%30 ); 
		f ^= lfirst(ZN2);
		lsfirst(ZN2,f);
		j = n - (n%30);
		for(; !(f=lfirst(ZN2)); ZN2=lred(ZN2), j-=30);
		for( f>>=1; f; f>>=1, j++ );
		ZN2 = lcomp(j,ZN2);
		AL1 = lcomp(ZN2,AL1);
		P2 = ZN2;

 	    /*    Darstellung von z^(n+1),z^(n+2),...,z^(2*n-2), also
		      von z^n*z,z^(n+1)*z,...,z^(2*n-3)*z, jeweils in P2  */ 

		n1 = 2*n - 2;
		for ( i=n+1; i <= n1; i++ ) {  

		    /* Multipliziere P2 mit x^1   	*/

			j = lfirst(P2); P2 = lred(P2); 
		        P2 = lcinv(P2);
			P2h = P2;
			u = 0;
			do {
				f = lfirst(P2h);
				if ( f & konst ) {
					f ^= konst;
					d = 1;
				}
				else d = 0;
				f <<= 1;
				f ^= u;
				lsfirst(P2h,f);
				u = d;
				P2h = lred(P2h);
			}
			while( P2h != _0 );
			P2 = linv(P2);
			if( u == 1 ) P2 = lcomp(1,P2);
			P2 = lcomp((j+1),P2); 

			if ( lfirst(P2) == n ) {
				P2 = lred(P2);
				f = 1 << ( n%30 ); 
				f ^= lfirst(P2);
				lsfirst(P2,f); 
				j = n - (n%30);
				for(; P2!=_0 && !(f=lfirst(P2)); P2=lred(P2), j-=30 );
				if( P2 == _0 )  P2 = 0;  
				else for( f>>=1; f; f>>=1, j++ );
				if ( P2 ) P2 = lcomp(j,P2);
				P2 = gf2sum(G,ZN2,P2);
			}
			AL1 = lcomp(P2,AL1);
		}
	}

   /***    AL = (G,AL1) wird als Funktionswert uebergeben    ***/ 

	return( list2(G,AL1) );
}
