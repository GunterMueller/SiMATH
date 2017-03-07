/*C
			calc_ppcon( fkeller )      

	"calculator primitive polynomial construction"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ppcon( fkeller );  list fkeller;
	P = calc_ppcon( fkeller );

	Die Liste fkeller besteht aus drei Elementen,naemlich einer
	Variablen X, einer ganzen single Zahl n >1 mit zugehoeriger Kennung, 
	und einer ganzen Zahl j mit n+2>j>2.
	calc_ppcon konstruiert ein unitaeres normiertes primitives Polynom 
	in X ueber GF(2^k) vom Grad n mit j nichttrivialen Koeffizienten und
	P(0) nicht gleich 0.

	Laeuft calc_ppcon fehlerhaft ab, so ist  P  = ERROR.
C*/
/*H
	Version  1      11.10.1996      S.Schmitt
H*/

#include <_calc.h>

list calc_ppcon(fkeller)
list fkeller;
{
	int j,n;
	list G,P,V;

	init(j,n,G,P,V);
	bind(fkeller);
	
 /*** Abfangen falscher Eingaben ***/

	if ( llength(fkeller)!=3 )
	{	mistake(232);
                return(ERROR);
	}
	if(!gfsch )
	{	mistake(260);
		return(ERROR);
	}
	if(gfchar!=2)
	{ 	mistake(257);
		return(ERROR);
	}

	/*** 1.Argument Variable ***/

	V = lthird( fkeller );
	if( lsecond(V) != 2 )
	{       mistake( 197 );
		return( ERROR );
	}
	V = lfirst( V );
	P=lsecond(V);
	V = lfirst( V );
	if( llength( P ) != 2 || lfirst( P ) != 1 || lsecond( P ) != 1 || llength( V ) != 1 )
	{       mistake( 197 );
		return( ERROR );
	}
	
	n=lsecond(fkeller);
	j=lfirst(fkeller);
	if(lsecond(j) || lsecond(n))
	{	mistake(49);
		return(ERROR);
	}
 	j=lfirst(j);
	n=lfirst(n);
	if(!issingle(j) || !issingle(n))
	{	mistake(49);
		return(ERROR);
	}
	if(n < 2 || j < 3 || j > (n+1) )
	{	mistake(217);
		return(ERROR);
	}

 /*** Eigentliche Rechnung ***/

	G=lfirst(varlist[gfsch].varwert);	
	P=upgf2prirand(G,n,j);

	P=list2(V,P);
	P=list2(P,32);
	return(P);
}
