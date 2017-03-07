/*M
.SH NAME
pnftrans - polynomial over number field translation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnftrans(r, F, P, A) 
single r; 
pol F, P; 
nfel A;
 
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
.B A
is an element in K.
.PP
pnftrans returns a polynomial over K, say P1, where
.PP
P1( X_1, ..., X_r ) = P( X_1, ..., X_( r-1 ), X_r+A ).   
 
M*/
                                  
/*H
     	Version 1	17.03.95 	Wolfgang Schwarz
   DATE pnftrans      : 951201
H*/

#include <_pol3.h>

pol pnftrans(r,F,P,A)
single r;
pol F,P;
nfel A;
{
        single e;
        pol H1, H2, P1, k;
        bind(F,P,A);
        init(H1,H2,P1,k);

/* P gleich 0 oder A gleich 0 */

        if (!P  ||  !A) P1 = P;

/* allgemeiner Fall */

        else {
                P1 = 0;
                while (P != _0) {
                        e = lfirst(P);
                        P = lred(P);
                        k = lfirst(P);
                        P = lred(P);
                        H1 = list2(0,k);
                        P1 = pnfsum(r,F,P1,H1);
                        if (P != _0) e -= lfirst(P);
                        for ( ; e; e--) {   /*   P1=P1*(X+A)   */
                                H1 = ppmvprod(r,P1,1);
                                H2 = pnfnfprod(r,F,P1,A);
                                P1 = pnfsum(r,F,H1,H2);
                                }
                        }
                }

/* Ausgabe */

        return(P1);
}

