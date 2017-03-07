/*C
			casi_ecnpscf( fkeller )

	"calculator elliptic curve with point order with small cofactor"
	Include- Datei: _calc.h
	list casi_ecnpscf( fkeller )   list fkeller;
	E = casi_ecnpscf( fkeller );

	fkeller ist eine Liste, bestehend entweder aus einer Primzahl p
	und einer Zahl cf, oder nur aus der Zahl cf (p ist dann der 
	curModulus). casi_ecnpscf bestimmt eine elliptische Kurve,
	die ueber Z/pZ eine Ordnung mit Kofaktor kleiner oder gleich cf
	hat.
	Laeuft casi_ecnpscf fehlerhaft ab, so ist  E = ERROR.
C*/
/*H
	Version  1	19.11.1998	S.Schmitt
H*/

#include <_calc.h>

list casi_ecnpscf( fkeller )
list fkeller;
{
# ifdef ___CASI

	single k;
	int p,a4,a6,n;
	list L,AVL;

	init(p,a4,a6,n,L,AVL);
	bind(fkeller);

	/*** Ueberpruefung der Eingaben. ***/
                                                                                
        if( llength(fkeller)!=1 && llength(fkeller)!=2 )
        {       mistake( 3 );
                return( ERROR );
        }

	/** Primzahl **/

	if(llength(fkeller)==2)
	{
                n=lsecond(fkeller);
                if(lsecond(n)) 
                {       mistake(328);
                        return(ERROR);
                }
		p=lfirst(n);                                              
                if(isatom(p))
		{
			if(issprime(p,&n)<1 )       
			{
				mistake(328);
				return(ERROR);
			}
			if(p==2 || p==3)
			{
				mistake(279);
				return(ERROR);
			}
		}
		else
		{
			L = ispd(p,&n);
			if(L!=_0)
			{
				mistake(328);
				return(ERROR);
			}
		}
		k = -1;
        }
	else
	{
		if(!pzsch)
		{
			mistake(328);
			return(ERROR);
		}
                p=lfirst(varlist[modsch].varwert);                      
		if(isatom(p) && (p==2 || p==3))
		{
			mistake(279);
			return(ERROR);
		}
		k = -5;
	}
                                                                                
        /*** Kofaktor ***/

	fkeller = lfirst(fkeller);
	if(lsecond(fkeller))
	{
		mistake(290);
		return(ERROR);
	}
	n = lfirst(fkeller);

	/** Rechnung **/

	L = ecmpsnfgenscf(p,0,0,n);

	/** Ausgabe der Punktanzahl **/

	n = lsecond(L);
	L = lfirst(L);
	a4 = lfirst(L);
	a6 = lsecond(L);
	if(!assch)
	{
		printf(" The elliptic curve EC( ");
		if(k==(-1)) puti(a4); 
		else putmi(p,a4);
		printf(", ");  
		if(k==(-1)) puti(a6); 
		else putmi(p,a6);
		printf(" ) has ");
		puti(n);
		printf(" points over Z/");
		puti(p);
		printf("Z.\n");
		if(ps)
		{
			fprintf(datei,"out: The elliptic curve EC( ");
			if(k==(-1)) fputi(a4,datei); 
			else fputmi(p,a4,datei);
			fprintf(datei,", "); 
			if(k==(-1)) fputi(a6,datei);
			else fputmi(p,a6,datei);
			fprintf(datei," ) has ");
			fputi(n,datei);
			fprintf(datei," points over Z/");
			fputi(p,datei);
			fprintf(datei,"Z.\n");
		}
	}
	if(avsch)
	{
		AVL = list2(n,0);
		AVL = list1(AVL);
		av_basad(AVL);
	}

	/** Rueckgabe **/

	if(k==(-1))
	{
		if(a4) a4 = itor(a4);
		if(a6) a6 = itor(a6);
		L = ecrinit(0,0,0,a4,a6);
	}	
	L = list2(L,k);
	return(L);


# else
	mistake(5);
	return(ERROR);
# endif
}
