/*M
.SH NAME
pnfhlift - polynomial over number field hensel lifting

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfhlift(r, F, P, Q, R, d, pQQ) 
single r, d; 
pol F, P, Q, R, *pQQ;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is a polynomial, generating a number field, say K.
.TP 4
.B P
is a polynomial over K in the variables Y_1,...,Y_(r-1),X.
.TP 4
.B Q, R
are univariate and coprime polynomials in the variable X over K, such that
P(0,...,0,X) = Q(X)*R(X).
.TP 4
.B d
is a natural number.
.TP 4
.B pQQ
points on a polynomial.
.PP
pnfhlift returns a polynomial, say PP, and writes a polynomial, say QQ, to *pQQ, where PP and QQ are polynomials in r variables, such that
.IP
PP(0,...,0,X)=P(X), QQ(0,...,0,X)=Q(X),and
.IP
PP * QQ is congruent to P modulo the ideal      (Y_1, ..., Y_(r-1))^d.
.PP
QQ and Q have the same degree in X and the same leading coefficient.
   
M*/
          
/*H
	Version 1	08.03.95	Wolfgang Schwarz
   DATE pnfhlift      : 951201
H*/

#include <_pol3.h>

pol pnfhlift(r,F,P,Q,R,d,pQQ)
single r,d;
pol F,P,Q,R,*pQQ;
{pol A,B,C,D,Delta,Quot,AQ,EINS;
 nfel c;
 single i;
 
    bind(F,P,Q,R);
    init(A,B,C,D,Delta,Quot,AQ,EINS,c);

/* Initialisierung */

    EINS=pitopnf(r,itopi(r,1));
    D=upnfegcd(F,Q,R,&A,&B);  /* AQ+BR=1 */

    if (!ispconst(1,D,&c)) return(ERROR); /* Q und R nicht teilerfremd */

    Q=pvinsert(1,Q,r-1);
    R=pvinsert(1,R,r-1);
    A=pvinsert(1,A,r-1);
    B=pvinsert(1,B,r-1);

/* Quadratisches Lifting */

    for (i=1;i<d;i*=2)
     {	Delta=pnfprod(r,F,Q,R);
	Delta=pnfdif(r,F,P,Delta); /* P-QR */


/* ... Delta auf Grad i in Y herabdruecken ... */



	D=pnfprod(r,F,Delta,B);
	Quot=pnfqrem(r,F,D,Q,&D);
	Q=pnfsum(r,F,Q,D);
			    
	Quot=pnfsum(r,F,Quot,EINS);
	R=pnfprod(r,F,R,Quot); 
	D=pnfprod(r,F,Delta,A);
	R=pnfsum(r,F,R,D);				     
   
	AQ=pnfprod(r,F,A,Q);
	Delta=pnfprod(r,F,B,R);
	Delta=pnfsum(r,F,Delta,AQ);
	Delta=pnfdif(r,F,EINS,Delta); /* 1-(AQ+BR) */


/* ... Delta auf Grad i in Y herabdruecken ... */



	D=pnfprod(r,F,Delta,B); 
	Quot=pnfqrem(r,F,D,Q,&D);
	B=pnfsum(r,F,D,B);
	Delta=pnfsum(r,F,Delta,EINS);
	A=pnfprod(r,F,A,Delta);
	D=pnfprod(r,F,Quot,R); 
	A=pnfsum(r,F,A,D);
     }
   *pQQ=Q;
   return(R);
}
