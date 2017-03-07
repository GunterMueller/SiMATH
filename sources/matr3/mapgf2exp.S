/*M
.SH NAME
mapgf2exp - matrix of polynomials over Galois-field of characteristic 2, exponentiation 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2exp(r, G, M, n)
single r;
obj G;
matrix M;
single n;

.SH DESCRIPTION
mapgf2exp() returns the matrix M^n, i.e. the n-th power of the matrix M.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B n
is a single precision integer, determining the exponent.
M*/
/*H
	Version 1       29.09.1995    E.Herrmann
   DATE mapgf2exp     : 951201.960501
H*/

#include <_matr3.h>

matrix mapgf2exp( r, G, M, n)
single r;
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
           M1 = mapgf2cons1( r, G, m );
        }

/* M gleich 0 */

        else    if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

           else
           {
              if ( n < 0 )
              {
                 M = mapgf2inv( r, G, M );
                 n = -n;
              }
              m = manrrow( M );
              for (M1 = mapgf2cons1( r, G, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = mapgf2prod( r, G, M1, M );

                      if (n != 1) M = mapgf2prod( r, G, M, M );
                }

           }

/* Ausgabe */

        return( M1 );
}


