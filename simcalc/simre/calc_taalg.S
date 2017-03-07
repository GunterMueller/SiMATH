/*C
			calc_taalg( fkeller )

	"calculator Tate algorithm".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_taalg( fkeller );  list fkeller;
	L = calc_taalg( fkeller );

	fkeller ist eine Liste, bestehend aus einer elliptischen Kurve
	und einer einfachgenauen Primzahl p. Falls die Kurve gute Reduk-
	tion in p hat, erfolgt entsprechende Meldung und L = 0. Sonst
	wird der Tate Algorithmus aufgerufen. War die Kurve in p nicht
	minimal, so ist L diejenige elliptische Kurve, die minimal in
	p ist. Eine entsprechende Meldung erfolgt auf Bildschirm.
	Sonst wird das Kodaira- und Neron- Symbol ausgegeben. L ist ne-
	gativ, falls die elliptische Kurve mult. Reduktion, und positiv,
	falls sie additive Reduktion hat. L ist diejenige Zahl, die das
	SIMATH- Programm ecitatealg zurueckliefert.
	Laeuft calc_taalg fehlerhaft ab, so ist  L  = ERROR.
C*/
/*H
	Version  1      06.12.1990      U.Schneiders
	Version  2	22.04.1993	S.Schmitt/U.Schneiders
	Version  3	21.03.1995	S.Schmitt/U.Schneiders (nfon)
	Version  3.1	10.07.1996	S.Schmitt (ecqnfsch)
H*/

#include <_calc.h>

list calc_taalg( fkeller )
list fkeller;

{
	single ken, k, ks;
	int ki[5];
	rat d, ko[5];
	obj p, L;
	init( d, L, p ); init( ko[0..4] ); init( ki[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"taalg" );
		return( ERROR );
	}

	/*** Primzahl ***/

	p = lsecond( fkeller );
	ks = lsecond( p );
	if( ks )
	{       mistake( 46 );
		return( ERROR );
	}
	p = lfirst( p );
	if( isatom( p ) )
	{	ks = issprime( p, &L );
		if( !ks || ks == (-1) )
		{       mistake( 46 );
			return( ERROR );
		}
	}
	else
	{
		L = ispd(p,&d);
		if(L!=_0)
		{
			mistake(46);
			return(ERROR);
		}
	}

	/*** elliptische Kurve ***/

	fkeller = lfirst( fkeller );
	ken = lsecond( fkeller );
	if( ken != (-1) && ken != (-2) && ( ( ken!=(-9) && ken!=(-10) ) || ecqnfsch==_0 ) )
	{       mistake( 133 );
		return( ERROR );
	}

	if( nfsch && nfon && ecqnfsch==_0 && (ken==(-1) || ken==(-2)) )
	{       mistake( 133 );
		return( ERROR );
	}

	fkeller=lfirst(fkeller);

	/*** Angleichung ueber NF, falls k=-1,-2 und nfsch=1 und nfon=1 ***/ 

	if( nfsch && nfon && (ken==(-1) || ken==(-2) ) )
	{	fkeller = tonftyper( fkeller,ken );
		ken = ken-8;
	}


	/*** hoechste p- Potenz, die die Diskr. teilt ***/

 	if(ken>=(-2))
	{	L=lfirst(fkeller);
		L=lfirst(L);
	}
	if( ken == (-1) )
	{       ki[0] = 0;
		ki[1] = 0;
		ki[2] = 0;
		ko[3] = lfourth( L );
		if( ko[3] )
		{       if( lsecond( ko[3] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[3] = lfirst( ko[3] );
		}
		else    ki[3] = ko[3];
		ko[4] = lfifth( L );
		if( ko[4] )
		{       if( lsecond( ko[4] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[4] = lfirst( ko[4] );
		}
		else    ki[4] = ko[4];
	}
	else if(ken==(-2))
	{       ko[0] = lfirst( L );
		if( ko[0] )
		{       if( lsecond( ko[0] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[0] = lfirst( ko[0] );
		}
		else    ki[0] = ko[0];
		ko[1] = lsecond( L );
		if( ko[1] )
		{       if( lsecond( ko[1] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[1] = lfirst( ko[1] );
		}
		else    ki[1] = ko[1];
		ko[2] = lthird( L );
		if( ko[2] )
		{       if( lsecond( ko[2] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[2] = lfirst( ko[2] );
		}
		else    ki[2] = ko[2];
		ko[3] = lfourth( L );
		if( ko[3] )
		{       if( lsecond( ko[3] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[3] = lfirst( ko[3] );
		}
		else    ki[3] = ko[3];
		ko[4] = lfifth( L );
		if( ko[4] )
		{       if( lsecond( ko[4] ) != 1 )
			{       mistake( 205 );
				return( ERROR );
			}
			ki[4] = lfirst( ko[4] );
		}
		else    ki[4] = ko[4];
	}
	else     /* ken=(-9) oder ken=(-10) */
	{	L=ecqnflcond(fkeller,p);
		k = 1;
		if(llength(L)==1)
		{	mistake(134);
			return(ERROR);
		}
		else if(lsecond(L) == _0) k=0;
	}
	if(ken>=(-2))
	{	d=ecracdisc(fkeller);
	
	/*** hoechste p- Potenz, die die Diskr. teilt ***/

		k = ravalint( p, d );
	}

	/*** Reduktionstypen ***/

	if( !k )
	{       if(!assch){
		printf( " Good reduction!\n" );
		if( ps ) fprintf( datei, "out: Good reduction!\n" );
		}
		L = list2( 0, 0 );
		return( L );
	}

	if(ken >= (-2) )
	{     	L=ecitatealg( ki[0], ki[1], ki[2], ki[3], ki[4], p, k );

		k = llength( L );
		if( k == 1 )
		{       mistake( 134 );
			return( ERROR );
		}
		else if( k == 5 )
		{       ko[0] = lfirst( L );
			ko[1] = lsecond( L );
			ko[2] = lthird( L );
			ko[3] = lfourth( L );
			ko[4] = lfifth( L );
			if( ko[0] )     ko[0] = list2( ko[0], 1 );
			if( ko[1] )     ko[1] = list2( ko[1], 1 );
			if( ko[2] )     ko[2] = list2( ko[2], 1 );
			if( ko[3] )     ko[3] = list2( ko[3], 1 );
			if( ko[4] )     ko[4] = list2( ko[4], 1 );
			L=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
			L = list2( L, (-2) );
			if(!assch){
			printf(" Elliptic curve not minimal at %i.\n",p);
			printf(" Please try again with the following birational\n" );
			printf(" isomorphic elliptic curve, minimal at %i:\n", p );
			if( ps )
			{       fprintf( datei, "out: Elliptic curve not minimal at %i.\n", p );
				fprintf( datei, "     Please try again with the following birational\n" );
				fprintf( datei, "     isomorphic elliptic curve, minimal at %i:\n", p );
			}
			}
		}
		else
		{       L = lsecond( L );
			if(!assch){
			if( L < 0 )
			{       printf( " multiplicative reduction\n" );
				printf( " Kodaira symbol: I(%i)\n", L );
				printf( " Neron symbol:   B(%i).\n", L );
				if( ps )
				{       fprintf( datei, "out: multiplicative reduction\n" );
					fprintf( datei, "     Kodaira symbol: I%i\n", L );
					fprintf( datei, "     Neron symbol:   B%i.\n", L );
				}
			}
			else
			{       printf( " additive reduction\n" );
				if( ps )   fprintf( datei, "out: additive reduction\n" );
				switch( L )
				{       case 1: printf( " Kodaira symbol: II\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: II\n" );
						break;
					case 2: printf( " Kodaira symbol: III\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: III\n" );
						break;
					case 3: printf( " Kodaira symbol: IV\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: IV\n" );
						break;
					case 4: 
					case 5: printf( " Kodaira symbol: I0*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: I0*\n" );
						break;
					case 6: printf( " Kodaira symbol: IV*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: IV*\n" );
						break;
					case 7: printf( " Kodaira symbol: III*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: III*\n" );
						break;
					case 8: printf( " Kodaira symbol: II*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: II*\n" );
						break;
					default: printf( " Kodaira symbol: I%i*\n", L-10 );
					 	if( ps )  fprintf( datei, "     Kodaira symbol: I%i*\n", L-10 );
					 	break;
				}
				if( L < 9 && L != 5 )
				{	printf( " Neron symbol:   C%i.\n", L );
					if( ps )  fprintf( datei, "     Neron symbol:   C%i.\n", L );
				}
				else if( L == 5 )
				{	printf( " Neron symbol:   C4.\n");
					if( ps )  fprintf( datei, "     Neron symbol:   C4.\n");
					L=4;
				}
				else
				{       printf( " Neron symbol:   C5,%i.\n", L-10 );
					if( ps )  fprintf( datei, "     Neron symbol:   C5,%i.\n", L-10 );
				}
	
			}
			}
			L = list2( L, 0 );
		}
	}
	else   /* ken = (-9)  oder  ken = (-10) */
	{	L=lsecond(L);
		if(llength(ecqnfsch)==3)
		{	p=lsecond(ecqnfsch);
			d = lthird(ecqnfsch);
			d=list2(p,d);
		}
		else d=ecqnfsch;
		while(L!=_0)
		{	p=lfirst(L);
			k=lfifth(L);
			L=lred6(L);
			if(!assch){
			if( k < 0 )
			{       printf( " multiplicative reduction at " );
				putqnfid(d,p);
				printf( "\n Kodaira symbol: I(%i)\n", k );
				printf( " Neron symbol:   B(%i).\n", k );
				if( ps )
				{       fprintf( datei, "out: multiplicative reduction at " );
					fputqnfidsp(d,p,datei);
					fprintf( datei, "\n     Kodaira symbol: I%i\n", k );
					fprintf( datei, "     Neron symbol:   B%i.\n", k );
				}
			}
			else
			{       printf( " additive reduction at " );
				putqnfid(d,p);
				printf("\n");
				if( ps )   
				{  	fprintf( datei, "out: additive reduction at " );
					fputqnfidsp(d,p,datei);
					fprintf(datei,"\n");
				}
				switch( k )
				{       case 1: printf( " Kodaira symbol: II\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: II\n" );
						break;
					case 2: printf( " Kodaira symbol: III\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: III\n" );
						break;
					case 3: printf( " Kodaira symbol: IV\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: IV\n" );
						break;
					case 4: 
					case 5: printf( " Kodaira symbol: I0*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: I0*\n" );
						break;
					case 6: printf( " Kodaira symbol: IV*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: IV*\n" );
						break;
					case 7: printf( " Kodaira symbol: III*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: III*\n" );
						break;
					case 8: printf( " Kodaira symbol: II*\n" );
						if( ps )  fprintf( datei, "     Kodaira symbol: II*\n" );
						break;
					default: printf( " Kodaira symbol: I%i*\n", k-10 );
					 	if( ps )  fprintf( datei, "     Kodaira symbol: I%i*\n", k-10 );
					 	break;
				}
				if( k < 9 && k != 5 )
				{       printf( " Neron symbol:   C%i.\n", k );
					if( ps )  fprintf( datei, "     Neron symbol:   C%i.\n", k );
				}
				else if( k == 5 )
				{	printf( " Neron symbol:   C4.\n");
					if( ps )  fprintf( datei, "     Neron symbol:   C4.\n");
					k = 4;
				}
				else
				{       printf( " Neron symbol:   C5,%i.\n", k-10 );
					if( ps )  fprintf( datei, "     Neron symbol:   C5,%i.\n", k-10 );
				}
	
			}
			}
		}
		L=list2(k,0);
	}

	return( L );
}
