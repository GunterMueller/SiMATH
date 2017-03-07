/*M
.SH NAME
putifel - put integer factor exponent list (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putifel(L)
list L;

.SH DESCRIPTION
putifel()
writes the the prime factorization list L
to stdout and returns 0.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B L
is the factor exponent list of a positive integer.
M*/
/*H
	Version 1        3.08.1988      Christine Hollinger
	Version 2       11.08.1988      Christine Hollinger
	Version 3       11.01.1990      C.H.  ( Druckbild )
   DATE fputifel      : 890501.900315.9203__.9311__
H*/

/*H	Version 1	11.01.1990	ChristineHollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putifel	      : 900315.9203__.941201
H*/
/*
	For the definition of puti please refer to the header file _arith1.h.
*/

