/*M
.SH NAME
eqisnfspbh - elliptic curve with integral coefficients over quadratic number
field, short normal form, search points with bounded height

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfspbh(E,A)
list E;
floating A;

.SH DESCRIPTION
eqisnfspbh() returns the list L=(P1,...,Pn) with all points of E(K) with
Weil-height less or equal to A.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/K over a quadratic number
field (see `ecqnfinit').
.TP 4
.B A
is a positive floating point number.

M*/
/*H
	Version 1       07.10.1998      S. Schmitt
   DATE eqisnfspbh    : 981015
H*/

# include <_ec2.h>

list eqisnfspbh( E,A )
list E;
floating A;
{
	list L;
	int D;

	init(L,D);
	bind(E,A);

 	D = ecqnfflddisc(E);                                                    
        if(isign(D)>0) L = erqispbh(D,E,A);                                     
        else L = eiqispbh(D,E,A);                                               
                                                                                
        return(L);                    

}
