/*M
.SH NAME
fputonfel - file put original number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputonfel(F, a, V, pf)  
pol F; 
nfel a; 
list V; 
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.TP 4
.B V
is a list of variables, V contains one element.    
.TP 4
.B pf
points on an output file.
.PP
fputonfel writes a to the file *pf and returns 0 by success and ERROR else.

.SH NOTES
A more predictable but slower output of a is given by fputnfel. 
 
.SH SEE ALSO
 nfneg
 fputnfel

M*/

/*H
	Version 1       14.03.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placebo F )
   DATE fputonfel     : 890601.901120
H*/

#include <_arith2.h>

fputonfel( F, a, V, pf )
pol F;
nfel a;
list V;
FILE *pf;
{
	single t = 0;
	int HNa;
	init( HNa );
	bind( a,V );

	/*** a = 0 -> Ausgabe: 0 ***/
	if ( !a )       fprintf( pf,"0\n");

	/*** a = ( HNa, r, ar, ...,a0 ) -> Ausgabe fuer Hna > 1:
					   1/HNa * ( ar*x^r +...+ a0 )***/
	else
	{       HNa = lfirst( a );

		/*** HNa > 1 -> Faktor 1/HNa und Klammern ausgeben. ***/
		if ( HNa != 1 )
			fprintf( pf,"1/%i * ( ", HNa );
		a = lred( a );
		a = dptop( 1,a );
		t = fputpi( 1, a, V, pf );
		if( HNa != 1 )          fprintf( pf," )\n" );
	}
	return( t );
}
