/*M
.SH NAME
upgfsrf - univariate polynomial over Galois-field with single characteristic root finding (rekursiv)

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsrf(p, AL, P)  
single p; 
list AL; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4                                         
.B P
is a monic and univariate polynomial over GF(p^n), deg(P) >= 1.
.PP
upgfsrf returns a list, containing all zeros of P.

.SH CAUTION
upgfsrf should only be used for polynomials, which completly split into linear factors. Otherwise, upgfsrf needs disproportional much time. In this case, please use upgfscfact.
 
.SH SEE ALSO
.nf
gfsalgen
upgfscfact

M*/
                                
/*H
	Version 1       14.07.1988      J.Schmitt
        Version 2       19.06.1989      V.Schwinn  (s.u.)
   DATE upgfsrf       : 890501.890801.9203__
H*/

#include <_pol3.h>

list upgfsrf(p,AL,P)
single p;
list AL;
pol P;
{
	list L,L1,L2;
	pol Q1,X,Tr,GCD1,GCD2;
	gfel a,d,k;
	single m,c,i,j,k1,m1,n;
	bind(AL,P);
	init(L,L1,L2,a,d,k,Q1,X,Tr,GCD1,GCD2);

	L=_0;

/*  Abspalten reiner X Potenzen */
	Q1=list2(1,list2(0,1));
	while (pgfseval(1,p,AL,P,0)==0) {
		P=pgfsquot(1,p,AL,P,Q1);
		L=lcomp(0,L);
	}
	if (pdegree(1,P)==0)         
    { 
      return(L);
    }

/*  P ist schon Linearfaktor  */
	if (pdegree(1,P)==1) {
		d=pgfseval(1,p,AL,P,0);
		d=gfsneg(p,AL,d);
		L=lcomp(d,L);  
		return(L);
	}

/*  eigentliche Faktorisierung */
	i=pdegree(1,P);
	m=lfirst(lfirst(AL));
	c = (-1);                                        /* vs */
	do {
		c++;                                     /* vs */
		a = list2(c,1);
		Q1=upgfsmprem(p,AL,a,p,P);
		Tr=list2(1,a);
		for (j=1;j<m;j++) {
			Tr=pgfssum(1,p,AL,Tr,Q1);
			Tr=pgfsrem(1,p,AL,Tr,P);
			k1 = 2;
			while ( k1 <= p ) k1 = k1 + k1;
			k1 /= 2;
			n = lfirst(P);

			X = Q1;
			m1 = p - k1;
			do {
				Q1 = pgfsprod(1,p,AL,Q1,Q1);
				if (lfirst(Q1)>=n) Q1 = pgfsrem(1,p,AL,Q1,P);
				k1 /= 2;
				if ( m1 >= k1 ) {
					Q1 = pgfsprod(1,p,AL,X,Q1);
					if (lfirst(Q1)>=n) Q1=pgfsrem(1,p,AL,Q1,P);
					m1 -= k1;
				}
			}
			while ( k1 != 1 );
		}
		if ( (Tr != 0) && (lfirst(Tr)!=0) ) {    /* vs */
			for (j=0;j<p;j++) {
				Tr=pgfssum(1,p,AL,Tr,list2(0,list2(0,1)));
				GCD1=upgfsgcd(p,AL,P,Tr);
				if((0<pdegree(1,GCD1))&&(pdegree(1,GCD1)<i)) break;
			}
		}
	}
	while ((c!=m)&&((0==pdegree(1,GCD1))||(pdegree(1,GCD1)==i)));
	if (c==m) return(L);
	GCD2=pgfsquot(1,p,AL,P,GCD1);

	if (pdegree(1,GCD1)==1) {
		a=pgfseval(1,p,AL,GCD1,0);
		a=gfsneg(p,AL,a);
		L1=list1(a);
	}
	if (pdegree(1,GCD2)==1) {
		a=pgfseval(1,p,AL,GCD2,0);
		a=gfsneg(p,AL,a);
		L2=list1(a);
	}
	if (lfirst(GCD1)> 1)      L1=upgfsrf(p,AL,GCD1);
	if (lfirst(GCD2)> 1)      L2=upgfsrf(p,AL,GCD2);

	L=lconc(L1,L2); 
	return(L);
}
