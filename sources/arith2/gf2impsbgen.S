/*M
.SH NAME
gf2impsbgen - Galois-field with characteristic 2 irreducible and monic polynomial in special bit-representation generator

.SH SYNOPSIS
.nf
#include<_arith2.h>

obj gf2impsbgen(n,H)  
single n; 
pol H;

.SH DESCRIPTION
.TP 4
.B n
is an integer number, n > 0.
.TP 4
.B H
is 0 or an univariate, monic and irreducible polynomial over Z/2Z in dense representation of degree n.
.PP
If H = 0, gf2impsbgen returns a randomly generated, univariate, monic and irreducible polynomial over Z/2Z of degree n in special bit-representation. (s. udpm2tosb).
.PP
If H != 0, gf2impsbgen returns the polynomial H, represented in special bit-representation.

.SH SEE ALSO
udpm2tosb

M*/
               
/*H
	Version 1	10.03.1992	A.Stein       
   DATE gf2impsbgen   : 920331
H*/

# include <_arith2.h>

obj gf2impsbgen(n,H)
single n;
pol H;
{
	obj  G;

	bind(H);
	init(G);

    /*    Polynom wird erzeugt, falls noetig    */

	if ( !H ) {
        	G = ( n == 1 )? ( list2(1,1) ) : ( upm2imgen(n) );
		G = ptodp(1,G);
	} 
        else G = lcopy( H ); 
	G = udpm2tosb(G);
	return( G );
}
