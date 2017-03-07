/*C
			calc_froot( fkeller )

	"calculator finding root".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_froot( fkeller );      list fkeller;
	X = calc_froot( fkeller );

	fkeller besteht entweder aus einem Polynom ueber Z/qZ, wobei q
	Primzahl ist, oder aus einer Primzahl q und einem Polynom ueber Z
	oder aus einem Polynom ueber GF(p^n), p Primzahl oder ein
	Polynom in einer Variablen ueber Z, Q oder R.
	calc_froot berechnet alle Nullstellen des Polynoms ueber Z/qZ ,
	ueber GF(p^n)bzw. ueber R und C.
	Laeuft calc_froot fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      04.07.1994      S.Schmitt
	Version  2	02.01.1995	S.Schmitt (GF)
	Version  3	17.02.1995	S.Schmitt ( Z, Q, R )
H*/

#include<_calc.h>

list calc_froot( fkeller )
list fkeller;

{       single k,deg,old=0;
	int p; 
	obj el,P,Q,L,V;
	list AVL;
	init(p,el,P,Q,L,V,AVL);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength(fkeller)!=1 && llength(fkeller)!=2 )
	{       mistake( 3 );
		return( ERROR );
	}

	/*** Primzahl + Polynom ***/

	if(llength(fkeller)==2)     
	{	P=lfirst(fkeller);
		if(llength(P)!=2 || lsecond(P)!=2)
		{	mistake(327);
			return(ERROR);	
		}
		P=lfirst(P);
		if(llength(P)!=2 || llength(lfirst(P))!=1)
		{	mistake(327);
			return(ERROR);
		}
		V=lfirst(P);
		Q=lsecond(P);
		fkeller=lsecond(fkeller);
		p=lfirst(fkeller);
		if(lsecond(fkeller) || (isatom(p) && issprime(p,&el)<1 ))
		{	mistake(328);
			return(ERROR);
		}
		P=pitopmi(1,Q,p);
		k=0;
	}

	/*** nur Polynom ***/

	else			
	{	P=lfirst(fkeller);
		k=lsecond(P);
		P=lfirst(P);
		if((k!=2 && k!=3 && k!=38 && k!=32 && k!=18) 
		  || llength(P)!=2 || llength(lfirst(P))!=1)
		{	mistake(327);
			return(ERROR);
		}
		V=lfirst(P);
		P=lsecond(P);
		if(k==18)
		{	if(!pzsch)
			{	mistake(328);
				return(ERROR);
			}
			p=lfirst(varlist[modsch].varwert);
			k=17;
		}
		else if(k==32)
		{	Q=lfirst(varlist[gfsch].varwert);
			k=31;
		}	
	}

	/*** Nullstellenberechnung ***/

	if(k==2 || k==3 || k==38)
	{	P=ptodp(1,P);
		el = lfirst(P);
		if(k==2) deg=udprf(1,P,1,&L);
		else if(k==3) deg=udprf(2,P,1,&L);
		else deg=udprf(0,P,1,&L);
		P=dptop(1,P);
		old=0;
	}
	else if(k==31)
	{	if(gfchar==2)  L=upgf2bofact(Q,P);	
		else  L=upgfscfact(gfchar,Q,P);
		L=gfrffact(gfchar,Q,L);
		old=1;
	}
	else 
	{	L=upmirf(p,P);
		old=1;
	}

	/*** Ausgabe fuer Z/pZ bzw. GF(p^n) falls keine Nullstelle 
		gefunden wurde ***/

	if(old && L==_0 && !assch)
	{	printf(" The polynomial ");
		if(!k) putpi(1,Q,V);	
		else if(k==17) putpm(1,P,V);
		else if(gfchar==2) putpgf2(1,Q,P,V,VGF);
		else putpgfs(1,P,V,VGF);
		printf(" has no roots in");
		if(k<31)
		{	printf(" Z/");
			puti(p);
			printf("Z.\n");
		}
		else
		{	printf(" GF(");
			puti(gfchar);
			if(gfchar==2) p=lfirst(Q);
			else p=lfirst(lfirst(Q));
			printf("^%i).\n",p);
		}
		if(ps)
		{	fprintf(datei,"out: The polynomial ");
			if(!k) fputpi(1,Q,V,datei);
			else if(k==17) fputpm(1,P,V,datei);
			else if(gfchar==2) fputpgf2(1,Q,P,V,VGF,datei);
			else fputpgfs(1,P,V,VGF,datei);
			fprintf(datei," has no roots in");
			if(k<31)
			{	fprintf(datei," Z/");
				fputi(p,datei);
				fprintf(datei,"Z.\n");
			}
			else
			{	fprintf(datei," GF(");
				fputi(gfchar,datei);
				fprintf(datei,"^%i).\n",p);
			}
		}
		return(ERROR-1);
	}

	/*** Keine Ausgabe f"ur Z/pZ und GF(p^n) falls keine 
			Nullstelle gefunden wurde. ***/

	else if(old && L==_0) return(ERROR-1);

	/*** Ausgabe der Nullstellen f"ur Z/pZ und GF(p^n) ***/

	else if(old)
	{	if(!assch)
		{  printf(" roots of ");
		   if(!k) 
		   {	putpi(1,Q,V);
			printf(" in Z/");
			puti(p);
			printf("Z:   ");
		   }
		   else if(k==17)
		   {	putpm(1,P,V);
			printf(":   ");
		   }
		   else if(gfchar==2)
		   {	putpgf2(1,Q,P,V,VGF);
			printf(":   ");
		   }
		   else
		   {	putpgfs(1,P,V,VGF);
			printf(":   ");
		   }
		   if(ps)
		   {	fprintf(datei,"out: roots of ");
			if(!k) 
			{	fputpi(1,Q,V,datei);
				fprintf(datei," in Z/");
				fputi(p,datei);
				fprintf(datei,"Z:   ");
			}
			else if(k==17)
			{	fputpm(1,P,V,datei);
				fprintf(datei,":   ");
			}
			else if(gfchar==2)
			{	fputpgf2(1,Q,P,V,VGF,datei);
				fprintf(datei,":   ");
			}
			else
			{	fputpgfs(1,P,V,VGF,datei);
				fprintf(datei,":   ");
			}
		   }
		}
		if(avsch) AVL=_0;
		while(L!=_0)
		{	el=lfirst(L);
			L=lred(L);
			if(avsch) AVL=lcomp(list2(el,k),AVL);
			if(!assch)
			{  if(!k) puti(el);
			   else if(k==17) printf("MOD(%i)",el);
			   else if(gfchar==2) putgf2el(Q,el,VGF);
			   else putgfsel(el,VGF);
			   if(L!=_0) printf(", ");
			   if(ps)
			   {	if(!k) fputi(el,datei);
				else if(k==17) fprintf(datei,"MOD(%i)",el);
				else if(gfchar==2) fputgf2el(Q,el,VGF,datei);
				else fputgfsel(el,VGF,datei);
				if(L!=_0) fprintf(datei,", ");
			   }
			}
		}
		if(!assch)
		{  printf("\n       ");
		   if(ps) fprintf(datei,"\n       ");
		}
		if(avsch)
		{	AVL=linv(AVL);
			av_basad(AVL);
		}
		el=list2(el,k);
		return(el);
	}
	
	/*** Ausgabe f"ur R und C ***/

	else 
	{	Q=lsecond(L);
		L=lfirst(L);
	
		if(deg==2 && !assch)
		{	printf(" The maximal number of iteration steps is exceeded.\n");
			if(ps) fprintf(datei, "out: The maximal number of iteration steps is exceeded.\n");
		}
		if(!assch && (L!=_0 || Q!=_0))
		{	printf(" roots of ");
			if(k==2) putpi(1,P,V);
			else if(k==3) putpr(1,P,V);
			else putpfl(1,P,V);
			printf(": \n");
			if(ps)
			{ 	fprintf(datei," roots of ");
				if(k==2) fputpi(1,P,V,datei);
				else if(k==3) fputpr(1,P,V,datei);
				else fputpfl(1,P,V,datei);
				fprintf(datei,": \n");
			}
		}
		if(avsch) AVL=_0;
		if(L!=_0)
		{	if(!assch)
			{  printf(" real roots: ");
			   if(ps) fprintf(datei," real roots: ");
			}
			while(L!=_0)
			{	el=lfirst(L);
				L=lred(L);
				if(avsch) AVL=lcomp(list2(el,15),AVL);
				if(!assch)

/**** RAUS ***
				{  if(!OUTPUTDIG) yputfl(el,-DIGITS);
				   else yputflfx(el,1,OUTPUTDIG);
*************/
				{  if(!OUTPUTDIG) putfl(el,-DIGITS);
				   else putflfx(el,1,OUTPUTDIG);
				   if(L!=_0) printf(", ");
				   if(ps)
				   {   if(!OUTPUTDIG) fputfl(el,-DIGITS,datei);
				       else fputflfx(el,1,OUTPUTDIG,datei);
				       if(L!=_0) fprintf(datei,", ");
				   }
				}
			}
			if(!assch)
			{  printf("\n");
			   if(ps) fprintf(datei,"\n");
			}
			old=15;	
		}
		if(Q!=_0)
		{	if(!assch)
			{  printf(" complex roots: ");
			   if(ps) fprintf(datei," complex roots: ");
			}
			while(Q!=_0)
			{	el=lfirst(Q);
				Q=lred(Q);
				if(avsch) AVL=lcomp(list2(el,37),AVL);
				if(!assch)
				{  if(!OUTPUTDIG) putcomp(el,-DIGITS);
				   else putcompfx(el,1,OUTPUTDIG);
				   if(Q!=_0) printf(", ");
				   if(ps)
				   {   if(!OUTPUTDIG) fputcomp(el,-DIGITS,datei);
				       else fputcompfx(el,1,OUTPUTDIG,datei);
				       if(L!=_0) fprintf(datei,", ");
				   }
				}
			}
			if(!assch)
			{  printf("\n");
			   if(ps) fprintf(datei,"\n");
			}
			old=37;	
		}
		if(old && !assch)
		{  printf("       ");
		   if(ps) fprintf(datei,"       ");
		}
		if(old)
		{	el=list2(el,old);
			if(avsch)
			{ 	AVL=linv(AVL);
				av_basad(AVL);
			}
			return(el);
		}
		else return(ERROR-1);
	}
}
