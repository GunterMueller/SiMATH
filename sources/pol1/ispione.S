/*M
.SH NAME
ispione - is polynomial over integers equal one

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispione(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.
.TP 4
.B P                                                                            
is a polynomial in r variables over the integer numbers.
.PP
ispione returns
.PP
   1,   for P = 1, 
   0,   else.
   
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE ispione       : 890501
H*/


#include <_pol1.h>

single ispione(r,P)
single r;
pol P;
{
	single n=0;

/* Berechnung von n */

	if (P) {
		while (r) {
			r--;
			if (lfirst(P)) break;
			P = lsecond(P);
			}
		}
	if (P == 1) n = 1;

/* Ausgabe */

	return(n);
}
