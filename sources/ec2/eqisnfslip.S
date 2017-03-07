/*M
.SH NAME
eqisnfslip - elliptic curve with integral coefficients over quadratic number
field, short normal form, search for linear independent points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfslip(E,r)
list E;
single r;

.SH DESCRIPTION
eqisnfslip() returns the list L=(L1,L2); list L1,L2;
where L2 contains r linear independent points of E(K), and L1 contains
all points which were found during the search.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/K over a quadratic number
field (see `ecqnfinit').
.TP 4
.B r
is a single precision number which should not be greater than the rank of
E over K.

M*/
/*H
	Version 1       04.10.1998      S. Schmitt
   DATE eqisnfslip    : 981015
H*/

#include <_ec2.h> 


list eqisnfslip( E,r )
list E;
single r;
{
	int D;
	list P,L;

	init(D,P,L);
    	bind( E );


	P = _0;
	L = _0;
	if(r==0) return(list2(P,L));

	D = ecqnfflddisc(E);
	if(isign(D)>0) L = erqislip(D,E,r);
	else L = eiqislip(D,E,r);

	return(L);
}
