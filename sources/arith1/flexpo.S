/*M
.SH NAME
flexpo - floating point exponent (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single flexpo(f)
floating f;

.SH DESCRIPTION                 
flexpo() returns the exponent d of the floating
point number f = a * (2^30)^d,
where a is integer and 2^30 is not a factor of a.
M*/

/*H    
	Version 1       21.03.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE flexpo        : 910715.941201
H*/
/*
	For the definition of flexpo please refer to the header file _arith1.h.
*/
