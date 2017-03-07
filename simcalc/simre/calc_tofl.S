/*C
			calc_tofl( fkeller )

	"calculator to floating points".
	int calc_tofl(fkeller); list fkeller;
	X = calc_tofl( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung.
	Das in fkeller stehende Objekt wird in eine Struktur ueber 
        floating point Zahlen umgewandelt.
	Die Anzahl der Nachkommastellen richtet sich nach der Vorein-
	stellung, die in der Variablen DIGITS abgespeichert ist.
	Die ausgebene Zahl wird reell gespeichert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  1.1    14.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  1.2	21.01.1994	S.Schmitt( Komplexe Zahlen )
	Version  2	02.03.1995	S.Schmitt/U.Schneiders( tofl )
H*/

#include <_calc.h>

int calc_tofl( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k, r;
	obj VL, Z;
	init( VL, Z );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS);
	Z = lfirst( fkeller );
	k = lsecond( fkeller );

	if( k<0 || (k>3 && k!=15 && k!=38) )
	{       mistake( 22 );
		return( -BASIS );
	}

	switch(k)
	{	case 0:	Z = itofl(Z);
			Z = list2(Z,15);
			break;
		case 1: Z = rtofl(Z);
			Z = list2(Z,15);
			break;
		case 2: VL = lfirst(Z);
			r = llength(VL);
			Z = lsecond(Z);
			Z = pitopfl(r,Z);
			Z = list2(VL,Z);
			Z = list2(Z,38);
			break;
		case 3: VL = lfirst(Z);
			r = llength(VL);
			Z = lsecond(Z);
			Z = prtopfl(r,Z);
			Z = list2(VL,Z);
			Z = list2(Z,38);
			break;
		case 15: Z = list2(Z,15);
			 break;
		case 38: Z = list2(Z,38);
			 break;
		default: break;
	}

	return( Z );
}
