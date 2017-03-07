/*M
.SH NAME
putecr - put elliptic curve over rational numbers

.SH SYNOPSIS
.nf 
#include<_ec1.h>

single putecr(E)
list E;

.SH DESCRIPTION
putecr writes all datas of the elliptic curve E/Q , 
beeing found in the list E, on stdout, and returns 0 
or ERROR in case of an error occurs.
A description of the list E can be found in the
documentation of 'ecrinit'.

M*/

/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecr        : 930531.941201
H*/
/*
	For the definition of putecr please refer to the header file _ec1.h.
*/
