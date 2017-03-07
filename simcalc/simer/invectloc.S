/*C
			invectloc( name )

	"is in vector local".    (rekursiv)
	single invectloc(name); char *name;
	i = invectloc( name );

	invectloc gibt die Stelle zurueck, an der name in localvar 
	steht, falls name eine lokale Variable ist, sonst ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.05.1994      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

int invectloc(name)
char *name;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i,zahl,altz;

	zahl=0;
	for(i=0;i<funktion;i++)
	{	altz=zahl;
		zahl=localvar[anzloc-zahl-1].varwert + zahl + 1;
	}	
	for(i=anzloc-zahl;i<anzloc-altz-1;i++)
		if(!strcmp(localvar[i].varname,name)) return(i);	
	return(ERROR);
}
