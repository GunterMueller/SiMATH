/*M
.SH NAME
qffmssearchs \- 
quadratic function field over modular singles,
ideal search special
.\" ( m, L, Q, P )

.SH SYNOPSIS
.nf
#include <_pol2.h>

single qffmssearchs( m, L, Q, P )
single m;
list L;
pol Q, P;

dA = qffmssearchs( m, L, Q, P );

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
dA_i denotes the distance A_i to (1). (1 <= i <= l)
.RE

.TP 4
.B dA
= dA_i, if  ( Q, P, dA_i ) is in L.
.TP 4
.B dA
= deg(Q) - dA_i, if  ( Q, -P, dA_i ) is in L.
.TP 4
.B dA
= 0, otherwise.

.SH SEE ALSO
.BR qffmisearchs(),
.BR qffmsregbg1(),
.BR qffmssearch()
M*/
/*H
	Version 1	14.08.97	A. Stein
H*/

#include <_pol2.h>

int qffmssearchs( m, L, Q, P )
single m;
list L;
pol Q, P; 
  /* L ist eine Liste von Tripeln  			            */
  /*	(QQi,Pi,dai)					            */
  /* die ein Ideal und deren Distanz zum Ursprung repraesentieren.  */
  /* Dieses Unterprogramm prueft lediglich, ob das Ideal	    */					
  /*	I = [ Q , P + D^(1/2) ]					    */
  /* in der Liste enthalten ist, oder ob dieses Ideal in der Liste  */
  /* L' vorhanden ist, wobei L' die konjugierten Ideale enthaelt.   */
  /* L' besteht dann aus den Tripeln                                */
  /*	(QQi,-Pi,dai')                                              */
  /* und braucht nicht extra konstruiert zu werden. Im ersten Fall  */
  /* wird dai zurueckgeliefert und im anderen ( Grad(Q) - dai ).    */			

{
	single index ;
	list L1;
	pol P2;
	bind(L,Q,P);
	init(L1,P2);

	do {
		do {
			L1 = lfirst(L);
			L = lred(L);
		}
		while( !( index = oequal(Q,lfirst(L1)) ) && L != _0 );
		if( index ) {
			P2 = lsecond(L1);
			udpmsqrem(m,P2,Q,&P2);
			if( oequal(P,P2) ) return(lthird(L1));
			P2 = udpmsneg(m,P2);
			if( oequal(P,P2) ) return( (lfirst(Q)-lthird(L1)) );
		}
	}
	while( L!=_0 );

	return(0);
}