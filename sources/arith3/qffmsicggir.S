/*M
.SH NAME
qffmsicggir - quadratic function field over modular singles ideal class group generators and isomorphy type, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicggir(m, D, d, H, L, pIT)  
single m; 
pol D, d; 
int H; 
list L, *pIT;
 
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
.TP 4
.B H 
is the ideal class number of Z/mZ((X,D^(1/2)).
.TP 4
.B L
= ( Ic_1, Ic_2, ... , Ic_hid ) is a system of repre-sentatives of the ideal class group, given for example by qffmsicgstr (s. qffmsicgstr).
.PP 
qffmsicggir returns a list, say LG, and writes a list, say IT, to *pIT, where
.TP 4
for H = 1
LG is equal to L and IT is empty. Then, the ideal class group is isomorphic to the integral numbers. 
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
Thereby, the I_1mj,...,I_k_mj, ..., I_11, ..., I_l1 are reduced ideals, so they are representatives of the ideal class group (s. qffmsicgrr
and qffmsicgstr) and generators of the cyclic subgroups with (positive) prime power
.IP
pj^mj, ... , pj^mj, ... , pj^1, ... , pj^1.
.TP 4
IT = (n1, .., ni)
represents the isomorphy type of the ideal class group, i.e. the nj (1 <= j <= i) are integer numbers, nj <= n(j+1), and the ideal class gr
oup is isomorphic to
.IP
(Z / n1Z) x (Z / n2Z ) x ... x (Z / niZ).

.SH NOTES
The negative signs in the Lj are only for programming reasons. Mathemeticaly, they are totaly irrelevant.

.SH SEE ALSO
Literature: B. Weis, Diplomarbeit, Universitaet Saarbruecken, 1986.
.nf   
qffmsicgstr
qffmsicgrr
M*/
       
/*H
        Version 1       28.09.1992	A.Stein
   DATE qffmsicggir   : 921130.9305__
H*/

#include <_arith3.h>

static list qffmsicggir1(single,pol,pol,list,int,list*);
static list qffmsicggir2(list,list);
static single qffmsicggir3(single,pol,pol,int,list,list);
static single qffmsicggir4(single,pol,pol,list,list,int,list,single);
static single qffmsicggir5(single,pol,pol,pol,pol,list,list);
static pol qffmsicggir6(single,pol,pol,pol,pol,pol*,pol*);
static list qffmsicggir7(list);

list qffmsicggir(m,D,d,H,L,pIT)
single m;
pol D, d;
int H;
list L, *pIT;
{
	single i, ind, e, a;
	int P, PN, OS, M;
	list LF, L1, L11, Lh, LC, LA, LE, ID;
	bind(D,d,H,L);
	init(P,OS,M,LF,L1,LC,LE,ID,LA);

	if( !icomp(H,1) ) { *pIT = _0; return( L ); }
	LF = ifact(H);
	LF = ifel(LF);
	OS = lipairspmax(LF);
	L1 = qffmsicggir1(m,D,d,L,OS,&LE);
	L1 = qffmsicggir2(LF,L1);
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
				i = (!ind) ? (qffmsicggir3(m,D,d,M,ID,LC)) : (1);
				if( i ) {
					e -= a;
					qffmsicggir4(m,D,d,ID,LC,M,LE,ind);
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
	*pIT = qffmsicggir7(L);
	return(L);
}

/*c                     
	qffmsicggir1 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul.
	Zu allen Idealklassen wird die zugehoerige Ordnung berechnet.
	Zudem werden alle Idealklassen eliminiert, deren Ornung keine
	Primzahlpotenz ist.
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static list qffmsicggir1(m,D,d,L,OS,pLE)
single m;
pol D, d;
list L, *pLE;
int OS;
{
	int I;
	pol Qm1, Q0, P0, Q1, P1;
	list LE, L1, LF, LID, ID, ID1, IDS;
	bind(D,d,L,OS);
	init(Qm1,Q0,P0,Q1,P1,LE,L1);
	init(LE,L1,LF,LID,ID,ID1,IDS,I);

	L1 = _0;
	Q0 = list2(0,1);
	P0 = d;
	Qm1 = pmsdif(1,m,D,pmsprod(1,m,d,d));
	ID1 = list2(Q0,P0);
	LE = list1(ID1);
	qffmsicggir6(m,d,Qm1,Q0,P0,&Q1,&P1);
	Qm1 = Q0; Q0 = Q1;
	Q1 = pmsmonic(1,m,Q1);
	IDS = list2(Q1,P1);
	while( !oequal(IDS,ID1) ) {
		LE = lcomp(IDS,LE);
		P0 = P1;
		qffmsicggir6(m,d,Qm1,Q0,P0,&Q1,&P1);
		Qm1 = Q0; Q0 = Q1;
		Q1 = pmsmonic(1,m,Q1);
		IDS = list2(Q1,P1);
	}
	while( L != _0 ) {
		LID = lfirst(L);
		L = lred(L);
		ID = lfirst(LID);
		I = qffmsordsicr(m,D,d,LE,ID,OS);
		LF = ifel(ifact(I));
		if( ( icomp(I,1) > 0 ) && ( icomp(I,OS) <= 0 ) ) {
			if( lred2(LF) == _0 ) {
				IDS = lcomp(LF,LID);
				L1 = lcomp(IDS,L1);
			}	
		}
	}
	*pLE = LE;
	return(L1);
}


/*c                     
	qffmsicggir2 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul.
	Elemente der Idealklassengruppe, deren Ordnung Potenz 
	derselben Primzahl ist, werden zu Teillisten geordnet.
	Diese Teillisten werden dann so sortiert, dass die Ordnung 
	der entsprechenden Idealklassen monoton faellt. 
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static list qffmsicggir2(LF,LG)
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
	qffmsicggir3 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul.
	Es wird untersucht, ob der von einer Idealklasse erzeugte Zykel
	mit der bereits erzeugten Gruppe ein direktes Produkt bildet.
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static single qffmsicggir3(m,D,d,M,ID,L)
single m;
pol D, d;
int M;
list ID, L;
{
	single ind, deg;
	int J;
	pol C1, Q1, P1, Q2, P2;
	list IDS, LA, LAA, L1;
	bind(D,d,M,ID,L);
	init(J,C1,P1,Q1,P2,Q2); 

	ind = 1;
	J = 2;
	Q1 = lfirst(ID);
	P1 = lsecond(ID);
	P1 = upmsrem(m,P1,Q1);
	Q2 = Q1;
	P2 = P1;
	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
	deg = lfirst(d);
	while( ind && (icomp(J,M) < 0) ) {
		qffmsspidprs(m,D,C1,Q1,P1,Q2,P2,&Q2,&P2);
		if( pdegree(1,Q2) >= deg ) {
			qffmsrspidrd(m,D,d,Q2,P2,&Q2,&P2);
			Q2 = pmsmonic(1,m,Q2);
			P2 = upmsrem(m,P2,Q2);
		}
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
	qffmsicggir4 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul.
	Es werden alle Potenzen einer gegebenen Idealklasse berechnet
	und markiert. Ausserdem werden alle Produkte mit bereits
	markierten Idealklassen ermittelt.
	( vgl. qffmsicggir5 )
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static single qffmsicggir4(m,D,d,ID,L,POT,LE,ind)
single m, ind;
pol D, d;
list ID, L, LE;
int POT;
{
	single ind2, deg;
	int I;
	pol C1, Q1, P1, Q2, P2;
	list LA, LAA, L1, Lh;
	bind(D,d,ID,L,LE,POT);
	init(I,C1,P1,Q1,P2,Q2); 
	

	Q1 = lfirst(ID);
	P1 = lsecond(ID);
	P1 = upmsrem(m,P1,Q1);
	Q2 = Q1;
	P2 = P1;
	I = 2;
	if( !ind ) qffmsicggir5(m,D,d,Q2,P2,L,LE);
	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
	deg = lfirst(d);
	while( icomp(I,POT) < 0 ) {
		qffmsspidprs(m,D,C1,Q1,P1,Q2,P2,&Q2,&P2);
		if( pdegree(1,Q2) >= deg ) {
			qffmsrspidrd(m,D,d,Q2,P2,&Q2,&P2);
			Q2 = pmsmonic(1,m,Q2);
			P2 = upmsrem(m,P2,Q2);
		}
		if( !ind ) qffmsicggir5(m,D,d,Q2,P2,L,LE);
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
	qffmsicggir5 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul.
	Es werden alle Produkte einer gegebenen Idealklasse mit den
	Idealklassen der Untergruppe der Idealklassengruppe berechnet,
	die bereits ermittelt sind. Diese werden markiert.
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static single qffmsicggir5(m,D,d,Q,P,L,LE)
single m;
pol D, d, Q, P;
list L, LE;
{
	single ind, deg;
	pol C, Qs, Ps;
	list LG, LA, L1, LB, LBB, IDS, Lh;
	bind(D,d,Q,P,L,LE);
	init(C,Qs,Ps,LA,IDS);
	
	C = pmsprod(1,m,P,P);
	C = pmsdif(1,m,D,C);
	C = pmsquot(1,m,C,Q);
	deg = lfirst(d);
	for( LG=L ; LG != _0; LG=lred(LG) ) {
		LA = lfirst(LG);	
		L1 = L;
		if( lsecond(lfirst(LA)) < 0 ) {
			LA = lsecond(LA);
			Qs = lfirst(LA);
			Ps = lsecond(LA);
			Ps = upmsrem(m,Ps,Qs);
			qffmsspidprs(m,D,C,Q,P,Qs,Ps,&Qs,&Ps);
			if( pdegree(1,Qs) >= deg ) {
				qffmsrspidrd(m,D,d,Qs,Ps,&Qs,&Ps);
				Qs = pmsmonic(1,m,Qs);
				Ps = upmsrem(m,Ps,Qs);
			}
			ind = 0;
			if( !qffmsiselic(m,D,LE,Qs,Ps) ) {
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
	qffmsicggir6 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul. 
	Berechnet wird ein Schritt in der Kettenbruchentwicklung
	einer reell-quadratischen Irrationalitaet.
	qffmsicggir6 ist gleich qffmsicgstrs (UP zu qffmsicgstr).
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/
	
static pol qffmsicggir6(m,d,Qm1,Q0,P0,pQ1,pP1)
single m;
pol d, Qm1, Q0, P0;
pol *pQ1, *pP1;
{
	pol a0, P1;
	bind(d,Qm1,Q0,P0);
	init(a0,P1);
	
	a0 = pmssum(1,m,P0,d);
	a0 = pmsqrem(1,m,a0,Q0,&P1);	/* P0+d = a0*Q0+r0	*/
	P1 = pmsdif(1,m,d,P1);		/* P1 = d - r0		*/
	P0 = pmsdif(1,m,P0,P1);
	P0 = pmsprod(1,m,P0,a0);
	*pQ1 = pmssum(1,m,P0,Qm1);	/* Q1 = a0*(P0-P1)+Qm1	*/
	*pP1 = P1;
	return(a0);
}

/*c
	qffmsicggir6 ist ein Unterprogramm zu qffmsicggir,
	abgelegt als static modul. 
	Berechnet wird der Isomorphietyp der Idealklassengruppe.
	Gleichzeitig werden Erzeugende, die nichts zur Isomorphie
	beitragen, weggefiltert. L wird dabei veraendert.
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static list qffmsicggir7(L)
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
