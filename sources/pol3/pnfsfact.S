/*M
.SH NAME
pnfsfact - polynomial over number field squarefree factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list pnfsfact(r, F, D, P)  
single r; 
int D; 
pol F, P;
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B F
is a monic polynomial in dense representation.
.PP
Let t denote a zero of F, then t generates a number field, say K.
.TP 4
.B D
is a natural number, such that the ring of integers of K is in 1/D * Z[t] (s. ouspidenic).
.TP 4
.B P
is a polynomial in r variables over K, P != 0.
.PP                                        
pnfsfact returns a list, say L, containing the squarefree factorization of P, i.e.
L = ((e_1, P_1),...,(e_n, P_n)), where for 1 <= i <= n
.TP 4
e'i
is a natural number, such that
  1 <= e_1 < ... < e_n  holds,
.TP 4
P_i is a squarefree factor of P 
(with regard to the main variable), and
.PP
P = P_1^e_1 * ... * P_n^e_n.
                              
.SH SEE ALSO
ouspidenic

M*/
         
/*H
	Version 1	06.03.95	Wolfgang Schwarz
   DATE pnfsfact      : 951201
H*/

#include <_pol3.h>

list pnfsfact(r,F,D,P)
single r;
int D;
pol F,P;
{
        single e=1;
        list L;
        pol P1,Q1;

        bind(F,D,P);
        init(L,P1,Q1);

/* Initialisierung */

        L = _0;
        P1 = pnfderiv(r,F,P);
        P = pnfgcdcf(r,F,D,P,P1,&P1,&Q1); 

/* Berechnung der Faktoren */

        while (lfirst(P)) {
                P1 = pnfgcdcf(r,F,D,P,P1,&P,&Q1);
                if (lfirst(Q1)) L = lcomp(list2(e,Q1),L);
                e++;
                }
        L = lcomp(list2(e,P1),L);
        L = linv(L);

/* Ausgabe */

        return(L);
}


