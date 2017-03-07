/*M
.SH NAME
ismagf2 - is matrix over Galois-field of characteristic 2 ? 

.SH SYNOPSIS
.nf
#include<_matr2.h>

single ismagf2(G, M)
obj G;
matrix M; 

.SH DESCRIPTION
ismagf2() returns 1 if M is a matrix over GF(2^n)
and 0 otherwise.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).

.TP 4
.B M
is the matrix to be tested.
M*/


/*H
        Version 1       22.06.1995      E.Herrmann
	Version 2	15.10.1996	E.Herrmann (Fehler behoben)
   DATE ismagf2       : 951201.961201
H*/

#include<_matr2.h>

single ismagf2( M,G ) 
obj M, G ;

{
    single erg=1, i;
    list Z;
    obj O;
    bind(M);
    bind(G);
    init( Z, O);

    if (M) {
        if (islist(M)) {
            i = llength(M);
            if (i >= 1) {
                i = 0;
                while (M != _0) {
                    Z = lfirst(M);
                    M = lred(M);
                    if (!islist(Z)) {erg = 0; break;}
                    else {
                        if (!i) {
                            i = llength(Z);
                            if (!i) {erg = 0; break;}
                            }
                        if (i != llength(Z)) {erg = 0; break;}
                        else {
                            while (Z != _0) {
                                O = lfirst(Z);
                                Z = lred(Z);
                                if (!(isgf2el( G, O))) {erg = 0; break;}
                                }
                            if (!erg) break;
                            }
                        }
                    }
                }
            else erg = 0;
            }
        else erg = 0;
        }
    return(erg);
}
