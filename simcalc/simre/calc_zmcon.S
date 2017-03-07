/*C
			calc_zmcon( fkeller )

	"calculator zero matrix construction".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_zmcon( fkeller );      list fkeller;
	X = calc_zmcon( fkeller );

	fkeller besteht aus zwei Zahlen m, n aus Z, m,n>0.
	X ist die mxn - Nullmatrix.
	Laeuft calc_zmcon fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      19.12.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_zmcon( fkeller )
list fkeller;

{       single m,n;
	list L;
	init(L);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	L=lfirst(fkeller);	
	fkeller=lsecond(fkeller);
	if(lsecond(fkeller) || lsecond(L))
	{	mistake(49);
		return(ERROR);
	}
	n=lfirst(L);
	m=lfirst(fkeller);
	if(n<1 || m<1)
	{	mistake(49);
		return(ERROR);
	}

	L=maconszero(m,n);
	L=list2(L,5);
	return(L);	
}
