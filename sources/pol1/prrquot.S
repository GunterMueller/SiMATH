/*M
.SH NAME
prrquot - polynomial over rationals, rational quotient

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prrquot(r, P, A) 
single r; 
pol P; 
rat A;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P                                                                            
is a polynomial in r variables over the rational numbers.
.TP 4
.B A
is a rational number, A != 0.
.PP
prrquot returns the polynomial P1, where                                        
.IP                                                                             
P1 = P / A.                                                                     
                                   
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE prrquot       : 890501
H*/


#include <_pol1.h>
 
pol prrquot(r,P,A)
single r;
pol P;
rat A;
{
	A = rinv(A);
	P = prrprod(r,P,A);
	return(P);
}
