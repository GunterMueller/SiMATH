/*M
.SH NAME
qffmisearchs \- 
quadratic function field over modular integers,
ideal search special
.\" ( M, L, Q, P )

.SH SYNOPSIS
.nf
#include <_pol2.h>

int qffmisearchs( M, L, Q, P )
int M;
list L;
pol Q, P;

dA = qffmisearchs( M, L, Q, P );

.SH DESCRIPTION
.TP 4
.B  M
is a prime integer, M > 2. Let k := Z/MZ. 

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
dA_i denotes the distance A_i to (1). (1 <= i <= l)
.RE

.TP 4
.B dA
= dA_i, if  ( Q, P, dA_i ) is in L.
.TP 4
.B dA
= 0, otherwise.

.SH SEE ALSO
.BR qffmiregbg1(),
.BR qffmssearch(),
.BR qffmssearchs()
M*//*H
	Version 1	14.08.97	A. Stein
H*/

#include <_pol2.h>

int qffmisearchs( M, L, Q, P)
int M;
list L;
pol Q, P; 
{
	single index ;
	list L1;
	pol P2;
	bind(M,L,Q,P);
	init(L1,P2);

	do {
		do {
			L1 = lfirst(L);
			L = lred(L);
		}
		while( !( index = oequal(Q,lfirst(L1)) ) && L != _0 );
		if( index ) {
			P2 = lsecond(L1);
			udpmiqrem(M,P2,Q,&P2);
			if( oequal(P,P2) ) return(lthird(L1));
			P2 = udpmineg(M,P2);
			if( oequal(P,P2) ) return( (lfirst(Q)-lthird(L1)) );
		}
	}
	while( L!=_0 );

	return(0);
}
