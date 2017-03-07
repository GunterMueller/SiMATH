/*C
			calc_putGF2b( fkeller )

	"calculator put Galois-field element in characteristic 2,
	 bit representation".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_putGF2b( fkeller );  list fkeller;
	X = calc_putGF2b( fkeller );

	fkeller enthaelt ein Galois-Feld Element in Charakteristik 2.
	Es wird die 2-Bit-Notation dieses Elements ausgegeben. 
	X = fkeller.
	Laeuft calc_putGF2b fehlerhaft ab, so ist  X = ERROR.
C*/
/*H
	Version  1      28.11.1995      S.Schmitt
H*/

#include <_calc.h>

list calc_putGF2b( fkeller )
list fkeller;
{
	single k;
	obj el;
	init( el );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake( 27 );
		return( ERROR );
	}
	k = lsecond( fkeller );
	if(k!=31)
	{	mistake(146);
		return(ERROR);
	}
	if(!gfsch)
	{	mistake(260);
		return(ERROR);
	}
	if(gfchar!=2)
	{	mistake(257);
		return(ERROR);
	}

	if(!assch){
	el=lfirst(fkeller);
	if(!el)
	{	printf(" 0");
		if(ps) fprintf( datei, "out: 0");
	}
	else
	{	el=sbtoudpm2(el);
		el=lred(el);
		printf(" ");
		if( ps )  fprintf( datei, "out: " );	
		while(el!=_0)
		{	k=lfirst(el);
			el=lred(el);
			puti( k );
			if( ps )  fputi( k, datei );
		}
	}
	printf( "\n\n" );
	if(ps)	fprintf( datei, "\n\n" );
	}

	return( fkeller );
}
