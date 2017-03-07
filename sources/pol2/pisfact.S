/*M
.SH NAME
pisfact - polynomial over integers squarefree factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list pisfact(r, P)  
single r; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a primitive polynomial in r variables over the integer numbers with leading basis coefficient > 0.
pisfact returns a list L = ((e1, P1), ..., (en, Pn)), where for 1 <= i <= n:  
.PP                                                                             
 the ei's  are integer numbers, ei > ... > e2 > e1 => 1,                        
 the Pi's are square-free factors of P (with regard to the 
 main variable), and 
.PP                                                                             
P = P1^e1 * ... * Pn^en.                                                        
                                                                          
M*/

/*H
	Version 1       26.11.1987      B. Weis
	Version 2       08.08.1991      fehlendes "init(L,P1,Q1);" ergaenzt.  PS
   DATE pisfact       : 890501.910915
H*/


#include <_pol2.h>

list pisfact(r,P)
single r;
pol P;
{
	single e=1;
	list L;
	pol P1, Q1;

	bind(P);
	init(L,P1,Q1);

/* Initialisierung */

	L = _0;
	P1 = pideriv(r,P);
	P = pigcdcf(r,P,P1,&P1,&Q1);

/* Berechnung der Faktoren */

	while (lfirst(P)) {
		P1 = pigcdcf(r,P,P1,&P,&Q1);
		if (lfirst(Q1)) L = lcomp(list2(e,Q1),L);
		e++;
		}
	L = lcomp(list2(e,P1),L);
	L = linv(L);

/* Ausgabe */

	return(L);
}
