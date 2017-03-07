/*C
			calc_intbas( )

	"calculator integral basis"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_intbas( );
	X = calc_intbas( );

	calc_intbas berechnet die Ganzheitsbasis der Polynomordnung
        Of, wobei f den aktuellen Zahlkoerper erzeugt, und den Index
        mit Primfaktorzerlegung.
	Laeuft calc_intbas fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.10.1992      U.Schneiders
H*/

#include <_calc.h>

list calc_intbas()
{
	single e;
	obj p, F;
	list L, M;
	list AVL;
	init( p, F, L, M, AVL );

	/*** Abfangen von Fehlern ***/

	if( !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}
	
	/*** Berechnung ***/

	F = lfirst( varlist[nfsch].varwert );
	p = lsecond( F );
	if( icomp( p, 1 ) )
	{	mistake( 192 );
		return( ERROR );
	}
	p = dptop( 1, F );
	M = ouspibasisic( p, &L );

	/*** Ausgabe der Ganzheitsbasis ***/

	if(avsch) AVL=_0;
	if(!assch)
	{  printf( " integral basis:  " );
	   if( ps ) fprintf( datei, "out: integral basis:  " );
	}
	while( M != _0 )
	{	p = lfirst( M );
		M = lred( M );
		p = ptodp( 1, p );
		p = udprtonfel( p );
		if(avsch) AVL=lcomp(list2(p,24),AVL);
		if(!assch)
		{  putnfel( F, p, VNF );
		   if( ps ) fputnfel( F, p, VNF, datei );	
		   if( M != _0 )
		   {       printf( ",  " );
			   if( ps ) fprintf( datei, ",  " );
		   }
		}
	}
	if(!assch)
	{  printf( "\n" );
	   if( ps ) fprintf( datei, "\n" );
	}
	

	/*** Sonderfall Index = 1 ***/
	
	if( L == _0 )   L = list2( 1, 1 );

	/*** Ausgabe des Index mit Primfaktorzerlegung ***/

	F = 1;
	if(!assch)
	{  printf( " factorization of the index: " );
	   if( ps ) fprintf( datei, "out: factorization of the index: " );
	}
	while( L != _0 )
	{	p = lfirst( L );
		e = lsecond( L );
		L = lred2( L );
		if(avsch)
		{	AVL=lcomp(list2(p,0),AVL);
			AVL=lcomp(list2(e,0),AVL);
		}
		if(!assch)
		{  if( e > 1 ) 
		   {	printf( " %i^%i ", p, e );	
			if( ps ) fprintf( datei, " %i^%i ", p, e );	
		   }
		   else
		   {	printf( " %i ", p );	
			if( ps ) fprintf( datei, " %i ", p );	
		   }
		   if( L != _0 )
		   {    printf( "*" );
			if( ps ) fprintf( datei, "*" );
		   }
		}
		p = iexp( p, e );
		F = iprod( F, p );
	}
	if(!assch)
	{  printf( "\n\n" );
	   if( ps ) fprintf( datei, "\n\n" );
	}
	if(avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}
	
	F = list2( F, 0 );
	return( F );
}
