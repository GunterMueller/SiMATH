/*C
			isass( arg )

	"is assignment".
	single isass(arg); char *arg; 
	X = isass( arg );

	Falls die Zeichenkette arg eine Zuweisung ist, so wird der 
	Funktionswert 1 an das aufrufende Programm zurueckgeliefert, 
	andernfalls der Funktionswert 0.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      12.11.1993      S.Schmitt/U.Schneiders
H*/
/*cS
	isass ruft auf: instring, isalnum, isalpha
		   Macros:
Sc*/
 
#include <_list.h>

single isass( arg )
char *arg;

{       /*** Deklarationen und Vorbesetzungen ***/

	single j,kl=0;

	if(!instring(arg,"=",&j)) return(0);
	while(*arg != '\0')
	{	switch(*arg)
		{	case '(': kl++;
				  arg++;
				  break;
			case ')': kl--;
				  arg++;
				  break;
			case '!':
			case '<':
			case '>': arg++;
				  while(*arg == ' ') arg++;
				  if(*arg == '=') arg++;
				  break;
			case '=': if(kl==0)
				  { 	arg++;
					while(*arg==' ') arg++;
					if(*arg!='=') return(1);
				  }
				  arg++;
				  break;
			default: arg++;
		}
	}
	return(0);
}
