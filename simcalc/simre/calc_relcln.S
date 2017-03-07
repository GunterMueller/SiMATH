/*C
			calc_relcln( fkeller )

	"calculator relative class number".
	int calc_relcln(fkeller); list fkeller;
	X = calc_relcln( fkeller );

	fkeller ist eine Liste bestehend aus einer ungeraden 
	Primzahlpotenz q und einer ganzen Zahl g>0, die ein Teiler
        von phi(q) ist.
	Berechnet wird die Relativklassenzahl des abelschen 
	Zahlkoerpers vom Fuehrer q und Grad g, d.h. des Teilkoerpers 
	K des q-ten Kreisteilungskoerpers vom Grad g ueber Q.
	Laeuft calc_relcln fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	14.07.1994	S.Schmitt 
H*/
 
#include <_calc.h>

int calc_relcln( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k;	
	int q,g;
	init(q,g);	
	bind(fkeller);

	/*** Abfangen ungueltiger Eingaben ***/

	if(llength(fkeller)!=2)
	{	mistake(3);
		return(ERROR);
	}

	q=lsecond(fkeller);
	k=lsecond(q);
	q=lfirst(q);
	if(!issingle(q))
	{	mistake(337);
		return(ERROR);
	}
	if(k || !isspprime(q,&g) || g==2)
	{	mistake(333);
		return(ERROR);
	}	
	
	g=lfirst(fkeller);
	k=lsecond(g);
	if(k)
	{	mistake(334);
		return(ERROR);
	}
	g=lfirst(g);
	fkeller=iphi(q);
	if(g<=0 || irem(fkeller,g))
	{	mistake(334);
		return(ERROR);
	}

	fkeller=abnfrelcl(q,g);
	if(fkeller==ERROR) 
	{	mistake1(34,"relcln" );
		return(ERROR);
	}
	fkeller=list2(fkeller,0);
	return(fkeller);		
}
