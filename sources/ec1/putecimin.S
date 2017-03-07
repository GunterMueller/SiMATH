/*M
.SH NAME
putecimin - put elliptic curve with integer coefficients, minimal model

.SH SYNOPSIS
.nf
#include<_ec1.h>

single putecimin(E)
list E;

.SH DESCRIPTION
putecimin writes all datas of the minimal model of the elliptic curve E/Q,
beeing found in the list E, on stdout, and returns 0 or ERROR in case of an error occurs.
A description of the list E can be found in the 
documentation of 'ecrinit' .

.SH SEE ALSO
ecrinit

M*/
  
/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecimin     : 930531.941201
H*/
/*
	For the definition of putecimin please refer to the header file _ec1.h.
*/
