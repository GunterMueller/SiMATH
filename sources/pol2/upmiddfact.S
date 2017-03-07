/*M
.SH NAME
upmiddfact - univariate polynomial over modular integers distinct degree factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmiddfact(p, P)  
int p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a monic, square-free and univariate polynomial over Z/pZ, deg (P) >= 2.
.PP
upmiddfact returns a list L = ( G1, m1, ..., Gk, mk ), where for 1 <= i <= k:
.IP
 mi is an integer number, mi > ... > m2 > m1 > 0,
 Gi is the product of all monic irreducible factors 
 of P with degree mi.

M*/

/*H
	Version 1       24.07.91	J.Schmitt
   DATE upmiddfact    : 910915.9203__
H*/

# include <_pol2.h>

list upmiddfact(ip,P)
int ip;
pol P;
{
	single d, e, i, m, n;
	list L, PV, Q, QV, QM;
	pol G, P1, X;
	bind(ip,P);
	init(L,PV,Q,QV,QM,G,P1,X);

	n = lfirst(P);
	m = 1;
	L = _0;
	X = list2(1,1);

	QM = upmibqp(ip,P);
	P1 = lsecond(QM);  /* P1(X) = X^q modulo P(X) */

	for ( ; ; ) {

        /* Alle irreduzible Polynome vom Grad m teilen X^(q^m) - X. */

	G = upmigcd(ip,P,pmidif(1,ip,P1,X));
	if ( lfirst(G) > 0 ) {
		L = lcomp2(m,G,L);
		P = pmiquot(1,ip,P,G);
	}
	m++;
	d = lfirst(P);
	if ( d >= 2*m ) {

	/* Es gilt vereinfacht: QM^T  *  X^(q^m) = X^(q^(m+1)) */

		if ( m==2 )  QM = matransp(macup(n,QM));
		P1 = ptodp(1,P1);
		e  = lfirst(P1);
		P1 = lred(P1);
		for (i=1; i<n-e; i++) P1=lcomp(0,P1);
		PV = linv(P1);

		P1 = _0;
		Q  = QM;
		do { 
			QV = lfirst(Q);
			Q  = lred(Q);
			P1 = lcomp(vecmisprod(ip,PV,QV),P1);
		} while ( Q != _0 );

		for ( e=n-1; lfirst(P1)==0; P1=lred(P1) ) e--;
		P1 = lcomp(e,P1);
		P1 = dptop(1,P1);
	}
	else {  

	/* Falls d < 2*m, hat P nicht zwei Faktoren mit Graden >= m. */

		if ( d > 0 )  L=lcomp2(d,P,L);
		L = linv(L);
		return(L);
	}

	} /* end while(1) */
}
