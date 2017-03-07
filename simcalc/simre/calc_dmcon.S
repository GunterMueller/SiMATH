/*C
			calc_dmcon( fkeller )

	"calculator diagonal matrix construction".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_dmcon( fkeller );      list fkeller;
	X = calc_dmcon( fkeller );

	fkeller besteht aus einer Zahl n aus Z, n>0, und einem
        Element el.
	X ist die nxn - Diagonalmatrix mit dem Element el auf der
	Diagonalen.
	Laeuft calc_dmcon fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      04.07.1994      S.Schmitt
	Version  1.1    01.03.1996      S.Schmitt (GF(2))
H*/

#include<_calc.h>

list calc_dmcon( fkeller )
list fkeller;

{       single ken;
	int n;
	obj VL,el;
	init(n, VL, el);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake( 3 );
		return( ERROR );
	}
	el=lfirst(fkeller);	
	fkeller=lsecond(fkeller);
	if(lsecond(fkeller))
	{	mistake(60);
		return(ERROR);
	}
	n=lfirst(fkeller);
	if(icomp(n,1)<0)
	{	mistake(60);
		return(ERROR);
	}
	ken=lsecond(el);
	if(ken<0 || (ken>4 && ken<17) || (ken>18 && ken<24) || (ken>25 && ken<31) || ken>32)
	{	mistake(77);
		return(ERROR);
	}
	el=lfirst(el);
	VL=_0;
	if(ken==2 || ken==3 || ken==4 || ken==18 || ken==25 || ken==32)
	{	VL=lfirst(el);
		el=lsecond(el);
	}

	el=maconsdiag(n,el);
	if(ken<5) ken=ken+5;
	else ken=ken+2;
	if(VL!=_0) el=list2(VL,el);
	if(ken==19 && lfirst(varlist[modsch].varwert)==2) el=mamstomam2(el);
	el=list2(el,ken);
	return(el);	
}
