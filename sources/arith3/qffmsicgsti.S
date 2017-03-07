/*M
.SH NAME
qffmsicgsti - quadratic function field over modular singles ideal class group structure, imaginary case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicgsti(m, D, L)  
single m; 
pol D; 
list L;

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
.B L
= ((Q1, P1), ..., (Ql, Pl)), where for 1 <= j <= l, Qj and Pj are polynomials in Z/mZ[X]. L is a system of representatives of the ideal class group (s. qffmsicgri). The ideals [Qj, Pj + D^(1/2)] are all reduced ideals such that
.IP 
 Qj | ( D - Pj^2 ) ,
 sign(Qj) = 1 and 
 deg(Pj) < deg(Qj) <= deg(D)/2 
.IP
holds.
.PP
qffmsicgsti returns a list, say L1, where
.IP
L1 = (Ic_1, Ic_2, ... , Ic_r) 
.PP
is a minimal system of representatives of the ideal class group.
.PP
Every Ic_k (k = 1, ..., n) represents a sub class and is in the form of 
.IP
((Q_k1, P_k1), ..., (Q_kn, P_kn)), 
.PP
so Ic_k is a subset of L.
  
.SH SEE ALSO
 qffmsicgsti
 Literature: Bosco Weis, Diplomarbeit, Universit"at des 
             Saarlandes, 1986.

M*/
                             
/*H
        Version 1       28.09.1992	A.Stein
	Version 2	26.01.1993	Zuweisung 'm =' gestrichen. AS
   DATE qffmsicgsti   : 921130.930531
H*/

#include <_arith3.h>

list qffmsicgsti(m,D,L)
single m;
pol D;
list L;
{

	if( sodd(lfirst(D)) ) return(L);
    {

	single i, k, r, ex, dd2;
	int R;
	list L1, L11, L111, LID, IDS;
	pol A, Q, P, Q1, P1;
	bind(D,L);
	init(R,L1,L11,LID,IDS,A,Q,P,Q1,P1);

	L1 = L;
	k = lsecond(D);
	dd2 = lfirst(D)/2;
	while( L1 != _0 ) {
		LID = lfirst(L1);
		if( lfirst(lfirst(lsecond(LID))) == dd2 ) {
			i = 0;
			ex = lfirst(LID);
			Q = lfirst(lsecond(LID));
			P = lsecond(lsecond(LID));
			A = pmsprod(1,m,P,P);
			A = pmsdif(1,m,A,D);
			A = pmsquot(1,m,A,Q);
			do {
				r = mshom(m,isprod(4,i));
				P1 = pmsmsprod(1,m,A,r);
				R = isprod(i,isum(i,i));
				R = isum(R,isprod(k,8));
				r = mshom(m,R);
				P1 = pmssum(1,m,P1,pmsmsprod(1,m,P,r));
				R = isprod(i,isprod(k,4));
				r = mshom(m,R);
				if( r ) P1 = pmssum(1,m,P1,pmsmsprod(1,m,Q,r));
				R = isprod(i,isum(i,i));
				R = idif(R,isprod(k,8));
				r = msinv(m,mshom(m,R));
				P1 = pmsmsprod(1,m,P1,r);
				r = mshom(m,16);
				Q1 = pmsmsprod(1,m,A,r);
				r = mshom(m,isprod(i,16));
				Q1 = pmssum(1,m,Q1,pmsmsprod(1,m,P,r));
				R = isprod(i,isprod(i,4));
				r = mshom(m,R);
				Q1 = pmssum(1,m,Q1,pmsmsprod(1,m,Q,r));
				Q1 = pmsmonic(1,m,Q1);
				IDS = list2(Q1,P1);
				LID = leins(LID,1,IDS);
				IDS = list2(ex,IDS);
				L11 = L1;
				while( !oequal(IDS,lsecond(L11)) ) L11 = lred(L11);
				L111 = lred2(L11);
				lsred(L11,L111);
				++i;				
			}
			while( i != m );
		}
		L1 = lred(L1);
	}
	return(L);	
    }
}

	


