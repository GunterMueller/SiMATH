/*M
.SH NAME
piabs - polynomial over integers absolute value

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol piabs(r,P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
piabs returns
.IP
  P, if the leading base coefficient ( with regard 
     to the main variable ) is positive;
 -P, else.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE piabs         : 890501
H*/


#include <_pol1.h>

pol piabs(r,P)
single r;
pol P;
{
	if (pisign(r,P) < 0) P = pineg(r,P);
	return(P);
}
