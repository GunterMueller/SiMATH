/*C
			calc_sgnfeq( fkeller ) 

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_sgnfeq( fkeller );  list fkeller;
	X = calc_sgnfeq( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. X ist das 
	Vorzeichen der Funktionalgleichung der L-Reihe von fkeller.

	Laeuft calc_sgnfeq fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.04.1993      S.Schmitt
H*/

# include<_calc.h>

list calc_sgnfeq(fkeller)
list fkeller;
{	obj C, k;
	init( C, k );
	bind( fkeller );

	k=lsecond(fkeller);
	if( k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}

	fkeller=lfirst(fkeller);
	C=ecrsign(fkeller);
	if(C==ERROR)
	{	mistake(208);
		return(ERROR);
	}
	if(C==0)
	{	mistake(159);
		return(ERROR);
	}
	C=list2(C,0);
	return(C);
}
