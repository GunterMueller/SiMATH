/*M
.SH NAME
pmsqrem - polynomial over modular singles quotient and remainder, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsqrem(r, m, P1, P2, pR) 
single r, m; 
pol P1, P2, *pR;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B m                                                                            
is a prime number, 0 < m < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are polynomials in r variables over Z/mZ, P2 != 0.
.PP
pmsqrem computes the division with remainder of P1 by P2                        
                                                                                
.TP 4                                                                           
P1 = P2 * P3 + Prem,
where Prem is the remainder of the division.                                    
.PP                                                 
pmsqrem returns P3. Prem can be found at *pR.                                                                          
.SH SEE ALSO                                  
 pmsquot
 pmsrem
                                  
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       31.07.1987      B. Weis
			r = 0 beruecksichtigt
   DATE pmsqrem       : 890501
H*/


#include <_pol1.h>

pol pmsqrem(r,m,P1,P2,pR)
single r;
single m;
pol P1, P2;
pol *pR;
{
	single d, e1, e2, rs;
	pol k1, k2, q, P3, P3S, s;
	bind2(P1,P2);
	init3(k1,k2,q);
	init3(P3,P3S,s);

/* r gleich 0 */

	if (!r) {P3 = msquot(m,P1,P2); *pR = 0;}
	else {

/* Initialisierungen */

		e2 = pdegree(r,P2);
		k2 = plc(r,P2);
		P2 = pred(r,P2);
		P3 =_0;
		rs = r-1;

/* Berechnung von P1/P2 und P1%P2 */

		while (P1) {
			e1 = pdegree(r,P1);
			d = e1-e2;
			if (d < 0) break;
			else {
				k1 = plc(r,P1);
				if (rs) q = pmsqrem(rs,m,k1,k2,&s);
				else {q = msquot(m,k1,k2); s = 0;}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = pmsprod(r,m,P2,P3S);
					P1 = pmsdif(r,m,P1,P3S);
					}
				}
			}
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
		*pR = P1;
		}

/* Ausgabe */

	return(P3);
}
