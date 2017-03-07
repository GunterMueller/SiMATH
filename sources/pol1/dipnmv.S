/*M
.SH NAME
dipnmv - distributive polynomial new main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipnmv(r, P, n) 
single r, n; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables.
.TP 4
.B n
is an integer number, 1 <= n <= r.
.PP
dipnmv returns the rearranged polynomial Q with new main variable Xn.
.PP
 List of variables of P = (X1,...,Xr)   -->
 List of variables of Q = (X1,...,Xn-1,Xn+1,...,Xr,Xn).
.PP
dipnmv returns ERROR, in case of an error occurs.

M*/

/*H
        Version 1       06.06.1989      V. Schwinn 
        Version 2       04.09.1989      V. Schwinn (Aufruf dipbsort)
   DATE dipnmv        : 890801.891101
H*/


# include <_pol1.h>

pol dipnmv( r, P, n)
single r, n;
pol P;

{ pol Q;
  list E, E2, Z, Z2;          /* Q = Resultat                            */
                              /* Z   durchlaeuft P                       */
                              /* Z2  durchlaeuft jeweils Exponentenliste */
                              /* E2  zeigt auf Eintraege der  "          */
                              /* E = neue Exponentenliste                */
  single i, k=0;

  bind( P );
  init( Q, E, E2, Z, Z2 );

  if ( (n<1) || (n>r)) return( ERROR );
  if ( r <= 1) 
  { return( P );
  }
  else
  { Q = _0;
    Z = P; 
    while ( Z != _0)
    { Z2 = lfirst( Z );
      Z  = lred( Z );
      if (seven( ++k )) 
      { E = _0;
        i = 0;
        while ( Z2 != _0 )
        { E2 = lfirst( Z2 );
          Z2 = lred( Z2 );
          if ( ( (++i) + n ) == ( r + 1 ) ) 
          { E = lsuffix( E, E2 ); 
          }
          else
          { E = lcomp( E2, E );   
          }
        }
        E = linv( E );
        Q = lcomp( E, Q );
      }
      else
      { Q = lcomp( Z2, Q ); 
      }
    }
    Q = linv( Q );

    dipbsort( r, Q );            /* auf SIMATH-Konvention bringen */

    return( Q );
  }
}
