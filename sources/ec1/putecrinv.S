/*M
.SH NAME
putecrinv - put elliptic curve over the rational numbers, invariants

.SH SYNOPSIS
.nf
#include<_ec1.h>

single putecrinv(E) 
list E ;

.SH DESCRIPTION
putecrinv writes all datas concerning the invariants of the 
elliptic curve  E/Q, defined in the list E, on stdout,
and returns 0 or ERROR in case of an error occurs.
 
M*/
/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecrinv     : 930531.941201
H*/
/*
	For the definition of putecrinv please refer to the header file _ec1.h.
*/
