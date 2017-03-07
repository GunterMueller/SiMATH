/*M
.SH NAME        
pmseval - polynomial over modular singles evaluation, main variable                                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmseval(r, m, P, a) 
single r, m, a; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.                                           
.TP 4                                                                           
.B m                                                                            
is an integer number, 0 < m < BASIS.                                            
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/mZ.
.TP 4
.B a
is element of Z/mZ.
.PP
pmseval returns P(a) (the evaluation of P at a) with regard to the main variable.
                               
.SH SEE ALSO
pmsevalsv
                                                                    
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       14.12.1987      B. Weis
			Aufruf von pmssum korrigiert
   DATE pmseval       : 890501
H*/


#include <_pol1.h>

pol pmseval(r,m,P,a)
single r;
single m;
pol P;
single a;
{
	single e, e1, i;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				if (r) P1 = pmsmsprod(r,m,P1,a);
				else P1 = msprod(m,P1,a);
				}
			if (r) P1 = pmssum(r,m,P1,k);
			else P1 = mssum(m,P1,k);
			e = e1;
			}
		for (; e; e--) {
				if (r) P1 = pmsmsprod(r,m,P1,a);
				else P1 = msprod(m,P1,a);
				}
		}

/* Ausgabe */

	return(P1);
}
