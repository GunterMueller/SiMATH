/*C
			calc_ptcoef( fkeller )

	"calculator point on elliptic curve coefficient".
	list calc_ptcoef( fkeller );  list fkeller;
	X = calc_ptcoef( fkeller );

	fkeller ist eine Liste, bestehend aus 2 Elementen: einem 
	Punkt P auf einer elliptischen Kurve und einer Zahl i.
	Dabei ist i=1,2, falls P in affiner Darstellung gegeben ist
	und i=1,2,3, falls P in projektiver Darstellung gegeben ist.
	calc_ptcoef gibt den i-ten Koeffizienten x_i des Punktes P an.
	Laeuft calc_ptcoef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       22.02.1995      S.Schmitt
H*/

#include<_calc.h>

list calc_ptcoef( fkeller )
list fkeller;
{
	list P,z,h;
	single i,ken,pro=0;
	init( P, z, h );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	P=lsecond(fkeller);
	fkeller=lfirst(fkeller);
	ken=lsecond(P);
	if( ken!=(-3) && ken!=(-4) && ken!=(-7) && ken!=(-8) && ken!=(-11) && ken!=(-12) && ken!=(-15) && ken != (-16) )
	{	mistake(125);
		return(ERROR);
	}
	P=lfirst(P);
	if( ken==(-4) || ken==(-8) || ken==(-12) || ken==(-16) ) pro=1;
	if(lsecond(fkeller))
	{ 	mistake(128);
		return(ERROR);
	}
	i=lfirst(fkeller);
	if(i!=1 && i!=2 && i!=3)
	{	mistake(128);
		return(ERROR);
	}
	if(!pro && i==3)
	{	mistake(132);
		return(ERROR);
	}
	if( !P || ( !pro && ken==(-3) && !lthird(P) ) ) /** O **/
	{	mistake1(34,"ptcoef");
		return(ERROR);
	}

	/*** Koeffizienten ***/

	if(ken==(-3) || ken==(-4))
	{	if(!lthird(P))
		{	switch(i)
			{	case 1: 
				case 3: P=list2(0,0);
					break;
				case 2: P=list2(1,0);
					break;
			}
			return(P);
		}
		z=lthird(P);
		if(!pro) h=iprod(z,z);
		else h=z;
		switch(i)
		{	case 1: P=lfirst(P);
				P=rcons(P,h);
				P=list2(P,1);
				break;
			case 2: P=lsecond(P);
				h=iprod(h,z);
				P=rcons(P,h);
				P=list2(P,1);
				break;
			case 3: P=list2(z,0);
				break;
		}
		return(P);
	}

	switch(i)
	{	case 1: P=lfirst(P);
			break;
		case 2: P=lsecond(P);
			break;
		case 3: P=lthird(P);
			break;
	}
	if(ken==(-7) || ken==(-8)) P=list2(P,17);
	else if(ken==(-11) || ken==(-12)) P=list2(P,24);
	else P=list2(P,31);

	return(P);
}
