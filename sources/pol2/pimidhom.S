/*M
.SH NAME
pimidhom - polynomial over integers modular ideal homomorphism

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pimidhom(r, S, P) 
single r;
list S;
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B S
= (s1 ... s(r-1)) is a list, consisting of non negative singles.
.TP 4
.B P
is a polynomial in the r variables X1,...Xr over the integer numbers.
.PP
pimidhom returns the polynomial P1, where
.IP
P1 = P mod (X1^s1, ..., (X(r-1))^s(r-1)).
            
M*/

/*H
	Version 1       20.02.1989      A.Stein
   DATE pimidhom      : 891101
H*/


#include <_pol2.h>

pol pimidhom(r,S,P)
single r;
list S;
pol P;
{
	pol P1;
	init(P1);

/* P gleich 0 oder r gleich 1 */

	if ( !P  ||  ( r == 1 ) ) P1 = P;

/* Allgemeiner Fall */

	else {
		single f;
		pol PP;
		bind(S,P);

		r-- ;
		for(P=lcinv(P),P1=_0; P!=_0 ; P=lred2(P) ) {
			PP = lfirst(P);
			f = lsecond(P);
			PP = pitrunc(r,S,PP) ;
			if ( PP ) P1 = lcomp2(f,PP,P1) ;
		}
		if( P1 == _0 ) P1 = 0 ;
	}

/* Ausgabe */

	return(P1);
}
