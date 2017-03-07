/*C
			calc_max( fkeller )

	"calculator maximum".
	list calc_max(fkeller); list fkeller;
	X = calc_max( fkeller );

	fkeller ist eine Liste bestehend aus mindestens zwei Objekten
	mit zugehoerigen Kennungen.
	Berechnet wird das Maximum der in fkeller stehenden Objekte. 
	Dabei muss jedes Objekt eine ganze Zahl, eine rationale Zahl oder
	eine floating point Zahl sein.
	Das Ergebnis wird mit zugehoeriger Kennung an das aufrufende 
	Programm uebergeben.
	Laeuft calc_max fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      24.02.1998      S.Schmitt
H*/
 
#include <_calc.h>

obj calc_max( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj a,b,a1,b1;
	single ka,kb;
	init( a,b,a1,b1 );
	bind( fkeller );

	/*** Sukzessives Abarbeiten des Kellerinhaltes ***/

	if(llength(fkeller)<2) 
	{
		mistake(3);
		return(ERROR);
	}

	a = lfirst(fkeller);
	fkeller = lred(fkeller);
	ka = lsecond(a);
	if(ka!=0 && ka!=1 && ka!=15 && ka!=16)
	{
		mistake(272);
		return(ERROR);
	}
	if(ka == 16) ka = 0;
	a = lfirst(a);

	while(fkeller!=_0)
	{
		b = lfirst(fkeller);
		fkeller = lred(fkeller);
		kb = lsecond(b);
		if(kb!=0 && kb!=1 && kb!=15 && kb!=16)
		{
			mistake(272);
			return(ERROR);
		}
		if(kb==16) kb = 0;
		b = lfirst(b);

		ka = typer(a,b,ka,kb,&a1,&b1,0);
		if(ka==ERROR) return(ERROR);
		switch(ka)
		{
			case 0: a = imax(a1,b1);
				break;
			case 1: a = rmax(a1,b1);
				break;
			case 15: kb = flcomp(a1,b1);
				 if(kb==1) a = a1;
				 else a = b1;
				 break;
		}		
	}
	a = list2(a,ka);
	return(a);
}

