/*M
.SH NAME
qffmszcgitr - quadratic function field over modular singles zero class group isomorphy type, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmszcgitr(m, D, d, H, LG, R, IT)  
single m; 
pol D, d; 
int H, R;
list LG, IT;
 
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree, i.e. Z/mZ(X,D^(1/2)) is a real quadratic function field.
.TP 4
.B d
is the principal part of D.
.TP 4
.B H 
is the ideal class number of Z/mZ(X,D^(1/2)).
.TP 4
.B LG 
is a set of generators of the ideal class group, given for example by qffmsicggir (s. qffmsicggir).
.TP 4
.B R
is the regulator of Z/mZ(X,D^(1/2)).
.TP 4
.B IT 
is a list, describing the isomorphy typ of the ideal class group, given for example by qffmsicggir (s. qffmsicggir).
.PP
qffmszcgitr returns a list L = (n1, ..., nl), describing the isomorphy type of the zero class group, i.e. the ni (i = 1,...,l) are integral numbers, such that the zero class group is isomophic to
.IP
(Z/n1Z) x ... x (Z/nlZ).
 
.SH SEE ALSO
Bosco Weis, Diplomarbeit, Universit"at des Saarlandes, 1986.

M*/
                        
/*H
        Version 1     	09.03.1993	A.Stein
   DATE qffmszcgitr   : 930531
H*/

#include <_arith3.h>

static list qffmszcgitr1(single,pol,list,int,list,list,int,list*);
static list qffmszcgitr2(list);
static list qffmszcgitr3(list);

list qffmszcgitr(m,D,d,H,LG,R,IT)
single m; 
pol D, d; 
int H, R;
list LG, IT;
{
	single ind;
	int Pi, A, Fi;
	list Lh, LM, LM1, L;
	init(Pi,A,Fi,LM,LM1,L);
	bind(d,D,H,R,LG,IT);

	if( !icomp(1,iprod(H,R)) ) return( _0 );
	else if( R == 1 ) return( IT );
	
	L = _0;
	LM = ifel(ifact(R));
	for( LM1 = _0; LM != _0; LM = lred2(LM) ) {
		Lh = lsecond(LM);
		LM1 = lcomp(Lh,LM1);
		Lh = lfirst(LM);
		LM1 = lcomp(Lh,LM1);
	}
	if( H == 1 ) {
		for( ; LM1 != _0; LM1 = lred2(LM1) ) {
			Pi = lfirst(LM1);
			Pi = iexp(Pi,lsecond(LM1));
			L = lcomp(Pi,L);
		}
		return(L);
	}
	if( igcd(H,R) == 1 ) {
		for( ; IT != _0; IT = lred(IT) ) {
			A = lfirst(IT);
			Lh = ifact(A);
			Fi = lfirst(Lh);
			for( ind = 0 ; (LM1 != _0) && !ind ; ) {
				if( icomp(Fi,lfirst(LM1)) > 0 ) {
					Pi = lfirst(LM1);
					Pi = iexp(Pi,lsecond(LM1));
					L = lcomp(Pi,L);
					LM1 = lred2(LM1);
				}
				else ind = 1;
			}
			L = lcomp(A,L);
		}
		for( ; LM1 != _0 ; LM1 = lred2(LM1) ) {
			Pi = lfirst(LM1);
			Pi = iexp(Pi,lsecond(LM1));
			L = lcomp(Pi,L);			
		}
		return( linv(L) );
	}
	while( IT != _0 ) {
		A = lfirst(IT);
		IT = lred(IT);
		Lh = ifact(A);
		Fi = lfirst(Lh);
		if( LM1 != _0 ) {
			if( icomp(Fi,lfirst(LM1)) < 0 ) L = lcomp(A,L);
			else {
				if( icomp(Fi,lfirst(LM1)) > 0 ) {
					ind = 0;
					while( (LM1 != _0) && !ind ) {
						Pi = lfirst(LM1);
						Pi = iexp(Pi,lsecond(LM1));
						L = lcomp(Pi,L);
						LM1 = lred2(LM1);
						if( LM1 != _0 ) {
							if( !icomp(Fi,lfirst(LM1)) ) {
								ind = 1;
								L = qffmszcgitr1(m,D,LG,Fi,IT,L,lsecond(LM1),&IT);
								LM1 = lred2(LM1);
							}
							else if( icomp(Fi,lfirst(LM1)) < 0 ) {
								ind = 1;
								L = lcomp(A,L);
							}
						}
						else L = lcomp(A,L);
					}
				}
				else {
					L = qffmszcgitr1(m,D,LG,Fi,IT,L,lsecond(LM1),&IT);
					LM1 = lred2(LM1);	
				} 	
			}
		}
		else L = lcomp(A,L);		
	}
	for( ; LM1 != _0 ; LM1 = lred2(LM1) ) {
		Pi = lfirst(LM1);
		Pi = iexp(Pi,lsecond(LM1));
		L = lcomp(Pi,L);			
	}
	return( linv(L) );
}

/*c                     
	qffmszcgitr1 ist ein Unterprogramm zu qffmszcgitr,
	abgelegt als static modul.
	Hilfsprozedur.
c*/  
/*H
        Version 1       09.03.1993	A.Stein
H*/

static list qffmszcgitr1(m,D,L,Fi,ITI,ITD,Rfi,pLI)
single m;
pol D;
int Fi, Rfi;
list ITI, ITD, L;
list *pLI;
{
	single dq0, dq1, ind = 0;
	pol P, Q, P1, Q1, C, G, G1;
	int E, Z, V, GGT, I1, Fin;
	list L1, Lh, LS;
	bind(D,L,Fi,ITI,ITD,Rfi);
	init(E, Z, V, GGT, I1, Fin, P, Q, P1, Q1, C, G, G1);
	init( L1, Lh, LS );

	Fin = ineg(Fi);
	L1 = lfirst(L);
	L = lred(L);
	for(; icomp(Fin,lfirst(lfirst(lfirst(L1)))); L=lred(L) ) L1 = lfirst(L);
	while( !ind ) {
		if( ITI != _0 ) {
			I1 = lfirst(ITI);
			I1 = ifact60(I1);
			if( !icomp(Fi,lfirst(I1)) ) ITI = lred(ITI);
			else ind = 1;
		}
		else ind = 1;
	}
	for( LS = _0; L1 != _0; L1=lred(L1) ) {
		Lh = lfirst(L1);
		E  = lsecond(lfirst(Lh));
		E = ineg(E);
		Lh = lsecond(Lh);
		Q = lfirst(Lh);	P = lsecond(Lh);
		Q1 = Q; P1 = P; 
		G1 = list2(0,1);
		C = pmsprod(1,m,P,P);
		C = pmsdif(1,m,D,C);
		C = pmsquot(1,m,C,Q);
		Z=1; 
		do {
			G = qffmsspidprs(m,D,C,Q,P,Q1,P1,&Q1,&P1);
			G1 = pmsprod(1,m,G,G1);
			Z=isum(Z,1);
		}
		while( icomp(E,Z) );
		Q1 = pmsprod(1,m,Q1,G1);
		P1 = pmsprod(1,m,P1,G1);
		Q1 = qffmspidgenr(m,D,Q1,P1,G1,&P1);
		dq1 = pdegree(1,Q1);
		Q1 = pmsprod(1,m,Q1,Q1);
		P1 = pmsprod(1,m,P1,P1);
		P1 = pmsprod(1,m,P1,D);
		P1 = pmsdif(1,m,Q1,P1);
		dq0 = pdegree(1,P1);
		V = ( dq0 > dq1 ) ? ( dq0 - dq1 ) : ( dq1 - dq0 );
		GGT = iexp(Fi,Rfi);
		for( Z=0; mihom(GGT,V); Z=isum(Z,1) ) V = iprod(V,Fi); 
		Lh = ifel(ifact(E));
		E = lsecond(Lh);
		Z = isum(Z,E);
		Lh = list2(Z,E);
		LS = lcomp(Lh,LS);
	}
	Lh = list2(Rfi,0);
	LS = lcomp(Lh,LS);
	LS = qffmszcgitr2(LS);
	LS = qffmszcgitr3(LS);
	LS = qffmszcgitr2(LS);
	LS = linv(LS);
	if( !lfirst(lfirst(LS)) ) LS = lred(LS);
	while( LS != _0 ) {
		Z = lfirst(lfirst(LS));
		E = iexp(Fi,Z);
		ITD = lcomp(E,ITD);
		LS = lred(LS);
	}
	*pLI = ITI;
	return(ITD);
}

/*c                     
	qffmszcgitr2 ist ein Unterprogramm zu qffmszcgitr,
	abgelegt als static modul.
	Sortieren einer Liste von Paaren nach der ersten Komponente, absteigend.
c*/  
/*H
        Version 1       09.03.1993	A.Stein
H*/

static list qffmszcgitr2(L)
list L;
{
	single i;
	int I;
	list L1, LB;
	init(L1,LB);

	for( L1 = L; lred(L1) != _0; L1 = lred(L1) ) {
		LB = lred(L1);
		for( i=1; LB != _0 ; LB = lred(LB) ) {
			++i;
			I = lfirst(lfirst(LB));
			if( icomp(I,lfirst(lfirst(L1))) > 0 ) lerot(L1,1,i);
		}
	}			
	return(L);
}

/*c                     
	qffmszcgitr3 ist ein Unterprogramm zu qffmszcgitr,
	abgelegt als static modul.
	Hilfsprozedur zum vergleichen der Pare in qffmszcgitr2.
c*/  
/*H
        Version 1       09.03.1993	A.Stein
H*/

static list qffmszcgitr3(L)
list L;
{
	list LA, L1;
	int U, U1, I;
	init(LA,L1,I,U,U1);

	for( I = 0, L1 = L; L1 != _0; L1 = lred(L1) ) {
		LA = lfirst(L1);
		U = lfirst(LA);
		U = idif(U,lsecond(LA));
		if( icomp(U,I) > 0 ) {
			U1 = lfirst(LA);
			U1 = idif(U1,I);
			lsfirst(LA,U1);
			I = U;
		}
		else {
			U = lsecond(LA);
			lsfirst(LA,U);
		}			
	}
	return(L);
}
