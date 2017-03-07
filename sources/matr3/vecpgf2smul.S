/*M
.SH NAME
vecpgf2smul - vector of polynomials over Galois-field with characteristic 2, scalar multiplication 

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgf2smul(r, G, V, po) 
single r;
pol G, po;
vec V;

.SH DESCRIPTION
vecpgf2smul() returns the vector po * V.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in GF(2^n)[x_1,...,x_r]^m.
.TP 4
.B po
is an element of GF(2^n)[x_1,...,x_r].
M*/

/*H
	Version 1       08.03.1996      S. Schmitt
   DATE vecpgf2smul   : 960501
H*/

#include <_matr3.h>

vec vecpgf2smul( r, G, V, po )
single r;
pol    G,po;
vec    V;

{          
	pol    e;
	single n;
	vec    W;

	bind( G, V, po );
	init( e, W );

/* po gleich 0 */

	if( !po )
	{
	   n = llength( V );
	   W = _0;
	   while( n-- ) W = lcomp( 0, W );
	}

/* allgemeiner Fall */

	else
	{
	   W = _0;
	   do
	   {
	      e = lfirst( V );
	      V = lred( V );
	      e = pgf2prod( r, G, e, po );
	      W = lcomp( e, W );
	   }
	   while ( V != _0 );
	   W = linv( W );
	}
	return( W );
}


