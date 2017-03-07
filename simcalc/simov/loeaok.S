/*C
		       loeaok( str )

	"Loeschen aller oder keiner Variablen".
	single loeaok(s); char *str;
	sch = loeaok( str );
	Das Programm dient zum Loeschen aller Variablen im
	Programm osloesche.
	sch ist -2, falls keine Variable geloescht wird.
	sch ist 1, falls alle Variablen geloescht werden.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.08.1987      M.Mang/H.Stroeher
	Version  2      10.01.1990      U.Schneiders ( MX- AS- Version )
	Version  2.1    29.11.1990      U.Schneiders ( ecsch )
	Version  2.2    12.07.1993      U.Schneiders
H*/

# include <_calc.h>

single loeaok( str )
char *str;

{
	char s, *getline();
	single n, h,j,k;
	char *ant;
	ant = malloc(1000);
	*ant = '\0';

	if ( ps ) fprintf(datei,"\nin : %s\n", str );
	printf(" Do you really want to delete all variables? (y/n) ");
	if ( ps )
	  fprintf( datei,"out: Do you really want to delete all variables? (y/n)\n");
	ant = getline("",-1);
	s = (*ant);
	if  ( ps ) fprintf( datei,"in : %c\n",s );
	if ( s != 'y' ) {
		printf(" \n No variables deleted!\n");
		if ( ps )
		    fprintf( datei,"out: No variables deleted!\n");
		free(ant);
		return( -2 );
	 }
	 else {
		for( n= 0; n<MX; n++) 
		{   if(varlist[n].typ==2)
		    {	h=varlist[n].varwert;
		        k=strlen(funstr[h]);
			for(j=0;j<k;j++) funstr[h][j]='\0';
			free(funstr[h]);
			funstr[h]=malloc(5); 
			funstr[h][0]='\0';
		    }
		    varlist[n].varwert = 0;
		    strcpy(varlist[n].varname,"\0");
		    varlist[n].typ=0;
		    if(!n) n=MXNUM-1;
		}
		ecsch = 0; modsch = 0; nfsch = 0; gfsch = 0;
		gfchar = 0; VNF = _0; VGF = _0;
		av_loesche(16); av_loesche(23); av_loesche(30);
		printf("  \n All variables deleted!\n");
		if ( ps ) fprintf( datei,"out: All variables deleted!\n");
		free(ant);
		return( 1 );
	 }
}
