/*M
.SH NAME
sexp - single-precision exponentiation (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sexp(a,n)
single a,n;

.SH DESCRIPTION
sexp() returns a ^ n for n >=0 and |a^n|<BASIS.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen            
	Version 2	12.10.90		Marc Conrad
						a ersetzt durch (a),
						b durch (b)
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE sexp          : 890501.901120.941201
H*/
/*
	For the definition of sexp please refer to the header file _arith1.h.
*/
