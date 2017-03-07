/*M
.SH NAME
ecqnfdmod4 - elliptic curve over quadratic number field, 
field discriminant modulo 4 (MACRO)

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecqnfdmod4(E)
list E;

.SH DESCRIPTION
ecqnfdmod4() returns 1, if the discriminant of the quadratic number field K
is 1 mod 4, 0 otherwise.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ecqnfdmod4    : 931130.941201
H*/
/*
	For the definition of ecqnfdmod4 please refer to the header file _ec2.h.
*/
