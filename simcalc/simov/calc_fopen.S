/*C
			calc_fopen( string )

	"calculator file open".
	single calc_fopen( string ); char *string;
	X = calc_fopen( string );
	Die Einlesedatei mit dem Namen string wird zum Lesen ge-
	oeffnet. Falls der string leer ist, so wird die Einlesedatei
	___INP geoeffnet.
	Der Name der Datei wird in der Zeichenkette fname[i] abge-
	legt und der entsprechende Filepointer in fpt[i] gesetzt.
	Sind bereits 10 Einlesedateien geoeffnet, so wird die neue
	nicht mehr geoeffnet. In diesem Fall und falls die Einlese-
	datei nicht vorhanden ist, wird X=0 zurueckgeliefert, sonst
	X=1.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.09.1990      U.Schneiders
	Version  2	03.12.1993	S.Schmitt/U.Schneiders
H*/
/*cS
	calc_fopen ruft auf:  fopen, isalsc, isdigit, mistake, strcpy
	Macros:  fprintf, printf
Sc*/
 
#include <_calc.h>

single calc_fopen( string )
char *string;

{
	single i,j,sp=0,klsch = 0;
	char s[30];
	string += 5;

	/*** zu viele Einlesedateien geoeffnet ***/

	if( fz >= 10 )
	{       mistake( 101 );
		return( 0 );
	}
	i=strlen(string);
	if(i && *(string+i-1) == ';') sp = 1;

	/*** Bestimmung des Feldes i in fname[] und fpt[] ***/

	for( i = 0; i < 10; i++ )
	{       if( *fname[i] == '\0' ) break;
	}

	while ( *string == ' ' ) string += 1;
	if(*string != '\0' && *string == '(')
	{	string++;
		while(*string == ' ') string++;
		if(*string == '\0' )
		{	mistake(1);
			return(0);
		}
		if(*string == ')')
		{	string++;
			while(*string == ' ') string++;
		}
		else klsch=1;
	}

	/*** Eroeffnen der Einlesedatei ___INP ***/

	if ( *string == '\0' || *string == ';') {
		fpt[i] = fopen("___INP","r");
		if( fpt[i] == NULL )
		{       mistake1( 102, "___INP" );
			return( 0 );
		}
		strcpy( fname[i], "___INP\0");
		fz++;
		if(!sp) 
		{	printf(" File ___INP is opened.\n" );
			if( ps ) fprintf( datei, "out: File ___INP is opened.\n" );
		}
		return( 1 );
	}

	else if(!klsch)
	{	mistake1(34,"fopen");
		return(0);
	}

	/*** Abfangen ungueltiger Dateinamen ***/

	j=0;
	if( *string != '\0' && isdigit( *string ) )
	{	mistake(303);
		return(0);
	}
	while( *string != '\0' && ( isalsc(*string) || isdigit(*string) ) )
	{	s[j]= *string;
		j++;
		string++;
	}
	s[j] = '\0';
	while(*string == ' ') string++;
	if(*string =='\0')
	{	mistake(1);
		return(0);
	}
	if(*string != ')')
	{	mistake(303);
		return(0);
	}
	string++;
	while(*string == ' ') string++;
	if(*string!='\0' && *string!=';')
	{	mistake1(34,"fopen");
		return(0);
	}

	/*** Anlegen einer Protokolldatei mit vorgegebenem Namen ***/

	fpt[i] = fopen( s , "r" );
	if( fpt[i] == NULL )
	{       mistake1( 102, s );
		return( 0 );
	}
	strcpy( fname[i], s );
	fz++;
	if(!sp)
	{	printf(" File %s is opened.\n", fname[i] );
		if( ps ) fprintf( datei, "out: File %s is opened.\n", fname[i] );
	}
	return( 1 );
}
