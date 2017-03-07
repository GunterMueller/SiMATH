/*M
.SH NAME
qffmsppssii \- 
quadratic function field over modular singles,
evaluation of psi function
.\" ( q, g, al )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmsppssii( q, g, al )
single q, g, al;

psi =  qffmsppssii( q, g, al );

.SH DESCRIPTION
.TP 4
.B q 
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.

.TP 4
.B g
is the genus of a real quadratic function field over k.

.TP 4
.B al
is an integer > 0.

.TP 4
.B psi
= ( ( 2 g + 3 ) / ( q^(1/2) - 1 ) ) * q^(-al/2).

.SH SEE ALSO
.BR qffmsapprox(),
.BR qffmsreglap()
M*/
/*H
	Version 1	14.08.97	Andreas Stein
H*/
#include <_arith2.h>

floating qffmsppssii( q, g, al )
single q, g, al;
{
	floating Psi, fq, fg;
	init( fg, fq, Psi );

	g = 2 * g + 3;
	fg = itofl( g );	
	fq = itofl( q );
	Psi = flsqrt( fq );
	Psi = ( seven( al ) ) ? ( fldif( Psi, itofl( 1 ) ) ) : ( fldif( fq, Psi ) );
	q = iexp( q, (al/2) );
	fq = itofl( q );
	Psi = flprod( fq, Psi );
	Psi = flquot( fg, Psi );
	return( Psi );
}