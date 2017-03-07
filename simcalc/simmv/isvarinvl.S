/*C
			isvarinvl( name,VL )

	" is variable in variable list?"
	single isvarinvl( name,VL );
	char *name;
	list VL;

	isvarinvl untersucht,ob die Variable name in der Variablenliste
	VL vorkommt. Falls ja,liefert isvarinvl die entsprechende
	Position in der Variablenliste zurueck;sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      30.10.1989      C.Hollinger/U.Schneiders
					( isvarinpol -> isvarinvl )
H*/
/*cS
	isvarinvl ruft auf:

		    Macros: lfirst,lred
Sc*/

#include<_calc.h>

single isvarinvl( name,VL )
char *name;
list VL;

{
	single sch, hsch, n, pos;
	int v;
	list V;
	init( V, v );
	bind( VL );

	hsch = 0;
	pos = 1;
	while ( !hsch && VL != _0 )
	{       V = lfirst( VL );
		VL = lred( VL );
		n = 0;
		sch = 1;
		while( V != _0 && sch )
		{       v= lfirst( V );
			V = lred( V );
			if ( v == *(name + n) ) n++;
			else sch = 0;
		}
		if ( sch && *(name + n) == '\0' )
			return( pos );
		pos++;
	}
	return( 0 );
}
