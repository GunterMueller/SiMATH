/*M
.SH NAME
itofl - integer to floating point (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating itofl(A)
int A;

.SH DESCRIPTION
itofl() returns the value of the integer A
as a floating point number f.
The relative error is at most:
.PP
| ( A - f ) / A | < 1/2 * (2^30)^( 1 - FL_EPS )
M*/

/*H    
	Version 1       18.03.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE itofl         : 910715.941201
H*/
/*
	For the definition of itofl please refer to the header file _arith1.h.
*/
