/*C
			calc_cper( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_cper( fkeller );  list fkeller;
	X = calc_cper( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. X ist die
	complexe Periode omega_2.

	Laeuft calc_cper fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      21.01.1994      U.Schneiders
H*/

# include<_calc.h>

list calc_cper(fkeller)
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
	w=ecrcperiod(fkeller);
	w=list2(w,37);
	return(w);
}
