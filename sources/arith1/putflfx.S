/*M
.SH NAME
putflfx - put floating point by fix point (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putflfx(f,vk,nk)
floating f;
single vk,nk;

.SH DESCRIPTION
putflfx()
writes the floating point number f in rounded
representation [-]zzz.zzz
to stdout and returns 0.
In case of a failure, the return code is ERROR.
Here 'z' stands for a figure from 0 to 9.
.PP
.TP 4
.B vk
must be positive and is the number of decimal digits to be written.
If less than vk digits are present, blanks will be inserted.
The optional sign does not account to vk.
.TP 4
.B nk
|nk| is the number of decimal places to write. If the value
of nk is negative, trailing zeroes of the mantissa will not
be written. For example
.nf

f = 4/99, vk = 3, nk =  3 gets "   0.040"  
f = 4/99, vk = 3, nk = -3 gets "   0.04"
f = e,    vk = 6, nk =  4 gets "      2.7183"
f = e,    vk = 6, nk =  0 gets "      3"  
f = -123  vk = 3, nk =  1 gets "-123.0"
f =  123  vk = 3, nk =  1 gets " 123.0"
f =  123  vk = 2, nk =  1 gets "123.0"
f = 2^30, vk = 3, nk =  4 gets "1073741824.0000"
f = 2^30, vk = 3, nk = -4 gets "1073741824"
M*/

/*H
	Version 1       21.05.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putflfx       : 910715.941201
H*/
/*
	For the definition of putflfx please refer to the header file _arith1.h.
*/
