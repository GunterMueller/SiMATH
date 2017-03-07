/*C
			calc_minim( fkeller )

	"calculator minimal modell (global)".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_minim( fkeller );  list fkeller;
	L = calc_minim( fkeller );

	fkeller ist eine Liste, bestehend aus 2 Objekten, einem
	Schalter und einer elliptischen Kurve. Die zu ihr birational
	isomorphe Kurve L in minimaler Form wird zurueckgegeben, und
	falls der Schalter ungleich 0 war, werden die Transformations-
	parameter r, s, t, u auf Bildschirm ausgegeben.
	Laeuft calc_minim fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.12.1990      U.Schneiders
	Version  2	08.04.1993	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_minim( fkeller )
list fkeller;

{
	single k, ks,i ;
	rat ko[5];
	obj h, L;
	list N,T;
	list AVL;
	init( L, h, N, T, AVL ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"minim" );
		return( ERROR );
	}

	/*** Schalter ***/

	h = lfirst( fkeller );
	ks = lsecond( h );
	if( ks )
	{       mistake( 121 );
		return( ERROR );
	}

	/*** elliptische Kurve ***/

	fkeller = lsecond( fkeller );
	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) )
	{       mistake( 129 );
		return( ERROR );
	}

	h = lfirst( h );

	fkeller = lfirst( fkeller );
	T = ecimina1(fkeller);
	T = lsecond( fkeller );
	T=lfirst(T);
	ko[0] = lfirst( T );
	ko[1] = lsecond( T );
	ko[2] = lthird( T );
	ko[3] = lfourth( T );
	ko[4] = lfifth( T );
	if(!ko[0] && !ko[1] && !ko[2])
	{   	ko[3]=itor(ko[3]);
		ko[4]=itor(ko[4]);
		T=ecrinit(0,0,0,ko[3],ko[4]);
		T = list2( T, (-1) );
	}
	else
	{  	ko[0]=itor(ko[0]);
		ko[1]=itor(ko[1]);
		ko[2]=itor(ko[2]);
		ko[3]=itor(ko[3]);
		ko[4]=itor(ko[4]);
		T=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
		T = list2( T, (-2) );
	}

	if(h)
	{	L = lfirst( fkeller );
		L = lsixth( L );
		L = lfirst( L );
	 	ko[0] = lfirst( L );
		ko[1] = lsecond( L );
		ko[2] = lthird( L );
		ko[3] = lfourth( L );
		if(avsch)
		{	AVL=_0;
			AVL=lcomp(list2(ko[3],1),AVL);
			AVL=lcomp(list2(ko[2],1),AVL);
			AVL=lcomp(list2(ko[1],1),AVL);
			AVL=lcomp(list2(ko[0],1),AVL);
			av_basad(AVL);
		}
		if(!assch)
		{   printf( " transformation with:  r = %r\n", ko[0] );
		    printf( "                       s = %r\n", ko[1] );
		    printf( "                       t = %r\n", ko[2] );
		    printf( "                       u = %r\n", ko[3] );
		    if( ps )
		    {   fprintf( datei, "out: transformation with:  r = %r\n", ko[0] );
			fprintf( datei, "                           s = %r\n", ko[1] );
			fprintf( datei, "                           t = %r\n", ko[2] );
			fprintf( datei, "                           u = %r\n", ko[3] );
		    }
		}
	}

	return( T );
}
