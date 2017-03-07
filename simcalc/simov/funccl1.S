/*C
			funccl1( arg, d );

	"function calling with one parameter".
	list funccl1(arg,d); char *arg; single *d;
	wert = funccl1( arg, d );
	Der zu einem Funktionsaufruf gehoerige Eingabestring wird
	bestimmt und ausgewertet. Die Laenge des ausgewerteten
	Strings wird *d zugewiesen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  1.2    26.08.1991      U.Schneiders ( brackex MX300 )
H*/
/*cS
	funccl1 ruft auf:  basad, brackex, strlen

		  Macros:
Sc*/
 
#include <_calc.h>

list funccl1 ( arg, d )
char *arg;
int *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	char arg2[MAXL];
	list wert;
	init( wert );

	/*** Erkennung des auszuwertenden Strings und Uebergabe
	     an Kellerverwaltung ( basad ) ***/

	arg += 1;
	brackex ( arg, arg2 );
	*d = strlen( arg2 )+1;
	if( !isbracor( arg2,0 ) )  
	{
	 	return( -BASIS );
	}

	wert = basad ( arg2 );
	if(wert == -BASIS-1)
	{	mistake(32);
	        wert = -BASIS;
	}

	return( wert );
}
