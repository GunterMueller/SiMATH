/*M
.SH NAME
fputvrfmsp1 - file put vector of rational functions over modular single primes,  transcendence degree 1 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputvrfmsp1(p, V, VL, pf)
single p;
vec V;
list VL;
FILE *pf;

.SH DESCRIPTION
fputvrfmsp1() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B V
is a vector of rational functions in one variable over Z/pZ.
.TP 4
.B VL
is a list containing one variable.
.TP 4
.B pf
is a pointer to the output file.
M*/







/*H
	Version 1       13.06.1989      U.Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputvrfmsp1   : 890801.9109__.941201
H*/
/*
	For the definition of fputvrfmsp1 please refer to the header file _matr3.h.
*/


