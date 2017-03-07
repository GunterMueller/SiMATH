/*M
.SH NAME
putfl - put floating point (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putfl(f,n)
floating f;
single n;

.SH DESCRIPTION
putfl() 
writes the floating point number f in rounded
representation [-]0.z...ze[-]z...z
to stdout and returns 0.
Here 'e' stands for "10^..." and z for a figure from 0 to 9.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B n
|n| is the number of decimal places to write. If the value
of n is negative, trailing zeroes of the mantissa will not
be written. For example
.nf

f = 4/99, n =  6  gets "0.404040e-1"
f = 4/99, n = -6  gets "0.40404e-1"
f = e,    n = -14 gets "0.2718281828459e1"
f = e,    n = 14  gets "0.27182818284590e1"
f = e,    n = 11  gets "0.27182818285e1"
M*/

/*H
	Version 1       19.03.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putfl         : 910715.941201
H*/
/*
	For the definition of putfl please refer to the header file _arith1.h.
*/
