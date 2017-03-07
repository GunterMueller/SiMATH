/*C
			calc_ordtsg( fkeller ) 

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ordtsg( fkeller );  list fkeller;
	X = calc_ordtsg( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. X ist die
	Ordnung der Tate-Shafarevic-Gruppe III.

	Laeuft calc_ordtsg fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.04.1993      S.Schmitt
H*/

# include<_calc.h>

list calc_ordtsg(fkeller)
list fkeller;
{	obj k, t;
	init( k, t );
	bind( fkeller );
	
	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}
	
	fkeller=lfirst(fkeller);
	t=ecrordtsg(fkeller);
	if(!t || t==(-1))
	{	mistake(261);
		return(ERROR);
	}
	k = ssqrt(t);
	k = t-k*k;
	if(k)
	{	printf(" *** Warning: The order of the Tate-Shafarevich group must be a square!\n" );
		if(ps) fprintf(datei, " out: *** Warning: The order of the Tate-Shafarevich group must be a square!\n" );
	}
	t=list2(t,0);
	return(t);
}
