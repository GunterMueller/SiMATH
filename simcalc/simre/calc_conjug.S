/*C
			calc_conjug( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_conjug( fkeller );  list fkeller;
	X = calc_conjug( fkeller );

	fkeller enthaelt eine Zahl aus Z, Q, R, C oder einem Zahl-
	koerper.
	X ist die zu fkeller konjugierte Zahl.

	Laeuft calc_conjug fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      21.01.1994      U.Schneiders
	Version  2      23.06.1994      S.Schmitt
	Version  3      28.12.1994      U.Schneiders
	Version  3.1    10.07.1996      S.Schmitt (ecqnfsch neu)
H*/

# include<_calc.h>

list calc_conjug(fkeller)
list fkeller;
{	single k,r;
	obj a0, a1, a, b, c, w, v;
	init( a0, a1, a, b, c, w, v );
	bind( fkeller );

	k=lsecond(fkeller);
	if( k>3 && k!=15 && k!=24 && k!=37 )
	{	mistake(122);
		return(ERROR);
	}
	if(k!=24 && k!=37) return(fkeller);
	if( k == 24 )
	{       if( !nfsch )
		{	mistake( 163 );
			return( ERROR );
		}
		if(ecqnfsch==_0) 
		{	mistake(122);
			return(ERROR);
		}
		fkeller = lfirst( fkeller );
		w=lfirst(ecqnfsch);
		if(llength(ecqnfsch)==3) fkeller=nftoqnf(fkeller,24);
		v=qnfconj(w,fkeller);
		if(llength(ecqnfsch)==3) v=qnftonf(v,24);
		w=list2(v,24);
	}
	else 
	{	fkeller=lfirst(fkeller);
		w=cconjug(fkeller);
		w=list2(w,37);
	}
	return(w);
}
