/*M
.SH NAME
putecisnf - put elliptic curve with integer coefficients, short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

single putecisnf(E)
list E;

.SH DESCRIPTION
putecisnf writes all datas, beeing found in list E, of the model
of the elliptic curve E/Q in short Weierstrass normal form
on stdout and returns 0 or ERROR in case of an error occurs.
A description of the list E can be found in the documentation of ecrinit.
M*/
/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecisnf     : 930531.941201
H*/
/*
	For the definition of putecisnf please refer to the header file _ec1.h.
*/
