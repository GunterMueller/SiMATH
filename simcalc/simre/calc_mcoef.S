/*C
			calc_mcoef( fkeller )

	"calculator matrix coefficient".
	list calc_mcoef( fkeller );  list fkeller;
	X = calc_mcoef( fkeller );

	fkeller ist eine Liste, bestehend aus 3 Elementen: einer
	mxn-Matrix M und zwei Zahlen i,j, 1 <= i <= m, 1 <= j <= n.
	calc_mcoef gibt den ixj-ten Koeffizienten der Matrix M an.
	Laeuft calc_mcoef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       20.12.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_mcoef( fkeller )
list fkeller;
{
	obj H,M,VL;
	single spbit=0,j,i,ken;
	init( H,M,VL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 3 )
	{       mistake( 3 );
		return( ERROR );
	}
	M=lthird(fkeller);
	ken=lsecond(M);
	if(ken<5 || (ken>9 && ken!=19 && ken!=20 && ken!=26 && ken!=27 && ken!=33 && ken!=34))
	{	mistake(61);
		return(ERROR);
	}
	M=lfirst(M);
	VL=_0;
	if(ken==7 || ken==8 || ken==9 || ken==20 || ken==27 || ken==34)
	{	VL=lfirst(M);
		M=lsecond(M);
	}
	if(ken==19 && lfirst(varlist[modsch].varwert)==2) spbit=1;
	H=lfirst(fkeller);
	fkeller=lsecond(fkeller);
	if(lsecond(fkeller))
	{	mistake(62);
		return(ERROR);
	}
	i=lfirst(fkeller);
	if(i<1 || (spbit && i>(llength(M)-1)) || (!spbit && i>manrrow(M)))
	{	mistake(62);
		return(ERROR);
	}
	if(lsecond(H))
	{ 	mistake(65);
		return(ERROR);
	}
	j=lfirst(H);
	if( j<1 || (spbit && j>lfirst(M)) || (!spbit && j>manrcol(M)))
	{	mistake(65);
		return(ERROR);
	}

	if(spbit) M=mam2selel(M,i,j);	
	else M=maselel(M,i,j);
	if(VL!=_0) M=list2(VL,M);
	if(ken<10) ken=ken-5;
	else ken=ken-2;
	M=list2(M,ken);

	return( M );
}
