/*M
.SH NAME
udprgcd - univariate dense polynomial over rationals greatest common 
divisor

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udprgcd(P1, P2)  
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B P1, P2
are univariate dense polynomials over the rational numbers. 
.PP
udprgcd returns the greatest common divisor of  P1 and P2 and 
0 if P1 = P2 = 0. 
M*/

/*H
	Version 1     04.04.00      Marc Conrad
H*/


# include <_pol1.h>

pol udprgcd(P1,P2)
pol P1, P2;
{
   bind(P1, P2); 
   while( P2 ) { 
      P1 = udprrem(P1, P2);  
      if( P1 ) { P2 = udprrem(P2, P1); } 
      else { return P2; } 
      } 
   return P1; 
}
