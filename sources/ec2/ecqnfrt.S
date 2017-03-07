/*M
.SH NAME
ecqnfrt - elliptic curve over quadratic number field reduction type

.SH SYNOPSIS
.nf
# include <_ec2.h>

single ecqnfrt(E,p,P,pi,z)
list E;
single p;
list P;
nfel pi;
single z;

.SH DESCRIPTION
ecqnfrt() determines the reduction type of the elliptic curve E at the 
prime ideal P. ecqnfrt() returns
	2, if E has good reduction at P,
	0, if E has additive reduction at P,
	-1, if E has non split multiplicative reduction at P,
	+1, if E has split multiplicative reduction at P.
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B p
is a single precision prime number.
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod') over the prime number p.
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
   DATE ecqnfrt     :   980731
H*/

#include <_ec2.h>

single ecqnfrt( E, p,P, pi, z )
list E;
single p;
list P;
nfel pi;
single z;
{
    nfel a1,a2,a3,a4,a6,c4,disc;
    int d;
    list L;

    init( a1,a2,a3,a4,a6,c4,disc );
    init(d);
    init(L);

    bind( E, P,pi );

    d = ecqnfflddisc(E);

	/** minimale Gleichung bzgl P **/

    L = ecqnfminnaav(d,E,P,pi,z);
    a1 = lfirst(L);
    a2 = lsecond(L);
    a3 = lthird(L);
    a4 = lfourth(L);
    a6 = lfifth(L);
    L = ecqnfinit(d,a1,a2,a3,a4,a6);

    disc = ecqnfacdisc(L);
    if(!qnfpiord(d,P,pi,z,disc)) return(2); /** gute Reduktion **/

    c4 = ecqnfacc4(L);
    if(!qnfpiord(d,P,pi,z,c4)) /** multiplikative Reduktion **/
    {
    	if(p==2) 
    	{
		if(mshom(8,d)==5)
		{
			a3 = qnfdif(d,a3,a2);
			a3 = qnfpihom(d,P,pi,z,a3);
			if(!a3) return(1);	/** zerfallend **/
			return(-1);		/** nicht zerfallend **/
		}
		a2 = qnfprod(d,a2,a1);
		a3 = qnfdif(d,a3,a2);
		a3 = qnfpihom(d,P,pi,z,a3);
		if(!a3) return(1);		/** zerfallend **/
		a3 = qnfdif(d,a3,itonf(1));
		a3 = qnfpihom(d,P,pi,z,a3);
		if(!a3) return(1);		/** zerfallend **/
		return(-1);			/** nicht zerfallend **/
    	}
    	if(p==3)
    	{
		a2 = ecqnfacb2(L);
		if(isqnfphsqu(d,a2,P,pi,z)==1) return(1);  /** zerfallend **/
		return(-1);				/** nicht zerfallend **/
    	}
    	a6 = ecqnfacc6(L);
    	c4 = qnfprod(d,c4,a6);
    	if(isqnfphsqu(d,c4,P,pi,z)==1) return(1);	/** zerfallend **/
    	return(-1);					/** nicht zerfallend **/

    }

    return(0); /** additive Reduktion **/
}
