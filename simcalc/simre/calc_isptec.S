/*C
			calc_isptec( fkeller )

	"calculator is point on elliptic curve".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_isptec( fkeller );  list fkeller;
	L = calc_isptec( fkeller );

	fkeller ist eine Liste, bestehend aus einem Punkt und einer
	elliptischen Kurve. Berechnet wird, ob der Punkt auf der
	Kurve liegt. Falls ja, wird Ja! auf den Bildschirm ausgege-
	ben, und L = 1; sonst Nein!, und L = 0.
	Laeuft calc_isptec fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  2      04.08.1992      U.Schneiders ( mod und nf )
	Version  2.1    06.04.1993      S.Schmitt/U.Schneiders
	Version  3      22.07.1993      U.Schneiders ( gf )
	Version  3.1    07.12.1993      U.Schneiders ( tonf )
	Version  3.2    28.12.1994      U.Schneiders ( togf )
	Version  3.3    10.07.1996      S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_isptec( fkeller )
list fkeller;

{
	single k, kp;
	rat h, ko[5];
	obj M, L;
	list P;
	init( M, L, h, P ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"isptec" );
		return( ERROR );
	}

	/*** Punkt ***/

	P = lfirst( fkeller );
	kp = lsecond( P );
	if( kp != (-3) && kp != (-4) && kp != (-7) && kp != (-8) 
	 && kp != (-11) && kp != (-12) && kp != (-15) && kp != (-16) )
	{       mistake1( 34,"isptec");
		return( ERROR );
	}

	/*** elliptische Kurve ***/

	fkeller = lsecond( fkeller );
	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10) && k != (-14) )
	{       mistake1( 34,"isptec" );
		return( ERROR );
	}

	if( ( ( k == (-1) || k == (-2) ) && kp < (-4) && kp != (-11) && kp != (-12) )
         || ( ( k == (-5) || k == (-6) ) && kp != (-7) && kp != (-8) && kp != (-15) && kp != (-16) )
         || ( ( k == (-9) || k == (-10) ) && kp != (-11) && kp != (-12) && kp !=(-3) && kp != (-4) )
	 || ( k == (-14 ) && kp != (-15) && kp != (-16) && kp != (-7) && kp != (-8) ) )
	{	mistake( 45 );
		return( ERROR );
	}

	P = lfirst( P );
	fkeller = lfirst( fkeller );

	/*** Umwandlung in nf ***/

	if( ( k == (-1) || k == (-2) ) && ( kp == (-11) || kp == (-12)))
	{	fkeller = tonftyper( fkeller, k );
		k = k - 8;
	}
	else if( ( k==(-9) || k==(-10) ) && ( kp==(-3) || kp==(-4) ) )
	{	P = tonftyper( P, kp );
		kp = kp - 8;
	}

	/*** Umwandlung in gf ***/

	else if( ( k == (-5) || k == (-6) ) && ( kp == (-15) || kp == (-16)))
	{	fkeller = togftyper( fkeller, k, 1 );
		if(fkeller==ERROR) return(ERROR);
		k = k - 8;
	}
	else if( k==(-14) && ( kp==(-7) || kp==(-8) ) )
	{	
		P = togftyper( P, kp, 1 );
		if(P==ERROR) return(ERROR);
		kp = kp - 8;
	}

	/*** affine in projektive Darstellung ***/

	if(kp == (-7) || kp == (-11) || kp == (-15) )
	{       if( kp == (-7) )  h = 1;
		else if( kp == (-11) )  h = itonf( 1 );
		else
		{	h = list2( 0, 1 );
			h = udpm2tosb( h );
		}
		if( !P )  P = list3( 0, h, 0 );
		else
		{       L = lcopy( P );
			P = lsuffix( L, h );
		}
	}

	if( k == (-5) || k == (-6) ) M = lfirst( varlist[modsch].varwert );
	else if( k == (-9) || k == (-10) ) M = lfirst( varlist[nfsch].varwert );
	else if( k == (-14) ) M = lfirst( varlist[gfsch].varwert );
	
	if((k==(-9) || k==(-10) ) && ecqnfsch!=_0)
	{	fkeller = lfirst(fkeller);
		fkeller = lfirst(fkeller);
		if(k==(-9)) fkeller = lred3(fkeller);
	}

	if(k == (-5) || k == (-9) )
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		if(k==(-9) && llength(ecqnfsch)==3) 
		{	ko[0]=qnftonf(ko[0],24);
			ko[1]=qnftonf(ko[1],24);
		}
		if( k == (-5) ) kp = iselecmpsnf( M, ko[0], ko[1], P );
		else kp = iselecnfsnf( M, ko[0], ko[1], P );
	}
	else if(k==(-6) || k==(-10) || k==(-14))
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
		if(k==(-10) && llength(ecqnfsch)==3) 
		{       ko[0]=qnftonf(ko[0],24);
			ko[1]=qnftonf(ko[1],24);
			ko[2]=qnftonf(ko[2],24);
			ko[3]=qnftonf(ko[3],24);
			ko[4]=qnftonf(ko[4],24);
		}

		if(k == (-6)) kp=iselecmp(M,ko[0],ko[1],ko[2],ko[3],ko[4],P);
		else if(k == (-10)) kp=iselecnf(M,ko[0],ko[1],ko[2],ko[3],ko[4],P);
		else kp=iselecgf2(M,ko[0],ko[1],ko[2],ko[3],ko[4],P);
	}
	else  kp=isponecrac(fkeller,P);

	/*** Ausgabe auf Bildschirm und Datei ***/

	if(!assch){
	if( kp )
	{       printf( "   yes!\n" );
		if( ps )  fprintf( datei, "out: yes!\n" );
	}
	else
	{       printf( "   no!\n" );
		if( ps )  fprintf( datei, "out: no!\n" );
	}
	}

	L  = list2( kp, 0 );
	return( L );
}
