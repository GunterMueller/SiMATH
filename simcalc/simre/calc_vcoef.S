/*C
			calc_vcoef( fkeller )

	"calculator vector coefficient".
	list calc_vcoef( fkeller );  list fkeller;
	X = calc_vcoef( fkeller );

	fkeller ist eine Liste, bestehend aus 2 Elementen: einem 
	Vektor V der Laenge n und einer Zahl i, 1 <= i <= n.
	calc_vcoef gibt den i-ten Koeffizienten des Vektors V an.
	Laeuft calc_vcoef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       19.12.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_vcoef( fkeller )
list fkeller;
{
	obj V,VL;
	single j,i,ken;
	init( V, VL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	V=lsecond(fkeller);
	fkeller=lfirst(fkeller);
	ken=lsecond(V);
	if(ken<10 || (ken>14 && ken!=21 && ken!=22 && ken!=28 && ken!=29 && ken!=35 && ken!=36))
	{	mistake(52);
		return(ERROR);
	}
	V=lfirst(V);
	VL=_0;
	if(ken==12 || ken==13 || ken==14 || ken==22 || ken==29 || ken==36)
	{	VL=lfirst(V);
		V=lsecond(V);
	}
	if(lsecond(fkeller))
	{ 	mistake(58);
		return(ERROR);
	}
	i=lfirst(fkeller);
	if(i<1 || i>llength(V))
	{	mistake(58);
		return(ERROR);
	}
	
	for(j=1;j<i;j++)  V=lred(V);
	V=lfirst(V);
	if(VL!=_0) V=list2(VL,V);
	if(ken<15) ken=ken-10;
	else ken=ken-4;
	V=list2(V,ken);

	return( V );
}
