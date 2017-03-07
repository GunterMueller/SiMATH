/*M
.SH NAME
qffmsicgstr - quadratic function field over modular singles ideal class group structure, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicgstr(m, D, d, LG, pHid)  
single m; 
pol D, d;
list LG; 
int *pHid;
  
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
.B LG
=  ( ( Q1 , P1 ) , ... , ( Ql , Pl ) ). For j = 1,...,l, the Qj and Pj are polynomials in Z/mZ[X]. LG is a system of representatives of the ideal class group (without grouping in classes) (s. qffmsicgrr).
.PP
qffmsicgstr writes the ideal class number of Z/mZ(X,D^(1/2)) to *pHid and returns a list L = (Ic_1, ..., Ic_hid) containing a minimal system of representa-tives of the ideal class group (with grouping in classes). The Ic_k are lists themself and subsets of LG.
  
.SH SEE ALSO
Bosco Weis, Diplomarbeit, Universit"at des Saarlandes, 1986.
M*/
             
/*H
        Version 1       28.09.1992	A.Stein
   DATE qffmsicgstr   : 921130
H*/

#include <_arith3.h>

static pol qffmsicgstr1(single,pol,pol,pol,pol,pol*,pol*);

list qffmsicgstr(m,D,d,LG,pHid)
single m;
pol D, d;
list LG;
int *pHid;
{
	int Hid;
	pol Qm1, Q0, P0, Q1, P1;
	list L, LS, LSS, LSSS, LID, ID, IDS;

	bind(D,d,LG);
	init(Qm1,Q0,Q1,P0,P1);
	init(L,LS,LSS,LID,ID,IDS);
	init(Hid);
	
	L = LG;
	LS = LG;
	while( LS != _0 ) {
		ID = lfirst(LS);
		LID = list1(ID);
		lsfirst(LS,LID);
		Q0 = lfirst(ID);
		P0 = lsecond(ID);
		Qm1 = pmsprod(1,m,P0,P0);
		Qm1 = pmsdif(1,m,D,Qm1);
		Qm1 = pmsquot(1,m,Qm1,Q0);
		qffmsicgstr1(m,d,Qm1,Q0,P0,&Q1,&P1); /* 1 Schritt in KBE */
		Qm1 = Q0;
		Q0 = Q1;
		Q1 = pmsmonic(1,m,Q1);
		IDS = list2(Q1,P1);
  /* 
     Einmal wird die Quasi-Periode der KBE eines Ideals durchlaufen, um alle
     Repraesentanten einer Idealklasse zu finden, d.h. alle zueinander
     aequivalenten, reduzierten Ideale.
  */
		while( !oequal(ID,IDS) ) {
			LID = leins(LID,1,IDS);
			LSS = LS;
			while( !oequal(IDS,lsecond(LSS)) ) LSS = lred(LSS);
			LSSS = lred2(LSS);
			lsred(LSS,LSSS);
			P0 = P1;
			qffmsicgstr1(m,d,Qm1,Q0,P0,&Q1,&P1); /* 1 Schritt in KBE */
			Qm1 = Q0;
			Q0 = Q1;
			Q1 = pmsmonic(1,m,Q1);
			IDS = list2(Q1,P1);
		}
		LS = lred(LS);
		Hid = isum(Hid,1);
	}
	*pHid = Hid;
	return(L);
}

/*c
	qffmsicgstr1 ist ein Unterprogramm zu qffmsicgstr,
	abgelegt als static modul. 
	Berechnet wird ein Schritt in der Kettenbruchentwicklung
	einer reell-quadratischen Irrationalitaet.
	qffmsicgstr1 ist gleich qffmsicggrs6 (UP zu qffmsicggr).
c*/  
/*H
        Version 1       28.09.1992	A.Stein
H*/

static pol qffmsicgstr1(m,d,Qm1,Q0,P0,pQ1,pP1)
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
