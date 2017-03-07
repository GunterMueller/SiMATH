/*M
.SH NAME
magf2exp - matrix over Galois field of characteristic 2, exponentiation

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magf2exp(G, M, n)
obj G;
matrix M;
single n;

.SH DESCRIPTION
magf2exp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B M
must be a square matrix over GF(2^n).
.TP 4
.B n
with -BASIS+1 <= n <= BASIS-1 is the exponent of the result.
M*/
/*H
	Version 1       02.06.1995     E.Herrmann
   DATE magf2exp      : 951201
H*/

#include <_matr2.h>

matrix magf2exp( G, M, n )
obj G;
matrix M;
single n;

{
        matrix M1;
        single m;

        bind( G, M );
        init( M1 );

/* n gleich 0 */

        if ( !n )
        {
           m = manrrow( M );
           M1 = magf2cons1( G, m );
        }

/* M gleich 0 */

        else    if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

           else
           {
              if ( n < 0 )
              {
                 M = magf2inv( G, M );
                 n = -n;
              }
              m = manrrow( M );
              for (M1 = magf2cons1( G, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = magf2prod( G, M1, M );

                      if (n != 1) M = magf2prod( G, M, M );
                }

           }

/* Ausgabe */

        return( M1 );
}


