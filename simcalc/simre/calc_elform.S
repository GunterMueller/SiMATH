/*C
			calc_elform( fkeller )

	"calculator elementar divisor form".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_elform( fkeller );  list fkeller;
	X = calc_elform( fkeller );

	In fkeller steht eine Matrix ueber Z oder ueber Polynome in
	einer Variablen ueber Z, Q bzw. ueber Z/pZ und 2 ganze Zahlen, 
	die 0 oder 1 sein muessen. calc_elform berechnet die Elementar-
	teilerform dieser Matrix und gibt sie an X zurueck. Die 0en und 
	1en geben an, ob der linke oder rechte Kofaktor mitausgegeben 
	wird.
	Laeuft calc_elform fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      17.01.1989      C.Hollinger/U.Schneiders
	Version  2	02.09.1993	S.Schmitt
H*/

#include <_calc.h>

list calc_elform( fkeller )
list fkeller;

{
	single ken;
	obj M, kl, kr, p, VL;
	matrix L, R;
	list AVL;
	init( M, kl, kr, p, VL, L, R, AVL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben      ***/

	if( llength( fkeller ) != 3 )
	{       mistake1( 34,"elform" );
		return( -BASIS );
	}
	kr = lfirst( fkeller );
	fkeller = lred( fkeller );
	if( lsecond( kr ) != 0 || ( lfirst( kr ) != 0 && lfirst( kr ) != 1 ) )
	{       mistake( 88 );
		return( -BASIS );
	}
	kl = lfirst( fkeller );
	fkeller = lred( fkeller );
	if( lsecond( kl ) != 0 || ( lfirst( kl ) != 0 && lfirst( kl ) != 1 ) )
	{       mistake( 88 );
		return( -BASIS );
	}
	M = lfirst( fkeller );
	ken = lsecond( M );
	if( ken != 5 && ken != 7 && ken != 8 && ken != 20 )
	{       mistake( 89 );
		return( -BASIS );
	}
	if( ken == 20 )
	{	if( !pzsch )
		{ 	mistake( 89 );
			return( ERROR );
		}
		p = lfirst( varlist[modsch].varwert);
	}
	M = lfirst( M );
	if( ken != 5 )
	{	VL = lfirst( M );
		if( llength( VL ) > 1 )
		{	mistake( 89 );
			return( ERROR );
		}
		M = lsecond( M ); 
		if( ken == 7 )
		{	M = mapitomapr( 1, M );
			ken = 8;
		}
	}
	if( isnullma( M ) )
	{       mistake( 89 );
		return( -BASIS );
	}
	kr = lfirst( kr );
	kl = lfirst( kl );

	/*** Berechnung der Elementarteilerform mit Kofaktoren  ***/

	if( ken == 5 )   M = maiedfcf( M, &L, &R );
	else if( ken == 8 )   M = maupredfcf( M, &L, &R );
	else 
	{	if( ssch ) M = maupmspedfcf( p, M, &L, &R );
		else  M = maupmipedfcf( p, M, &L, &R );
	}
	if(avsch) AVL=_0;
	if( kl )
	{	if( ken != 5 ) L = list2( VL, L );
		if(!assch)
		{   printf( "%t left cofactor:  ", 8 );
		    if( ps ) fprintf( datei, "out: left cofactor: " );
		    matraus( L, ken, 13 );
		    printf( "\n" );
		    if( ps ) fprintf( datei, "\n" );
		}
		if(avsch) AVL=lcomp(list2(L,ken),AVL);
		
	}
	if( kr )
	{	if( ken != 5 ) R = list2( VL, R );	
		if(!assch)
		{   printf( "%t right cofactor: ", 8 );
		    if( ps ) fprintf( datei, "out: right cofactor: " );
		    matraus( R, ken, 13 );
		    printf( "\n" );
		    if( ps ) fprintf( datei, "\n" );
		}
		if(avsch) AVL=lcomp(list2(R,ken),AVL);
	}
	if(avsch && AVL!=_0)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}
	
	if( ken != 5 )  M = list2( VL, M );
	M = list2( M, ken );
	return( M );
}
