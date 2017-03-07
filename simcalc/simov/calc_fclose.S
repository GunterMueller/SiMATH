/*C
			calc_fclose( string )

	"calculator file close".
	single calc_fclose( string ); char *string;
	X = calc_fclose( string );
	Die Einlesedatei mit dem Namen string wird geschlossen.
	Falls der string leer ist, so wird die Einlesedatei ___INP
	geschlossen.
	Der Name der Datei wird in der Zeichenkette fname[i] ge-
	loescht.
	Falls die Datei nicht geoeffnet war, wird 0, sonst 1
	zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.09.1990      U.Schneiders
	Version  2	03.12.1993	S.Schmitt/U.Schneiders
H*/
/*cS
	calc_fclose ruft auf: fclose, isalsc, isdigit, strcmp, strcpy
	Macros: fprintf
Sc*/
 
#include <_calc.h>

single calc_fclose( string )
char *string;

{
	single i,j,sp=0,klsch=0;
	char s[30];
	string += 6;

	i=strlen(string);
	if(i && *(string+i-1) == ';') sp = 1;
	
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


	if ( *string == '\0' || *string == ';' )
		strcpy( s, "___INP");
	else if(!klsch)
	{	mistake1(34,"fclose");
		return(0);
	}

	/*** Abfangen ungueltiger Dateinamen ***/

	else
	{	j=0;
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
		{	mistake1(34,"fclose");
			return(0);
		}
	}

	/*** Bestimmung des Feldes i in fname[] und fpt[] ***/

	for( i = 0; i < 10; i++ )
	{       if( !strcmp( fname[i], s ) ) break;
	}

	if( i == 10 )
	{       mistake1( 103, s );
		return( 0 );
	}

	fclose( fpt[i] );
	if(!sp)
	{ 	printf(" File %s is closed.\n", fname[i] );
		if( ps ) fprintf( datei, "out: File %s is closed.\n", fname[i] );
	}
	*fname[i] = '\0';
	fz--;
	return( 1 );
}
