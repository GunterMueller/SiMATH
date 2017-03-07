/*M
.SH NAME
pieuklnorm - polynomial over integers Euclidean norm (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>
                                                                                
nt pieuklnorm(r, P) 
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
pieuklnorm returns the Euclidean norm of P, i.e. the square root of the sum of the squares of the values of the base coefficients.
 
M*/                                                                             


/*H
	Version 1       21.09.1989      A. Stein
   DATE pieuklnorm    : 891101.9011__
H*/


#include <_pol1.h>

int pieuklnorm(r,P)
single r;
pol P;
{
	int A, A1;
	pol kP;
	bind(P);
	init(A,A1,kP);

/* r gleich 0 */

	if (!r) A = iabs(P);

/* r ungleich 0 */

	else {
		A = 0;
		if (P) {
			r--;
			while (P != _0) {
				P = lred(P);
				kP = lfirst(P);
				P = lred(P);
				if (r) A1 = pieuklnorm(r,kP);
				else A1 = iabs(kP);
				A = isum( A , iprod( A1,A1 ) );
				}
			}
		}

/* Ausgabe */

	return( isqrt(A) );
}
