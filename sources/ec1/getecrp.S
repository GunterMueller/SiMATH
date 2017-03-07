/*M
.SH NAME
getecrp - get elliptic curve over rational numbers point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list getecrp( )

.SH DESCRIPTION
getecrp reads the point P from stdin, and returns P as a list ( x y z ), or
ERROR in case of an error occurs.
.PP
For a description of the possible representations of P, please refer to the documentation of 'fgetercp'.

.SH SEE ALSO
fgetecrp

M*/

/*H
	Version 1       17.12.1992  	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getecrp       : 930531.941201
H*/
/*
	For the definition of getecrp please refer to the header file _ec1.h.
*/
