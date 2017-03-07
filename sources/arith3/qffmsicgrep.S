/*M
.SH NAME
qffmsicgrep - quadratic function field over modular singles ideal class group system of representatives

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsicgrep(m, D, pHid)  
single m; 
pol D; 
int *pHid;
   
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X] of positive degree, i.e. Z/mZ(X,D^(1/2)) is a quadratic function field.
.TP 4
.B pHid 
points on an integer.
.PP
qffmsicgrep returns a list, say L, where 
.IP
L =  ( ( Q1 , P1 ) , ... , ( Ql , Pl ) ),
.PP
for j = 1,...,l, the Qj and Pj are polynomials in Z/mZ[X].
.PP
L is a system of representatives of the ideal class group.
.PP
The ideals [ Qj, Pj + D^(1/2) ] are all reduced ideals with sign(Qj) = 1.
.PP
qffmsicgrep writes the ideal class number of Z/mZ(X,D^(1/2)) to *pHid. 

.SH SEE ALSO
Bosco Weis, Diplomarbeit, Universit"at des Saarlandes, 1986.

M*/
                          
/*H
        Version 1       23.09.1992	A.Stein
   DATE qffmsicgrep   : 921130
H*/
	
#include <_arith3.h>

list qffmsicgrep(m,D,pHid)
single m;
pol D;
int *pHid;
{
	int H;
	pol d;
	list L;
	bind(D);
	init(H,d,L);

 /* Grad D gerade, sign(D) ein Quadrat in Z/mZ */

	if( seven(lfirst(D)) && (ijacsym(lsecond(D),m) > 0) ) {
		D = pmsmonic(1,m,D);
		d = upmssrpp(m,D);
		L = qffmsicgrr(m,D,d);
		L = qffmsicgstr(m,D,d,L,&H);
	}

 /* Grad P ungerade oder Grad P gerade, sign(P) kein Quadrat in Z/mZ */
	
	else L = qffmsicgri(m,D,&H);
	*pHid = H;
	return(L);
}
