/*M
.SH NAME
putrd - put rational number decimal (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putrd(R,n)
rat R;
single n;

.SH DESCRIPTION
putrd()
writes the rational number R using decimal notation rounded to n places
to stdout and returns 0.
In case of a failure, the return code is ERROR.
The rounding error is at most (1/2) * 10^-n.
If the absolute value of R is rounded upwards, a trailing "+" will be added.
If the absolute value of R is rounded downwards, a trailing "-" will be added.
M*/

/*H
	Version 1       04.03.1987      R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putrd         : 890501.941201
H*/
/*
	For the definition of putrd please refer to the header file _arith1.h.
*/
