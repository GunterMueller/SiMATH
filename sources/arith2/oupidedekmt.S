/*M
.SH NAME
oupidedekmt - order of an univariate polynomial over the integers, Dedekind maximality test

.SH SYNOPSIS
.nf
#include<_arith2.h>

single oupidedekmt(M, P)  
int M; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B M
is a prime number.
.TP 4
.B P
is an univariate polynomial over the integer numbers.
.PP
oupidedekmt returns 
 0, if the order of P is M-maximal, and
 1, if the order of P is really contained in the m-maximal order.

.SH SEE ALSO
For definitions and algorithms s. Diplomarbeit of R. Boeffgen, p.2 and 22, Universitaet des Saarlandes, Germany. 
M*/
                               
/*H
	Version 1       10.05.89        J.Schmitt
	Version 2   	30.12.89	J.Schmitt
					Spezialfall abgefragt.
	Version 3	05.08.91	J.S. auch int-prime zugelassen.
   DATE oupidedekmt   : 891101.900101.910915
H*/

# include <_arith2.h>

single oupidedekmt(M,P)
int M;
pol P;
{
	pol Pm,P0,P1,G,H;
	single t;
	bind(M,P);
	init(Pm,P0,P1,G,H);
                                     
	if ( pdegree(1,P) < 2 ) return(0);
	if ( issingle(M) ) {
		Pm = pitopms(1,P,M);
		P0 = upmsgsd(M,Pm);
		P1 = pmsquot(1,M,Pm,P0);
		G  = pidif(1,P,piprod(1,P0,P1));
		H  = pitopms(1,piiquot(1,G,M),M);
		G  = upmsgcd(M,H,P1);
	}
	else {
		Pm = pitopmi(1,P,M);
		P0 = upmigsd(M,Pm);
		P1 = pmiquot(1,M,Pm,P0);
		G  = pidif(1,P,piprod(1,P0,P1));
		H  = pitopmi(1,piiquot(1,G,M),M);
		G  = upmigcd(M,H,P1);
	}
	t = ssign(pdegree(1,G));
	return(t);
}
