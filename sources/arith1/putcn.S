/*M
.SH NAME
putcn - put complex number (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putcn(a,v,n)
complex a;
single v,n;

.SH DESCRIPTION
putcn()
writes the the complex number a
to stdout and returns 0.
In case of a failure, the return code is ERROR.
Let a = x+y*i with floating point numbers x and y.
The output of fputcn() is of the form "x + y i",
where x and y are written using fputflfx().
fputflfx() is given the number v of decimal digits
and the number n of decimal places to write.
Special cases:
.PP
.nf
    x =  0 , "x +" will not be written
    y =  0 , "+ y i" will not be written
    y = +1 , only "i" will be written
    y = -1 , only "-i" will be written

Examples: let v = n = 1, given the value of a

    4+3*i : "4.0 + 3.0 i"
        0 : "0"
     -3*i : "-3.0 i"
        i : "i"
       -i : "-i"
     12.5 : "12.5"
M*/

/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putcn         : 931130.941201
H*/
/*
	For the definition of putcn please refer to the header file _arith1.h.
*/
