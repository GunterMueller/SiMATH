/*M
.SH NAME
pgfshlift - polynomial over galois field of single characteristic hensel lifting

.SH SYNOPSIS
.nf
#include<_pol3.h>

single pgfshlift(r, p, AL, P, Q, R, d, pQQ, pRR)
single r, p, d; 
list AL; 
pol P, Q, R, *pQQ, *pRR;
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.        
.TP 4
.B AL 
is the arihmetic list of the finite field with characteristic p, say K.
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
.B pQQ, pRR 
point on two polynomials.
.PP
pgfshlift writes two polynomials of degree < d to *pQQ and *pRR, say QQ and RR respectively, such that 
.IP
RR(0,...,0,X)=R(X), QQ(0,...,0,X)=Q(X),and
.IP
RR * QQ is congruent to P modulo the ideal      (Y_1, ..., Y_(r-1))^d.
.PP
QQ and Q have the same degree in X and the same leading coefficient.   
.PP
pgfshlift returns 0 by success and ERROR else.

M*/
                    
/*H
	Version 1	16.03.95	Wolfgang Schwarz
   DATE pgfshlift     : 951201
H*/

#include <_pol3.h>

single pgfshlift(r,p,AL,P,QU,RU,d,pQ,pR)
single r,p,d;
list AL;
pol P,QU,RU,*pQ,*pR;
{pol A,B,D,Q,R,Delta,Quot,AQ,EINS;
 nfel c;
 single i,i2;
 
    bind(AL,P,QU,RU);
    init(A,B,D,Q,R,Delta,Quot,AQ,EINS,c);

/* Initialisierung */

    EINS=itopi(r+1,1);
    D=upgfsegcd(p,AL,QU,RU,&A,&B);  /* AQ+BR=1 */
    if (D==ERROR) return(ERROR);

    if (!ispconst(1,D,&c)) return(ERROR); /* Q und R nicht teilerfremd */
    if (!c) return(ERROR);
    c=gfsinv(p,AL,c);
    A=pgfsgfsprod(1,p,AL,A,c);
    B=pgfsgfsprod(1,p,AL,B,c);

    Q=pvinsert(1,QU,r-1);
    R=pvinsert(1,RU,r-1);
    A=pvinsert(1,A,r-1);
    B=pvinsert(1,B,r-1);

/* Quadratisches Lifting */

    for (i=1;i<d;i=i2)
     {	i2=2*i;if (i2>d) i2=d;
	Delta=pgfstrprod(r,p,AL,Q,R,1,i2);
	Delta=pgfsdif(r,p,AL,P,Delta); /* P-QR */

	D=pgfstrprod(r,p,AL,Delta,B,1,i2);
	Quot=pgfsqrem(r,p,AL,D,Q,&D);
	Quot=ptdtrunc(r,Quot,1,i2);
	D=ptdtrunc(r,D,1,i2);
	Q=pgfssum(r,p,AL,Q,D);
			    
	Quot=pgfssum(r,p,AL,Quot,EINS);
	R=pgfstrprod(r,p,AL,R,Quot,1,i2); 
	D=pgfstrprod(r,p,AL,Delta,A,1,i2);
	R=pgfssum(r,p,AL,R,D);				     
   
	AQ=pgfstrprod(r,p,AL,A,Q,1,i2);
	Delta=pgfstrprod(r,p,AL,B,R,1,i2);
	Delta=pgfssum(r,p,AL,Delta,AQ);
	Delta=pgfsdif(r,p,AL,EINS,Delta); /* 1-(AQ+BR) */

	D=pgfstrprod(r,p,AL,Delta,B,1,i2); 
	Quot=pgfsqrem(r,p,AL,D,Q,&D);
	Quot=ptdtrunc(r,Quot,1,i2);
	D=ptdtrunc(r,D,1,i2);
	B=pgfssum(r,p,AL,D,B);
	Delta=pgfssum(r,p,AL,Delta,EINS);
	A=pgfstrprod(r,p,AL,A,Delta,1,i2);
	D=pgfstrprod(r,p,AL,Quot,R,1,i2); 
	A=pgfssum(r,p,AL,A,D);
     }

/* Ausgabe */

   *pQ=Q; *pR=R;
   return(0);
}
