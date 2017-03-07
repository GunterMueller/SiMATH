/*M
.SH NAME
pmstrans - polynomial over modular singles translation, main variable                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmstrans(r, m, P, a) 
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
is an element of Z/mZ.
.PP
pmstrans returns the polynomial P1 in r variables over Z/mZ, where           
.IP                                                                             
P1(X1, ..., Xr) = P(X1, ..., X(r-1), Xr+a ).                                                                         
.SH SEE ALSO                             
pmstransav
                                       
M*/                                                                             

/*H
	Version 1       28.10.1987      B. Weis
   DATE pmstrans      : 890501
H*/


#include <_pol1.h>

pol pmstrans(r,m,P,a)
single r, m;
pol P;
single a;
{
	single e;
	pol H1, H2, P1, k;
	bind(P);
	init4(H1,H2,P1,k);

/* P gleich 0 oder a gleich 0 */

	if (!P  ||  !a) P1 = P;

/* allgemeiner Fall */

	else {
		P1 = 0;
		while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			H1 = list2(0,k);
			P1 = pmssum(r,m,P1,H1);
			if (P != _0) e -= lfirst(P);
			for ( ; e; e--) {
				H1 = ppmvprod(r,P1,1);
				H2 = pmsmsprod(r,m,P1,a);
				P1 = pmssum(r,m,H1,H2);
				}
			}
		}

/* Ausgabe */

	return(P1);
}
