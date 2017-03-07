/*C
			calc_derivL( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_derivL( fkeller );  list fkeller;
	X = calc_derivL( fkeller );

	fkeller enthaelt eine Liste aus einer ganzen Zahl r>=0 und einer
	elliptischen Kurve ueber Q. X ist der Wert der r-ten Ableitung 
	der L-Reihe L(fkeller,s) von fkeller bei s=1.

	Laeuft calc_derivL fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.04.1993      S.Schmitt
H*/

# include<_calc.h>

list calc_derivL(fkeller)
list fkeller;
{	single k;
	obj r;
	floating a, ecrlser(), ecrlserfd();
	floating ecrlserhd();
	init( r ); 
	bind( fkeller );

	r=lsecond(fkeller);
	fkeller=lfirst(fkeller);
	k=lsecond(r);
	r=lfirst(r);
	if( k || r<0 )
	{	mistake(60);
		return(ERROR);
	}
	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);

	if(r==0) 	a=ecrlser(fkeller);
	else if(r==1)	a=ecrlserfd(fkeller);
	else 		a=ecrlserhd(fkeller,r);
	if( a == ERROR )
	{	mistake( 221 );
		return( ERROR );
	}
	r=list2(a,15);
	return(r);
}

