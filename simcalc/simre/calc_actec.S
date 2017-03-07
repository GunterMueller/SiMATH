/*C
			calc_actec( fkeller )

	"calculator actual elliptic curve".
	list calc_actec(fkeller); list fkeller;
	L = calc_actec( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt, das eine
	elliptische Kurve mit zugehoeriger Kennung darstellt.
	calc_actec merkt sich intern ueber den Schalter ecsch, dass
	bezueglich der elliptischen Kurve, die in fkeller steht, die
	Punktaddition, die mit + und - bezeichnet wird, zu verstehen
	ist. Sie wird an die Variable act.ell.curve zurueckgegeben.
	In L wird die entsprechende elliptische Kurve zurueckgegeben.
	Laeuft calc_actec fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      22.11.1990      U.Schneiders
	Version  1.2    28.07.1992      U.Schneiders ( nf umd mod )
	Version  1.3    12.07.1993      U.Schneiders ( gf )
H*/
 
#include <_calc.h>

list calc_actec( fkeller )
list fkeller;
{
	single k;
	char *name;
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k!=(-1) && k!=(-2) && k!=(-5) && k!=(-6) && k!=(-9) && k!=(-10) && k!=(-14) )
	{       mistake( 110 );
		return( ERROR );
	}

	/*** Abspeichern der cur. ell. curve in varlist ***/

	if( !ecsch )
	{
		for( k = MXNUM; k < MX; k++ )
		{       if( !strlen( varlist[k].varname ) )
			{       name = "curEllCurve";
				strcpy( varlist[k].varname, name );
				ecsch = k;
				break;
			}
		}
	}
	varlist[ecsch].varwert = fkeller;
	return( fkeller );
}
