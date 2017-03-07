/*M
.SH NAME
ppmvquot - polynomial quotient by power of main variable
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol ppmvquot(r, P, n) 
single r, n; 
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.  
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables.       
.TP 4
.B n
is an integer number, 0 <= n < BASIS.
.PP
For X (say) the main variable of the polynomial P, ppmvquot returns the polynomial P1, where 
.IP
P1 = P / X^n.

.SH SEE ALSO
 ppvquot
                                                                    
M*/                                                                             

/*H
	Version 1       25.09.1987      B. Weis
   DATE ppmvquot      : 890501
H*/


#include <_pol1.h>

pol ppmvquot(r,P,n)
single r;
pol P;
single n;
{
	single e;
	pol P1=0;
	bind2(P,P1);

/* P oder n gleich 0 */

	if (!P  ||  !n) P1 = P;

/* P,n ungleich 0 */

	else {
		P1 = _0;
		while (P != _0) {
			e = lfirst(P)-n;
			if (e >= 0) {
				P = lred(P);
				P1 = lcomp(e,P1);
				P1 = lcomp(lfirst(P),P1);
				P = lred(P);
				}
			else break;
			}
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
