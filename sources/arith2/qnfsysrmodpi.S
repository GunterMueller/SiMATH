/*M
.SH NAME
qnfsysrmodpi - quadratic number field system of representatives modulo a prime ideal

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfsysrmodpi( D, P, pi, z, k )  
int D; 
list P; 
nfel pi;
single z, k;
                                   
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
. B P
is a prime ideal in the ring of integers, say O_K, of K. P is the extension of a prime number p on K. (for the representation of ideals s. qnfidprod).
.TP 4
.B pi
is a locally uniformizing parameter of P.
.TP 4
.B z
 = 0, for p inertial in K,
 = 1, for p ramified in K,
 = 2, for p split in K.
.PP
Let w be D^(1/2),      for D = 2 or 3 mod 4,
      or (1 + D^(1/2))/2,   for D = 1 mod 4.
.PP
Then {1, w} is an integral basis of O_K.
.PP  
qnfsysrmodpi computes a complete system of representatives modulo the ideal P^k:
.IP
{ x * y*w | 0 <= x < a, 0 <= y <b },
.PP
and returns a list, say L, where
.IP
L = (a b).
 
.SH SEE ALSO
qnfidprod

M*/
                                 
/*H
        Version 1	22.06.1990      Josef Gebel und Claude Grasser
   DATE qnfsysrmodpi  : 931130
H*/

#include <_arith2.h>

list qnfsysrmodpi( D, P, pi, z, k )
int    D;
list   P;
nfel   pi;
single z, k;
{
    single e;
    int    a, b, p;

    init( a, b, p );

    bind( D, P, pi );

    if( z )
    {
	/***  p zerlegt oder verzweigt: P = ( 1  p*s  x  s ) ***/
        p = lsecond( P );
	p = isquot( p, lfourth( P ) );
    }
    else
    {
	/***  p traege: P = ( p  s  x  s ) ***/
        p = lfirst( P );
    }

    a = iexp( p, k );

    if( z == 2 )
    {
        /***   p zerlegt: 0, 1, 2, ..., p^k-1 ist ein          ***/
        /***   vollstaendiges Vertretersystem modulo P^k.      ***/
        b = 0;
    }
    else if( z == 1 )
    {
        /***   p verzweigt: m = ceil(k/2), n = floor(k/2)      ***/
        /***   x + y * w mit 0 <= x < p^m, 0 <= y < p^n        ***/
        /***   ist ein vollstaendiges Vertretersystem mod P^k. ***/
 
        b = iexp( p, k/2 );      /***   k/2 = floor(k/2) = n   ***/
        a /= b;                  /***   a = p^k / p^n = p^m    ***/
    }
    else
    {
        /***   p traege: x + y * w mit 0 <= x, y < p^k ist      ***/
        /***   ein vollstaendiges Vertretersystem modulo P^k.   ***/
        b = a;
    }
    
    a--;
    if( b )
    {
        b--;
    }
    return( list2( a, b ) );
}
