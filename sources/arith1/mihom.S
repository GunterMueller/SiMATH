/*M
.SH NAME
mihom - modular integer homomorphism

.SH SYNOPSIS
.nf
#include<_arith1.h>

int mihom(M,A)
int M,A;

.SH DESCRIPTION
mihom() returns the representative of A
in the positive residue system Z/MZ for M>0.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      10.02.1987      Alter Name "mihomp" geaendert.  RB
   DATE mihom         : 890501
H*/


# include <_arith1.h>

int mihom ( M,A )
int M,A;
{
	int R;
	bind( M, A, R );
	R = irem( A, M );
	if ( isign(R) < 0 )  R = isum( R,M );
	return( R );
}
