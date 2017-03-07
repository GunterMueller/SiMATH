/*M
.SH NAME
upnfsfact - univariate polynomial over number field squarefree factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upnfsfact(F, P)  
pol F, P;

.SH DESCRIPTION
Let K be a number field,
.TP 4
.B F
is the respective univariate minimal polynomial of degree >= 1 in dense representation, i.e. K arises by the adjunction of a root of F.
.TP 4          
.B P
is a primitive and univariate polynomial of positive degree over K.
.PP
upnfsfact returns a list, say L, containing the squarefree factorization of P, i.e. 
L = ((e_1, P_1),...,(e_n, P_n)), where for 1 <= i <= n
.TP 4
e'i 
is a natural number, such that
  1 <= e_1 < ... < e_n  holds,
.TP 4
P_i is a monic and squarefree factor of P, and
.PP
P = P_1^e_1 * ... * P_n^e_n.
 
M*/
                                       
/*H
	Version 1       13.11.1991	A.Stein
   DATE upnfsfact     : 920331
H*/


#include <_pol3.h>

list upnfsfact(F,P)
pol F,P;
{
	single e=1;
	list L;
	pol P1, Q1;

	bind(F,P);
	init(L,P1,Q1);

/* Initialisierung */

	L = _0;
	P1 = pnfderiv(1,F,P);
	P = upnfgcdcf(F,P,P1,&P1,&Q1);

/* Berechnung der Faktoren */

	while (lfirst(P)) {
		P1 = upnfgcdcf(F,P,P1,&P,&Q1);
		if (lfirst(Q1)) L = lcomp(list2(e,Q1),L);
		e++;
	}
	L = lcomp(list2(e,P1),L);
	L = linv(L);

/* Ausgabe */

	return(L);
}
