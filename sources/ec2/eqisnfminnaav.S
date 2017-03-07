/*M
.SH NAME 
eqisnfminnaav - elliptic curve over quadratic number field with integral coefficients, short normal form, minimal equation at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  eqisnfminnaav(D, E, P, pi, z)
int    D;
list   E, P;
nfel pi;
single z;

.SH DESCRIPTION
eqisnfminnaav() returns the minimal equation of an elliptic curve E over a quadratic number field K = Q(D^(1/2)) with respect to a non archimedean absolute value.
.TP 3 
eqisnfminnaav() returns:
L = ( a4m, a6m ), where a1m=0, a2m=0, a3m=0, a4m and a6m are the minimal Weierstrass coefficients with respect to the given non archimedean absolute value.
.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi 
is a prime element of the prime ideal P.
.TP 4
.B z
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime
number in Q.
M*/
/*H
        Version 1       31.07.1998      S. Schmitt
   DATE eqisnfminnaav     :  980731
H*/

#include<_ec2.h>

list  eqisnfminnaav(D,E,P,pi,z)
int	D;
list 	E,P;
nfel pi;
single z;
{	
	nfel	h,u,a4,a6;
	single	f,g;
	list	L;

	init(h,u,a4,a6,L);

	bind(D,E,P,pi);


	a4=eqisnfa4(E);	
	a6=eqisnfa6(E); /* a4 und a6 sind ganz */


	f = -1;	
	if(a4)
	{
		f = qnfpiord(D,P,pi,z,a4);
		f = iquot(f,4);
	}
	if(f && a6)
	{
		g = qnfpiord(D,P,pi,z,a6);
		g = iquot(g,6);
		if(f>0) f = smin(f,g);
		else f=g;
	}
	if(f)
	{	u  = qnfexp(D,pi,f);
		u  = qnfprod(D,u,u);	/** u^2 **/
		h  = qnfprod(D,u,u);	/** u^4 **/
		if(a4) a4 = qnfquot(D,a4,h);
		h  = qnfprod(D,h,u);
		if(a6) a6 = qnfquot(D,a6,h);
	}

	L = list2(a4,a6);
	
	return(L);
}



