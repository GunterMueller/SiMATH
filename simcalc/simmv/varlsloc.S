/*C
			varlsloc( L, zahl, zkstr )

	"variables from list to string local".
	single varlsloc(L, zahl,zkstr); list L; single zahl; char *zkstr;
	sch = varlsloc( L, zahl, zkstr );

	Die Liste L wird in einen string umgewandelt.
	sch ergibt sich zur Position des Elements string in
	der Variablenliste. Ist string eine benutzerdefinierte 
	Funktion, so ist -sch-2 = Position des Elements in der
	Variablenliste.
	Falls zahl=-1, hat man kein Array, sonst gibt die Zahl zahl
	den Index des Arrays an.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1   25.05.1994         S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

single varlsloc( L, zahl, zkstr )
list L;
single zahl;
char *zkstr;

{
	/*** Deklarationen und Vorbesetzungen ***/

	single altz,i=0, sch=(-1);
	bind( L );

	/*** Umwandlung Liste zu string ***/
                          
	if ( llength( L ) > 20 ) return( -1 );
	while ( L != _0  && i<=19 ) {
		*( zkstr + i ) = lfirst( L );
		L = lred( L );
		++i;
	}
	if(zahl>=0)
	{	*(zkstr + i) = '[';
		i++;
		sputi(zahl,zkstr+i); i++;
		if(zahl>=10) i++;
		if(zahl>=100) i++;
		if(zahl>=1000) i++;
		*(zkstr+i) = ']'; i++;
	}
	*( zkstr + i ) = '\0';         

	/*** zkstr suchen ***/

	zahl=0;
	for(i=0;i<funktion;i++)
	{	altz=zahl;
		zahl=localvar[anzloc-zahl-1].varwert + zahl + 1;
	}
	for(i=anzloc-zahl;i<anzloc-altz-1;i++)
        {	if(!strcmp(localvar[i].varname,zkstr)) 
		{	sch=i;	
			break;
		}
	}
	if(sch >= 0  && (localvar[sch].typ == 2 || localvar[sch].typ == -3 ))
		sch = -sch-2;
	return( sch );
}
