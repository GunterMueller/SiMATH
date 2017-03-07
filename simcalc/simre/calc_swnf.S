/*C
			calc_swnf( fkeller )

	"calculator short Weierstrass normal form".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_swnf( fkeller );  list fkeller;
	L = calc_swnf( fkeller );

	fkeller ist eine Liste, bestehend aus 2 Objekten, einem
	Schalter und einer elliptischen Kurve. Falls die ellipti-
	schen Kurve schon in kurzer WNF gegeben ist, wird sie un-
	veraendert zurueckgegeben. Sonst wird die zu ihr birational
	isomorphe Kurve in kurzer WNF zurueckgegeben, und falls der
	Schalter ungleich 0 war, werden die Transformationsparame-
	ter r, s, t, u auf Bildschirm ausgegeben.
	Laeuft calc_swnf fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  2      10.09.1992      U.Schneiders ( mod und nf )
	Version  3	08.04.1993	S.Schmitt/U.Schneiders
	Version  3.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_swnf( fkeller )
list fkeller;

{
	single k, ks;
	rat ko[5];
	obj h, L, M;
	list AVL;
	init( h, L, M, AVL ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"swnf" );
		return( ERROR );
	}

	/*** Schalter ***/

	h = lfirst( fkeller );
	ks = lsecond( h );
	if( ks )
	{       mistake( 121 );
		return( ERROR );
	}

	/*** elliptische Kurve ***/

	fkeller = lsecond( fkeller );
	k = lsecond( fkeller );
	if( k == (-14) && gfchar == 2 )
	{	mistake( 267 );
		return( ERROR );
	}
	if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10) )
	{       mistake( 120 );
		return( ERROR );
	}

	h = lfirst( h );

	/*** schon in kurzer Weierstrass Normalform gegeben ***/

	if( k == (-1) || k == (-5) || k == (-9) ) return( fkeller );

	if( k == (-6) )
	{       M = lfirst( varlist[modsch].varwert );
	 	if( ssch && M < 5 )
		{	mistake( 174 );
			return( ERROR );
		}
	}			
	else if( k == (-10) ) M = lfirst( varlist[nfsch].varwert );

	fkeller = lfirst( fkeller );
	if(k==(-10))
	{	if( llength(ecqnfsch)==3) fkeller = qnftonf(fkeller,(-10));
		else 
		{	fkeller = lfirst(fkeller);
		 	fkeller = lfirst(fkeller);
		}
	}
	if(k==(-6) || k==(-10))
	{ 	ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
	}
	switch( k )
	{	case (-2): ko[0]=ecisnfa4(fkeller);
			   L=lthird(fkeller);
			   L=lfirst(L);
			   ko[1]=lsecond(L);
			   ko[0]=itor(ko[0]);
			   ko[1]=itor(ko[1]);	
			   L=ecrinit(0,0,0,ko[0],ko[1]);
			   if(h) M=ecracbtsnf(fkeller);
			   fkeller=list2(L,(-1));
			   break; 
		case (-6): L = ecmptosnf( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   fkeller = lfirst( L );
			   ko[0] = lfirst( fkeller );
			   ko[1] = lsecond( fkeller );
			   if(ssch )
			   {	ko[0] = mshom( M, ko[0] );
				ko[1] = mshom( M, ko[1] );
			   }
			   else
			   {	ko[0] = mihom( M, ko[0] );
				ko[1] = mihom( M, ko[1] );
			   }
			   fkeller = list2( ko[0], ko[1] );
			   fkeller = list2( fkeller, (-5) );
			   break;
		case (-10):L = ecnftosnf( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
			   fkeller = lfirst( L );
			   if(ecqnfsch!=_0)
			   {	ko[2]=lfirst(ecqnfsch);
				ko[0]=lfirst(fkeller);
				ko[1] = lsecond(fkeller);
				if(llength(ecqnfsch)==3)
				{	ko[0]=nftoqnf(ko[0],24);
					ko[1]=nftoqnf(ko[1],24);
				}
				fkeller=ecqnfinit(ko[2],0,0,0,ko[0],ko[1]);
			   }
			   fkeller = list2( fkeller, (-9) );
			   break;
	}

	/*** Ausgabe der Transformationsparameter ***/

	if( h )
	{	if(k==(-6) || k==(-10))	L = lsecond( L );
		else	L=M;
		ko[0] = lfirst( L );
		ko[1] = lsecond( L );
		ko[2] = lthird( L );
		ko[3] = lfourth( L );
		if(avsch)
		{  switch( k )
		   {  case (-2): AVL=_0;
				 AVL=lcomp(list2(ko[3],1),AVL);
				 AVL=lcomp(list2(ko[2],1),AVL);
				 AVL=lcomp(list2(ko[1],1),AVL);
				 AVL=lcomp(list2(ko[0],1),AVL);
		 	         break;
		      case (-6): AVL=_0;
				 AVL=lcomp(list2(ko[3],17),AVL);
				 AVL=lcomp(list2(ko[2],17),AVL);
				 AVL=lcomp(list2(ko[1],17),AVL);
				 AVL=lcomp(list2(ko[0],17),AVL);
				 break;
		      case(-10): AVL=_0;
				 AVL=lcomp(list2(ko[3],24),AVL);
				 AVL=lcomp(list2(ko[2],24),AVL);
				 AVL=lcomp(list2(ko[1],24),AVL);
				 AVL=lcomp(list2(ko[0],24),AVL);
				 break;
		   }
		   av_basad(AVL);
		}
		if(!assch)
		{  switch( k )
		   {	case (-2): printf( " transformation with:  r = %r\n", ko[0] );
				   printf( "                       s = %r\n", ko[1] );
				   printf( "                       t = %r\n", ko[2] );
				   printf( "                       u = %r\n", ko[3] );
				   if( ps )
				   {       fprintf( datei, "out: transformation with:  r = %r\n", ko[0] );
					   fprintf( datei, "                           s = %r\n", ko[1] );
				           fprintf( datei, "                           t = %r\n", ko[2] );
					   fprintf( datei, "                           u = %r\n", ko[3] );
				   }
				   break;
			case (-6): printf( " transformation with:  r = MOD(%i)\n", ko[0] );
				   printf( "                       s = MOD(%i)\n", ko[1] );
				   printf( "                       t = MOD(%i)\n", ko[2] );
				   printf( "                       u = MOD(%i)\n", ko[3] );
				   if( ps )
				   {       fprintf( datei, "out: transformation with:  r = MOD(%i)\n", ko[0] );
					   fprintf( datei, "                           s = MOD(%i)\n", ko[1] );
				           fprintf( datei, "                           t = MOD(%i)\n", ko[2] );
					   fprintf( datei, "                           u = MOD(%i)\n", ko[3] );
				   }
				   break;
			case (-10):printf( " transformation with:  r = " );
				   putnfel( M, ko[0], VNF );
				   printf( "\n" );
				   printf( "                       s = " );
				   putnfel( M, ko[1], VNF );
				   printf( "\n" );
				   printf( "                       t = " );
				   putnfel( M, ko[2], VNF );
				   printf( "\n" );
				   printf( "                       u = " );
				   putnfel( M, ko[3], VNF );
				   printf( "\n" );
				   if( ps )
				   {       fprintf( datei, "out: transformation with:  r = " );
				   	   fputnfel( M, ko[0], VNF, datei );
				   	   fprintf( datei, "\n" );
					   fprintf( datei, "                           s = " );
				   	   fputnfel( M, ko[1], VNF, datei );
				   	   fprintf( datei, "\n" );
				           fprintf( datei, "                           t = " );
				   	   fputnfel( M, ko[2], VNF, datei );
				   	   fprintf( datei, "\n" );
					   fprintf( datei, "                           u = " );
				   	   fputnfel( M, ko[3], VNF, datei );
				   	   fprintf( datei, "\n" );
				   }
				   break;
		   }
		}
	}

	return( fkeller );
}
