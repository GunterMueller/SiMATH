/*C
			calc_clnum( fkeller )

	"calculator class number".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_clnum( fkeller );      list fkeller;
	X = calc_clnum( fkeller );

	fkeller besteht aus einer Zahl D aus Z, D= 0 oder = 1 mod 4, oder 
	fkeller=_0. Im zweiten Fall nimmt man als D die Diskriminante des 
	curNumberfields, das ein quadratischer Zahlkoerper sein soll.
	X ist die Klassenzahl von Q(sqrt(D)).
	Laeuft calc_clnum fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      05.12.1999      S.Schmitt
H*/

#include<_calc.h>

list calc_clnum( fkeller )
list fkeller;
{
	int D,h;
	init( D,h );
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if(fkeller==_0)
	{	if(!nfsch || ecqnfsch==_0)
		{	mistake(278);
			return(ERROR);
		}
		D = lfirst(ecqnfsch);
		D = qnfdisc(D);
	}
	else 
	{  if(llength(fkeller)!=2 || (lsecond(fkeller) && lsecond(fkeller)!=23))
	   {       mistake(3);
	           return(ERROR);
	   }
	   if(!lsecond(fkeller)) 
	   {	D=lfirst(fkeller);
	   	if(!D || (mshom(4,D)!=0 && mshom(4,D)!=1))
	   	{	mistake(3);
			return(ERROR);
	   	}
	   }
	   else 	/* curNumberField muss quadratisch sein */
	   { 	if(ecqnfsch==_0)
		{	mistake(278);
			return(ERROR);
		}	
		D = lfirst(ecqnfsch);
		D = qnfdisc(D);
	   }
	}


	h = qnfclassnum(D);
	return(list2(h,0));   
}
