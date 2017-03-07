/*C
			calc_rper( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_rper( fkeller );  list fkeller;
	X = calc_rper( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. X ist die
	reelle Periode omega.

	Laeuft calc_rper fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.05.1993      S.Schmitt
H*/

# include<_calc.h>

list calc_rper(fkeller)
list fkeller;
{	single k;
	obj w;
	init( w );
	bind( fkeller );

	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
	w=ecrrperiod(fkeller);
	w=list2(w,15);
	return(w);
}
