/*C
			calc_zvcon( fkeller )

	"calculator zero vector construction".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_zvcon( fkeller );      list fkeller;
	X = calc_zvcon( fkeller );

	fkeller besteht aus einer Zahl n aus Z, n>0.
	X ist der Nullvektor der Laenge n.
	Laeuft calc_zvcon fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      19.12.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_zvcon( fkeller )
list fkeller;

{       single i,n;
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	if(lsecond(fkeller))
	{	mistake(50);
		return(ERROR);
	}
	n=lfirst(fkeller);
	if(n<1)
	{	mistake(50);
		return(ERROR);
	}
	
	fkeller = _0;
	for(i=1;i<=n;i++) fkeller=lcomp(0,fkeller);
	fkeller=list2(fkeller,10);
		
	return(fkeller);	
}
