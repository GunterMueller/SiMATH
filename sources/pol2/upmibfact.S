/*M
.SH NAME   
upmibfact - univariate polynomial over modular integers factorization, Berlekamp algorithm
                                                                     
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
list upmibfact(p, P, d)  
int p; 
pol P; 
single d;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.    
.TP 4                                                                           
.B P                                                                            
is a monic, univariate and square-free polynomial over Z/pZ with degree > 0.
P is not allowed to have an irreducible factor f (say), with deg(f) < d.
.PP
upmibfact returns a list L consisting of all irreducible, monic factors, say pi, of P, with deg(pi) > 0. 
                                                                    
M*/                                                                             

/*H
	Version 1       30.07.91	J.Schmitt
   DATE upmibfact     : 910915
H*/

# include <_pol2.h>

list upmibfact(ip,P,d)
int ip;
pol P;
single d;
{
	single n,i,j;
	int a;
	list Q,Q1,P1;

	bind(ip,P);
	init(a,Q,Q1,P1);

	n  = lfirst(P);
	if ( n == 1 || n == d ) {
		P = list1(P);
		return(P);
	}
                                                                             

/* Berechnung der Matrix Q - I, wobei Q gemaess upmibqp erklaert ist. */

	Q  = upmibqp(ip,P);
	Q  = macup(n,Q);
	Q1 = Q;
	for(i=0;i<=n-1;i++) {
		P1 = lfirst(Q1);
		for(j=1;j<=i;j++) P1 = lred(P1);
		a  = lfirst(P1);
		a  = midif(ip,a,1);
		lsfirst(P1,a);
		Q1 = lred(Q1);
	}


/* Berechnung einer Basis des Vektorraums aller Polynome g, fuer die gilt: */
/* P  teilt  ( g^(ip) - g )						   */
									
	Q  = matransp(Q);
	Q1 = maminsb(ip,Q);
	P1 = _0;
	do {
		Q  = lfirst(Q1);
		Q1 = lred(Q1);
		Q  = linv(Q);
		i  = n - 1;
		while ( lfirst(Q) == 0 ) {
			i--;
			Q = lred(Q);
		}
		Q  = lcomp(i,Q);
		Q  = dptop(1,Q);
		P1 = lcomp(Q,P1);
	}
	while ( Q1 != _0 );

/* eigentliche Faktorisierung nach Berlekamp */
	Q = upmibfls(ip,P,P1,d);

	return(Q);

}
