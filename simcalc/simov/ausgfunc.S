/*C
			ausgfunc ( name, wert )

	"Ausgabe von Funktionen".
	char *name; single wert; 
	ausgfunc( name, wert );

	ausgfunc schreibt die Funktion "name" auf stdout und auf eine 
	Protokolldatei, falls eine geoeffnet ist.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1    10.05.1994      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

ausgfunc ( name, wert )
char *name;
single wert;

{
     single l=0;

     if(!assch){

     printf( "%t %s(",8, name );
     if ( ps )
     fprintf( datei, "out: %s(", name );

	/** Parameter **/

     while(*(funstr[wert]+l)!= '~')
     {	 if(*(funstr[wert]+l)=='#') 
	 {	putc(',',stdout);
		if(ps) fputc(',', datei);
	 }
	 else 
	 {	putc(*(funstr[wert]+l),stdout);
		if(ps) fputc(*(funstr[wert]+l),datei);
	 }
	 l++;
     }

     printf(") = ");
     if(ps) fprintf(datei,") = ");

	/** Funktion **/

     l++;
     puts(funstr[wert]+l);
     if(ps) fputs(funstr[wert]+l,datei);
     printf("\n");
     if(ps) fprintf(datei,"\n");
     }
     return(0);
}
