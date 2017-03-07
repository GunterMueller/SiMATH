/*M
.SH NAME
dipbsort - distributive polynomial bubble sort

.SH SYNOPSIS
.nf
#include<_pol1.h>

single dipbsort( r, P )  
single r, 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables, which is allowed to be orderless.
.PP
dipbsort sorts the polynomial P in lexicographical, descending order, and returns zero by success.
 
.SH CAUTION
P will be changed.

M*/

/*H
        Version  1      06.06.1989      V. Schwinn
        Version  2      04.09.1989      V. Schwinn 
                                        Uebergabeparameter r eingefuehrt
   DATE dipbsort      : 890801.891101
H*/


# include <_pol1.h>

single dipbsort( r, P )              /* safe */
single r; pol P;
{
    single  a1,a2;
    list L1, L2, M, M1, k1, k2, E1, E2;
 
                /* L1, L2 durchlaufen das Polynom                     */
                /* M ist verbleibender ungeordneter Teil von P        */ 
                /* k1, k2 speichern die Koeffizienten                 */
                /* E1, E2 sind die zu vergleichenden Exponentenlisten */
                                
    bind( P );          
    init( L1, L2, M, M1, k1, k2, E1, E2 );                                              

    if ( P == _0 ) return(0);
    M = _0;
    do 
    { L1 = P;
      k1 = lfirst( L1 );
      E1 = lsecond( L1 );
      M1 = _0;
      L2 = lred( L1 ); L2 = lred( L2 );
      while ( L2 != M )  
      {
        k2 = lfirst( L2 );
        E2 = lsecond( L2 );
        if ( lscomp( E1, E2 ) == -1 ) 
        {
          lsfirst( L1,k2 );
          lsfirst( L2,k1 );
          leset( L1, 2, E2 );
          leset( L2, 2, E1 );
          M1 = L2;
        }
        else  
        { k1 = k2;
          E1 = E2;
        }
        L1 = L2;
        L2 = lred( L1 ); L2 = lred( L2 );
      }
    }
    while ( (M=M1) != _0 );
    return(0);
}
