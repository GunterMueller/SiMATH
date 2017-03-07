/*M
.SH NAME
pnftransav - polynomial over number field translation, all variables
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnftransav(r, F, P, LI) 
single r; 
pol F, P; 
list LI;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.      
.TP 4
.B LI
is a list, containing r elements in K, say          B_1, ..., B_r.
.PP
pnftransav returns a polynomial over K, say P1, where
.PP
P1(X_1, ..., X_r) = P(X_1+B1, .., X_r+Br).

M*/
                   
/*H
	Version 1	17.03.95	Wolfgang Schwarz
   DATE pnftransav    : 951201
H*/

#include <_pol3.h>

pol pnftransav(r,F,P,LI)
single r;
pol F,P;
list LI;
{
        single e;
        nfel A;
        pol P1, P1S, k;
        bind(F,P,LI);
        init(A,P1,P1S,k);

/* Translation der Hauptvariablen */

        A = lfirst(LI);
        P1 = pnftrans(r,F,P,A);
        LI = lred(LI);

/* Translation der Nebenvariablen */

        r--;
        if (r  &&  P1) {
                P1S = _0;
                while (P1 != _0) {
                        e = lfirst(P1);
                        P1 = lred(P1);
                        k = lfirst(P1);
                        P1 = lred(P1);
                        k = pnftransav(r,F,k,LI);
                        P1S = lcomp2(k,e,P1S);
                        }
                P1 = linv(P1S);
                }

/* Ausgabe */

        return(P1);
}

