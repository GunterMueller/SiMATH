/*C
			calc_unit( ) 

	"calculator units" 
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_unit( );
	X = calc_unit( );

	calc_unit berechnet, falls der aktuelle Zahlkoeper eine quadra-
	tische Erweiterung von Q ist, die Einheitengruppe. D.h. die
	Erzeuger werden ausgegeben. Im reellquadratischen Fall ist X
	die Fundamentaleinheit; sonst die Einheitswurzel.
	Laeuft calc_unit fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
	Version  1.1    25.03.1994      U.Schneiders (Ruecktransf.)
H*/

#include <_calc.h>
list calc_unit()
{
	int a0, a1, b;
	obj a, c, h, L;
	pol F;
	init( a0, a1, b, a, c, h, L, F );

	/*** Abfangen von Fehlern ***/

	if( !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}

	F = lfirst( varlist[nfsch].varwert );

	if( lfirst( F ) != 2 )
	{	mistake( 189 );
		return( ERROR ); 	
	}

	/*** Umwandlung von F = a x^2 + b x + c in 
				x^2 + (4 a c - b^2) ***/

	a = lsecond( F );
	b = lthird( F );
	c = lfourth( F );
	L = iprod( 4, a );
	L = iprod( L, c );
	c = iprod( b, b );
	L = idif( L, c );
	L = isfp( L );
	h = ineg( L );
	c = isign( h );

	/*** Berechnung und Ausgabe ***/

	if( c < 0 )   /*** imaginaerquadratisch ***/
	{	L = qnfunit( h );
		L = lfirst( L );

		/*** Transformation x' = 2 a x + b ***/

		if( (b || icomp(a,1)) && L && lsecond( L ) == 1 )
		{	c = lfirst( L );
			a1 = lthird( L );
			a0 = lfourth( L );
			L = iprod( b, a1 );
			L = isum( a0, L );
			a0 = rcons( L, c );
			L = iprod( a, a1 );
			L = iprod( 2, L );
			a1 = rcons( L, c );
			if( a1 ) 
			{	if( a0 ) L = list4( 1, a1, 0, a0 );
				else L = list2( 1, a1 );
				L = prnfevalfvs( 1, F, L );
			}
			else 
			{	L = lsecond( a0 );
			  	a0 = lfirst( a0 );
				L = list3( L, 0, a0 );
			}
		}	
						
		if( !lsecond( L ) )
		{	L = list2( L, 24 );
			L = kenntest(L);
			a0 = lsecond(L);
			L = lfirst(L);
		}
		else a0 = 24;
		if(!assch){
		printf( " unit group:  < " );
		if( ps ) fprintf( datei, "out: unit group:  < " );
		switch( a0 )
		{	case 0: puti( L );
				if( ps ) fputi( L, datei );
				break;
			case 1: putr( L );
				if( ps ) fputr( L, datei );
				break;
			case 24:putnfel( F, L, VNF );
				if(ps ) fputnfel( F, L, VNF, datei );
				break;
			default: break;
		}
		printf( " >\n\n" );
		if( ps ) fprintf( datei, " >\n\n" );
		}
		L = list2( L, a0 );
	}

	else /*** reellquadratisch ***/
	{	L=rqnffu(h,h);
		if( L == _0 )
		{	mistake( 190 );
			return( ERROR );
		}

		/*** Transformation x' = 2 a x + b ***/

		if( (b || icomp(a,1)) && L && lsecond( L ) == 1 )
		{	c = lfirst( L );
			a1 = lthird( L );
			a0 = lfourth( L );
			L = iprod( b, a1 );
			L = isum( a0, L );
			a0 = rcons( L, c );
			L = iprod( a, a1 );
			L = iprod( 2, L );
			a1 = rcons( L, c );
			if( a1 ) 
			{	if( a0 ) L = list4( 1, a1, 0, a0 );
				else L = list2( 1, a1 );
				L = prnfevalfvs( 1, F, L );
			}
			else 
			{	L = lsecond( a0 );
			  	a0 = lfirst( a0 );
				L = list3( L, 0, a0 );
			}
		}	

		if(!assch){
		printf( " unit group:  < -1 > x < " );
		if( ps ) fprintf( datei, "out: unit group:  < -1 > x < " );
		putnfel( F, L, VNF );
		printf( " >\n\n" );
		if( ps )	 
		{	fputnfel( F, L, VNF, datei );
			fprintf( datei, " >\n\n" );
		}
		}
		L = list2( L, 24 );
	}

	return( L );
}
