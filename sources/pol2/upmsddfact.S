/*M
.SH NAME
upmsddfact - univariate polynomial distinct degree factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsddfact(p, P)  
single p; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a monic, square-free and univariate polynomial over Z/pZ, deg (P) >= 2.
.PP
upmsddfact returns a list L = ( G1, m1, ..., Gk, mk ), where for 1 <= i <= k:   
.IP                                                                             
 mi is an integer number, mi > ... > m2 > m1 > 0,                               
 Gi is the product of all monic irreducible factors                             
 of P with degree mi.                                                           

M*/

/*H
	Version 1       14.04.88        R.Boeffgen
	Version 2       20.05.88        i++<n-e        R.B.
   DATE upmsddfact    : 890501.9203__
H*/


# include <_pol2.h>

list upmsddfact( p, F )
single p;
pol F;
{
	single d, e, i, m, n;
	list   L, PV, Q, QV, QM;
	pol    G, P, X;
	bind( F );
	init( G,L,P,PV,QM,X );

   /*** Q-Matrix und Initialisierung ***/
	QM= upmsbqp( p,F );
	P = lsecond( QM );
	m = 1,   n = lfirst( F );
	L = _0,  X = list2( 1,1 );

	for ( ; ; ) {

	   /*** Faktoren m-ten Grades aus (P-X) herausfiltern ***/
		G = upmsgcd( p, F, pmsdif(1,p,P,X) );
		if ( lfirst(G)>0 ) {
			L = lcomp2( m,G,L );
			F = pmsquot( 1,p,F,G );
		}
		m++,  d = lfirst( F );
		if ( d >= 2*m ) {

		   /*** Vektordarstellung ***/
			if ( m==2 )  QM = matransp( macup(n,QM) );
			P = ptodp( 1,P );
			e = lfirst( P ),  P = lred( P );
			for (  i=1;  i++<n-e;  P=lcomp(0,P)  );
			PV = linv( P );

		   /*** neues P berechnen ***/
			P = _0,  Q = QM;
			do {
				QV = lfirst( Q ),  Q = lred( Q );
				P = lcomp( vecmssprod(p,PV,QV), P );
			}
			while ( Q != _0 );

		   /*** Polynomdarstellung ***/
			for (  e=n-1;  lfirst(P)==0;  e--, P=lred(P)  );
			P = lcomp( e,P ),  P = dptop( 1,P );
		}
		else {

		   /*** alle Faktoren gefunden ***/
			if ( d>0 )  L = lcomp2( d,F,L );
			return( linv(L) );
		}
	}
}
