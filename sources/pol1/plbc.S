/*M
.SH NAME
plbc - polynomial leading base coefficient, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

obj plbc(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.                                           
.TP 4                         
.B P
is a polynomial in r variables.
.PP
plbc returns the leading base coefficient of P with regard to the main variable, or 0 if P = 0.
                     
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE plbc          : 890501
H*/


#include <_pol1.h>

obj plbc(r,P)
single r;
pol P;
{
	obj a;

/* Berechnung von a */

	a = P;
	if (a) for ( ; r; r--) a = lsecond(a);

/* Ausgabe */

	return(a);
}
