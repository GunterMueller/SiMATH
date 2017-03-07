/*M
.SH NAME
pmimiquot - polynomial over modular integers, modular integer quotient, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmimiquot(r, M, P, A)  
single r; 
int M, A; 
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
.B A
is an invertible element of Z/(M*Z).
.PP
pmimiquot returns the polynomial P1, where
.IP
P1 = P / A.
                                                                 
M*/                                                                             
                              
/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmimiquot     : 910915
H*/

#include <_pol1.h>
 
pol pmimiquot(r,m,P,a)
single r;
int m;
pol P;
int a;
{
	single e;
	pol P1, k, k1;
	bind(m,P,a);
	init(P1,k,k1);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = miquot(m,P,a);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P =lred(P);
			if (r) k = pmimiquot(r,m,k,a);
			else k = miquot(m,k,a);
			P1 = lcomp2(k,e,P1);
		} while (P != _0);
		P1 = linv(P1);
	}

/* Ausgabe */

	return(P1);
}
