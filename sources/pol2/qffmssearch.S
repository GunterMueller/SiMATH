/*M
.SH NAME
qffmssearch \- 
quadratic function field over modular singles,
ideal search
.\" ( m, L, Q, P, d_b  )

.SH SYNOPSIS
.nf
#include <_pol2.h>

single qffmssearch( m, L, Q, P, d_b  )
single m;
list L;
pol Q, P;
int *d_b; 

dA = qffmssearch( m, L, Q, P, &d_b  );

.SH DESCRIPTION
.TP 4
.B m 
is a prime integer, 2 < m < BASIS. Let k := Z/mZ.

.TP 4
.B L =
( ( Q_1, P_1, dA_1 ) ,..., ( Q_l, P_l, dA_l ) ),
.RS
where Q_i, P_i are polynomials in k[X] in dense representation, 
such that
.RS
A_i := [ Q_i, P_i + Y ]= Q_i k[X] + (P_i + Y) k[X]
.RE
are reduced, principal ideals in k(X)(Y), i.e.
.RS
         Q_i | ( D - P_i^2 ), sgn(Q_i) = 1.
.RE
dA_i denotes the distance of A_i to A_1. (1 <= i <= l)
.RE

.TP 4
.B *d_b
= dA_i, if  ( Q, P, dA_i ) is in L.
.TP 4
.B *d_b
= deg(Q) - dA_i, if  ( Q, -P, dA_i ) is in L.
.TP 4
.B *d_b
= 0, otherwise.

.TP 4
.B dA
= 1, if  ( Q, P, dA_i ) is in L.
.TP 4
.B dA
= -1, if  ( Q, -P, dA_i ) is in L.
.TP 4
.B dA
= 0, otherwise.

.SH SEE ALSO
.BR qffmssearchs()
M*/
/*H
	Version 1	13.08.97	A. Stein
H*/

#include <_pol2.h>

qffmssearch( m, L, Q, P, d_b )
single m;
list L;
pol Q,P;
int *d_b; 
{
	single index=0 ;
	list L1;
	pol P2;
	bind( L, Q, P );
	init( L1, P2 );

	do {
		do {
			L1 = lfirst(L);
			L = lred(L);
		}
		while( !( index = oequal(Q,lfirst(L1)) ) && L != _0 );
		if( index ) {
			P2 = lsecond(L1);
			udpmsqrem(m,P2,Q,&P2);
			if( oequal(P,P2) ) { 
				*d_b = lthird(L1); 
				return( 1 ); 
			}
			P2 = udpmsneg(m,P2);
			if( oequal(P,P2) ) { 
			index = lfirst(Q);
				*d_b = idif( lthird(L1), index ); 
				return( -1 ); 
			}
		}
	}
	while( L!=_0 );
	return(0);
}
