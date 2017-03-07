/*M
.SH NAME
mapgfsdet - matrix of polynomials over Galois-field with single characteristic, determinant

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgfsdet(r, p, AL, M)
single r,p;
list AL;
matrix M;

.SH DESCRIPTION
mapgfsdet() returns the determinant det(M).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a square matrix of polynomials in r variables over GF(p^n).
M*/







/*H
        Version 1       05.06.1989      V. Schwinn
   DATE mapgfsdet     : 890801.9109__
H*/


#include <_matr3.h>

pol mapgfsdet(r,p,AL,M)
single r,p;
list AL;
matrix M;
{
    single i, j, v=1;
    list Z1, Z1S, Z2, Z3;
    matrix MS, MT;
    pol H, P, P1, P1S, P1T, P2, P2S, P3;
    bind(M);
    init(MT,Z1,Z2,Z3,H,P);
    init(P1,P1S,P1T,P2,P2S,P3);
    P1T = 0; P = 1;


/* Schleife */
    while (lred(M) != _0) 
    { 

/* Suche Pivot-Zeile */

      MS = M;
      i = 0;
      do
      { i++;
        Z1 = lfirst(MS);
        MS = lred(MS);
      }
      while (lfirst(Z1) == 0  &&  MS != _0);

/* M hat nicht vollen Rang */

      if (!lfirst(Z1)) 
      { P = 0; break;
      }

/* Aktualisiere Vorzeichen */

      if (seven(i)) v = -v;

/* Berechne MT */

      P1 = lfirst(Z1);
      Z1 = lred(Z1);
      MT = _0;
      j = 0;
      do 
      { j++;
        Z2 = lfirst(M);
        M = lred(M);
        if (j != i) 
        { P2 = lfirst(Z2);
          Z2 = lred(Z2);
          Z3 = _0;
          Z1S = Z1;
          do
          { P1S = lfirst(Z1S);
            Z1S = lred(Z1S);
            P2S = lfirst(Z2);
            Z2 = lred(Z2);
            P3 = pgfsprod(r,p,AL,P1,P2S);
            H = pgfsprod(r,p,AL,P2,P1S); 
            P3 = pgfsdif(r,p,AL,P3,H);
            if (P1T) 
            { P3 = pgfsquot(r,p,AL,P3,P1T); 
            }
            Z3 = lcomp(P3,Z3);
          }
          while (Z1S != _0);
          MT = lcomp(Z3,MT);
        }
      }        
      while (M != _0);
      P1T = P1;
      M = MT;
    }
    if (P) 
    { P = lfirst(M); P = lfirst(P); 
      if (v < 0 ) 
      { P = pgfsneg(r,p,AL,P);
      }
    }

/* Ausgabe */
    return(P);
}


