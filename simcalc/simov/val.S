/*C
			val( aid )

	"value".
	list val( aid );
	char *aid;

	val wertet aid aus und untersucht, ob der Wert zulaessig 
	fuer eine Polynomsubstitution ist.
	Falls nein, gibt val Fehlermeldung aus und liefert -BASIS
	zurueck; andernfalls die Auswertung von aid.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      18.01.88        C.Hollinger/U.Schneiders
	Version  2      18.09.92        U.Schneiders ( mod und nf )
	Version  3	26.07.93	S.Schmitt ( gf )
	Version  4	01.02.95	S.Schmitt ( R und C )
H*/
 
#include<_calc.h>
list val( aid )
char *aid;

{
	list erg;
	single ken=0;
	init( erg );

	erg = basad( aid, ken );
	if( erg == -BASIS-1 ) mistake(32);
	if( erg == -BASIS || erg == -BASIS-1 ) return( -BASIS );
	ken = lsecond( erg );

	/*** Ueberpruefung,ob aid Polynom. ***/

	if( ( ken >= 5 && ken!=15 && ken != 17 && ken != 18 && ken != 24 && ken != 25 && ken != 31 && ken != 32 && ken!=37 && ken!=38 && ken!=39 ) || ken < 0 )
	{       mistake1( 250, aid );
		return( -BASIS );
	}

	/*** aid ist zulaessiges Argument. *****/

	return( erg );
}
