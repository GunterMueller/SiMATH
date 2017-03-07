/*M
.SH NAME
udprrem - univariate dense polynomial over rationals remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udprrem(P1, P2)  
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B P1, P2
are univariate dense polynomials over the rational numbers. P2 != 0.
.PP
udprrem computes the division with remainder of P1 by P2 
.TP 4                                                                           
P1 = P2 * P3 + Prem,                                                            
where Prem is the remainder of the division.                                    
.PP                                                              
udprrem returns Prem. 
M*/

/*H
	Version 1     04.04.00      Marc Conrad
H*/


# include <_pol1.h>

pol udprrem(P1,P2)
pol P1, P2;
{
        pol P4; 
        bind(P1, P2); 
        init(P4); 
        udprqrem(P1, P2, &P4); 
	return(P4);
}
