/*C
			calc_fakt( fkeller )

	"calculator factorization".
	int calc_fakt(fkeller); list fkeller;
	X = calc_fakt( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung. Berechnet wird die Liste der Primteiler des
	Objekts, dabei wird im Falle einer Zahl aus Q\Z oder einer
	rationalen Funktion Zaehler und Nenner faktorisiert. Zulaes-
	sige Eingaben sind alle von 0 verschiedenen rationalen Zahlen
	und Polynome ueber Z bzw ueber Q oder in einer Veraenderlichen
	ueber Z/pZ oder einem endlichen Koerper mit Charakteristik > 2 
	oder rationale Funktionen. Da die berechnete Liste der Primteiler 
	von den uebergeordneten Programmen des Calculators nicht 
	verarbeitet werden kann, wird der Ersatzwert -BASIS 
	zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      12.09.1988      U.Schneiders
	Version  3      04.12.1989      U.Schneiders
	Version  4      11.03.1993      S.Schmitt/U.Schneiders
	Version  5	26.07.1993	S.Schmitt ( gf )
	Version  6      17.02 1994	S.Schmitt/U.Schneiders
	Version  7	06.10.1994	S.Schmitt (P(Nf))
	Version  8	21.03.1995	S.Schmitt/U.Schneiders (nfon)
	Version  8.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

int calc_fakt( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj c, Z, Z1, Ne, Za, erg, p;
	list AVL, VL, L;
	int hn;
	single l, ken, r;
	init( Z, Z1, Ne, Za, erg, p, AVL, VL, L, c, hn );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	ken = lsecond( fkeller );
	if( ( ken > 4 || ken < 0 ) && ken != 18 && ken != 24 && ken != 25 && ken != 32 )
	{       mistake( 84 );
		return( -BASIS );
	}
	if( ( ken == 24 && ecqnfsch==_0 )
         || ( (!ken || ken==1) && nfon && nfsch && ecqnfsch==_0 ) )
	{	mistake(84);
		return(ERROR);
	}
	if( ken==18 && !pzsch )   
	{	mistake(46);
		return(ERROR);
	}	
	Z = lfirst( fkeller );

	/*** Fehlermeldung zur Eingabe 0 ***/
	if ( Z == 0 )
	{       mistake( 14 );
		return( -BASIS );
	}
	if( ken > 1 && ken != 24 )
	{       VL = lfirst( Z );
		Z = lsecond( Z );
		r = llength( VL );
	}
        if( ( ken==18 || ken == 32 ) && r>1 )
	{	mistake(199);
		return(ERROR);
	}
	if(ken==24 || (nfsch && nfon && (!ken || ken==1) ) )
	{	Z1=lfirst(varlist[nfsch].varwert);
		if(llength(ecqnfsch)==3) 
		{	Za=lsecond(ecqnfsch);
			VL=lthird(ecqnfsch);
			VL=list2(Za,VL);
		}
		else VL=ecqnfsch;
		Za=lfirst(ecqnfsch);
	}


	/*** Angleichung an Zahlkoerper fuer ken = 0,1,2,3
             und nfsch=1 und nfon=1                       ***/

	if( nfsch && nfon )
	{	switch( ken )
		{	case 0: Z = itonf(Z);
				ken = 24;
				break;
			case 1: Z = rtonf(Z);
				ken = 24;
				break;
			case 2: Z = pitopnf(r,Z);
				ken = 25;
				break;
			case 3: Z = prtopnf(r,Z);
				ken = 25;
				break;
			default: break;
		}
	}

	/*** Faktorisierung und Zuordnung der zu fakto-
	     risierenden Zahl an Systemvariable @ ***/

	switch( ken )
	{       case 0: erg=caifact( Z , Z, 1 ); 
			if(erg==_0)  erg=fkeller;
			else
			{ 	if(avsch)
				{	L = erg;
					L = ifel(L);
					AVL = _0;	
					while(L!=_0)
					{	Z = lfirst(L);
						Z1 = lsecond(L);
						L = lred2(L);
						AVL = lcomp( list2(Z1,0),AVL);
						AVL = lcomp( list2(Z,0),AVL);
					}
					av_basad(AVL);
				}
				erg=llast(erg);
				erg=lfirst(erg);
				erg=list2(erg,0);
			}
			break;
		case 1: Z1 = lfirst( Z );
			erg=caifact( Z1, Z, 2 );
			if( avsch ) AVL = _0;
			if(erg==_0)  erg=list2(Z1,0);
			else
			{ 	if(avsch)
				{	L = erg;
					L = ifel(L);
					while(L!=_0)
					{	VL = lfirst(L);
						Z1 = lsecond(L);
						L = lred2(L);
						AVL = lcomp( list2(Z1,0),AVL);
						AVL = lcomp( list2(VL,0),AVL);
					}
				}
			 	erg=llast(erg);
				erg=lfirst(erg);
				erg=list2(erg,0);
			}
			Z1 = lsecond( Z );
			L = caifact( Z1, Z, 3 );
			if(avsch)
			{	L = ifel(L);
				Za = _0;
				while(L!=_0)
				{	VL = lfirst(L);
					Z1 = lsecond(L);
					Z1 = ineg(Z1);
					L = lred2(L);
					Za = lcomp( list2(Z1,0),Za);
					Za = lcomp( list2(VL,0),Za);
				}
				if( AVL == _0 ) AVL = Za;
				else AVL = lcconc( AVL, Za );
				av_basad(AVL);
			}
			break;
		case 2: if( r == 1 ) L = upifact( Z );
			else         L = pifact( r, Z );
			if( L == ERROR )
			{       mistake( 13 );
				return( -BASIS );
			}
			L=lpbsorts(r,L);
			erg=pfaktaus( VL, Z, ken, L, 1 );
			if( avsch )
			{	AVL = _0;
				Z = lfirst( L );
				AVL = lcomp( list2(Z,0), AVL );
				L = lred(L);
				while( L!=_0 )
				{	Z = lfirst(L);
					Z1 = lsecond(L);
					L = lred2(L);
					Z = list2(VL,Z);
					AVL = lcomp( list2(Z,2), AVL);
					AVL = lcomp( list2(Z1,0), AVL);
				}
				AVL = linv( AVL );
				av_basad( AVL );
			}
			erg=list2(VL,erg);
			erg=list2(erg,2);
			break;
		case 3: if( r == 1 ) L = uprfact( Z );
			else
			{       Z1 = prnumden( r, Z, &hn );
				L = pifact( r, Z1 );
			}
			if( L == ERROR )
			{       mistake( 13 );
				return( -BASIS );
			}
			if( r > 1 && icomp( hn, 1 ) )
			{       c = lfirst( L );
				L = lred( L );
				c = rcons( c, hn );
				L = lcomp( c, L );
			}
			L=lpbsorts(r,L);	
			erg=pfaktaus( VL, Z, ken, L, 1 );
			if( avsch )
			{	AVL = _0;
				Z = lfirst( L );
				AVL = lcomp( list2(Z,1), AVL );
				L = lred(L);
				while( L!=_0 )
				{	Z = lfirst(L);
					Z1 = lsecond(L);
					L = lred2(L);
					Z = list2(VL,Z);
					AVL = lcomp( list2(Z,2), AVL);
					AVL = lcomp( list2(Z1,0), AVL);
				}
				AVL = linv( AVL );
				av_basad( AVL );
			}
			erg=list2(VL,erg);
			erg=list2(erg,2);
			break;
		case 4: Ne = lsecond( Z );
			Za = lfirst( Z );
			if( r == 1 ) L = upifact( Za );
			else         L = pifact( r, Za );
			if( L == ERROR )
			{       mistake( 13 );
				return( -BASIS );
			}
			L=lpbsorts(r,L);
			erg=pfaktaus( VL, Z, ken, L, 2 );
			if( avsch )
			{	AVL = _0;
				Z = lfirst( L );
				AVL = lcomp( list2(Z,0), AVL );
				L = lred(L);
				while( L!=_0 )
				{	Z = lfirst(L);
					Z1 = lsecond(L);
					L = lred2(L);
					Z = list2(VL,Z);
					AVL = lcomp( list2(Z,2), AVL);
					AVL = lcomp( list2(Z1,0), AVL);
				}
				AVL = linv( AVL );
			}
			erg=list2(VL,erg);
			erg=list2(erg,2);
			if( r == 1 ) L = upifact( Ne );
			else         L = pifact( r, Ne );
			if( L == ERROR )
			{       mistake( 13 );
				return( -BASIS );
			}
			L=lpbsorts(r,L);
			pfaktaus( VL, Z, ken, L, 3 );
			if( avsch )
			{	Za = _0;
				Z = lfirst( L );
				if( icomp(Z,1) )
				{   	Z1 = lfirst(AVL);
					Z1 = lfirst(Z1);
					Z1 = rcons(Z1,Z);
					Z1 = list2(Z1,1);
					AVL = lred( AVL );
					AVL = lcomp(Z1,AVL);
				}	
				L = lred(L);
				while( L!=_0 )
				{	Z = lfirst(L);
					Z1 = lsecond(L);
					Z1 = ineg(Z1);
					L = lred2(L);
					Z = list2(VL,Z);
					Za = lcomp( list2(Z,2), Za);
					Za = lcomp( list2(Z1,0), Za);
				}
				Za = linv( Za );
				AVL = lcconc( AVL, Za );
				av_basad( AVL );
			}
			break;
		case 18:p=lfirst(varlist[modsch].varwert);
			c=lsecond(Z);
			if(c!=1) 
			{	if(ssch) Za=pmsmsquot(1,p,Z,c);
				else     Za=pmimiquot(1,p,Z,c);
			}
			else Za=Z;
			L=upmicfact(p,Za);
			L=lcomp(c,L);
  			erg=polaus(VL,L,Z,18,p);	
			erg=list2(VL,erg);
			erg=list2(erg,18);
			break;
		case 24:if(llength(ecqnfsch)==3) Z=nftoqnf(Z,24);
			L=qnfpifact(Za,Z);
			if(llength(ecqnfsch)==3) Z=qnftonf(Z,24);
			if(!assch){
			puts(" factorization of (");
			putnfel(Z1, Z, VNF);
			puts("): ");
			if(ps)
			{	fputs(" factorization of (",datei);
				fputnfel(Z1, Z, VNF,datei);
				fputs("): ",datei);
			}
			if(llength(L)==1) 
			{	puts("(1)\n");
				if(ps) fputs("(1)\n",datei);
				erg = list2(Z,24);
				break;
			}
			while(L!=_0)
			{	putqnfid(VL,lfirst(L));
				if(ps) fputqnfidsp(VL,lfirst(L),datei);
				p=lsecond(L);
				if(p>1)
				{	printf("^%i",p);
					if(ps) fprintf(datei, "^%i",p);
				}
				else if(p<0)
				{	printf("^(%i)",p);
					if(ps) fprintf(datei, "^(%i)",p);
				}
				L=lred4(L);
				if(L!=_0)
				{	printf(" * ");
					if( ps) fprintf(datei," * ");
				}
			}
			printf("\n");
			if(ps) fprintf( datei, "\n");
			}
			erg = list2(Z,24);
			break;
		case 25:Za=lfirst(varlist[nfsch].varwert);
			L=dptop(1,Za);	
			Z1=ouspidenic(L);
			L=pnffact(r,Za,Z1,Z);
		/**************case 25:Za=lfirst(varlist[nfsch].varwert);
			L=upnffact(Za,Z); ************/
			if(!assch){
			puts(" factorization of ");
			putpnf(r, Za,  Z, VL, VNF);
			puts(":\n");
			if(ps)
			{	fputs(" factorization of ",datei);
				fputpnf(r, Za, Z, VL, VNF,datei);
				fputs(":\n",datei);
			}
			}
			Z1=lfirst(L);
			L=lred(L);
			Z1=kenntest(list2(Z1,24));
			if( avsch ) AVL = list1( Z1 );
			if(!assch){
			p=lsecond(Z1);
			Z1=lfirst(Z1);
			hn=0;
			switch(p)
			{	case 0: if(Z1==(-1))
					{	printf("-");
						if(ps) fprintf(datei,"-");
					}
					else if(Z1!=1)
					{	puti(Z1);
						printf(" * ");
						if(ps)
						{  fputi(Z1,datei);
						   fprintf(datei," * ");
						}
					}
					else hn=1;
					break;
				case 1: putr(Z1);
					printf(" * ");
					if(ps)
					{	fputr(Z1,datei);
						fprintf(datei," * ");
					}
					break;
				case 24:putnfel(Za, Z1, VNF);
					printf(" * ");
					if(ps)
					{	fputnfel(Za,Z1,VNF,datei);
						fprintf(datei," * ");
					}	
					break;
			}
			}
			while(L!=_0)
			{	Z1=lfirst(L);
				p=lsecond(L);
				if( avsch )
				{	Ne = list2( VL, Z1 );
					AVL = lcomp( list2(Ne,25), AVL);
					AVL = lcomp( list2(p,0), AVL );
				}
				L=lred2(L);
				if(!assch){
				if(!hn || p>1 || L!=_0)
				{
				    Ne=Z1;
				    while(lfirst(Ne)==0) Ne=lsecond(Ne);
				    l=llength(Ne);
				    if(l>2) 
				    {	printf("(");
					if(ps) fprintf(datei,"(");
				    }
				}
				putpnf(r,Za,Z1,VL,VNF);
				if(ps) fputpnf(r,Za,Z1,VL,VNF,datei);
				if(!hn || p>1 || L!=_0)
				{   if(l>2) 
				    {	printf(")");
					if(ps) fprintf(datei,")");
				    }
				    hn=0;
				}
				if(p>1)
				{	printf("^");
					puti(p);
					if(ps) 
					{	fprintf(datei,"^");
						fputi(p,datei);
					}
				}	
				if(L!=_0)
				{	printf(" * ");
					if(ps) fprintf(datei," * ");
				}
				}
			}					
			if(!assch)
			{	printf("\n");
				if(ps) fprintf(datei,"\n");
			}
			if( avsch )
			{	AVL = linv( AVL );
				av_basad( AVL );
			}
			erg=list2(VL,Z1);
			erg=list2(erg,25);
			break;
		case 32:p=lfirst(varlist[gfsch].varwert);
			c=lsecond(Z);
			L=list2(0,1);
			if( !oequal( c, L ) )  
			{	if(gfchar==2) Za=pgf2gf2quot(1,p,Z,c);
				else  Za=pgfsgfsquot(1,gfchar,p,Z,c);
			}
			else Za=Z;
			if(gfchar==2)
			{	L=upgf2bofact(p,Za);
				L=lcomp(c,L);
				erg=pgf2faus(VL,Z,L);
			}
			else
			{ 	L=upgfscfact(gfchar,p,Za);
				L=lcomp(c,L);
				erg=pgfsfaus(VL,Z,L);
			}
			erg=list2(VL,erg);
			erg=list2(erg,32);
			break;
	}
	return(erg);
}
