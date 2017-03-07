/*M
.SH NAME
qffmsicgrr - quadratic function field over modular singles ideal class group system of representatives, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicgrr(m, D, d)  
single m; 
pol D, d;
     
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree, i.e. Z/mZ(X,D^(1/2)) is a real quadratic function field.
.TP 4
.B d 
is the principal part of D
.PP
qffmsicgrr returns a list, say L, where 
.IP
L =  ( ( Q1 , P1 ) , ... , ( Ql , Pl ) ),
.PP
for j = 1,...,l, the Qj and Pj are polynomials in Z/mZ[X].
.PP
L is a system of representatives of the ideal class group.
.PP
The ideals [ Qj, Pj + D^(1/2) ] are all reduced ideals such that
.PP
  Qj | ( D - Pj^2 ) ,
  sign(Qj) = 1 and
  deg(Pj) < deg(Qj) <= deg(D)/2
.PP
holds.

.SH SEE ALSO
Bosco Weis, Diplomarbeit, Universit"at des Saarlandes, 1986. 
                                                                                                                     
M*/

/*H
        Version 1       24.09.1992	A.Stein
   DATE qffmsicgrr    : 921130
H*/

#include <_arith3.h>

static list qffmsicgrrs1(single,pol,single,single,pol,list,list);

list qffmsicgrr(m,D,d)
single m;
pol D, d;
{
	single u, o, r;
	int H, I, J;
	pol Q, B, R;
	list L, LH, LF;
	bind(D,d);
	init(LF,L,LH,Q,B,R,H,I,J);

	o = (lfirst(D)/2) - 1;
	H = iexp(m,o);
	H = idif(H,1);
	B = d;
	R = pmsprod(1,m,B,B);
	R = pmsdif(1,m,R,D);
	R = pmsmonic(1,m,R);
	LF = ( !lfirst(R) ) ? (list2(R,1)) : (upmscfacts(m,R));
	u = -1;
	Q = list2(0,1);
	L = _0; 
	if( oequal(LF,list2(Q,1)) ) {
		LH = list2(Q,d);
		L = lcomp(LH,L);
	}	
	else L = qffmsicgrrs1(m,B,u,o,Q,LF,L);
	I = 0;
	while( icomp(I,H) ) {
		I = isum(I,1);
		J = I;
		u = -1;
		B = _0;
		do {	
			isqrem(J,m,&J,&r);
			u++;			
			if ( r ) B = lcomp2(u,r,B);
		}
		while( J ); 
		B = pmssum(1,m,d,B);
		R = pmsprod(1,m,B,B);
		R = pmsdif(1,m,R,D);
		R = pmsmonic(1,m,R);
		LF = ( !lfirst(R) ) ? (list2(R,1)) : (upmscfacts(m,R));
		Q = list2(0,1);
		L = qffmsicgrrs1(m,B,u,o,Q,LF,L);
	}
	return(L);
}

/*c
	qffmsicgrrs1 (rekursiv) ist ein Unterprogramm zu qffmsicgrr,
	abgelegt als static modul.
	Berechnet werden alle Ideale der Form
		[ Q, P + D^(1/2) ] 
	mit fest vorgegebenen P und variablem Q, wobei gilt:
		- u < Grad(Q) <= o 
		- Q teilt ( P^2 - D )
		- sign(Q) = 1 .
	Sind (QQ1,P), ... , (QQn,P) die neu berechneten Ideale, so ist
	L1 = ( (QQ1,P), ... , (QQn,P) , (Q1,P1) , ... (Ql,Pl) ) . 
c*/
/*H
        Version 1       24.09.1992	A.Stein
H*/

static list qffmsicgrrs1(m,P,u,o,Q,L,LG)
single m, u, o;
pol P, Q;
list L, LG;
{
	single i, e;
	pol F;
	list Lh;
	bind(P,Q,L,LG);
	init(Lh,F);
	
	i = 0;
	F = lfirst(L);
	e = lsecond(L);
	L = lred2(L);
	if ( L != _0 ) LG = qffmsicgrrs1(m,P,u,o,Q,L,LG);
	else if ( !lfirst(Q) && ( lfirst(Q) > u ) ) {
		Lh = list2(Q,P);
		LG = lcomp(Lh,LG);
	}
	do {
		i++;
		Q = pmsprod(1,m,Q,F);
		if ( ( lfirst(Q) > u ) && ( lfirst(Q) <= o ) ) {
			Lh = list2(Q,P);
			LG = lcomp(Lh,LG);
		}
		else if ( lfirst(Q) > o ) break;
		if( L != _0 ) LG = qffmsicgrrs1(m,P,u,o,Q,L,LG);
	}
	while ( i != e );
	return(LG);
}

