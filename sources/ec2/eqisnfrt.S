/*M
.SH NAME
eqisnfrt - elliptic curve over quadratic number field with integral coefficients,short normal form, reduction type

.SH SYNOPSIS
.nf
# include <_ec2.h>

single eqisnfrt(E,p,P,pi,z)
list E;
single p;
list P;
nfel pi;
single z;

.SH DESCRIPTION
eqisnfrt() determines the reduction type of the elliptic curve E at the 
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
   DATE eqisnfrt     :  980731
H*/

#include <_ec2.h>

single eqisnfrt( E, p,P, pi, z )
list E;
single p;
list P;
nfel pi;
single z;
{
    nfel a4,a6,c4,disc;
    int d;
    single s;
    list L;

    init( a4,a6,c4,disc );
    init(d);
    init(L);

    bind( E, P,pi );

    d = ecqnfflddisc(E);

	/** minimale Gleichung bzgl P **/

    L = eqisnfminnaav(d,E,P,pi,z);	
    a4 = lfirst(L);
    a6 = lsecond(L);
    L = ecqnfinit(d,0,0,0,a4,a6);

    disc = ecqnfacdisc(L);
    if(!qnfpiord(d,P,pi,z,disc)) return(2); /** gute Reduktion **/

    c4 = ecqnfacc4(L);
    if(!qnfpiord(d,P,pi,z,c4)) /** multiplikative Reduktion **/
    {
	/** p=2 kann nicht auftreten. **/
    	if(p==3)
    	{
		a4 = ecqnfacb2(L);
		s=isqnfphsqu(d,a4,P,pi,z);
		return(s);
    	}
    	a6 = ecqnfacc6(L);
    	c4 = qnfprod(d,c4,a6);
    	s=isqnfphsqu(d,c4,P,pi,z);
	return(s);

    }

    return(0); /** additive Reduktion **/
}
