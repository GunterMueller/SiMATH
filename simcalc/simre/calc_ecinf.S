/*C
			calc_ecinf( fkeller )

	"calculator elliptic curve information".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_ecinf( fkeller );  list fkeller;
	L = calc_ecinf( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q, Z/mZ oder
	Zahlkoerpern.
	calc_ecinf gibt an:
	    fuer ellipt. Kurven ueber Q
		die Tate'schen Groessen b2, b4, b6, b8 und c4, c6,
		die Diskriminante mit Faktorisierung,
		die j-Invariante mit Faktorisierunge ihres Nenners,
		die minimale Weierstrass Normalform mit Angabe der
		Transformationsparameter,
		der Fuehrer der minimalen Kurve mit Faktorisierung,
		die zu den Stellen schlechter Reduktion gehoerenden
		Kodaira- und Neron-Symbole.
	    fuer ellipt. Kurven ueber qnadr. Zahlkoerpern
		die Tate'schen Groessen b2, b4, b6, b8 und c4, c6,
		die Diskriminante mit Faktorisierung,
		die j-Invariante,
		der Fuehrer mit Faktorisierung,
		die zu den Stellen schlechter Reduktion gehoerenden
		Kodaira- und Neron-Symbole.
	    fuer ellipt. Kurven ueber Z/mZ, Zahl- und Galois-Koerpern
		die Tate'schen Groessen b2, b4, b6, b8 und c4, c6,
		die Diskriminante,
		die j-Invariante.
	Laeuft calc_ecinf fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      27.01.1992      U.Schneiders
	Version  2      11.09.1992      U.Schneiders ( mod und nf )
	Version  3	15.04.1993	S.Schmitt
	Version  4      27.07.1993      U.Schneiders ( gf )
	Version  5	09.02.1994	S.Schmitt/U.Schneiders
	Version  6	21.03.1995	S.Schmitt/U.Schneiders (nfon)
	Version  6.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_ecinf( fkeller )
list fkeller;
{
	single e, k, sch; 
	int  p, i;
	rat ko[5];
	obj D, h,a;
	list E, L, M, T, DD;
	list AVL;
	init( p, i, E, L, M, T, DD, AVL, D, h,a ); init( ko[0..4] ); 
	bind( fkeller );

	/*** Abfangen falscher Eingaben und Vorbesetzungen ***/

	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10)  && k != (-14) )
	{       mistake1( 34,"ecinf" );
		return( ERROR );
	}
	fkeller=lfirst(fkeller);

	/*** Angleichung ueber NF, falls k=-1,-2 und nfsch=1 und nfon=1 ***/ 

	if( nfsch && nfon && (k==(-1) || k==(-2) ) )
	{	fkeller = tonftyper( fkeller,k );
		k = k-8;
	}

	if((k==(-9) || k==(-10)) && ecqnfsch!=_0)
	{	L=lfirst(fkeller);
		L=lfirst(L);
		ko[0] = lfirst(L);
		ko[1] = lsecond(L);
		ko[2] = lthird(L);
		ko[3] = lfourth(L);
		ko[4] = lfifth(L);
	}
	else if( k == (-5) || k == (-9) )
	{       ko[0] = 0;
		ko[1] = 0;
		ko[2] = 0;
		ko[3] = lfirst( fkeller );
		ko[4] = lsecond( fkeller );
	}
	else if(k==(-6) || k==(-10) || k==(-14))
	{ 	ko[0]=lfirst(fkeller);
		ko[1]=lsecond(fkeller);
		ko[2]=lthird(fkeller);
		ko[3]=lfourth(fkeller);
		ko[4]=lfifth(fkeller);
	}	
	if( k == (-5) || k == (-6) ) M = lfirst( varlist[modsch].varwert );
	else if( k == (-9) || k == (-10) ) 
	{	M = lfirst( varlist[nfsch].varwert );
		if(ecqnfsch!=_0) D=lfirst(ecqnfsch);
	}
	else if( k == (-14) ) M = lfirst( varlist[gfsch].varwert );

	/*** Tate'sche Groessen b's ***/

	if( k ==(-1) || k == (-2) ) 
	{	h=ecracb2(fkeller);
		L=lfirst(fkeller);
		L=lsecond(L);
	}
	else if( k ==(-5) || k == (-6) ) L = ecmptavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	else if( k ==(-9) || k == (-10)) 
	{	if(ecqnfsch!=_0)
		{	L=ecqnfacb2(fkeller);
			L=lfirst(fkeller);
			L=lsecond(L);
		}
		else L = ecnftavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	}
	else L = ecgf2tavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	
	if(!assch)
	{	printf(" b's:             " );
		if( ps ) fprintf( datei, "out: b's:             " );
	}
	sch = 0;
	if(avsch) AVL=_0;
	while( L != _0 )
	{       h = lfirst( L );
		L = lred( L );
		if(avsch)
		{  switch(k)
		   {  case (-1):
		      case (-2): AVL=lcomp(list2(h,1),AVL);
				 break;
		      case (-5):
		      case (-6): AVL=lcomp(list2(h,17),AVL);
				 break;
		      case (-9):
		      case (-10): if(llength(ecqnfsch)==3) a=qnftonf(h,24);
				  T=kenntest(list2(a,24));
		      		  AVL=lcomp(T,AVL);
				  break;
		      case (-14): AVL=lcomp(list2(h,31),AVL);
				  break;
		   }
		}
		if(!assch)
		{  if( sch )
		   {       printf( "," );
			   if( ps ) fprintf( datei, "," );
		   }
		   else sch = 1;
		   if( k > (-3) )
		   { 	printf( " %r", h );
			if( ps ) fprintf( datei, " %r", h );
		   }
		   else if( k == (-5) || k == (-6) )
		   {	printf( " MOD(%i)", h );
			if( ps ) fprintf( datei, " MOD(%i)", h );
		   }
		   else if( k == (-9) || k == (-10) ) 
		   {	printf( " " );
			h=kenntest(list2(h,24));
			e=lsecond(h);
			h=lfirst(h);
			if(e==24) 
			{	if(llength(ecqnfsch)==3) h=qnftonf(h,24);
				putnfel( M, h, VNF );
			}
			else if(e==1) putr(h);
			else puti(h);
			if( ps )
                        {  fprintf( datei, " " );
			   if(e==24) fputnfel( M, h, VNF, datei );
			   else if(e==1) fputr(h,datei);
			   else fputi(h,datei);
			}
		   }
		   else 
		   {	printf( " " );
			putgf2el( M, h, VGF );
			if( ps )
                        {  fprintf( datei, " " );
			   fputgf2el( M, h, VGF, datei );
			}
		   }
		}
	}
	if(!assch)
	{	printf( "\n\n" );
		if( ps ) fprintf( datei, "\n\n" );
	}

	/*** Tate'sche Groessen c's ***/

	if( k ==(-1) || k == (-2) ) 
	{	h=ecracc4(fkeller);
		L=lfirst(fkeller);
		L=lthird(L);
	}
	else if( k ==(-5) || k == (-6) ) L = ecmptavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	else if( k ==(-9) || k == (-10)) 
	{	if(ecqnfsch!=_0)
		{	L=ecqnfacc4(fkeller);
			L=lfirst(fkeller);
			L=lthird(L);
		}
		else L = ecnftavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	}
	else  L = ecgf2tavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );

	if(!assch)
	{ 	printf(" c's:             " );
		if( ps ) fprintf( datei, "     c's:             " );
	}
	sch = 0;
	while( L != _0 )
	{       h = lfirst( L );
		L = lred( L );
		if(avsch)
		{  switch(k)
		   {  case (-1):
		      case (-2): AVL=lcomp(list2(h,1),AVL);
				 break;
		      case (-5):
		      case (-6): AVL=lcomp(list2(h,17),AVL);
				 break;
		      case (-9):
		      case (-10): if(llength(ecqnfsch)==3) a=qnftonf(h,24);
				  T=kenntest(list2(a,24));
				  AVL=lcomp(T,AVL);
				  break;
		      case (-14): AVL=lcomp(list2(h,31),AVL);
				  break;
		   }
		}
		if(!assch)
		{  if( sch )
		   {       printf( "," );
			   if( ps ) fprintf( datei, "," );
		   }
		   else sch = 1;
		   if( k > (-3) )
		   { 	printf( " %r", h );
			if( ps ) fprintf( datei, " %r", h );
		   }
		   else if( k == (-5) || k == (-6) )
		   {	printf( " MOD(%i)", h );
			if( ps ) fprintf( datei, " MOD(%i)", h );
		   }
		   else if( k == (-9) || k == (-10) ) 
		   {	printf( " " );
			h=kenntest(list2(h,24));
			e=lsecond(h);
			h=lfirst(h);
			if(e==24) 
			{	if(llength(ecqnfsch)==3) h=qnftonf(h,24);
				putnfel( M, h, VNF );
			}
			else if(e==1) putr(h);
			else puti(h);
			if( ps )
                        {  fprintf( datei, " " );
			   if(e==24) fputnfel( M, h, VNF, datei );
			   else if(e==1) fputr(h,datei);
			   else fputi(h,datei);
			}
		   }
		   else 
		   {	printf( " " );
			putgf2el( M, h, VGF );
			if( ps )
                        {  fprintf( datei, " " );
			   fputgf2el( M, h, VGF, datei );
			}
		   }
		}
	}
	if(!assch)
	{  printf( "\n\n" );
	   if( ps ) fprintf( datei, "\n\n" );
	}

	/*** Diskriminante ***/

	switch( k )
	{	case (-1):
		case (-2): h = ecracdisc( fkeller );
			   L = ecracfdisc(fkeller);
			   M=L;
			   while(lsecond(M)>0)
			   { 	M=lred2(M);
				if(M==_0)  break;
			   }
			   break;
		case (-5): h = ecmpsnfdisc( M, ko[3], ko[4] );
			   break;
		case (-6): h = ecmpdisc( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
		case (-9): if(ecqnfsch!=_0)
			   {	h=ecqnfacdisc(fkeller);
				L=ecqnfacpifdi(fkeller);
			   }
			   else h = ecnfsnfdisc( M, ko[3], ko[4] );
			   break;
		case (-10):if(ecqnfsch!=_0)
			   {	h=ecqnfacdisc(fkeller);
				L=ecqnfacpifdi(fkeller);
			   }
			   else h = ecnfdisc( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
		case (-14):h = ecgf2disc( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
	}

	if( k > (-3) )
	{	if(!assch)
		{   printf( " discriminant:     ");
		    if(ps) fprintf( datei, "     discriminant:     ");
		    printf( "%r =", h );
		    if( ps ) fprintf( datei, "%r =", h );
		    if(rsign(h)==(-1) )
		    {       printf( " -" );
			    if( ps ) fprintf( datei, " -" );
		    }
		}	
		if(avsch) AVL=lcomp(list2(h,1),AVL);
		if(L==_0) 
		{	if(!assch)
			{  printf(" 1");
			   if(ps) fprintf( datei, " 1");
			}
		}
		else
		{	if(!assch && M!=_0)
			{	printf(" (");
				if(ps) fprintf( datei, " (");
			}
			sch=0;
			while(L!=_0)
			{	h=lfirst(L);
				p=lsecond(L);
				if( p < 0 ) break;
				if(avsch)
				{	AVL=lcomp(list2(h,0),AVL);
					AVL=lcomp(list2(p,0),AVL);
				}
				if(!assch)
				{  if(sch) 
				   {	printf(" *");
					if(ps) fprintf( datei, " *");
				   }
				   else sch=1;
				   printf(" %i",h);
				   if(ps) fprintf( datei, " %i",h);
				   if(p>1)
				   {	printf("^%i",p);
					if(ps) fprintf( datei, "^%i",p);
				   }
				}
				L=lred2(L);
			}
			if(!assch && M!=_0)
			{ 	printf(" )");
				if(ps) fprintf( datei, " )");
			}
		}
		if(M!=_0)
		{	if(!assch)
			{	printf(" / (");
				if(ps) fprintf( datei, " / (");
			}
			sch=0;
			while(M!=_0)
			{	if(!assch)
				{  if(sch) 
				   {	printf(" *");
					if(ps) fprintf( datei, " *");
				   }
				   else  sch=1;
				}
				h=lfirst(M);
				p=lsecond(M);	
				if(avsch)
				{	AVL=lcomp(list2(h,0),AVL);
					AVL=lcomp(list2(p,0),AVL);
				}
				if(!assch)
				{  p=iabs(p);
				   printf(" %i",h);
				   if(ps) fprintf( datei, " %i",h);
				   if(p>1)
				   {	printf("^%i",p);
					if(ps) fprintf( datei, "^%i",p);
				   }
				}
				M=lred2(M);
			}
			if(!assch)
			{  printf(" )");
			   if(ps) fprintf( datei, " )");
			}
		}
		if(!assch)
		{   printf("\n\n");
		    if(ps) fprintf( datei, "\n\n");
		}
	}
	else if( k == (-5) || k == (-6) )
	{	if(avsch) AVL=lcomp(list2(h,17),AVL);
		if(!assch)
		{   printf( " discriminant:     MOD(%i)\n\n", h );
		    if( ps ) fprintf( datei, "     discriminant:     MOD(%i)\n\n", h );
		}
	}
	else if(( k == (-9) || k == (-10) ) && ecqnfsch==_0 )
	{	h=kenntest(list2(h,24));
		if(avsch) AVL=lcomp(h,AVL);
		if(!assch)
		{  e=lsecond(h);
		   h=lfirst(h);
		   printf( " discriminant:     " );
		   if(e==24) putnfel( M, h, VNF );
		   else if(e==1) putr(h);
		   else puti(h);
		   printf( "\n\n" );
		   if( ps )
                   {  fprintf( datei, "     discriminant:     " );
		      if(e==24) fputnfel( M, h, VNF, datei );
		      else if(e==1) fputr(h,datei);
		      else fputi(h,datei);
		      fprintf( datei, "\n\n" );
	           }
		}
	}
	else if((k==(-9) || k==(-10)) && ecqnfsch!=_0)
	{	if(llength(ecqnfsch)==3) h=qnftonf(h,24);
		h=kenntest(list2(h,24));
		if(avsch) AVL=lcomp(h,AVL);
		if(!assch)
		{  e=lsecond(h);
		   h=lfirst(h);
		   printf( " discriminant:     (");
		   if(e==24) putnfel( M, h, VNF );
		   else if(e==1) putr(h);
		   else puti(h);
		   if( ps ) 
		   {       fprintf( datei, "     discriminant:     (");
		 	   if(e==24) fputnfel( M, h, VNF, datei );
			   else if(e==1) fputr(h,datei);
			   else fputi(h,datei);
		   }
		   printf( ") = " );
		   if(ps) fprintf( datei, ") = " );
		   if(llength(ecqnfsch)==3) 
		   {	h=lsecond(ecqnfsch);
			DD=lthird(ecqnfsch);
			DD=list2(h,DD);
		   }
		   else DD=ecqnfsch;
		   if(llength(L)==1) 
		   {	puts("(1)\n");
			if(ps) fputs("(1)\n",datei);
		   }
		   else 
		   {	while(L!=_0)
		   	{	putqnfid(DD,lfirst(L));
				if(ps) fputqnfidsp(DD,lfirst(L),datei);
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
		   }
		   printf("\n\n");
		   if(ps) fprintf( datei, "\n\n");
		}
	}
	else
	{	if(avsch) AVL=lcomp(list2(h,31),AVL);
		if(!assch)
		{  printf( " discriminant:     " );
		   putgf2el( M, h, VGF );
		   printf( "\n\n" );
		   if( ps )
                   {  fprintf( datei, "     discriminant:     " );
		      fputgf2el( M, h, VGF, datei );
		      fprintf( datei, "\n\n" );
	           }
		}
	}


	/*** j-Invariante ***/

	switch( k )
	{	case (-1):
		case (-2): h = ecrjinv( fkeller );
			   L=ecrfdenjinv(fkeller);	
			   break;
		case (-5): h = ecmpsnfjinv( M, ko[3], ko[4] );
			   break;
		case (-6): h = ecmpjinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
		case (-9): if(ecqnfsch!=_0) h=ecqnfjinv(fkeller);
			   else h = ecnfsnfjinv( M, ko[3], ko[4] );
			   break;
		case (-10):if(ecqnfsch!=_0) h=ecqnfjinv(fkeller);
		           else h = ecnfjinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
		case (-14):h = ecgf2jinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   break;
	}

	if( k > (-3) )
	{	if(avsch) AVL=lcomp(list2(h,1),AVL);
		if(!assch)
		{   printf( " j-invariant:      %r\n", h );
		    if( ps ) fprintf( datei, "     j-invariant:      %r\n", h );
		}
		if( !h || lsecond( h ) == 1 )
		{       if(!assch)
			{  printf( "\n" );
			   if( ps ) fprintf( datei, "\n" );
			}
		}
		else
		{       if(!assch)
			{   printf(" denominator(j):  " );
			    if( ps ) fprintf( datei, "     denominator(j):  " );
			}
			sch=0;
			while(L!=_0)
			{	h=lfirst(L);
				p=lsecond(L);
				L=lred2(L);
				if(avsch)
				{	AVL=lcomp(list2(h,0),AVL);
					AVL=lcomp(list2(p,0),AVL);
				}
				if(!assch)
				{  if(sch)
				   {	printf(" *");
					if(ps) fprintf( datei, " *");
				   }
				   else  sch=1;
				   printf(" %i",h);
				   if(ps) fprintf( datei, " %i",h);
				   if(p>1)
				   {	printf("^%i",p);
					if(ps) fprintf( datei, "^%i",p);
				   }
				}
			}
			if(!assch)
			{  printf( "\n\n" );
			   if( ps ) fprintf( datei, "\n\n" );
			}
		}
	}
	else if( k == (-5) || k == (-6) )
	{	if(avsch) AVL=lcomp(list2(h,17),AVL);
		if(!assch)
		{	printf( " j-invariant:      MOD(%i)\n\n", h );
			if( ps ) fprintf( datei, "     j-invariant:      MOD(%i)\n\n", h );
		}
	}	
	else if( k == (-9) || k == (-10) )
	{	if(llength(ecqnfsch)==3) h=qnftonf(h,24);
	 	h=kenntest(list2(h,24));
		if(avsch) AVL=lcomp(h,AVL);
		if(!assch)
		{  e=lsecond(h);
		   h=lfirst(h);
	 	   printf( " j-invariant:      " );
		   if(e==24) putnfel( M, h, VNF );
		   else if(e==1) putr(h);
		   else puti(h);
		   printf( "\n\n" );
		   if( ps )
                   {  fprintf( datei, "     j-invariant:      " );
		      if(e==24) fputnfel( M, h, VNF, datei );
		      else if(e==1) fputr(h,datei);
		      else fputi(h,datei);
		      fprintf( datei, "\n\n" );
	           }
		}
	}
	else
	{	if(avsch) AVL=lcomp(list2(h,31),AVL);
		if(!assch)
		{  printf( " j-invariant:      " );
		   putgf2el( M, h, VGF );
		   printf( "\n\n" );
		   if( ps )
                   {  fprintf( datei, "     j-invariant:      " );
		      fputgf2el( M, h, VGF, datei );
		      fprintf( datei, "\n\n" );
	           }
		}
	}

   if( k < (-2) && k>(-15) )	E = list2( fkeller, k );

   else
   {
	/*** Mimales Modell ***/

	h = ecimina1( fkeller);
	L = lsecond( fkeller );
	L=lfirst(L);
	ko[0] = lfirst( L );
	ko[1] = lsecond( L );
	ko[2] = lthird( L );
	ko[3] = lfourth( L );
	ko[4] = lfifth( L );
	if(!ko[0] && !ko[1] && !ko[2])
	{       if(!assch)
		{   printf( " minimal model:    EC(%i, %i)\n", ko[3], ko[4] );
		    if( ps ) fprintf( datei, "     minimal model:    EC(%i, %i)\n", ko[3], ko[4] );
		}
		ko[3]=itor(ko[3]);
		ko[4]=itor(ko[4]);
		T=ecrinit(0,0,0,ko[3],ko[4]);
	}
	else
	{  	if(!assch)
		{   printf( " minimal model:    EC(%i, %i, %i, %i, %i)\n", ko[0], ko[1], ko[2], ko[3], ko[4] );
		    if( ps ) fprintf( datei, "     minimal model:    EC(%i, %i, %i, %i, %i)\n", ko[0], ko[1], ko[2],ko[3], ko[4] );
		}
		ko[0]=itor(ko[0]);
		ko[1]=itor(ko[1]);
		ko[2]=itor(ko[2]);
		ko[3]=itor(ko[3]);
		ko[4]=itor(ko[4]);
		T=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
	}

	L = lfirst( fkeller );
	L = lsixth( L );
	L = lfirst( L );
	if(!assch)
	{    printf(" transformation:   r = %r, s = %r, t = %r, u = %r\n\n",lfirst(L),lsecond(L),lthird(L),lfourth(L) );
	     if( ps ) fprintf(datei,"     transformation:   r = %r, s = %r, t = %r, u = %r\n\n",lfirst(L),lsecond(L),lthird(L),lfourth(L) );
	}
	if(avsch)
	{	while(L!=_0)
		{	p=lfirst(L);
			L=lred(L);
			AVL=lcomp(list2(p,1),AVL);
		}
	}
   }
	
	/*** Fuehrer ***/

   if( k>=(-2) || ( ( k==(-9) || k==(-10) ) && ecqnfsch!=_0 ) )
   {
	if(k>=(-2))
	{  h = ecrcond( fkeller );
	   if( h == (ERROR) )
	   {       mistake( 134 );
		   return( ERROR );
	   }
	   L=lfourth(fkeller);	
	   L=lsecond(L);
	   L=lsecond(L);
	   if(avsch) AVL=lcomp(list2(h,0),AVL);
	   if(!assch)
	   {  printf( " conductor:        %i", h );
	      if( ps ) fprintf( datei, "     conductor:        %i", h );
	   }
	   sch = isign( h );
	   if(llength(L)>2 || lsecond(L)>1)
	   { 	if(!assch)
		{   printf(" =");
		    if(ps) fprintf( datei, " =");
		}
		while(L!=_0)
		{	if(!assch)
			{  if(sch==(-1))
			   {	printf(" -");
				if(ps) fprintf( datei, " -");
				sch=1;
			   }
			   if(sch==2)
			   {	printf(" *");
				if(ps) fprintf( datei, " *");
			   }
			   else sch=2;
			}
			h=lfirst(L);
			p=lsecond(L);
			L=lred2(L);
			if(avsch)
			{	AVL=lcomp(list2(h,0),AVL);
				AVL=lcomp(list2(p,0),AVL);
			}
			if(!assch)
			{  printf(" %i",h);
			   if(ps) fprintf(	datei, " %i",h);
			   if(p>1)
			   {	printf("^%i",p);
				if(ps) fprintf( datei, "^%i",p);
			   }
			}
		}
	   }
	}
	else
	{	p=ecqnfcond(fkeller);
		if(p==ERROR)
		{	mistake(134);
			return(ERROR);
		}
		L=lfourth(fkeller);
		L=lsecond(L);
		L=lsecond(L);
		if(!assch)
   		{  printf( " conductor:        ");
	   	   if( ps ) fprintf( datei, "     conductor:        ");
		   putqnfid(DD,p);
		   puts(" = ");
		   if(ps)
		   {	fputqnfidsp(DD,p,datei);
			fputs(" = ", datei);
		   }
		   if(llength(L)==1) 
		   {	puts("(1)\n");
			if(ps) fputs("(1)\n",datei);
		   }
		   else 
		   {	while(L!=_0)
		   	{	putqnfid(DD,lfirst(L));
				if(ps) fputqnfidsp(DD,lfirst(L),datei);
				p=lsecond(L);
				if(p>1)
				{	printf("^%i",p);
					if(ps) fprintf(datei, "^%i",p);
				}
				L=lred4(L);
				if(L!=_0)
				{	printf(" * ");
					if( ps) fprintf(datei," * ");
				}
			}
		   }
		}
	}
	if(!assch)
	{	printf( "\n\n" );
		if( ps ) fprintf( datei, "\n\n" );
	}

	/*** Kodaira- und Neron-Symbole ***/

	if(!assch)
 	{  e=1;
	   if(k>=(-2)) L = lthird( lsecond( lfourth( fkeller ) ) );
	   else  
	   {	L=lsecond( lfourth( fkeller) );
		L=lfourth(L);
		if(L==_0) e=0;
	   }
	   if(e){
	   M = L;  sch = 0;
	   printf( " Kodaira symbols: " );
	   if( ps ) fprintf( datei, "     Kodaira symbols: " );
	   while( L != _0 )
	   {    h = lsecond( L );
		L = lred2( L );
		if( sch )
		{       printf( "," );
			if( ps ) fprintf( datei, "," );
			if(sch==2) 
			{	printf(" ");
				if(ps) fprintf(datei," ");
			}
		}
		sch=1;
		if( h < 0 )
		{       printf( " I(%i)", h );
			if( ps ) fprintf( datei, " I(%i)", h );
		}
		else
		{       switch( h )
			{       case 1: printf( " II" );
					if( ps )  fprintf( datei, " II" );
					break;
				case 2: printf( " III" );
					if( ps )  fprintf( datei, " III" );
					break;
				case 3: printf( " IV" );
					if( ps )  fprintf( datei, " IV" );
					break;
				case 4: 
				case 5: printf( " I0*" );
					if( ps )  fprintf( datei, " I0*" );
					break;
				case 6: printf( " IV*" );
					if( ps )  fprintf( datei, " IV*" );
					break;
				case 7: printf( " III*" );
					if( ps )  fprintf( datei, " III*" );
					break;
				case 8: printf( " II*" );
					if( ps )  fprintf( datei, " II*" );
					break;
				default: printf( " I%i*", h-10 );
					 if( ps )  fprintf( datei, " I%i*", h-10 );
					 sch=2;
					 break;
			}
		}
	   }
	   printf( "\n" );
	   if( ps ) fprintf( datei, "\n" );
	   sch = 0;
	   printf( " Neron symbols:   " );
	   if( ps ) fprintf( datei, "     Neron symbols:   " );
	   while( M != _0 )
	   {    h = lsecond( M );
		M = lred2( M );
		if( sch )
		{       printf( "," );
			if( ps ) fprintf( datei, "," );
			while(sch>1)
			{	printf(" ");
				if(ps) fprintf( datei, " " );
				sch--;
			}
		}
		sch=1;
		if( h < 0 )
		{       printf( " B(%i)", h );
			if( ps ) fprintf( datei, " B(%i)", h );
		}
		else
		{       switch( h )
			{	case 1:
				case 3: printf( " C%i", h );
				        if( ps )  fprintf( datei, " C%i", h );
				        break;
			 	case 2:
			 	case 4:
			 	case 6:
				case 8: printf( " C%i", h );
				        if( ps )  fprintf( datei, " C%i", h );
					sch=2;
				        break;
				case 5: printf( " C4" );
					if( ps )  fprintf( datei, " C4" );
					sch=2;
					break;
				case 7: printf( " C%i", h );
				        if( ps )  fprintf( datei, " C%i", h );
					sch=3;
				        break;
				default: printf( " C5,%i", h-10 );
					 if( ps )  fprintf( datei, " C5,%i", h-10 );
					break;
			}
		}
	   }
	   printf( "\n\n" );
	   if( ps ) fprintf( datei, "\n\n" );
	   }
	}

	/*** Rueckgabe ***/

	if(k>=(-2)) E = list2( T, (-2) );
   }
   if(avsch)
   { 	AVL=linv(AVL);
	av_basad(AVL);
   }
   return( E );

}
