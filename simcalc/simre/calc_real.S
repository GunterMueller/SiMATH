/*C
			calc_real( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_real( fkeller );  list fkeller;
	X = calc_real( fkeller );

	fkeller enthaelt eine Zahl aus Z, Q, R oder C.
	X ist der reelle Anteil.
	Laeuft calc_real fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      21.01.1994      U.Schneiders
H*/

# include<_calc.h>

list calc_real(fkeller)
list fkeller;
{	single k;
	obj w, v;
	init( w, v );
	bind( fkeller );

	k=lsecond(fkeller);
	if( k>3 && k!=15 && k!=24 && k!=37 )
	{	mistake(223);
		return(ERROR);
	}
	if(k!=24 && k!=37) return(fkeller);
	if(k==24)
	{	w = lfirst( varlist[nfsch].varwert );
		v = list4( 2, 1, 0, 1 );
		if(!oequal(w,v))
		{	mistake(223);
			return( ERROR );
		}
		fkeller = lfirst(fkeller);
		k=nftyper(fkeller,0,k,37,&w,&v);
		fkeller = w;
	}
	else fkeller=lfirst(fkeller);
	w=creal(fkeller);
	w=list2(w,15);
	return(w);
}
