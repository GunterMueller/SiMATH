/*C
			brackex ( arg, arg2 )

	"bracket expression".
	brackex(arg, arg2)  char *arg, *arg2;

	Der String innerhalb einer oeffnenden und der zugehoerigen
	schliessenden Klammer wird bestimmt und arg2 zugewiesen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      19.08.1991      U.Schneiders ( 2 Argumente )
H*/
/*cS
	brackex ruft auf:
		  Macros:
Sc*/
 
#include <_calc.h>

brackex( arg, arg2 )
char *arg, *arg2;

{       /*** Deklarationen und Vorbesetzungen ***/

	single p=0,i=1,j=0,g=0;

	/*** Isolierung des geklammerten Ausdrucks ***/

	while ( i ) {
		switch( *(arg+p) ) {
			case '(': if(seven(g)) ++i;
				  break;
			case ')': if(seven(g)) --i;
				  break;
			case '"': if(!p || *(arg+p-1)!='\\')
				      g++;
				  break;
		}
		if ( i > 0 ) *( arg2+j ) = *(arg+p);
		++j;
		p++;
	}
	*( arg2+j-1 ) = '\0';
	return( 0 );
}
