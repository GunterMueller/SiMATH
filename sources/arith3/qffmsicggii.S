 /*M
.SH NAME
qffmsicggii - quadratic function field over modular singles ideal class group generators and isomorphy type, imaginary case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicggii(m, D, H, L, pIT)  
single m; 
pol D; 
int H;
list L, *pIT;
                                                                
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
.B H 
is the ideal class number of Z/mZ(X,D^(1/2)).
.TP 4
.B L
is a list of representatives of the ideal class group (s. qffmsicgri).
.PP
qffmsicggii returns a list, say LG, and writes a list, say IT, to *pIT, where
.TP 4
for H = 1
LG is equal to L and IT is empty.
.TP 4
for 1 < H = p1^m1 * p2^m2 * ... * pk^mk,
LG = (L1, L2,..., Lk), where for 1 <= j <= k,
.IP
the Lj are generators of the ideal class group.
.IP
Lj = ( ( (- pj , - pj^mj) I_1mj , ... , I_kmj) ,
                         .
                         .
       ( (- pj , - pj^1) I_11  , ... , I_l1) ).
.IP
Thereby, the I_1mj,...,I_k_mj, ..., I_11, ..., I_l1 are reduced ideals, so they are representatives of the ideal class group (s. qffmsicgrr and qffmsicgstr) and generators of the cyclic subgroups with (positive) prime power
.IP
pj^mj, ... , pj^mj, ... , pj^1, ... , pj^1.
.TP 4
IT = (n1, .., ni)
represents the isomorphy type of the ideal class group, i.e. the nj (1 <= j <= i) are integer numbers, nj <= n(j+1), and the ideal class group is isomorphic to 
.IP
(Z / n1Z) x (Z / n2Z ) x ... x (Z / niZ).

.SH NOTES 
The negative signs in the Lj are only for programming reasons. Mathemetical, they are totaly irrelevant.

.SH SEE ALSO
Literature: B. Weis, Diplomarbeit, Universitaet Saarbruecken, 1986.
.nf
qffmsicgri
qffmsicgrr
qffmsicgstr

M*/
                                
/*H
        Version 1       26.01.1993	A.Stein
   DATE qffmsicggii   : 930531
H*/

#include <_arith3.h>

static list qffmsicggii1(single,pol,list,int);
static list qffmsicggii2(list,list);
static single qffmsicggii3(single,pol,int,list,list);
static single qffmsicggii4(single,pol,list,list,int,single);
static single qffmsicggii5(single,pol,pol,pol,list);
static list qffmsicggii6(list);

list qffmsicggii(m,D,H,L,pIT)
single m;
pol D;
int H;
list L, *pIT;
{
	single i, ind, e, a;
	int P, PN, OS, M;
	list LF, L1, L11, Lh, LC, LA, ID;
	bind(D,H,L);
	init(P,OS,M,LF,L1,LC,ID,LA);

	if( !icomp(H,1) ) { *pIT = _0; return( L ); }
	LF = ifact(H);
	LF = ifel(LF);
	OS = lipairspmax(LF);
	L1 = qffmsicggii1(m,D,L,OS);
	L1 = qffmsicgsti(m,D,L1);
	L1 = qffmsicggii2(LF,L1);
	LF = linv(LF);
	for( L=L1; LF != _0 ; LF=lred2(LF) ) {
		e = lfirst(LF);
		P = lsecond(LF);
		L11 = lfirst(L1);
		L1 = lred(L1);
		LC = L11;
		for( ind=1; e > 0 ; L11=lred(L11) ) {
			ID = lfirst(L11);
			LA = lfirst(ID);
			ID = lsecond(ID);	
			a = lsecond(LA);
			if( a > 0 ) {
				M = iexp(P,a);
				i = (!ind) ? (qffmsicggii3(m,D,M,ID,LC)) : (1);
				if( i ) {
					e -= a;
					qffmsicggii4(m,D,ID,LC,M,ind);
					ind = 0;
					PN = ineg(P);
					lsfirst(LA,PN);
					M = ineg(M);
					Lh = lred(LA);
					lsfirst(Lh,M);
				}
			}
		}
	}
	*pIT = qffmsicggii6(L);
	return(L);
}

/*c                     
	qffmsicggii1 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul.
	Zu allen Idealklassen wird die zugehoerige Ordnung berechnet.
	Zudem werden alle Idealklassen eliminiert, deren Ordnung keine
	Primzahlpotenz ist.
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

static list qffmsicggii1(m,D,L,OS)
single m;
pol D;
list L;
int OS;
{
	int I;
	list LH, LQ, LS, LF, L1;
	pol Q, P;
	bind(D,L,OS);
	init(LQ,LS,LF,L1,I,Q,P);

	for( L1 = _0; L != _0; L = lred(L) ) {
		LH = lfirst(L);
		P = lfirst(LH);
		LQ = lsecond(LH);
		while( LQ != _0 ) {
			LS = lfirst(LQ);
			LQ = lred(LQ);
			Q = lsecond(LS);
			I = qffmsordsici(m,D,Q,P,OS);
			LF = ifel(ifact(I));
			if( ( icomp(I,1) > 0 ) && ( icomp(I,OS) <= 0 ) ) {
				if( lred2(LF) == _0 ) {
					LH = list2(Q,P);
					LH = list2(LF,LH);
					L1 = lcomp(LH,L1);
				}	
			}
		}
	}
	return(L1);
}

/*c
	qffmsicggii2 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul.
	Elemente der Idealklassengruppe, deren Ordnung Potenz 
	derselben Primzahl ist, werden zu Teillisten geordnet.
	Diese Teillisten werden dann so sortiert, dass die Ordnung 
	der entsprechenden Idealklassen monoton faellt. 
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

static list qffmsicggii2(LF,LG)
list LF, LG;
{
	single i;
	list L, LG1, LA, LM, LC;
	int P, P1;
	bind(LF,LG);
	init(P,P1,L,LG1,LA,LM,LC);

   /*	Elemente der Idealklassengruppe, deren Ordnung Potenz 
	derselben Primzahl ist, werden zu Teillisten geordnet. */

	for( L=_0; LF != _0; LF = lred2(LF) ) {
		P = lfirst(LF);
		for( LG1=LG, LM=_0; LG1 != _0; LG1=lred(LG1) ) {
			LA = lfirst(LG1);
			P1 = lfirst(lfirst(LA));
			if( !icomp(P,P1) ) LM = lcomp(LA,LM);
		}
		L = lcomp(LM,L);
	}

   /*	Ordnen der Teillisten so, dass die Ordnung der 
	entsprechenden Idealklassen monoton faellt. 	*/
	
	for( LG1=L; LG1 != _0; LG1=lred(LG1) ) {
		for( LA=lfirst(LG1); (LM=lred(LA)) != _0; LA=lred(LA) ) {
			for( i=1; LM != _0; LM=lred(LM) ) {
				LC = lfirst(LM);
				i++;
				P = lsecond(lfirst(LC));
				P1 = lsecond(lfirst(lfirst(LA)));
				if( icomp(P,P1) > 0 ) lerot(LA,1,i);
			}
		}
	}
	return(L);
}

/*c
	qffmsicggii3 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul.
	Es wird untersucht, ob der von einer Idealklasse erzeugte Zykel
	mit der bereits erzeugten Gruppe einen trivialen Schnitt hat.
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

#include <_arith3.h>

static single qffmsicggii3(m,D,M,ID,L)
single m;
pol D;
int M;
list ID, L;
{
	single ind;
	int J;
	pol C1, Q1, P1, Q2, P2;
	list IDS, LA, LAA, L1;
	bind(D,M,ID,L);
	init(J,C1,P1,Q1,P2,Q2); 

	ind = 1;
	J = 2;
	Q1 = lfirst(ID);
	P1 = lsecond(ID);
	Q1 = pmsmonic(1,m,Q1);
	P1 = upmsrem(m,P1,Q1);
	Q2 = Q1;
	P2 = P1;
	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
	while( ind && (icomp(J,M) < 0) ) {
		qffmsspidprs(m,D,C1,Q1,P1,Q2,P2,&Q2,&P2);
		qffmsispidrd(m,D,Q2,P2,&Q2,&P2);
		Q2 = pmsmonic(1,m,Q2);
		P2 = upmsrem(m,P2,Q2);
		J = isum(J,1);
		for( L1=L; ind && (L1 != _0); L1=lred(L1) ) {
		    LA = lfirst(L1);
		    for( LAA=lred(LA); ind && (LAA != _0); LAA=lred(LAA) ) {
			IDS = lfirst(LAA);
			if( qffmsiseqids(m,D,Q2,P2,lfirst(IDS),lsecond(IDS) ) && 
				(lsecond(lfirst(LA)) < 0 ) ) ind = 0;
		    }
		}
	}
	return(ind);
}

/*c                     
	qffmsicggii4 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul.
	Es werden alle Potenzen einer gegebenen Idealklasse berechnet
	und markiert. Ausserdem werden alle Produkte mit bereits
	markierten Idealklassen ermittelt.
	( vgl. qffmsicggii5 )
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

static single qffmsicggii4(m,D,ID,L,POT,ind)
single m, ind;
pol D;
list ID, L;
int POT;
{
	single ind2;
	int I;
	pol C1, Q1, P1, Q2, P2;
	list LA, LAA, L1, Lh;
	bind(D,ID,L,POT);
	init(I,C1,P1,Q1,P2,Q2); 
	
	Q1 = lfirst(ID);
	P1 = lsecond(ID);
	P1 = upmsrem(m,P1,Q1);
	Q2 = Q1;
	P2 = P1;
	I = 2;
	if( !ind ) qffmsicggii5(m,D,Q2,P2,L);
	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
	while( icomp(I,POT) < 0 ) {
		qffmsspidprs(m,D,C1,Q1,P1,Q2,P2,&Q2,&P2);
		qffmsispidrd(m,D,Q2,P2,&Q2,&P2);
		Q2 = pmsmonic(1,m,Q2);
		P2 = upmsrem(m,P2,Q2);
		if( !ind ) qffmsicggii5(m,D,Q2,P2,L);
		for( L1=L, ind2=0; (L1 != _0) && !ind2; L1=lred(L1) ) {
			LA = lfirst(L1);
			for(LAA=lred(LA); (LAA!=_0) && !ind2; LAA=lred(LAA)) {
				Lh = lfirst(LAA); 	
				if( qffmsiseqids(m,D,Q2,P2,lfirst(Lh),lsecond(Lh)) ) {
					Lh = lfirst(LA);
					Lh = lred(Lh);
					lsfirst(Lh,(-1));
					ind2 = 1;
				}
			}
		}
		I = isum(I,1);
	}
	return(0);
}

/*c                     
	qffmsicggii5 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul.
	Es werden alle Produkte einer vorgegebenen Idealklasse mit den
	Elementen der bereits ermittelten Untergruppe der Idealklassengruppe 
	berechnet. Diese werden markiert.
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

static single qffmsicggii5(m,D,Q,P,L)
single m;
pol D, Q, P;
list L;
{
	single ind;
	pol C, Qs, Ps;
	list LG, LA, L1, LB, LBB, IDS, Lh;
	bind(D,Q,P,L);
	init(C,Qs,Ps,LA,IDS);
	
	C = pmsprod(1,m,P,P);
	C = pmsdif(1,m,D,C);
	C = pmsquot(1,m,C,Q);
	for( LG=L ; LG != _0; LG=lred(LG) ) {
		LA = lfirst(LG);	
		L1 = L;
		if( lsecond(lfirst(LA)) < 0 ) {
			LA = lsecond(LA);
			Qs = lfirst(LA);
			Ps = lsecond(LA);
			Ps = upmsrem(m,Ps,Qs);
			qffmsspidprs(m,D,C,Q,P,Qs,Ps,&Qs,&Ps);
			qffmsispidrd(m,D,Qs,Ps,&Qs,&Ps);
			Qs = pmsmonic(1,m,Qs);
			Ps = upmsrem(m,Ps,Qs);
			ind = 0;
			if( lfirst(Qs) ) {
				for( ; (L1 != _0) && !ind; L1=lred(L1) ) {
					LB = lfirst(L1);
					LBB=lred(LB); 
					while( (LBB != _0) && !ind ) {
						IDS = lfirst(LBB);
						LBB=lred(LBB); 
						if( qffmsiseqids(m,D,Qs,Ps,lfirst(IDS),lsecond(IDS))  ) {
							if( lfirst(lfirst(LB)) > 0 ) {
								Lh = lfirst(LB);
								Lh = lred(Lh);
								lsfirst(Lh,(-1));
							}
							ind = 1;
						}
					}
				}
			}
		}
	}
	return(0);
}

/*c
	qffmsicggii6 ist ein Unterprogramm zu qffmsicggii,
	abgelegt als static modul. 
	Berechnet wird der Isomorphietyp der Idealklassengruppe.
	Gleichzeitig werden Erzeugende, die nichts zur Isomorphie
	beitragen, weggefiltert. L wird dabei veraendert.
c*/  
/*H
        Version 1       26.01.1993	A.Stein
H*/

static list qffmsicggii6(L)
list L;
{
	int I;
	list IT, L1, LA, LH;
	bind(L);
	init(IT,L1,LA,I);

	L1 = L;
	for( IT=_0; L1 != _0; L1=lred(L1) ) {
		LA = lfirst(L1);
		I = lsecond(lfirst(lfirst(LA)));
		I = ineg(I);
		IT = lcomp(I,IT);
		while( lred(LA) != _0 ) {
			if( lsecond(lfirst(lsecond(LA))) == -1 ) {
				LH = lred2(LA);
				lsred(LA,LH);
			}
			else {
				I = lsecond(lfirst(lsecond(LA)));
				I = ineg(I);
				IT = lcomp(I,IT);
				LA = lred(LA);
			}
		}
	}
	return( linv(IT) );
}

