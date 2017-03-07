/*M
.SH NAME
mapgf2det - matrix of polynomials over Galois-field of characteristic 2, determinant 

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgf2det(r, G, M)
single r;
obj G;
matrix M;

.SH DESCRIPTION
mapgf2det() returns the determinant of the matrix M.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).

M*/
/*H
	Version 1	19.06.1995 	E.Herrmann
   DATE mapgf2det     : 951201
H*/

#include <_matr3.h>

pol mapgf2det( r, G, M)
single r;
obj G;
matrix M;
{
    single i, j, v=1;
    list Z1, Z1S, Z2, Z3;
    matrix MS, MT;
    pol H, P, P1, P1S, P1T, P2, P2S, P3;
    bind( M, G);
    init( MT, Z1, Z2, Z3, H, P);
    init( P1, P1S, P1T, P2, P2S, P3);
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
            P3 = pgf2prod(r,G,P1,P2S);
            H = pgf2prod(r,G,P2,P1S); 
            P3 = pgf2dif(r,G,P3,H);
            if (P1T) 
            { P3 = pgf2quot(r,G,P3,P1T); 
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
      { P = pgf2neg(r,G,P);
      }
    }

/* Ausgabe */
    return(P);
}


