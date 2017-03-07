/*C
			calc_sfp( fkeller )

	"calculator square free part".
	list calc_sfp( fkeller ); list fkeller;
	erg = calc_sfp( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zugehoe-
	riger Kennung. Falls das Objekt in fkeller eine ganze Zahl oder
	ein normiertes Polynom in einer Variable ueber Z/pZ  oder 
	GF(p^n), mit p Primzahl < BASIS, ist, so wird der quadratfreie 
	Anteil dieses Objektes berechnet.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen 'erg'
	zugeordnet.
	Laeuft calc_sfp fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      07.03.1990      U.Schneiders
	Version  2	23.06.1994	S.Schmitt
	Version  3	21.03.1995	S.Schmitt/U.Schneiders (nfon)
H*/
 
#include <_calc.h>

list calc_sfp(fkeller)
obj fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, a1, M, VL, L, c;
	single t1;
	init( a1, erg, M, VL, L, c );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	t1 = lsecond( fkeller );
	if(((t1>4 || t1<0) && t1!=18 && t1!=25 && t1!=32))
	{       mistake( 99 );
		return( ERROR );
	}
	if( t1==18 && !pzsch )   
	{	mistake(99);
		return(ERROR);
	}	
	if( nfsch && nfon && (!t1 || t1==1) )
	{	mistake( 99 );
		return( ERROR );
	}
	a1 = lfirst( fkeller );

	if( t1 > 1 )
	{       VL = lfirst( a1 );
		a1 = lsecond( a1 );
		if(llength(VL)>1)
		{	mistake(99);
			return(ERROR);
		}
	}

	/*** Angleichung an Zahlkoerper fuer t1 = 2,3
             und nfsch=1 und nfon=1                  ***/

	if( nfsch && nfon )
	{	switch( t1 )
		{	case 2: a1 = pitopnf(1,a1);
				t1 = 25;
				break;
			case 3: a1 = prtopnf(1,a1);
				t1 = 25;
				break;
			default: break;
		}
	}

	/*** Berechnung der des quadratfreien Anteils ***/

	switch( t1 )
	{       case 0: erg=isfp( a1 ); 
			break;
		case 1: M = lfirst( a1 );
			erg=isfp( M );
			a1 = lsecond( a1 );
			M=isfp( a1 );
			erg=rcons(erg,M);
			break;
		case 2: erg = upisfp( a1 );
			erg=list2(VL,erg);
			break;
		case 3: M = prnumden( 1, a1, &c );
			erg = upisfp( M );
			erg=pitopr(1,erg);
			c=isfp(c);
			c=rcons(1,c);
			erg = prrprod( 1, erg, c );
			erg=list2(VL,erg);
			break;
		case 4: M = lsecond( a1 );
			a1 = lfirst( a1 );
			erg = upisfp( a1 );
			M=upisfp( M );
			erg=rfrcons(1,erg,M);
			erg=list2(VL,erg);
			break;
		case 18:M=lfirst(varlist[modsch].varwert);
			c=lsecond(a1);
			if(c!=1) 
			{	if(ssch) a1=pmsmsquot(1,M,a1,c);
				else     a1=pmimiquot(1,M,a1,c);
				if(ismisquare(M,c)!=(-1)) c=1;
			}
			if(ssch) erg=upmssfp(M,a1);
			else erg=upmisfp(M,a1);
			if(c!=1)
			{	if(ssch) erg=pmsmsprod(1,M,erg,c);
				else erg=pmimiprod(1,M,erg,c);
			}
			erg=list2(VL,erg);
			break;
		case 25:M=lfirst(varlist[nfsch].varwert);
			c=lsecond(a1);
			L=list3(1,0,1);
			if(!oequal(c,L))
			{	mistake(99);
				return(ERROR);
			}
			erg=upnfsfp(M,a1);
			erg=list2(VL,erg);
			break;
		case 32:M=lfirst(varlist[gfsch].varwert);
			c=lsecond(a1);
			L=list2(0,1);
			if( !oequal( c, L ) )  
			{	mistake(99);
				return(ERROR);
			}
			if(gfchar==2) erg=upgf2sfp(M,a1);
			else erg=upgfssfp(gfchar,M,a1);
			erg=list2(VL,erg);
			break;
	}
	erg = list2( erg, t1 );
	return( erg );
}
