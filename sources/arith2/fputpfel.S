/*M
.SH NAME
fputpfel - file put p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel fputpfel(p, a, pf)            
single p; 
pfel a; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s.itopfel).         
.TP 4
.B pf
points on the output file *pf.
.PP
fputpfel writes a to the file *pf and returns 0 by success and ERROR else.

.SH NOTES
a will be writen as a expansion in a series, if the output in digits is favoured , please use fputspfel. 

.SH SEE ALSO
 itopfel
 fputspfel
 putpfel

M*/
                                           
/*H
	Version 1       28.05.1990      Christine Hollinger
   DATE fputpfel      : 901120
H*/

#include <_arith2.h>

pfel fputpfel( p, a, pf )
single p;
pfel a;
FILE *pf;
{
	bind( a );

	if( a )
	{       single v,ai;

		/*** a = a_vp( A ) * p^vp( A ) + ...  ***/

		v = lsecond( a );
		ai = lthird( a );
		fprintf( pf,"%i*%i^%i",ai, p, v );
		v++;
		a = lred3( a );
		while( a != _0 )
		{       ai = lfirst( a );
			a = lred( a );
			if( ai )
			  fprintf( pf," + %i*%i^%i", ai, p, v );
			v++;
		}
	}
	else    fprintf( pf,"0#" );
	fprintf( pf,"#" );
	return( 0 );
}
