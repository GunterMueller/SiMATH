/*M
.SH NAME
maam - matrix adjoin matrix

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maam(M, el)
matrix M;
obj el;

.SH DESCRIPTION
maam() returns the matrix MN which is obtained by concatenating
M with the matrix N = el*I where I is the unity matrix.
 
.PP
.TP 4
.B M
is a mxn matrix over a certain ring R.
.TP 4
.B el
is an element of the ring R.

.SH CAUTION
M will be changed.
M*/
/*H
	Version 1       03.11.1988      Klaus Petry
   DATE maam          : 890501.8910__
H*/

#include <_matr1.h>

matrix maam (A, el)
matrix A;
obj el;

{
	matrix B=A, E;
	list Z;

	bind (A);
	init (E);

	E = maconsdiag (manrrow (A), el);
	while (B != _0) {
		Z = lfirst (B);
		lconc (Z, lfirst (E));
		B = lred (B);
		E = lred (E);
		}
	return (A);
}
