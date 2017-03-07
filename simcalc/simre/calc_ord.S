/*C
			calc_ord( fkeller )

	"calculator order".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ord( fkeller );      list fkeller;
	X = calc_ord( fkeller );

	fkeller besteht entweder aus einem Element b aus Z/nZ oder aus einer 
	Zahl n aus N und einer Zahl a aus Z.
	calc_ord berechnet die Ordnung von a oder b in der multiplikativen
	Gruppe von Z/nZ. 
	Laeuft calc_ord fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.10.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_ord( fkeller )
list fkeller;

{       single k;
	int n; 
	obj a,P,Q,L;
	init(n,a,P,Q,L);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength(fkeller)!=1 && llength(fkeller)!=2 )
	{       mistake( 3 );
		return( ERROR );
	}
	if(llength(fkeller)==2)     
	{	a=lfirst(fkeller);
		if(llength(a)!=2 || lsecond(a)!=0)
		{	mistake(42);
			return(ERROR);	
		}
		a=lfirst(a);
		fkeller=lsecond(fkeller);
		n=lfirst(fkeller);
		if(lsecond(fkeller) || isign(n)!=1 || n==1)
		{	mistake(42);
			return(ERROR);
		}
		k=0;
	}
	else			
	{	a=lfirst(fkeller);
		k=lsecond(a);
		a=lfirst(a);
		if(k!=17)
		{	mistake(42);
			return(ERROR);
		}
		n=lfirst(varlist[modsch].varwert);
	}

	if(igcd(a,n)>1)
	{	if(!assch){
		if(!k) puti(a);
		else printf("MOD(%i)",a);
		printf(" is no element of the multiplicative group of Z/");
		puti(n);
		printf("Z\n");
		if(ps)
		{	if(!k) fputi(a,datei);
			else fprintf(datei,"MOD(%i)",a);
			fprintf(datei," is no element of the multiplicative group of Z/");
			fputi(n,datei);
			fprintf(datei,"Z\n");
		}		
		}		
		return(ERROR-1);
	}

	P=_0; Q=_0;
	n=miord(n,a,&P,&Q);
	n=list2(n,0);
	return(n);
}
