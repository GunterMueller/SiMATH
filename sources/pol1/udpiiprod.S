/*M
.SH NAME
udpiiprod - univariate dense polynomial over integers integer product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpiiprod(P, A)  
pol P; 
int A;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the integer numbers.        
.PP
udpiiprod returns the polynomial P1, where                                      
.IP                                                                             
P1 = A * P.                                                                     
                         
M*/

/*H
	Version 1       12.08.1988      Pascale Serf
   DATE udpiiprod     : 890501
H*/


# include <_pol1.h>

pol udpiiprod(P,A)
pol P;
int A;
{
	single r;
	int KOEFF;
	pol P1;

	bind(P,A);
	init(KOEFF,P1);

	/***    1.Fall : P = 0 oder A = 0    ***/
	if ( !P || !A ) P1 = 0;

	/***    2.Fall : P != 0 und A != 0                 ***/
	/***    koeffizientenweise Multiplikation mit A    ***/
	else {
	    r = lfirst(P);
	    P = lred(P);
	    P1 = _0;
	    while ( P != _0 ) {
		KOEFF = lfirst(P);
		P1 = lcomp(iprod(KOEFF,A),P1);
		P = lred(P);
	    }
	    P1 = lcomp(r,linv(P1));
	}

	/***    Rueckgabe    ***/
	return(P1);
}
