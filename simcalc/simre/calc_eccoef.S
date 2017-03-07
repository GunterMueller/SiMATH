/*C
			calc_eccoef( fkeller )

	"calculator elliptic curve coefficient".
	list calc_eccoef( fkeller );  list fkeller;
	X = calc_eccoef( fkeller );

	fkeller ist eine Liste, bestehend aus 2 Elementen: einer 
	elliptischen Kurve E und einer Zahl i aus {1,2,3,4,6}.
	calc_eccoef gibt den i-ten Koeffizienten a_i der Kurve E an.
	Laeuft calc_eccoef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       18.01.1995      S.Schmitt
	Version 1.1     10.07.1996      S.Schmitt (ecqnfsch neu)
H*/

#include<_calc.h>

list calc_eccoef( fkeller )
list fkeller;
{
	list E;
	single i,ken;
	init( E );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	E=lsecond(fkeller);
	fkeller=lfirst(fkeller);
	ken=lsecond(E);
	if( ken!=(-1) && ken!=(-2) && ken!=(-5) && ken!=(-6) && ken!=(-9) && ken!=(-10) && ken!=(-14))
	{	mistake(120);
		return(ERROR);
	}
	E=lfirst(E);
	if(lsecond(fkeller))
	{ 	mistake(119);
		return(ERROR);
	}
	i=lfirst(fkeller);
	if(i!=1 && i!=2 && i!=3 && i!=4 && i!=6)
	{	mistake(119);
		return(ERROR);
	}

	/*** Koeffizienten ***/

	if(ken==(-1) || ken==(-2) || ((ken==(-9) || ken==(-10)) && ecqnfsch!=_0))
	{	E=lfirst(E);
		E=lfirst(E);
	}
	if(ken==(-5) || (ken==(-9) && ecqnfsch==_0))
	{	switch(i)
	  	{	case(1):
			case(2):
			case(3): E=0;
				 break;
			case(4): E=lfirst(E);
				 break;
			case(6): E=lsecond(E);
				 break;
		}
		if(ken==(-5)) E=list2(E,17);
		else E=list2(E,24);
	}
	else
	{	switch(i)
		{	case(1): E=lfirst(E);
				 break;
			case(2): E=lsecond(E);
				 break;
			case(3): E=lthird(E);
				 break;
			case(4): E=lfourth(E);
				 break;
			case(6): E=lfifth(E);
				 break;
		}
		if(ken==(-1) || ken==(-2)) E=list2(E,1);
		else if(ken==(-6)) E=list2(E,17);
		else if(ken==(-9) || ken==(-10)) 
		{	if(llength(ecqnfsch)==3) E=qnftonf(E,24);
			E=list2(E,24);
		}
		else E=list2(E,31);
	}
	return(E);
}
