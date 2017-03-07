/*C
			calc_mex( fkeller )

	"calculator modular exponentiation".
	list calc_mex( fkeller );  list fkeller;
	X = calc_mex( fkeller );

	calc_exp berechnet ( bas ^ exp ) mod m, wobei fkeller von
	der Form ( exp, bas, m ) ist.
	Laeuft calc_mex fehlerhaft ab, so ist  X  = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      14.07.1988      C.Hollinger/U.Schneiders
	Version  1.1    11.04.1991      U.Schneiders
	Version  1.2	06.05.1993	S.Schmitt/U.Schneiders
H*/

#include<_calc.h>

list calc_mex( fkeller )
list fkeller;

{
	obj exp, bas, m, erg;
	single ken, kenb;
	init( exp, bas, m, erg );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 3 )
	{       mistake1( 34,"mex" );
		return( -BASIS );
	}
	exp = lfirst( fkeller );
	ken = lsecond( exp );
	exp = lfirst( exp );
	if( ken )
	{       mistake( 54 );
		return( -BASIS );
	}
	fkeller = lred( fkeller );
	bas = lfirst( fkeller );
	kenb = lsecond( bas );
	bas = lfirst( bas );
	if( kenb > 1 || kenb < 0 )
	{       mistake( 55 );
		return( -BASIS );
	}
	m = lsecond( fkeller );
	ken = lsecond( m );
	m = lfirst( m );
	if( ken || isign(m) <= 0 )
	{       mistake( 222 );
		return( -BASIS );
	}

	if( kenb )
	{       erg = lsecond( bas );
		if ( igcd( erg, m ) != 1 )
		{       mistake2( 233, bas, m );
			return( ERROR );
		}
		erg = miinv( m, erg );
		bas = lfirst( bas );
		bas = iprod( bas, erg );
	}

	/*** Berechnung ***/

	bas = mihom( m, bas );
	if(exp<0)
	{	exp=(-exp);
		ken=(-1);
	}
	erg = miexp( m, bas, exp );
	if(ken==(-1))
	{	if(igcd(erg,m) != 1)
		{	erg=list2(1,erg);
			mistake2( 233, erg, m );
			return(ERROR);
		}
		erg = miinv(m,erg);
	}
	erg = list2( erg, 0 );
	return( erg );
}
