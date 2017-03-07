/*C

			loesche( name )

	"Loeschen von Variablen".
	single loesche(name); char *name;
	sch = loesche( name );
	Das Programm dient zum Loeschen von Variablen und wird
	automatisch aufgerufen, wenn der Variablenspeicher voll ist.
	sch ist -1, falls keine Variable geloescht wird,
	sch ist -2, falls der Bediener unzulaessige Eingaben macht,
	sch ist 1, falls Variablen geloescht wurden.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H
	Version  1      04.05.1987      H.Stroeher/M.Mang
	Version  2      10.01.1990      U.Schneiders ( MX- AS- Version )
H*/

#include <_calc.h>

single loesche( name )
char *name;

{

	/*** Deklarationen und Vorbesetzungen ***/

	single i=0, d=0, n=0, z, sch, sch1=(-2);
	char *stri, va[ 20 ], s, *getline();
	char *st;
	st=malloc(MAXLV); *st='\0';
	stri = malloc( MAXLV );

	signal(SIGINT,SIG_IGN);
	*stri = '\0'; *va = '\0';

	/*** Meldung fuer Benutzer, dass zu berechnende Variable
	     nicht mehr in den Speicher aufgenommen werden kann ***/

	printf(" Variable store overflow!\n");
	if ( ps ) fprintf(datei,"out: Variable store overflow!\n");

	if( !isatty(fileno(stdin)) )
	{        printf(" %s is assigned to the variable '@'.\n",name);
	         if ( ps ) fprintf( datei, "out: %s is assigned to the variable '@'.\n", name );
	         free(st);
		 free(stri);
		 return( -1 );
  	}
	  printf(" Please delete unnecessary variables!\n");
	  printf(" If you do not want to delete any variables, please type CTRL/D.\n");
	  printf(" variables to delete: ");
	  if ( ps ) {
    fprintf(datei,"     Please delete unnecessary variables!\n");
    fprintf(datei,"     If you do not want to delete any variables, please type CTRL/D.\n");
    fprintf(datei,"     variables to delete: ");
	}
	  setocnt( stdout, 0 );
	  *stri = '\0';
	  st = getline("",-1);
	  strcpy(stri,st);
	  if(!strcmp(stri,"quit")) s=4;
	  else s = (*stri);
	while( *(stri+n) == '*' ) {
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
			 return ( -2 );

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
				strcpy(stri,st);
				if(!strcmp(stri,"quit")) s=4;
				else s = (*stri);
				while( *(stri+n) == '*' ) {
				    if ( *(stri+n) == '\0' ) {
					sch = loeaok( stri );
					free(st);
					free(stri);
					return( sch );
				    }
				}
				switch ( s  ){
				  case 10 :
					   free(st);
					   free(stri);
					   return( -2 );
				  case  4 :*stri = ' ';
					   break;
				  default:
					if ( ps )
					   fprintf( datei, "\nin : %s\n",stri);
				}
			 }
			 if ( s != 4 ) break;

		/*** Keine Variable wird im Speicher geloescht ***/

		case  4: printf(" %s is assigned to the variable '@'.\n",name);
			 if ( ps ) {
	fprintf( datei, "\nin : END\n");
	fprintf( datei, "out: %s is assigned to the variable '@'.\n", name );
			 }
			 
		         free(st);
			 free(stri);
			 return( -1 );

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
	       if (!strlen(va))
	       {
			free(st);
			free(stri);
		        return(-2);
	       }
/******		if ( !strcmp(va,"@")) {
		   printf( " @ cannot be deleted!\n" );
		   if ( ps )
		     fprintf( datei, "out: @ cannot be deleted!\n" );
	       }
	       else { *****/
		   if ( strchr( va, '*' ) != NULL ) sch = loem( va );
		   else  sch = loee(va);
		   if ( sch > -2 ) sch1=1;
		   structsort();
	       /*************} *****/
	       d = 0; *va = '\0';
	    }
	}
	sch = sch1;
	free(st);
	free(stri);
	return( sch );
}
