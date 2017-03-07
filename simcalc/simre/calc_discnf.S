/*C
			calc_discnf( )

	"calculator number field discriminant"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_discnf( );
	X = calc_discnf( );

	calc_discnf berechnet die Koerperdiskriminante des aktuellen
	Zahlkoerpers. Ihre Primfaktorzerlegung wird mit ausgegeben.
	Laeuft calc_discnf fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      28.09.1992      U.Schneiders
H*/

#include <_calc.h>

list calc_discnf()
{
	single e;
	int p;
	obj F;
	list L;
	list(AVL);
	init( p, F, L, AVL );

	/*** Abfangen von Fehlern ***/

	if( !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}
	
	/*** Berechnung ***/

	F = lfirst( varlist[nfsch].varwert );
	L = lsecond( F );
	if( icomp( L, 1 ) )
	{	mistake( 192 );
		return( ERROR );
	}
	L = nffielddiscr( F );

	/*** Sonderfall Diskr = 1 ***/
	
	if( L == _0 )  L = list2( 1, 1 );

	/*** Ausgabe ***/

	F = 1;
	if(!assch){
	printf( " factorization of the field discriminant: " );
	if( ps ) fprintf( datei, "out: factorization of the field discriminant: " );
	}
	L = linv( L );
	if(avsch) AVL=_0;
	while( L != _0 )
	{	e = lfirst( L );
		p = lsecond( L );
		L = lred2( L );
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
		   {       printf( "*" );
			   if( ps ) fprintf( datei, "*" );
		   }
		}
		if(avsch)
		{	AVL=lcomp(list2(p,0),AVL);
			AVL=lcomp(list2(e,0),AVL);
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
