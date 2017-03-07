/*M
.SH NAME
ecqnfpnp23 - elliptic curve over quadratic number field number modulo prime ideal

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecqnfpnp23(E, P, pi, z)
list   E, P;
nfel pi;
single z;

.SH DESCRIPTION
ecqnfpnp23() returns the number of points of an elliptic curve E over a quadratic
number field K = Q(D^(1/2)) modulo a prime ideal.
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod'). The prime ideal P divides a prime number not equal to 2.
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
   DATE ecqnfpnp23     :980731
H*/


# include <_ec2.h>




static single ecqnfpn23(D,L,P,pi,z)
int D;
list L,P;
nfel pi;
single z;
{
	nfel a1,a2,a3,a4,a6;
	nfel omega,A,Y,X,K,H,B;
	single p,a,b,c,d,n;

	bind(D,L,P,pi);
	init(a1,a2,a3,a4,a6,omega,A,Y,X,K,H,B);

	a1 = lfirst(L);
	a2 = lsecond(L);
	a3 = lthird(L);
	a4 = lfourth(L);
	a6 = lfifth(L);

	a1 = qnfpihom(D,P,pi,z,a1);
	a2 = qnfpihom(D,P,pi,z,a2);
	a3 = qnfpihom(D,P,pi,z,a3);
	a4 = qnfpihom(D,P,pi,z,a4);
	a6 = qnfpihom(D,P,pi,z,a6);

	p = qnfidprime(P,pi,z);

	if(z)  /** verzweigt oder zerlegt **/ 
	{
		if(a1) a1 = lthird(a1); /** a1 = 0 oder (1 0 a) **/
		if(a2) a2 = lthird(a2); 
		if(a3) a3 = lthird(a3); 
		if(a4) a4 = lthird(a4); 
		if(a6) a6 = lthird(a6); 
		n = ecmspnp(p,a1,a2,a3,a4,a6);
		return(n);
	}

	if(mshom(4,D)==1) omega = list4(2,1,1,1);
	else omega = list4(1,1,1,0);

	n = 1; /** O **/

	for(a =0;a<p;a++)
	{
		Y = itonf(a);
		for(b=0;b<p;b++)
		{
			B = qnfsum(D,Y,a3);
			B = qnfprod(D,B,Y);
			H = qnfprod(D,a1,Y);
			for(c=0;c<p;c++)
			{
				X = itonf(c);
				for(d=0;d<p;d++)
				{
					A = qnfsum(D,X,a2);
					A = qnfprod(D,A,X);
					A = qnfsum(D,A,a4);
					A = qnfprod(D,A,X);
					A = qnfsum(D,A,a6);
					A = qnfpihom(D,P,pi,z,A);
					K = qnfprod(D,H,X);
				 	K = qnfsum(D,B,K);
					K = qnfpihom(D,P,pi,z,K);
					K = qnfdif(D,K,A);
					K = qnfpihom(D,P,pi,z,K);
					if(!K) n++;
					
					X = qnfsum(D,X,omega);
				}
			}
			Y = qnfsum(D,Y,omega);
		}	
	}

	return(n);



}


int ecqnfpnp23(E,P,pi,z)
list E,P;
nfel pi;
single z;
{

	int n,d;
	list L;

	bind(E,P,pi);
	init(n,d,L);

	d = ecqnfflddisc(E);
	L = ecqnfminnaav(d,E,P,pi,z);
	n = ecqnfpn23(d,L,P,pi,z);
	return(n);
}
