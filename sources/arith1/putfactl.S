/*M
.SH NAME
putfactl - put factor list (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putfactl(L)
list L;

.SH DESCRIPTION
putfactl()
writes the the factor list L
to stdout and returns 0.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B L
is a list of the form ( p_1  e_1  p_2  e_2  ...  p_n  e_n )
with integers p_1, p_2, ..., p_n and singles e_1, e_2, ..., e_n 
(c.f. 'ifel'). It will be written as p1^e_1 * p2^e_2  * ... * p_n^e_n.
M*/

/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putfactl      : 930531.941201
H*/
/*
	For the definition of putfactl please refer to the header file _arith1.h.
*/
