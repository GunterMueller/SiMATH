/*M
.SH NAME
upgfsddfact - univariate polynomial over Galois-field with single characteristic distinct degree factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsddfact(p, AL, P)  
single p; 
list AL; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is an univariate, monic and squarefree polynomial over GF(p^n), deg(P) >= 2.
.PP 
upgfsddfact returns a list (G1, m1, G2, m2, ..., Gk, mk), whereat
.PP
m_i is a positive integer number, 
.PP
m_i < m_j  for i < j, and
.PP
G_i is the product of all irreducible and monic factors of P with degree m_i

.SH SEE ALSO
 gfsalgen

M*/
                                              
/*H
	Version 1       01.08.88        J.Schmitt
   DATE upgfsddfact   : 890501.9203__
H*/


# include <_pol3.h>

list upgfsddfact(p,AL,P)
single p;
list AL;
pol P;
{
	single d, e, i, m, n;
	list   L, PV, Q, QV, QM;
	pol    G, P1, X;
	bind(AL,P);
	init( G,P1,X,L,PV,Q,QV,QM );

	QM= upgfsbqp(p,AL,P);
	P1= lsecond( QM );
	m = 1;
	n = lfirst(P);
	L = _0;
	X = list2(1,list2(0,1));

	for ( ; ; ) {

		G = upgfsgcd(p,AL,P,pgfsdif(1,p,AL,P1,X) );
		if ( lfirst(G)>0 ) {
			L = lcomp2(m,G,L);
			P = pgfsquot(1,p,AL,P,G);
		}
		m++;
		d = lfirst(P);
		if ( d >= 2*m ) {

			if ( m==2 )  QM = matransp( macup(n,QM) );
			P1= ptodp(1,P1);
			e = lfirst(P1);
			P1= lred(P1);
			for ( i=1; i++<n-e; P1=lcomp(0,P1) );
			PV = linv(P1);

			P1 = _0,  Q = QM;
			do {
				QV = lfirst( Q ),  Q = lred( Q );
				P1 = lcomp(vecgfssprod(p,AL,PV,QV),P1);
			}
			while ( Q != _0 );

			for (  e=n-1;  lfirst(P)==0;  e--, P1=lred(P1)  );
			P1= lcomp(e,P1),  P1= dptop(1,P1);
		}
		else {

		/*      alle Faktoren gefunden      */
			if ( d>0 )  L = lcomp2(d,P,L);
			return( linv(L) );
		}
	}
}
