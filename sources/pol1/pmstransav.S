/*M
.SH NAME 
pmstransav - polynomial over modular singles translation, all variables, (recursive)
                                                                       
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmstransav(r, m, P, L) 
single r, m; 
pol P; 
list L;                                                                                
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
.B L
.SM = ( ar ... a2 a1 )         single a1, ..., ar;
 is a list of r elements of Z/mZ.
.PP
pmstransav returns the polynomial P1 in r variables over Z/mZ, where         
.IP                                                                             
P1(X1, X2, ...,Xr) = P(X1+a1, X2+a2, ..., Xr+ar).                                                         
.SH SEE ALSO 
pmstrans
                                                                   
M*/                                                                             
 
/*H
	Version 1       28.10.1987      B. Weis
   DATE pmstransav    : 890501
H*/


#include <_pol1.h>

pol pmstransav(r,m,P,Lms)
single r, m;
pol P;
list Lms;
{
	single a, e;
	pol P1, P1S, k;
	bind2(P,Lms);
	init3(P1,P1S,k);

/* Translation der Hauptvariablen */

	a = lfirst(Lms);
	P1 = pmstrans(r,m,P,a);
	Lms = lred(Lms);

/* Translation der Nebenvariablen */

	r--;
	if (r  &&  P1) {
		P1S = _0;
		while (P1 != _0) {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			k = pmstransav(r,m,k,Lms);
			P1S = lcomp2(k,e,P1S);
			}
		P1 = linv(P1S);
		}

/* Ausgabe */

	return(P1);
}
