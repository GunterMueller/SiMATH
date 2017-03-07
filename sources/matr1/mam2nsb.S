/*M 
.SH NAME
mam2nsb - matrix over Z/2Z, special bit representation, null space basis

.SH SYNOPSIS
.nf
#include <_matr1.h>

object mam2nsb(A)
matrix A;

.SH DESCRIPTION
mam2nsb() returns a matrix in special bit representation
whose rows are a basis of the null space of A, or
_0 in case A is regular.

.PP
.TP
.B A
is a matrix over Z/2Z in special bit representation.

.SH CAUTION
A will be changed.

.SH NOTE
Calling mam2nsb(A) is equivalent to the call mam2gnsb(A, _0, 0).

.SH SEE ALSO
mam2gnsb
M*/

/*H
	Version 1	20.10.1995	Marc Conrad
	Version 2	20.03.1996	Die Arbeit wird jetzt in 
					mam2gnsb() gemacht.
					Marc Conrad
   DATE mam2nsb       : 951201.960501
H*/

#include <_matr1.h>

matrix mam2nsb(A)
	matrix A; 
	{ 
	return( mam2gnsb( A, _0, 0 ) ); 
	} 




