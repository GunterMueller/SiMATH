/*C
			calc_tors( fkeller )

	"calculator torsion".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_tors( fkeller )   list fkeller;
	L = calc_tors( fkeller );

	fkeller ist eine Liste, bestehend aus einer elliptischen Kurve E
	und einer Zahl zwischen 1 und 3.
	Fuer 1 wird die Gruppenstruktur, fuer 2 die Gruppenstruktur und
	die Erzeugenden, fuer 3 die Gruppenstruktur, die Erzeugenden
	und alle Elemente der Torsionsgruppe von E ausgegeben.
	In L wird die Ordnung der Torsionsgruppe zurueckgeliefert.
	Laeuft calc_tors fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1      11.06.1992      U.Schneiders
	Version  2	22.04.1993	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_tors( fkeller )
list fkeller;
{
	single k, sch, h, s, s1, s2;
	rat x, y;
	obj a, L, z, z1;
	list H, P, S;
	list AVL, AH1, AH2;
	init( x, y, a, L, z, z1, H, P, S, AVL, AH1, AH2 );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"tors" );
		return( ERROR );
	}

	/*** 1, 2, 3 ***/

	a = lfirst( fkeller );
	k = lsecond( a );
	if( k )
	{       mistake( 167 );
		return( ERROR );
	}
	a = lfirst( a );
	if( a != 1 && a != 2 && a != 3 )
	{       mistake( 167 );
		return( ERROR );
	}

	/*** elliptische Kurve ***/

	fkeller = lsecond( fkeller );
	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && k != (-9) && k != (-10) )
	{       mistake1( 34,"tors" );
		return( ERROR );
	}
	if((k<=(-9) || (nfsch && nfon)) && ecqnfsch==_0)
        {       mistake(187);
                return(ERROR);
        }
	fkeller = lfirst( fkeller );
	if(k>=(-2) && nfsch && nfon)
	{
		fkeller=tonftyper(fkeller,k);
		k=k-8;
	}
	if(k<=(-9))
	{
		z1 = lfirst(varlist[nfsch].varwert);
		if(lsecond(z1)!=1 || lthird(z1)!=0)
		{
			mistake1( 34,"tors" );
			return( ERROR );
		}
		s = lfourth(z1);
		if(isfp(s)!=s) 
		{
			mistake1( 34,"tors" );
                        return( ERROR );
                }
	}

	/*** Berechnung der Torsionsgruppe ***/

	if(k>=(-2))
	{	 
		S = ecrstrtor(fkeller);
		s = llength(S);
		if( a>=2 ) L = ecracgentor(fkeller);
		if( a==3 ) 
		{
			H = ecractorgr(fkeller);
			h = llength(H);
		}
	}
	else
	{
		S = ecqnfstrtor(fkeller);
		s = llength(S);
		L = ecqnfgentor(fkeller);
		H = ecqnftorgr(fkeller);
		h = llength(H);
	}

	/*** Ausgabe ***/

	/*** Struktur ***/

	if(!assch)
	{	printf( " structure:    " );
	 	if( ps ) fprintf( datei, "out: structure:    " );
		s1 = lfirst(S);
		if( s == 1 )
		{  
		   if( s1>1 )
           	   {	
			printf( "  Z/%iZ\n", s1 );
			if( ps ) fprintf( datei, "  Z/%iZ\n", s1 );
	   	   }
	   	   else
           	   {	
			printf( "  ( 0 )\n" );
			if( ps ) fprintf( datei, "  ( 0 )\n" );
	   	   }
		}
		else
		{	
			s2 = lsecond(S);
			printf( "  Z/%iZ x Z/%iZ\n",s1, s2);
			if( ps ) fprintf( datei, "  Z/%iZ x Z/%iZ\n",s1, s2);
		}
	}

	/*** Erzeuger ***/

	if( a > 1 )
	{ 	if(!assch)
		{	if(s==1)
			{    printf( " generator:      " );
			     if( ps ) fprintf( datei, "     generator:      " );
			}
			else
			{    printf( " generators:     " );
			     if( ps ) fprintf( datei, "     generators:     " );
			}
		}
		sch = 0;
		if(avsch) 
		{	AVL=_0;
			if(a>2)
			{	AH1=0;
				AH2=0;
				s2=0;
			}
			if(k>=(-2)) s1 = -4;
			else s1 = -12;
		}	
	 	while( L != _0 )
		{	P = lfirst( L );
			L = lred( L );
			if(avsch) 
			{	AVL=lcomp(list2(P,s1),AVL);
				if(a>2)
				{	if(!s2) AH1=P;
					else AH2=P;
					s2=1;
				}
			}
			if(!assch)
			{  if( sch ) 
			   {	printf( "%t", 18 );
				if( ps ) fprintf( datei, "%t", 22 );
			   }
			   x=lfirst(P);
			   y=lsecond(P);
			   z=lthird(P);
			   if(!z)
			   {	printf("PT(0, 1, 0)\n");
				if(ps) fprintf( datei, "PT(0, 1, 0)\n");
			   }
			   else if(k>=(-2))
			   {	if(z!=1)
				{	z1 = iprod(z,z);
					x=rcons(x,z1);
					z1=iprod(z1,z);
					y=rcons(y,z1);
					z = rden(x);
					z1 = rden(y);
					z = ilcm(z,z1);
					z = itor(z);
					x = rprod(x,z);
					y = rprod(y,z);
					x = rnum(x);
					y = rnum(y);
					z = rnum(z);
				}
				printf( "PT(%i, %i, %i)\n", x, y, z );
				if( ps ) fprintf( datei, "PT(%i, %i, %i)\n", x, y, z );
			   }
			   else /** k=(-9) || k=(-10) **/
			   {
				printf( "PT(");
				if(ps) fprintf( datei, "PT(");

				x = kenntest(list2(x, 24));
				s = lsecond(x);
				x = lfirst(x);
				if(s==24) putnfel(z1, x, VNF);
				else if(s==1) putr(x);
				else puti(x);
				if(ps)
				{
					if(s==24) fputnfel(z1, x, VNF, datei);
					else if(s==1) fputr(x, datei);
					else fputi(x, datei);
				}
					
				printf(", ");
				if(ps) fprintf( datei, ", ");

				y = kenntest(list2(y, 24));
				s = lsecond(y);
				y = lfirst(y);
				if(s==24) putnfel(z1, y, VNF);
				else if(s==1) putr(y);
				else puti(y);
				if(ps)
				{
					if(s==24) fputnfel(z1, y, VNF, datei);
					else if(s==1) fputr(y, datei);
					else fputi(y, datei);
				}
				
				printf(", 1)\n");
				if(ps) fprintf( datei, ", 1)\n");
			   }
			   sch = 1;
			}
		}
	}				

	/*** Torsionspunkte ***/

	if( a > 2 )
	{ 	if(!assch)
		{	if(h==1)
			{    printf( " torsion point:  " );
			     if( ps ) fprintf( datei, "     torsion point:  " );
			}
			else
			{    printf( " torsion points: " );
			     if( ps ) fprintf( datei, "     torsion points: " );
			}
		}
		sch = 0;
	 	while( H != _0 )
		{	P = lfirst( H );
			H = lred( H );
			if(avsch) 
			{  if(!oequal(P,AH1))
			   {   if(!AH2 || !oequal(P,AH2))
					AVL=lcomp(list2(P,s1),AVL);
			   }
			}
			if(!assch)
			{  if( sch )
			   {	printf( "%t", 18 );
				if( ps ) fprintf( datei, "%t", 22 );
			   }
			   x=lfirst(P);
			   y=lsecond(P);
			   z=lthird(P);
			   if(!z)
			   {	printf("PT(0, 1, 0)\n");
				if(ps) fprintf( datei, "PT(0, 1, 0)\n");
			   }
			   else if(k>=(-2))
			   {	if(z!=1)
				{	z1 = iprod(z,z);
					x=rcons(x,z1);
					z1=iprod(z1,z);
					y=rcons(y,z1);
					z = rden(x);
					z1 = rden(y);
					z = ilcm(z,z1);
					z = itor(z);
					x = rprod(x,z);
					y = rprod(y,z);
					x = rnum(x);
					y = rnum(y);
					z = rnum(z);
				}
				printf( "PT(%i, %i, %i)\n", x, y, z );
				if( ps ) fprintf( datei, "PT(%i, %i, %i)\n", x, y, z );
			   }
			   else /** k=(-9) || k=(-10) **/
			   {
				printf( "PT(");
				if(ps) fprintf( datei, "PT(");

				x = kenntest(list2(x, 24));
				s = lsecond(x);
				x = lfirst(x);
				if(s==24) putnfel(z1, x, VNF);
				else if(s==1) putr(x);
				else puti(x);
				if(ps)
				{
					if(s==24) fputnfel(z1, x, VNF, datei);
					else if(s==1) fputr(x, datei);
					else fputi(x, datei);
				}
					
				printf(", ");
				if(ps) fprintf( datei, ", ");

				y = kenntest(list2(y, 24));
				s = lsecond(y);
				y = lfirst(y);
				if(s==24) putnfel(z1, y, VNF);
				else if(s==1) putr(y);
				else puti(y);
				if(ps)
				{
					if(s==24) fputnfel(z1, y, VNF, datei);
					else if(s==1) fputr(y, datei);
					else fputi(y, datei);
				}
				
				printf(", 1)\n");
				if(ps) fprintf( datei, ", 1)\n");
			   }
			   sch = 1;
			}

		}
	}				
	if(a>1 && avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}
				
	L = list2( h, 0 );
	return( L );
}
