/*C
			calc_root( fkeller )

	"calculator root".
	list calc_root( fkeller ); list fkeller;
	erg = calc_root( fkeller );

	fkeller ist eine Liste bestehend aus zwei Objekten, einer
	einfachgenauen positiven Zahl n und einer Zahl R. Berechnet
	wird R^(1/n), falls n eine 2-Potenz ist, sonst der ganzzahli-
	ge Anteil.
	Laeuft calc_root fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      27.01.1992      U.Schneiders
	Version  1.2    10.09.1992      U.Schneiders ( mod )
	Version  2	20.01.1994	S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list calc_root(fkeller)
obj fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj n, Z, M, w;
	single k, l, t;
	init( n, Z, M, w );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( llength( fkeller ) != 2 )
	{       mistake1( 34,"root" );
		return( ERROR );
	}

	n = lfirst( fkeller );
	k = lsecond( n );
	n = lfirst( n );
	if( k || !n )
	{       mistake1( 34,"root");
		return( ERROR );
	}

	Z = lsecond( fkeller );
	k = lsecond( Z );
	if( k < 0 || ( k > 1 && k < 15 ) || ( k > 15 && k != 17 && k!=24 && k != 37 ) )
	{       mistake( 150 );
		return( ERROR );
	}
	if( k == 24 )
	{	w = lfirst( varlist[nfsch].varwert );
		M = list4( 2, 1, 0, 1 );
		if(!oequal(w,M))
		{	mistake(150);
			return( ERROR );
		}
		Z = lfirst(Z);
		k=nftyper(Z,0,24,37,&w,&M);
		Z = w;
	}
	else Z=lfirst(Z);
	if( k != 17 && k != 37 && !isatom(n) )
	{	mistake1(34,"root");
		return(ERROR);
	}

	 /*** Berechnung der Wurzel mit calc_exp ***/
   
	if( isign(n) == 1 ) n = list2( 1, n );
	else  
	{	n = ineg(n);
		n = list2( -1, n);
	}
	Z = calc_exp( n, Z, 1, k );


/**	else  *** k == 17 ***
	{	k = imp2d( n );
		if( ip2quot( n, k ) != 1 )	
		{	mistake( 176 );
			return( ERROR );
		}
		M = lfirst( varlist[modsch].varwert );
		l = k;
		if( pzsch && icomp(M,2) )
		{	t = mshom( 4, M );
			for( ; k; k-- )
			{    n = mipsqrt( M, Z );
			     if( t == 3 && n == (-1) )
			     {	if( ssch ) Z = msneg( M, Z );
				else	   Z = mineg( M, Z );
				n = mipsqrt( M, Z );
			     }
			     if( n == (-1) )
			     {	l = sexp( 2, l-k );	
				if( l == 2 ) mistake1( 240, Z );
				else if( l > 2 ) mistake2( 241, l, Z );
				else mistake( 175 );
				return( ERROR );
			     }
			     if( n == (-2) )
			     {  mistake( 195 );
				return( ERROR );
			     }
			     Z = n;
			}
		}
		else
		{	for( ; k; k-- )
			{    n = misqrt( M, Z );
			     if( n == (-1) )
			     {	l = sexp( 2, l-k );	
				if( l == 2 ) mistake1( 240, Z );
				else if( l > 2 ) mistake2( 241, l, Z );
				else mistake( 175 );
				return( ERROR );
			     }
			     Z = n;
			}
		}
		Z = list2( Z, 17 );
	}   **/

	return( Z );
}
