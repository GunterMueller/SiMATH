/*M
.SH NAME
upprmsp1disc - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, discriminant

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol upprmsp1disc(p, F) 
single p; 
pol F;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4 
.B F
is a univariate polynomial over the polynomial ring in x over Z/(pZ).
.PP
upprmsp1disc returns the discriminant of F.

M*/
                    
/*H
	Version 1	22.11.89		J.Schmitt
   DATE upprmsp1disc  : 901120
H*/

#include <_pol4.h>

pol upprmsp1disc(p,F)
single p;
pol F;                      
{
	pol P;
	bind(F);
	init(P);

	if ( !F ) return(0);
	                                       
	P = pmsderiv(2,p,F);
	if ( !P ) return(0);     

	P = upprmsp1ress(p,F,P);
	return(P);
}
