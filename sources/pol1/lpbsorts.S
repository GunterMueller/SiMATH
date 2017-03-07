/*M
.SH NAME
lpbsorts - list of polynomials bubble sort, special

.SH SYNOPSIS
.nf
#include<_pol1.h>

list lpbsorts(r, L)  
single r; 
list L;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4 
.B L 
= (c, P1, e1, ..., Pn, en), where
for 1 <= i <= n :
  Pi is a polynomial in r variables.
  ei is the exponent vector of Pi.
  c is a number.
.PP
lpbsorts returns the list L, ordered by the degree of the polynomials with regard to the main variable.
.SH CAUTION
L will be changed !
 
M*/

/*H
        Version 1       16.03.1993      S.Schmitt/U.Schneiders
   DATE lpbsorts      : 930531
H*/


# include <_pol1.h>

list lpbsorts( r, L )            
single r; 
list L;
{
    single  e1,e2;
    obj c;
    pol P1, P2;
    list L1, L2, M, M1;
 
                /* L1, L2 durchlaufen die Liste                  */
                /* M ist verbleibender ungeordneter Teil von L   */ 
                /* P1, P2 speichern die Polynome                 */
                /* e1, e2 sind die zu vergleichenden Exponenten  */
                                
    bind( L );          
    init( c, P1, P2, L1, L2, M, M1 );                                              
    c=lfirst(L);
    L=lred(L);
    if ( L == _0 ) return(list1(c));
    M = _0;
    do 
    { L1 = L;
      P1 = lfirst( L1 );
      e1 = lsecond( L1 );
      M1 = _0;
      L2 = lred( L1 ); L2 = lred( L2 );
      while ( L2 != M )  
      {
        P2 = lfirst( L2 );
        e2 = lsecond( L2 );
        if ( pdegree( r, P1 ) > pdegree(r, P2))
        {
          lsfirst( L1,P2 );
          lsfirst( L2,P1 );
          leset( L1, 2, e2 );
          leset( L2, 2, e1 );
          M1 = L2;
        }
        else  
        { P1 = P2;
          e1 = e2;
        }
        L1 = L2;
        L2 = lred( L1 ); L2 = lred( L2 );
      }
    }
    while ( (M=M1) != _0 );
    return(lcomp(c,L));
}
