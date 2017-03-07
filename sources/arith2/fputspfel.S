/*M
.SH NAME
fputspfel - file put special p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel fputspfel(p, a, pf)           
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
fputspfel writes a to the file *pf and returns 0 by success and ERROR else.
a will be written in digits, with rising powers of p. The coefficients are separated by _ . The change from negative to non negative exponents will be marked by using . instead of _.
.SH NOTES
If the output as a expansion in a series is favoured , please use fputpfel. 

.SH SEE ALSO
 fputpfel
 putspfel
 itopfel

M*/
                                                  
/*H
	Version 1       01.06.1990      Christine Hollinger
   DATE fputspfel     : 901120
H*/

#include <_arith2.h>

pfel fputspfel( p, a, pf )
single p;
pfel a;
FILE *pf;
{
	bind( a );

	if( a )
	{       single v,ai;

		v = lsecond( a );
		a = lred2( a );

		/*** Stellen vorm Punkt ***/

		if( v < 0 )
		{       ai = lfirst( a );
			a = lred( a );
			fprintf( pf,"%i",ai );
			v++;
			while( v < 0 && a != _0 )
			{       ai = lfirst( a );
				a = lred( a );
				fprintf( pf,"_%i",ai );
				v++;
			}
			if( a == _0 )     /*** Nullen bis zum Punkt ***/
				for( ;v < 0; v++ )      fprintf( pf,"_0" );
		}
		fprintf( pf,"." );

		/*** v > 0 => bis Position v-1 einschliesslich mit
		     Nullen auffuellen.                             ***/

		if( a != _0 )
		{       if( v )
			{       fprintf( pf,"0" ); v--;
				for( ; v; v-- )  fprintf( pf,"_0" );
			}
			else
			{       ai = lfirst( a );
				a = lred( a );
				fprintf( pf,"%i",ai );
			}
			for( ;a != _0; a = lred( a ) )
			{       ai = lfirst( a );
				fprintf( pf,"_%i",ai );
			}
		}
	}
	else    fprintf( pf,".0" );
	fprintf( pf,"#" );
	return( 0 );
}
