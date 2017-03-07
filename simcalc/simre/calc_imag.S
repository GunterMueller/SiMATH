/*C
			calc_imag( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_imag( fkeller );  list fkeller;
	X = calc_imag( fkeller );

	fkeller enthaelt eine Zahl aus Z, Q, R oder C.
	X ist der imaginaere Anteil.
	Laeuft calc_imag fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      21.01.1994      U.Schneiders
H*/

# include<_calc.h>

list calc_imag(fkeller)
list fkeller;
{	single k;
	obj w, v;
	init( w, v );
	bind( fkeller );

	k=lsecond(fkeller);
	if(k>3 && k!=15 && k!=24 && k!=37)
	{	mistake(223);
		return(ERROR);
	}
	fkeller = lfirst(fkeller);
	if(k==24)
	{	w = lfirst( varlist[nfsch].varwert );
		v = list4( 2, 1, 0, 1 );
		if(!oequal(w,v))
		{	mistake(223);
			return( ERROR );
		}
		k=nftyper(fkeller,0,k,37,&w,&v);
		fkeller = w;
	}

	if(k!=37)
	{ 	w = list2( 0, 0 );
		return( w );
	}

	w=cimag(fkeller);
	w=list2(w,15);
	return(w);
}
