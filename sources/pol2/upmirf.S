/*M
.SH NAME
upmirf - univariate polynomial over modular integers, root finding (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmirf(p, P)  
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate monic polynomial over Z/pZ,     deg(P) >= 1.
.PP
upmirf returns a list L consisting of all roots of P.

M*/

/*H
	Version 1       30.07.91	J.Schmitt
   DATE upmirf        : 910915
H*/

#include <_pol2.h>

list upmirf(ip,P)
int ip;
pol P;
{
	int a,c,J;
	list L,L1,L2;
	pol P1,Q1,Q2,GCD1,GCD2,Zw,Zw2;
	single i;
	bind(ip,P);
	init(a,c,J,L,L1,L2,P1,Q1,Q2,GCD1,GCD2,Zw,Zw2);


/* Linearfakt. von P abspalten durch Bildung von gcd( P(x), x^(ip)-x ) */

	P1 = upmimprem(ip,1,ip,P);
	P1 = pmidif(1,ip,P1,list2(1,1));
	if (P1)	P1 = upmirem(ip,P1,P);

	if (P1)	{
		P1 = upmigcd(ip,P,P1);

		L2 = P1;
		L1 = P;
		while ( pdegree(1,L2) != 0 ) {
			L1 = pmiquot(1,ip,L1,L2);
			L2 = upmigcd(ip,L1,L2);
			P1 = pmiprod(1,ip,P1,L2);
		}
		P  = P1;
	}


/* Initialisierungen */

	L  = _0;

	a  = mineg(ip,1);	
	Q1 = list2(0,a);
	Q2 = list2(1,1);
	P1 = list4(1,Q1,0,Q2);
              

/*  Abspalten reiner X Potenzen  */

	Q1 = P;
	while ( Q1 != _0 ) {
		a  = lfirst(Q1);
		Q1 = lred2(Q1);	
	}
	if ( a ) {
		P = ppmvquot(1,P,a);
		for (i=1;i<=a;i++) L=lcomp(0,L);
	}
	if (pdegree(1,P)==0) return(L);


/*  ip=2 gesondert betrachten  */

	if ( !icomp(ip,2) ) {
		Q1 = list4(1,1,0,1);
		while ( pmieval(1,ip,P,1) == 0 ) {
			P = pmiquot(1,ip,P,Q1);
			L = lcomp(1,L);
		}
		return(L);
	}


/*  P ist schon Linearfaktor  */

	if ( pdegree(1,P) == 1 ) {
		c = pmieval(1,ip,P,0);
		c = mineg(ip,c);
		L = lcomp(c,L);
		return(L);
	}


/*  Eigentliche Faktorisierung  */

	a   = pdegree(1,P);
	J   = idif(ip,1);
	J   = isquot(J,2);
	Zw2 = list2(0,1);


	c   = 0; 
	i   = 0;		
	do {
		if ( !icomp(c,1) ) {
			Q1 = upmitransf(ip,P,2,P1);
			i  = 1;
		}
		if (  i ) Q2 = pmieval(2,ip,Q1,c);
		if ( !c ) Q2 = P;
		c    = isum(c,1);
		Zw   = upmimprem(ip,1,J,Q2);
		Zw   = pmisum(1,ip,Zw,Zw2);
		GCD1 = upmigcd(ip,Q2,Zw);
	}
	while( icomp(c,ip) && (pdegree(1,GCD1)==0 || pdegree(1,GCD1)==a) );
									
	if ( !icomp(c,ip) ) return(L);
	GCD2 = pmiquot(1,ip,Q2,GCD1);

	if ( pdegree(1,GCD1) == 1 ) {
		a  = pmieval(1,ip,GCD1,0);
		a  = mineg(ip,a);
		L1 = list1(a);
	}
	if ( pdegree(1,GCD2) == 1 ) {
		a  = pmieval(1,ip,GCD2,0);
		a  = mineg(ip,a);
		L2 = list1(a);
	}             

/* rekursiver Aufruf mit den Faktoren des urspruenglichen Polynoms  */

	if ( lfirst(GCD1) > 1 ) L1 = upmirf(ip,GCD1);
	if ( lfirst(GCD2) > 1 ) L2 = upmirf(ip,GCD2);

	c = idif(c,1);
	while ( L1 != _0 ) {
		a  = midif(ip,lfirst(L1),c);
		L1 = lred(L1);
		L  = lcomp(a,L);
	}
	while (L2!=_0) {
		a  = midif(ip,lfirst(L2),c);
		L2 = lred(L2);
		L  = lcomp(a,L);
	}
	return(L);
}
