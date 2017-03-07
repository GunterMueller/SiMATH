/*M
.SH NAME
fltofl - floating point to floating point (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating fltofl( f )
floating f;

.SH DESCRIPTION       
fltofl() returns f represented using the currently set value of FL_EPS.
The relative error is at most
.PP
  | ( g - f ) / f | < 1/2 * (2^30)^( 1 - FL_EPS ). 
.PP
The purpose of fltofl() is to convert a floating point number
which is internally represented using more than FL_EPS+1
list elements to a list using FL_EPS+1 elements at most.
M*/
/*H    
	Version 1       06.05.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fltofl        : 910715.941201
H*/
/*
	For the definition of fltofl please refer to the header file _arith1.h.
*/
