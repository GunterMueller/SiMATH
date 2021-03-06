/*M
.SH NAME
fgetmagf2 - file get matrix over Galois-field of characteristic 2 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix fgetmagf2(G, VL, pf)
obj G;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmagf2() returns the matrix of elements of the Galois-field GF(2^n) generated by G,
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B VL
is the variable list of G which contains one element.
.TP 4
.B pf
is a pointer to the input file.
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE fgetmagf2     : 951201
H*/
/*
	For the definition of fgetmagf2 please refer to the header file _matr2.h
*/

