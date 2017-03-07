/*M
.SH NAME 
ecqnfreg - elliptic curve over quadratic number field regulator

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnfreg(D, E, L)
int    D;
list   E, L;

.SH DESCRIPTION
ecqnfreg() returns the regulator of a given set of r points P1,...,Pr on an elliptic curve E over a quadratic number field K = Q(D^(1/2)).

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B L
is a list containing r points Pi = ( xi, yi, zi ) on E(K), L = ( P1 ... Pr ).   
M*/
/*H
        Version 1       06.01.1997      Andreas Heiser
   DATE ecqnfreg     :  
H*/


#include<_ec2.h>

floating ecqnfreg(D,E,L)
int	D;
list	E,L;
{	pol		P;
	list		H,P1,P2,V;
	floating	reg,h1,h2,h3;
	matrix		M;
	single		i,j,n;
	nfel		a1,a2,a3,a4,a6,h;
	init(a1,a2,a3,a4,a6,H,P,P1,P2,V,M,i,j,n,reg,h,h1,h2,h3);
	bind(D,E,L);
	
	V=pmakevl("x");
	P=list4(2,1,0,-D);
	H=lfirst(E);
	H=lfirst(H);
	a1=lfirst(H);
	a2=lsecond(H);
	a3=lthird(H);
	a4=lfourth(H);	
	a6=lfifth(H);
	n=llength(L);
	M=maconszero(n,n);
	M=maitomafl(M);
	H=L;
	for(i=1;i<=n;i++)
	{	P1=lfirst(H);
		h1=ecqnfnetahe(D,E,P1);
		h1=masetel(M,i,i,h1);
		H=lred(H);
	}
	for(i=1;i<=n;i++)
	{	H=L;
		h1=maselel(M,i,i);
		P1=lfirst(H);
		H=lred(H);
		for(j=i+1;j<=n;j++)
		{	h2=maselel(M,j,j);
			h2=flsum(h1,h2);
			P2=lfirst(H);
			P2=ecnfsum(P,a1,a2,a3,a4,a6,P1,P2);
			h3=ecqnfnetahe(D,E,P2);
			h2=fldif(h3,h2);h2=flquot(h2,itofl(2));
			h2=masetel(M,i,j,h2);
			h2=masetel(M,j,i,h2);
			H=lred(H);
		}
		L=lred(L);
	}
	reg=mafldet(M);
	return(reg);
}


