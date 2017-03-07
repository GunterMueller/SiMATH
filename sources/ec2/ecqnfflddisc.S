/*M
.SH NAME
ecqnfflddisc - elliptic curve over quadratic number field, 
field discriminant (MACRO)

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecqnfflddisc(E)
list E;

.SH DESCRIPTION
ecqnfflddisc() returns the discriminant of the quadratic number field K.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ecqnfflddisc  : 931130.941201
H*/
/*
	For the definition of ecqnfflddisc please refer to the header file _ec2.h.
*/
