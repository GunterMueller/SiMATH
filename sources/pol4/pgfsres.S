/*M
.SH NAME
pgfsres - polynomial over Galois-field with single characteristic resultant

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol pgfsres(r, p, AL, P1, P2) 
single r, p; 
list AL; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1
(s. gfsalgen).
.TP 4
.B P1, P2
are polynomials in r variables over GF(p^n).
.PP 
pgfsres returns the resultant of P1 and P2 with regard to the main variable.

M*/
         
/*H
	Version 1       09.06.1989      V. Schwinn
   DATE pgfsres       : 890801.8909__
H*/


#include <_pol4.h>

pol pgfsres(r,p,AL,P1,P2)
single r,p;
list AL;
pol P1, P2;
{
    single e1, e2;   
    obj Eins;
    pol H, P3, k1, k2;
    matrix M;
    bind( AL, P1, P2 );
    init( Eins, H, P3, k1, k2, M );

    Eins = list2(0,1);              /* 1 als Element von GF(q) */

/* Sonderfaelle und Minimierung des Problems */

    if (!P1  ||  !P2) 
    { return( 0 );                  /* Res(P,0) = 0            */
    }
                          
    if ( ( lfirst(P1) == 0 ) &&  ( lfirst(P2) == 0 ) ) 
    { P3 = pvinsert( 0, Eins, r-1 ); 
      return( P3 );                 /* Res(a,b) = 1            */
    }                                                            
    
    if ( lfirst( P1 ) == 0 )
    { P3 = pgfsexp( r-1, p, AL, lsecond( P1 ), lfirst( P2 ) );
      return( P3 );                 /* Res(a,P) = a^deg(P)     */
    }

    if ( lfirst( P2 ) == 0 )
    { P3 = pgfsexp( r-1, p, AL, lsecond( P2 ), lfirst( P1 ) );
      return( P3 );
    }                               /* s. o.                   */

    H = P1;
    while (H != _0) 
    { e1 = lfirst(H);
      H = lred(H);
      k1 = lfirst(H);
      H = lred(H);
    }

    H = P2;
    while (H != _0)
    { e2 = lfirst(H);
      H = lred(H);
      k2 = lfirst(H);
      H = lred(H);
    }

    if ( e1 && e2 )
    { return( 0 );                  /* ggt( P1, P2 ) > 1       */
    }

    if ( e1 )
    { P1 = ppmvquot( r, P1, e1 );
      H = pgfsexp( r-1, p, AL, k2, e1 );
      if ( !lfirst( P1 ) ) 
      { P3 = pgfsexp( r-1, p, AL, lsecond( P1 ), lfirst( P2 ) );
                                    /* analog s.o. mit P1 red. */
      }
      else
      { M = psylvester( r, P1, P2 );
        P3 = mapgfsdet( r-1, p, AL, M );
      }
      P3 = pgfsprod( r-1, p, AL, P3, H );
    }
    else
    { if ( e2 )
      { P2 = ppmvquot( r, P2, e2 );
        H = pgfsexp( r-1, p, AL, k1, e2 );
        if ( sodd( e2 ) && sodd( lfirst( P1 ) ) ) 
        { H = pgfsneg( r-1, p, AL, H );
        }
        if ( !lfirst( P2 ) )
        { P3 = pgfsexp( r-1, p, AL, lsecond( P2 ), lfirst( P1 ) );
        }
        else
        { M = psylvester( r, P1, P2 );
          P3 = mapgfsdet( r-1, p, AL, M );
        }
        P3 = pgfsprod( r-1, p, AL, P3, H );
      }
      else
      { M = psylvester( r, P1, P2 );
        P3 = mapgfsdet( r-1, p, AL, M );
      }
    }
  
    return( P3 );
}
