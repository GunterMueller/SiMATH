/*M
.SH NAME
pmsevalsv - polynomial over modular singles evaluation, specified variable, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsevalsv(r, m, P, n, a) 
single r, m, n, a;  
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
.B n                                                                            
is an integer number, 1 <= n <= r.          
.TP 4
.B a
is element of Z/mZ.
.PP
pmsevalsv returns P(a) (the evaluation of P at a) with regard to the n-th variable.
                                                                       
.SH SEE ALSO
pmseval
                                                                    
M*/                                                                             
                 
/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsevalsv     : 890501
H*/


#include <_pol1.h>

pol pmsevalsv(r,m,P,n,a)
single r;
single m;
pol P;
single n;
single a;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (n == r) P1 = pmseval(r,m,P,a);

/* allgemeiner Fall: P ungleich 0, n ungleich r */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pmsevalsv(r,m,k,n,a);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
