/*M
.SH NAME
qffmsordsicr - quadratic function field over modular singles order of one single ideal class, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsordsicr(m, D, d, LE, ID, OS)  
single m; 
pol D, d;
list LE, ID; 
int OS;
      
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
.B LE
= ((Q1, P1), ..., (Ql,Pl)) is a list, containing lists of two polynomials Qj and Pj in Z/mZ[x], representing all members of (1) in the ideal class group. The ide-als 
.IP
[ Qj, Pj + D^(1/2) ]
.IP
are reduced, i.e. 
.IP
 Qj |( D - Pj^2 )
 sign(Qj) = 1 and
 deg(Pj) < deg(Qj) (s. qffmsicggr)
.TP 4
.B ID
is a list, containig two polynomials in Z/mZ[x], say Q and P, such that
.IP
[ Q, P + D^(1/2) ]
is a (primitive) reduced ideal, i.e.
.IP
 Q | ( D - P^2 )
 sign(Q) = 1 and
 deg(P) < deg(Q)
.TP 4
.B OS
gives an upper bound for the computation of the order of the ideal class.
.PP
Let ORD be minimal, such that
.IP
[ Q, P + D^(1/2) ] ^ ORD = (1),
.PP
then qffmsordsicr returns min{ORD, OS}.

.SH SEE ALSO
qffmsicggr

M*/
            
/*H
        Version 1       29.09.1992	A.Stein
   DATE qffmsordsicr  : 921130
H*/

#include <_arith3.h>

int qffmsordsicr(m,D,d,LE,ID,OS)
single m;
pol D, d;
list LE, ID;
int OS;
{
	single deg;
	int I;
	pol C1, Q1, P1, Q2, P2;
	bind(D,d,LE,ID,OS);
	init(C1,Q1,P1,Q2,P2,I);

	Q1 = lfirst(ID);
	P1 = lsecond(ID);
	P1 = upmsrem(m,P1,Q1);
	if( qffmsiselic(m,D,LE,Q1,P1) ) return(1);
	Q2 = Q1;
	P2 = P1;
	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
	deg = lfirst(d);
	I = 1;
	do {
		qffmsspidprs(m,D,C1,Q1,P1,Q2,P2,&Q2,&P2);
		if( pdegree(1,Q2) >= deg ) {
			qffmsrspidrd(m,D,d,Q2,P2,&Q2,&P2);
			Q2 = pmsmonic(1,m,Q2);
			P2 = upmsrem(m,P2,Q2);
		}
		I = isum(I,1);
	}
	while( ( !qffmsiselic(m,D,LE,Q2,P2) ) && ( icomp(I,OS) <= 0 ) );
	return(I);
}	
	
