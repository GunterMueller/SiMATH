/*C
			calc_cond( fkeller )

	"calculator conductor".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_cond( fkeller );  list fkeller;
	L = calc_cond( fkeller );

	fkeller enthaelt eine elliptische Kurve. Falls die Kurve mini-
	mal war, ist L der Fuehrer. Sonst die L diejenige elliptische
	Kurve, die minimal in der ersten Primzahl p ist, fuer die die
	urspruengliche Kurve nicht minimal war. Eine entsprechende
	Meldung erfolgt auf Bildschirm.
	Laeuft calc_cond fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.12.1990      U.Schneiders
	Version  2	01.04.1993	S.Schmitt/U.Schneiders
	Version  3	21.03.1995	S.Schmitt/U.Schneiders (nfon)
	Version  3.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_cond( fkeller )
list fkeller;

{
	single k;
	obj a,D, L, p;
	list AVL;
	init( a,D, L, p,AVL );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && ( ecqnfsch==_0 || (k!=(-9) && k!=(-10))))
	{       mistake( 131 );
		return( ERROR );
	}
	if( (k==(-1) || k==(-2)) && nfsch && nfon && ecqnfsch==_0 )
	{	mistake( 131 );
		return( ERROR );
	}
	fkeller=lfirst(fkeller);

	/*** Angleichung ueber NF, falls k=-1,-2 und nfsch=1 und nfon=1 ***/ 

	if( nfsch && nfon && (k==(-1) || k==(-2) ) )
	{	fkeller = tonftyper( fkeller,k );
		k = k-8;
	}

	if(k==(-1) || k==(-2))
	{ 	p=ecrcond(fkeller);
		if(p==ERROR)
		{	mistake(134);
			return(ERROR);
		}
		L=lfourth(fkeller);
		L=lsecond(L);
		L=lsecond(L);

/*** Ausgabe der Faktorisierung ***/

		if(!assch)
		{  printf(" %i = ",p);
		   if(ps) fprintf(datei," out: %i = ",p);
		   if(isign(p)==(-1))
		   {	printf("- ");
			if(ps) fprintf(datei,"- ");
		   }
		}
		if(avsch) AVL=_0;
		while(L!=_0)
		{	if(!assch)
			{  puti(lfirst(L));
			   if(ps) fputi(lfirst(L),datei);
			   k=lsecond(L);
			   if(k>1)
			   {	printf("^%i",k);
				if(ps) fprintf(datei,"^%i",k);
			   }
			}
			if(avsch)
			{  D=lfirst(L);
			   k=lsecond(L);
			   AVL=lcomp(list2(D,0),AVL);
			   AVL=lcomp(list2(k,0),AVL);
			}
			L=lred2(L);
			if(!assch)
			{  if(L!=_0)
			   {	printf(" * ");
				if(ps) fprintf(datei," * ");
			   }
			}
		}
		if(!assch)
		{  printf("\n");
		   if(ps) fprintf(datei,"\n");
		}
		if(avsch)
		{	AVL=linv(AVL);
			av_basad(AVL);
		}
		
		p=list2(p,0);
	}
	else
	{	p=ecqnfcond(fkeller);
		if(p==ERROR)
		{	mistake(134);
			return(ERROR);
		}
		L=lfourth(fkeller);
		L=lsecond(L);
		if(!assch){
		if(llength(ecqnfsch)==3) 
		{	a=lsecond(ecqnfsch);
			D=lthird(ecqnfsch);
			D=list2(a,D);
		}
		else D=ecqnfsch;
		putc(' ',stdout);
		putqnfid(D,p);
		puts(" = ");
		if(ps)
		{	fputs(" ", datei);	
			fputqnfidsp(D,p,datei);
			fputs(" = ", datei);
		}
		}
		p = lthird(L);
		if(!assch){
		L=lsecond(L);
		if(llength(L)==1) 
		{	puts("(1)\n");
			if(ps) fputs("(1)\n",datei);
		}
		else 
		{	while(L!=_0)
			{	putqnfid(D,lfirst(L));
				if(ps) fputqnfidsp(D,lfirst(L),datei);
				k=lsecond(L);
				if(k>1)
				{	printf("^%i",k);
					if(ps) fprintf(datei, "^%i",k);
				}
				L=lred4(L);
				if(L!=_0)
				{	printf(" * ");
					if( ps) fprintf(datei," * ");
				}
			}
		}
		printf("\n");
		if(ps) fprintf(datei,"\n");
		}
		p=list2(p,0);
	}
	return(p);
}
