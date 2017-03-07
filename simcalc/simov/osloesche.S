/*C

		       osloesche( )

	"Loeschen von Variablen ohne Speicherueberlauf".
	single loesche();
	sch = loesche( );
	Das Programm dient zum Loeschen von Variablen waehrend einer
	Calculatorsitzung.
	sch ist -1, falls Benutzer unzulaessige Eingaben macht.
	sch ist -2, falls keine Variable geloescht wird.
	sch ist 1, falls Variablen geloescht werden.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H
	Version  1      11.06.1987      H.Stroeher/M.Mang
	Version  2      25.08.1987      M.Mang
	(Loeschen von ganzen Variablengruppen durch Angabe mit * moeglich)
	Version  3      10.01.1990      U.Schneiders ( MX- AS- Version )
H*/

#include <_calc.h>

single osloesche( )

{

	/*** Deklarationen und Vorbesetzungen ***/

	single i=0, d=0, n=0, z, sch= (-1);
	char *stri, va[ 21 ], s, *getline();
	char *st;
	st=malloc(MAXLV); *st='\0';
	stri = malloc( MAXLV );
	*stri = '\0'; *va = '\0';

	/*** Aufforderung an Benutzer ***/

	signal(SIGINT,SIG_IGN);
	printf(" If you do not want to delete any variables, please type CTRL/D.\n");
	printf(" variables to delete: ");
	if ( ps ) {
    fprintf(datei,"out: If you do not want to delete any variables, please type CTRL/D.\n");
    fprintf(datei,"     variables to delete: ");
	}
	setocnt( stdout, 0 );
	*stri = '\0';
	st = getline("",-1);
	strcpy( stri, st );
	if(!strcmp(stri,"quit")) s=4;
	else s = (*stri);
	while ( *(stri+n) == '*' ) {
		++n;
		if ( *(stri+n) == '\0' ) {
			sch = loeaok( stri );
			free(st);
			free(stri);
			return( sch );
		}
	}
	switch(s) {

		/*** Leerer String ***/

		case 10 :
			 free(st);
			 free(stri);
			 return( -1 );

		/*** Auflisten des Speicherinhaltes ***/

		case 63 :if ( ps ){ fprintf( datei, "\nin : " );
				   fputs(stri,datei);fprintf(datei,"\n");
			 }
			 while ( *stri == '?' ) {
				inform( stri+1 );
				signal(SIGINT,SIG_IGN);
				printf("\n variables to delete: ");
				if ( ps ) fprintf( datei, "out: variables to delete: ");
				setocnt( stdout, 0 );
				*stri = '\0';
				st = getline("",-1);
			        strcpy( stri, st );
				if(!strcmp(stri,"quit")) s=4;
				else s = (*stri);
				while ( *(stri+n) == '*' ) {
				    ++n;
				    if ( *(stri+n) == '\0' ) {
					sch = loeaok( stri );
					
			 	 	 free(st);
			 		 free(stri);
					 return( sch );
				    }
				}
				switch ( s ){
				  case 10 :
					   free(st);
					   free(stri);
					   return( -1 );
				  case  4 :*stri = ' ';
					   break;
				  default:
					if ( ps )
					   fprintf( datei, "\nin : %s\n",stri);
				}
			 }
			 if ( s != 4 ) break;
		/*** Keine Variable wird im Speicher geloescht ***/

		case  4: printf(" No variables deleted.\n");
			 if ( ps ) {
	fprintf( datei, "\nin : END\n");
	fprintf( datei, "out: No variables deleted.\n");
			 }
			 
			 free(st);
			 free(stri);
			 return( 0 );

		/*** Loeschen der gewuenschten Variablen, falls
		     moeglich ***/

		default:if ( ps )
			fprintf( datei, "\nin : %s\n", stri );
	}
	z = strlen( stri );
	while ( z - i ) {
	  while ( *(stri+i) == ' ' || *(stri+i) == ',' ) ++i;
	    *(va+d) = *(stri+i);
	    ++i; ++d;
	    if (*(stri+i)==' ' || *(stri+i)==',' || *(stri+i)=='\0') {
	       *(va+d) = '\0';
	       if(!strlen(va)) 
	       {
			free(st);
			free(stri);
			return(-1);
	       }
/*******
	       if ( !strcmp(va,"@")) {
		   printf( " @ cannot be deleted!\n" );
		   if ( ps )
		     fprintf( datei, "out: @ cannot be deleted!\n" );
	       }
	       else { ********/
		   if ( strchr( va, '*' ) != NULL ) sch = loem( va );
		   else  sch = loee(va);
		   structsort();
/*******
	       } ********/
	       d = 0; *va = '\0';
	    }
	}
	free(st);
	free(stri);
	return( sch );
}
