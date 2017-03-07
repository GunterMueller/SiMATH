/*M
.SH NAME
isdipol - is distributive polynomial 

.SH SYNOPSIS
.nf
#include<_pol1.h>

isdipol(r, P)
obj r, P;

.SH DESCRIPTION
isdipol returns 
.TP 4
1, 
if P can be interpreted as a distributive polynomial in r (0 <= r < BASIS) variables,
.TP 4
0, 
else.

M*/

/*H
        Version 1       27.11.1987      B. Weis 
        Version 2       05.06.1989      V. Schwinn 
                                        NL := Liste mit r Nullen
   DATE isdipol       : 890501.891101.9211__
H*/


#include <_pol1.h>

single isdipol(r,P)
obj r, P;
{
    single erg=0, i;
    obj E, E1, k;
    list NL;          /* Liste mit r Nullen (falls r>0) */
    bind(P);
    init( NL, E, E1, k );

    if (isatom(r)  &&  r >= 0) 
    { if (!P  ||  !r) 
      { erg = 1; 
      }
      else 
      { if (islist(P)  &&  seven(llength(P))  &&  P != _0) 
        { k = lfirst(P);
          P = lred(P);
          E = lfirst(P);
          P = lred(P); 
          for (i=0; i<r; i++)
          { NL = lcomp( 0, NL );   
          }
          if (!islists(E)  ||  llength(E) != r  ||  lscomp(E,NL) == -1) 
          { k = 0;
/* d.h E keine Liste oder falsche Laenge oder negative(r) Eintra(e)g(e) */
          }

          while (P != _0  &&  k)
          { k = lfirst(P);
            if (!k) break;
            P = lred(P);
            E1 = lfirst(P);
            P = lred(P);
            if (!islists(E1)  ||  llength(E1) != r  ||
                lscomp(E1,NL) == -1  ||  lscomp(E,E1) <= 0) 
            { k = 0; 
              break;
            }
            E = E1;
          }
          if (k) erg = 1;
        }
      }
    }
/* Ausgabe */

    return(erg);
}
