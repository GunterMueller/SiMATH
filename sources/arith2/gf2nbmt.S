/*M
.SH NAME
gf2nbmt - Galois field of characteristic 2, normal basis multiplication table

.SH SYNOPSIS
.nf
#include<_arith2.h>

single gf2nbmt(G, a, MT, PN)  
obj  G; 
nfel a; 
list *MT, PN;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial of degree > 1 over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a
is an elements of GF(2^n), a is given in special bit notation and represented with respect to a power basis.
.TP 4
.B *MT
is a pointer on an array of (n * (n + 1) / 2) gf2-elements (MT will be the multiplication table).
.TP 4
.B PN
is the matrix (with rows in special bit notation) that transforms an element in power basis representation into an element in normal basis representation.
.PP
gf2nbmt computes the multiplication table with respect to the normal basis {a, a^2, ..., a^(2^(n-1))} and stores the results in the table MT as follows: 
.IP
The normal basis representation of a^(2^i) * a^(2^j) (i <= j) will be stored in MT[k] where k = i * n - (i * (i+1)/2) + j. 
.PP
gf2nbmt returns 0 by success.
 
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1	09.09.1994	Josef Gebel
	Version 2	25.10.1995	New arithmetic for matrices 
                                        over GF(2) JG
   DATE gf2nbmt	      : 941201.951201
H*/

#include <_arith2.h>

gf2nbmt( G, a, MT, PN )
obj  G;
nfel a;
list *MT, PN;
{
    single i, j,     /***   counters for the 2-powers of a	    ***/
	   k,	     /***   counter for the current position in MT  ***/
	   n;	     /***   field degree			    ***/
    list   b, c,     /***   current 2-powers of a		    ***/
	   d;	     /***   product of b and c			    ***/

    bind( G, a, PN );
    init( b, c, d );
 
    n = lfirst( G );

    b = a; 
    i = 0;
    k = 0;


    while( 1 )
    {
	c = b;
	j = i;
	while( 1 )
	{
	    d = gf2prod( G, b, c );
	    /***   d = a^( 2^i + 2^j ) in power basis repres.   ***/

	    d = gf2elsbbt( G, PN, d );
	    /***   d = a^( 2^i + 2^j ) in normal basis repres.	***/

	    MT[k++] = d;

	    if( (++j) == n )
	    {
		break;
	    }
	    c = gf2squ( G, c );
	    /***   c = a^( 2^j ) in power basis representation	 ***/
	}
	i++;
	if( i == n )
	{
	    return( 0 );
	}
	b = gf2squ( G, b );
	/***   b = a^( 2^i ) in power basis representation   ***/
    }
}
