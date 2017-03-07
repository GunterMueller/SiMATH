/*C

			typprint( i )

	"type print"
	typprint( i ); single i;

	i ist die Kennung eines Variablen- bzw eines Polynombereiches.
	Die Prozedur typprint gibt zu gegebenem i die Meldung
	'Variable ueber ...' bzw 'Polynome ueber ...' bzw
	'Rationale Funktionen ...' bzw 'Matrizen' bzw 'Vektoren' aus.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H

	Version  1      11.05.1987      H.Stroeher
	Version  1.1    24.01.1989      C.Hollinger/U.Schneiders
	Version  1.2    03.12.1990      U.Schneiders
	Version  1.3    27.01.1992      U.Schneiders
	Version  2      25.05.1992      U.Schneiders

H*/
 
#include <_calc.h>

typprint( i )
single i;

{
	switch( i ) {
		case 0: printf(" variables over Z:\n");
			if ( ps )
			fprintf( datei, "out: variables over Z:\n" );
			break;
		case 1: printf(" variables over Q:\n");
			if ( ps )
			fprintf( datei, "out: variables over Q:\n" );
			break;
		case 2: printf(" polynomials over Z:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over Z:\n" );
			break;
		case 3: printf(" polynomials over Q:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over Q:\n" );
			break;
		case 4: printf(" rational functions:\n" );
			if( ps )
			fprintf( datei, "out: rational functions:\n" );
			break;
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 19:
		case 20:
		case 26:
		case 27:
		case 33:
		case 34: printf(" matrices:\n" );
			if( ps )
			fprintf( datei,"out: matrices:\n");
			break;
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 21:
		case 22:
		case 28:
		case 29:
		case 35:
		case 36: printf(" vectors:\n" );
			if( ps )
			fprintf( datei,"out: vectors:\n");
			break;
		case 15:printf(" variables over R:\n");
			if ( ps )
			fprintf( datei, "out: variables over R:\n" );
			break;
		case 37:printf(" variables over C:\n");
			if(ps)
			fprintf( datei, "out: variables over C:\n" );
			break;
		case 38:printf(" polynomials over R:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over R:\n" );
			break;
		case 39:printf(" polynomials over C:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over C:\n" );
			break;
		case 16:printf(" current modulus:\n");
			if ( ps )
			fprintf( datei, "out: current modulus:\n" );
			break;
		case 17:printf(" variables over Z/mZ:\n");
			if ( ps )
			fprintf( datei, "out: variables over Z/mZ:\n" );
			break;
		case 18:printf(" polynomials over Z/mZ:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over Z/mZ:\n" );
			break;
		case 23:printf(" current number field:\n");
			if ( ps )
			fprintf( datei, "out: current number field:\n" );
			break;
		case 24:printf(" algebraic numbers:\n");
			if ( ps )
			fprintf( datei, "out: algebraic numbers:\n" );
			break;
		case 25:printf(" polynomials over the current number field:\n");
			if ( ps )
			fprintf( datei, "out: polynomials over the current number field:\n" );
			break;
		case 30:printf(" current Galois-field:\n");
			if(ps)
			fprintf( datei, "out: current Galois-field:\n");
			break;
		case 31:printf(" Galois-field elements:\n");
			if(ps)
			fprintf( datei, "out: Galois-field elements:\n");
			break;
		case 32:printf(" polynomials over the current Galois-field:\n");
			if(ps)
			fprintf( datei, "out: polynomials over the current Galois-field:\n");
			break;
		case (-1):
		case (-2): printf(" elliptic curves over Q:\n" );
			   if( ps )
			   fprintf( datei, "out: elliptic curves over Q:\n" );
			   break;
		case (-3):
		case (-4): printf(" points on elliptic curves over Q:\n" );
			   if( ps )
			   fprintf( datei, "out: points on elliptic curves over Q:\n" );
			   break;
		case (-5):
		case (-6): printf(" elliptic curves over Z/pZ:\n" );
			   if( ps )
			   fprintf( datei, "out: elliptic curves over Z/pZ:\n" );
			   break;
		case (-7):
		case (-8): printf(" points on elliptic curves over Z/pZ:\n" );
			   if( ps )
			   fprintf( datei, "out: points on elliptic curves over Z/pZ:\n" );
			   break;
		case (-9):
		case (-10):printf(" elliptic curves over the current number field:\n" );
			   if( ps )
			   fprintf( datei, "out: elliptic curves over the current number field:\n" );
			   break;
		case (-11):
		case (-12):printf(" points on elliptic curves over the current number field:\n" );
			   if( ps )
			   fprintf( datei, "out: points on elliptic curves over the current number field:\n" );
			   break;
		case (-14):printf(" elliptic curves over the current Galois-field:\n");
			   if(ps) 
			   fprintf( datei, "out: elliptic curves over the current Galois-field:\n");
			   break;
		case (-15):
		case (-16):printf(" points on elliptic curves over the current Galois-field:\n");
			   if(ps)
			   fprintf( datei, "out: points on elliptic curves over the current Galois-field:\n");
			   break;
		default: break;
	}
}
