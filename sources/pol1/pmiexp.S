/*M
.SH NAME
pmiexp - polynomial over modular integers exponentiation                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmiexp(r, M, P, n)  
single r, n; 
int M; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/(M*Z).                                    
.TP 4
.B n
is an integer number, 0 <= n < BASIS.
.PP
pmiexp returns the polynomial P1 = P ^ n.

M*/                                                                             

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmiexp        : 910915
H*/

#include <_pol1.h>

pol pmiexp(r,m,P,n)
single r;
int m;
pol P;
single n;
{
	pol P1;
	bind(m,P);
	init(P1);

/* n gleich 0 */

	if (!n) P1 = pvinsert(0,1,r);

/* P gleich 0 */

	else if (!P) P1 = 0;

/* n,P ungleich 0 */

	else {
		P1 = P;
		for (--n; n; n--) P1 = pmiprod(r,m,P1,P);
	}

/* Ausgabe */

	return(P1);
}
