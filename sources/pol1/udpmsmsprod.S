/*M
.SH NAME
udpmsmsprod - univariate dense polynomial over modular singles, modular single product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsmsprod(m, P, a)  
single m, a; 
pol P;

.SH DESCRIPTION
.TP 4
.B m 
is an integer number, 0 < m < BASIS. 
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.  
.TP 4
.B a                                                                            
is element of Z/mZ.                                                             
.PP             
udpmsmsprod returns the polynomial P1, where                                    
.IP                                                                             
P1 = a * P. 

M*/

/*H
	Version 1       21.12.1989      A.Stein 
	Version 2       28.08.1991      Konstruktion der Ergebnisliste neu.  AS
   DATE udpmsmsprod   : 900315.9011__.910915
H*/


#include <_pol1.h>
 
pol udpmsmsprod(m,P,a)
single m;
pol P;
single a;
{
	single e,k;
	pol P1;
	bind(P);
	init(P1);

/* P oder a gleich 0 */

	if (P == 0  ||  a == 0) P1 = 0;

/* allgemeiner Fall: P,a ungleich 0 */

	else {
		P1 = _0;
		e = lfirst(P);
		P = lred(P);
		do {
			k = lfirst(P);
			P =lred(P);
			k = msprod(m,k,a);
			P1 = lcomp(k,P1);
		}
		while (P != _0);
		P1 = linv(P1);
		while (P1 != _0  &&  lfirst(P1) == 0) {
			P1 = lred(P1);
			e--;
		}
		if ( P1 == _0 ) P1 = 0;
		else P1 = lcomp(e,P1);
	}

/* Ausgabe */

	return(P1);
}
