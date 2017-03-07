/*M
.SH NAME
flmant - floating point mantissa (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

int flmant(f)
floating f;

.SH DESCRIPTION                 
flmant() returns the mantissa a of the floating
point number f = a * (2^30)^d,
where a is integer and 2^30 is not a factor of a.
If f=0, then flmant() returns 0.
M*/

/*H    
	Version 1       21.03.1991      Marc Conrad
	Version 2	10.09.1992	Doku geaendert.  MC
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE flmant        : 910715.921130.941201
H*/
/*
	For the definition of flmant please refer to the header file _arith1.h.
*/
