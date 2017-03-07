/*M
.SH NAME
mactransp - matrix, constructive transpose

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mactransp(M)
matrix M;

.SH DESCRIPTION
mactransp() returns the transpose of the matrix M without changing M.
M*/

/*H
	Version 1       22.06.1988      Klaus Petry
	Version 1       22.11.1988      Klaus Petry     Null entfaellt
   DATE mactransp     : 890501.9011__
H*/


# include <_matr1.h>

matrix mactransp( M )
matrix M;

{
	matrix Mtransp = 0;
	matrix Mspt, Msp;
	list Ztransp, Z;

	bind( M, Mtransp );
	init( Mspt, Msp, Ztransp, Z );

	Mtransp = _0;
	Mspt = lcopy( M );
	while( lfirst( Mspt ) != _0 ) {
		Msp = Mspt;
		Ztransp = _0;
		while( Msp != _0 ) {
			Z = lfirst( Msp );
			Ztransp = lcomp( lfirst( Z ), Ztransp );
			lsfirst( Msp, lred( Z ) );
			Msp = lred( Msp );
			}
		Mtransp = lcomp( linv( Ztransp ), Mtransp );
		}
	Mtransp = linv( Mtransp );
	return( Mtransp );
}
