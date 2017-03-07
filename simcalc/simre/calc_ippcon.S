/*C
			calc_ippcon( fkeller )      

	"calculator pseudo prime construction"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ippcon( fkeller );  list fkeller;
	X = calc_ippcon( fkeller );

	Die Liste fkeller besteht aus zwei Elementen,naemlich
	einer positiven ganzen Zahl mit zugehoeriger Kennung
	und der Algorithmusangabe 0,1 oder 2.
	calc_ippcon konstruiert eine Pseudo-Primzahl p in der 
	Groessenordnung der positiven ganzen Zahl.
	Die Algorithmusangabe entscheidet, welche Primfaktoren
	p-1 hat.

	Laeuft calc_ippcon fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.11.1997      S.Schmitt
H*/

#include <_calc.h>

list calc_ippcon(fkeller)
list fkeller;
{
	list L;
	single b;
	int p,rand();
	obj z,k;
	list AVL;

	init(L,p,z,k,AVL);
	bind(fkeller);
	
 /*** Abfangen falscher Eingaben ***/

	if ( llength(fkeller)!=2 )
	{	mistake(232);
                return(ERROR);
	}
	k=lfirst(fkeller);
	if(lsecond(k))
	{	mistake(20);
		return(ERROR);
	}
 	k=lfirst(k);
	if( k && k!=1 && k!=2 )
	{  	mistake(20);
		return(ERROR);
	}
 	z=lsecond(fkeller);
	if(lsecond(z))
	{	mistake(19);
		return(ERROR);
	}
	z=lfirst(z);
	if(isign(z)!=1)
	{	mistake(19);
		return(ERROR);
	}

 /*** Eigentliche Rechnung ***/

	b=ilog2(z);
	z=ipprimeconstr(b,rand,&L,k);

	if(!assch)
	{	printf(" %i = ",idif(z,1));
		if(ps) fprintf(datei," out: %i = ",idif(z,1));
	}
	if(avsch)
	{	AVL=_0;
		p=idif(z,1);
		AVL=lcomp(list2(p,0),AVL);
	}
	while(L!=_0)
	{	k=1;
		p=lfirst(L);
		L=lred(L);
		while(L!=_0 && icomp(lfirst(L),p)==0)
		{	k++;
			L=lred(L);
		}
		if(avsch)
		{	AVL=lcomp(list2(p,0),AVL);
			AVL=lcomp(list2(k,0),AVL);
		}
		if(!assch)
		{  if(k!=1)
		   {	printf("%i^%i",p,k);
			if(ps) fprintf(datei,"%i^%i",p,k);
		   }
		   else
		   {	printf("%i",p);
			if(ps) fprintf(datei,"%i",p);
		   }
		   if(L!=_0)
		   {	printf(" * ");
			if(ps) fprintf(datei," * ");
		   }
		   else
		   {	printf("\n\n");
			if(ps) fprintf(datei,"\n\n");
		   }	
		}
	}
	if(avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}
	z=list2(z,0);
	return(z);
}
