/*M
.SH NAME
isrem - integer single-precision remainder (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isrem(A,b)
int A;
single b;

.SH DESCRIPTION
isrem() returns  A - Q*b, where Q is the integer part of A / b for b!=0.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isrem         : 890501.941201
H*/
/*
	For the definition of isrem please refer to the header file _arith1.h.
*/
