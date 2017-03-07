/*M
.SH NAME
fgetvrfmsp1 - file get vector of rational functions over modular single primes, transcendence degree 1 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec fgetvrfmsp1(p, VL, pf)
single p;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetvrfmsp1() returns the vector of rational functions in one variable over Z/pZ
read from the input file *pf or ERROR in case an error has occurred.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B VL
is a list containing one variable.
.TP 4
.B pf
is a pointer to the input file.

.SH SEE ALSO
fgetrfmsp1
M*/







/*H
	Version 1       13.06.1989      U.Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvrfmsp1   : 890801.9109__.941201
H*/
/*
	For the definition of fgetvrfmsp1 please refer to the header file _matr3.h.
*/


