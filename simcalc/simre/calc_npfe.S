/*C
			calc_npfe( fkeller )

	"calculator number of points after field extension".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_npfe( fkeller )   list fkeller;
	N = calc_npfe( fkeller );

	fkeller ist eine Liste, bestehend aus einer elliptischen Kurve E
	mit Koeffizienten aus dem aktuellen Galois-Koerper GF(2^m), 
	der Zahl #E( GF(2^m) ) und der Spezifikation der Koerpererwei-
	terung GF(2^n) (m|n) mit n oder mit einem univariaten, irredu-
	ziblen Polynom ueber Z oder Z/2Z vom Grad n.
	N = #E( GF(2^n) ). 
	Laeuft calc_np fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1      07.10.1993      U.Schneiders
H*/

#include <_calc.h>

list calc_npfe( fkeller )
list fkeller;
{	single hn,k,n;
	pol A,P;
	list AL,Nm,EMB,nach,V,E;
	gf2el ko[5];
	init(A,P,AL,Nm,EMB,nach,V,E);
	init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 3 )
	{	mistake1(34,"npfe");
		return( ERROR );
	}

	/*** elliptische Kurve ***/
	E = lthird( fkeller );
	if( lsecond( E ) != (-14) )
	{	mistake1(34,"npfe");
		return( ERROR );
	}
	E = lfirst( E );

	/*** Anzahl der Punkte von E auf GF(2^m) ***/
	Nm = lsecond( fkeller );
	if( lsecond( Nm ) )
	{	mistake1(34,"npfe");
		return( ERROR );
	}
	Nm = lfirst(Nm);

	/*** Spezifikation von GF(2^n) ***/
	nach = lfirst( fkeller );
	k = lsecond( nach );
	if( k && k != 2 && k != 18 )
	{	mistake(277);
		return( ERROR );
	}
	nach = lfirst( nach );
	A=lfirst(varlist[gfsch].varwert);
	hn = lfirst(A);
	if( !k && ( !isatom(nach) || nach<2 || (nach % hn)) ) 
	{	mistake(277);
		return(ERROR);
	}
	if(k)
	{ 	V = lfirst( nach );
		if( llength( V ) != 1 )
		{      	 mistake( 277 );
			return( ERROR );
		}
		nach = lsecond( nach );
		if (k==2)	 nach=pitopms(1,nach,2);
		else
		{	P=lfirst(varlist[modsch].varwert);
			if(!ssch || !pzsch || P!=2)
			{	mistake(277);
				return(ERROR);
			}
		}		
		n = pdegree(1,nach);
		if(n<2 || (n%hn))
		{	mistake(277);
			return(ERROR);
		}
		if( !isimupms( 2, nach ) )
		{       mistake( 277 );
			return( ERROR );
		}
		P=ptodp(1,nach);
		AL = gf2impsbgen(n,P);
	}
	else 
	{	AL=0;
		n = nach;
	}
	EMB = gf2ies(A,AL,n);
	ko[0] = lfirst( E );
	ko[1] = lsecond( E );
	ko[2] = lthird( E );
	ko[3] = lfourth( E );
	ko[4] = lfifth( E );
	AL = ecgf2npfe(A,ko[0],ko[1],ko[2],ko[3],ko[4],Nm,EMB);
	AL = lred(AL);
	AL = lsixth(AL);
	AL = list2( AL, 0 );
	return( AL );
}
