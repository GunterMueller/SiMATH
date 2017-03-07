/*C
			calc_rkbsd( fkeller )

	"calculator elliptic curve over the rationals, rank via Birch and 
	 Swinnerton-Dyer conjecture"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_rkbsd( fkeller );  list fkeller;
	X = calc_rkbsd( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q.
	X ist der Rang der Kurve, berechnet nach der Birch und 
	Swinnerton-Dyer Vermutung.

	Laeuft calc_rkbsd fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      18.03.1996      S.Schmitt
H*/

# include<_calc.h>

list calc_rkbsd(fkeller)
list fkeller;
{	single k;
	bind(fkeller);

	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2))
	{	mistake(155);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
	k=ecrrankbsd(fkeller);
	if( k==ERROR )
	{	mistake(90);
		return(ERROR);
	}
	fkeller=list2(k,0);
	return(fkeller);
}
