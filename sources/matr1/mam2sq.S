/*M
.SH NAME
mam2sq - matrix over Z/2Z, special bit representation, square

.SH SYNOPSIS
.nf
#include<_matr1.h>

mam2sq(M)
matrix M;

.SH DESCRIPTION
mam2sq() returns M*M.

.PP
.TP 4
.B M
is a matrix over Z/2Z in special bit representation.
M*/
/*H
	Version 1       20.10.1995      Marc Conrad
   DATE mam2sq        : 951201
H*/

#include <_matr1.h>
/* Diese Funktion wird in der naechsten Version optimiert!? */
matrix mam2sq(M)
matrix M; 
{
	bind(M); 
	return( mam2prod(M, M) );
}
