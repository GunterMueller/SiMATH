/*M
.SH NAME 
ecqnfnetapa - elliptic curve over quadratic number field Neron-Tate pairing

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnfnetapa(D, E, P1, P2)
int    D;
list   E, P1, P2;

.SH DESCRIPTION
ecqnfnetapa() returns the Neron-Tate pairing < P1 , P2 > of two points P1 and P2 on an elliptic curve E over a quadratic number field K = Q(D^(1/2)).

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P1 , P2
are lists representing the points P1 and P2 on E(K), Pi = ( x_i, y_i, z_i )\  nfel x_i, y_i, z_i;   
M*/
/*H
        Version 1      02.01.1997	 Andreas Heiser
   DATE ecqnfnetapa  : 
H*/

#include<_ec2.h>

floating ecqnfnetapa(D,E,P1,P2)
int	D;
list	E,P1,P2;
{	floating	bi,h1,h2;
	nfel		a1,a2,a3,a4,a6;
	list		L,PP;
	pol		F;

	init(bi,h1,h2,a1,a2,a3,a4,a6,L,PP,F);
	bind(D,E,P1,P2);
	
	L=lfirst(E);
	L=lfirst(L);
	a1=lfirst(L);
	a2=lsecond(L);
	a3=lthird(L);
	a4=lfourth(L);	
	a6=lfifth(L);

	F=list4(2,1,0,-D);
	h1=ecqnfnetahe(D,E,P1);
	h2=ecqnfnetahe(D,E,P2);
	h2=flsum(h1,h2);
	PP=ecnfsum(F,a1,a2,a3,a4,a6,P1,P2);
	h1=ecqnfnetahe(D,E,PP);
	h1=fldif(h1,h2);
	bi=flquot(h1,itofl(2));
	return(bi);
}