/*M
.SH NAME
fgetnfel - file get number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel fgetnfel(F, V, pf)     
pol F; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K.
.TP 4
.B V
is a list of variables, V contains one element.  
.TP 4
.B pf
points on the input file *pf.  
.PP
fgetnfel  reads a univariate polynomial, say P, in the variable given in V, over Q from the file *pf. The polynomial will be reduced modulo F and konverted into an element of K. By success, fgetnfel returns that element and ERROR else.

.SH SEE ALSO
 getnfel 

M*/

/*H
	Version 1       20.03.1989      Christine Hollinger
	Version 2       26.01.1990      C.H.  ( 0,Monome )
   DATE fgetnfel      : 890601.900315.9011__
H*/

#include <_arith2.h>

nfel fgetnfel( F, V, pf )
pol F;
list V;
FILE *pf;
{
	single r, i, deg;
	int HNa, N, Z;
	nfel a;
	list L = _0;
	init( a, HNa, N, Z );
	bind( F, V, L );


	/*** Einlesen von Datei. ***/
	a = fgetpr( 1, V, pf );
	if( a == ERROR )        errmsgio( "fgetnfel","EA009" );

	/*** In Typ nfel umformen, falls a != 0. ***/
	else
	{       if( a )
		{       F = dptop( 1,F );
			F = pitopr( 1,F );
			a = prrem( 1, a, F );
			if( a )
			{       r = lfirst( a );
				HNa = 1;

				/*** Hauptnenner HNa bestimmen. ***/
				i = r;
				while( a !=  _0 )
				{       deg = lfirst( a );

					/*** Koeffizient von x^i ist 0. ***/
					if( deg != i )  L = lcomp( 0,L );
					else
					{       a = lred( a );
						N = lfirst( a );
						L = lcomp( N,L );
						if( N )
						{       N = lsecond( N );
							HNa = ilcm( HNa, N );
						}
						a = lred( a );
					}
					i--;
				}
				for( ; i >= 0; i-- )
					L = lcomp( 0,L );

				/*** Aufbau von a. ***/
				while( L != _0 )
				{       Z = lfirst( L );
					if( Z )
					{       N = lsecond( Z );
						Z = lfirst( Z );
						if( N != HNa );
						{       N = iquot( HNa,N );
							Z = iprod( Z,N );
						}
					}
					a = lcomp( Z,a );
					L = lred( L );
				}
				a = lcomp2( HNa, r, a );
			}
		}
	}
	return(a);
}
