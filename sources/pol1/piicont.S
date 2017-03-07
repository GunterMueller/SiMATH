/*M
.SH NAME
piicont - polynomial over integers integer content (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>
                                                                                
int piicont(r, P) 
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
piicont returns the content of P (over the integer numbers) for P unequal to 0, or 0 else.                                                                 
                                                                    
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE piicont       : 890501
H*/


#include <_pol1.h>

int piicont(r,P)
single r;
pol P;
{
	pol kP;
	int A=0;
	bind2(P,A);
	init(kP);

/* P ungleich 0 */

	if (P) {
		r--;
		do {
			P = lred(P);
			kP = lfirst(P);
			P = lred(P);
			if (r) kP = piicont(r,kP);
			A = igcd(kP,A);
			}
		while (A != 1  &&  P != _0);
		}

/* Ausgabe */

	return(A);
}
