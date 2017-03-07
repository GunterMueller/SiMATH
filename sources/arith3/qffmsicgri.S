/*M
.SH NAME
qffmsicgri - quadratic function field over modular singles ideal class group system of representatives, imaginary case 

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicgri(m,D,pHid)  
single m; 
pol D; 
int *pHid;
                                  
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X], such that either
.IP
D is of odd degree, or
.IP
deg(D) is even and the leading coefficient of D is not a square in the multiplicative group of (Z/mZ), i.e. 
.PP
Z/mZ(X,D^(1/2)) is an imaginary quadratic function field.    
.TP 4
.B  pHid
points on an integer. 
.PP
qffmsicgri returns a list, say L, where
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
.PP
qffmsicgri writes the ideal class number of Z/mZ(X,D^(1/2)) to *pHid.               
.SH SEE ALSO
Bosco Weis, Diplomarbeit, Universit"at des Saarlandes, 1986.         

M*/
           
/*H
        Version 1       24.09.1992	A.Stein
   DATE qffmsicgri    : 921130
H*/

#include <_arith3.h>

static list qffmsicgris1(single,single,single,pol,list,list,int,int,int*,int*);

list qffmsicgri(m,D,pHid)
single m;
pol D;
int *pHid;
{
	single u, o, deg, r, a0;
	int H, I, J, Hid, Hids;
	pol Q, B, R, D1;
	list L, LH, LF, LG;
	bind(D);
	init(LG,L,LF,Q,B,R,H,I,J,Hid,Hids);

	
	o = lfirst(D)/2;
	H = iexp(m,o);
	H = idif(H,1);
	Hid = 0;
	Hids = 0;
	LF = (plc(1,D)!=1) ? (upmscfacts(m,pmsmonic(1,m,D))) : (upmscfacts(m,D));
	u = -1;
	Q = list2(0,1);
	B = 0;
	LG = _0;
	LG = qffmsicgris1(m,u,o,Q,LF,LG,Hid,Hids,&Hid,&Hids);
	L = _0;
	if( LG != _0 ) {
		LH = list2(B,LG);
		L = lcomp(LH,L);
	}
	I = 0;
	do {
		I = isum(I,1);
		J = I;
		deg = 0;
		B = _0;
		do {	
			isqrem(J,m,&J,&r);			
			if ( r ) B = lcomp2(deg,r,B);
			deg++;
		}
		while(	J );
		R = pmsdif(1,m,D,pmsprod(1,m,B,B));
		R = pmsmonic(1,m,R);
		LF = ( !lfirst(R) ) ? (list2(R,1)) : (upmscfacts(m,R));
		u = lfirst(B);
		Q = list2(0,1);
		LG = _0;
		LG = qffmsicgris1(m,u,o,Q,LF,LG,Hid,Hids,&Hid,&Hids);
		if( LG != _0 ) {
			LH = list2(B,LG);
			L = lcomp(LH,L);
		}
	}
	while( icomp(I,H) );
	if( seven(lfirst(D)) ) {
		Hid = idif(Hid,Hids);
		Hids = isquot(Hids,(m+1));
		Hid = isum(Hid,Hids);
	}
	*pHid = Hid;
	return(L);

}

/*c
	qffmsicgris1 (rekursiv) ist ein Unterprogramm zu qffmsicgri,
	abgelegt als static modul.
	Berechnet werden alle reduzierten Ideale mit Basis
		[ Q, P + D^(1/2) ] 
	Dabei ist P fest vorgegebenen und Q variabel. 
c*/
/*H
        Version 1       24.09.1992	A.Stein
H*/

static list qffmsicgris1(m,u,o,Q,L,LG,Z1,Z1s,pZ2,pZ2s)
single m, u, o;
pol Q;
list L, LG;
int Z1, Z1s;
int *pZ2, *pZ2s;
{
	single i, e;
	pol F, Q1;
	list Lh;
	bind(Q,L,LG,Z1,Z1s);
	init(F,Q1);
	
	i = 0;
	Q1 = Q;
	F = lfirst(L);
	e = lsecond(L);
	L = lred2(L);
	if ( L != _0 ) LG = qffmsicgris1(m,u,o,Q1,L,LG,Z1,Z1s,&Z1,&Z1s);
	else if ( !lfirst(Q) && ( lfirst(Q) > u ) ) {
		Lh = list2(0,Q);
		LG = lcomp(Lh,LG);
		Z1 = isum(Z1,1);
	}
	do {
		i++;
		Q1 = pmsprod(1,m,Q1,F);
		if ( ( lfirst(Q1) > u ) && ( lfirst(Q1) <= o ) ) {
			Lh = list2(0,Q1);
			LG = lcomp(Lh,LG);
			Z1 = isum(Z1,1);
			if ( lfirst(Q1) == o ) Z1s = isum(Z1s,1);
		}
		else if ( lfirst(Q1) > o ) break;
		if( L != _0 ) LG = qffmsicgris1(m,u,o,Q1,L,LG,Z1,Z1s,&Z1,&Z1s);
	}
	while ( i != e );
	*pZ2 = Z1;
	*pZ2s = Z1s;
	return(LG);
}
