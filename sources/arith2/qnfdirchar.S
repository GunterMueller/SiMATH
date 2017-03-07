/*M
.SH NAME
qnfdirchar - quadratic number field Dirichlet character

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfdirchar( D, z )  
int D, z;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B z 
is an integer number, z != 0.
.PP
qnfdirchar returns the value of the Dirichlet character of K at the spot z, i.e. the value of the Kronecker symbol of the discriminant of K over z.
      
M*/
                     
/*H
	Version 1       07.05.1991      U. Schneiders
	Version 2       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
   DATE qnfdirchar    : 910715.910915
H*/

#include<_arith2.h>

single qnfdirchar( F, z )
int F;
int z;
{
	single h1, h2, s;
	int h;
	init( h );
	bind( F, z );

	/***    F mod 4    ***/

	h = mshom( 4, F );

	/***    ( z, Diskr( K ) ) > 1    ***/

	if( igcd( F, z ) != 1 ) return( 0 );
	if( h != 1 && ieven( z ) ) return( 0 );

	if( h != 2 )
	{       F = iabs( F );
		s = ijacsym( z, F );
		if( h == 3 )
		{       z = idif( z, 1 );
			z = iquot( z, 2 );
			if( iodd( z ) )  s = (-s);
		}
	}
	else
	{       F = iquot( F, 2 );
		h = idif( F, 1 );
		h = iquot( h, 2 );
		h1 = ieven( h );
		h = idif( z, 1 );
		h = iquot( h, 2 );
		h2 = ieven( h );
		h = iprod( z, z );
		h = idif( h, 1 );
		h = iquot( h, 8 );
		h = ieven( h );
		F = iabs( F );
		s = ijacsym( z, F );
		if( ( h && !h1 && !h2 ) || ( !h && ( h1 || h2 ) ) )  s = (-s);
	}

	return( s );
}
