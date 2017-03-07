/*M
.SH NAME
isgf2normel - is Galois-field with characteristic 2 normal element

.SH SYNOPSIS
.nf
#include <_arith2.h>

isgf2normel(G, a)
obj G;
gf2el a;

s = isgf2normel(G, a);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B s = 1
if a can be interpreted as a normel element in F over F2,
i.e. an element of F given in special bit notation
(see 'udpm2tosb') for which the set
  B = {a, a^2, a^(2^2), ..., a^(2^(n-1))}
forms a basis of F over F2.
.TP 4
.B s = 0
 otherwise.

.SH LITERATURE
Rudolf Lidl & Harald Niederreiter: "Finite Fields", 
Addison-Wesley, 1983, Theorem 2.39, p. 62.

.SH SEE ALSO
.BR gf2nbcons()
.BR gf2normel(),
.BR udpm2tosb()
M*/
/*H
	Version 1	30.09.96	Andreas Stein
   DATE isgf2normel	: 961201
H*/

#include <_arith2.h>

isgf2normel(G, a)
obj G;
gf2el a;
{
   if( !isgf2el( G, a ) ) return( 0 );
   else {
	single n;
	gf2el one;
	pol f, g, P;
	bind( G, a );
	init( one, f, g );
	
	n = lfirst(G);
	one = list2( 0, 1); 		/* one = 1 in special bit	 */
	f = list4( n, one, 0, one); 	/* f = x^n - 1 in special bit	 */
	g = list2( a, n-1 );
	for( n=n-2; n>=0; n-- ) {
		a = gf2squ( G, a );
		g = lcomp2( a, n, g );
	}
	g = linv( g );	

	/* g = 	a x^(n-1) + a^2 x^(n-2) + a^(2^2) x^(n-3) + ...
		... + a^(2^(n-2)) x + a^(2^(n-1))  in special bit	 */
	
	/* Theorem 2.39, Lidl/Niederreiter:
		if f and g are relatively prime, then 
		a is a normal element for GF(2^n) over GF(2)		*/

	g = upgf2gcd(G,f,g);
	n = ( lfirst(g) == 0 ) ? ( 1 ) : ( 0 );	
	return( n );
   }
}
