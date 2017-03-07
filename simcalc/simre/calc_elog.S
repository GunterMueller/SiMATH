/*C
			calc_elog( fkeller )

	"calculator elliptic logarithm".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_elog( fkeller );  list fkeller;
	L = calc_elog( fkeller );

	fkeller is a list containing the representation of a
	point on the current elliptic curve over Q.
	calc_elog returns the elliptic logarithm with a precision 
	of DIGITS digits.
	calc_elog returns ERROR if an error occurs.
C*/
/*H
	Version  1      06.03.1997      S.Schmitt
H*/

#include <_calc.h>

list calc_elog( fkeller )
list fkeller;

{
	single k;
	obj L;
	init( L );
	bind( fkeller );

	/*** testing the input ***/
	
	k = lsecond( fkeller );
	if(k!=(-3) && k!=(-4))
	{	mistake( 186 );
		return( ERROR );
	}
	if( !ecsch )
	{	mistake( 111 );
		return( ERROR );
	}

	k = lsecond( varlist[ecsch].varwert );
	if(k!=(-1) && k!=(-2))
	{       mistake( 45 );
		return( ERROR );
	}

	L = lfirst( varlist[ecsch].varwert );
	fkeller = lfirst( fkeller );
	if(!isponecrac(L,fkeller))
        {    mistake( 112 );
	     return( ERROR );
        }
	
	/*** calculation ***/

	L=ecracelog(L,fkeller);
	L = list2( L, 37 );
	return( L );

}
