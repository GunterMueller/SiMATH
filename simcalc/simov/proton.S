/*C
			proton( string )

	"Protokoll on".
	single proton(string); char *string;
	X = proton( string);
	Es wird die Protokolldatei mit dem Namen string angelegt.
	Falls string leer ist, so wird die Protokolldatei ___PROT
	angelegt. Der Name der Protokolldatei wird in der Zeichenkette
	datn abgelegt. hps ist ein Schalter der anzeigt , ob bereits eine
	Protokolldatei angelegt ist. Ist dies der Fall, so wird diese
	geschlossen.
	Konnte eine Protokolldatei angelegt werden, so wird der
	Funktionswert 1, andernfalls 0, an das aufrufende Programm
	zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  2	03.12.1993	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

single proton( string )
char *string;
{

	/*** Deklarationen und Vorbesetzungen ***/

	single i,sp=0,klsch=0;
	string += 5;

	/*** Schliessen einer vorhandenen Protokolldatei ***/

	if ( hps ) fclose( datei );

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

	/*** Eroeffnen der Protokolldatei ___PROT ***/

	if ( *string == '\0' || *string == ';' ) {
		datei = fopen("___LOG","a");
		if( datei == NULL )
		{	mistake(300);
			return(0);
		}
		strcpy( datn, "___LOG");
		if(!sp) printf(" Logging to file %s.\n",datn);
		protkopf();
		return( 1 );
	}
	else if(!klsch)
	{	mistake1(34,"logon");
		return(0);	
	}

	/*** Abfangen ungueltiger Dateinamen ***/

	i=0;
	if( *string != '\0' && isdigit( *string ) )
	{	mistake(303);
		return(0);
	}
	while( *string != '\0' && ( isalsc(*string) || isdigit(*string) ) )
	{	datn[i]= *string;
		i++;
		string++;
	}
	datn[i] = '\0';
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
	{	mistake1(34,"logon");
		return(0);
	}

	/*** Anlegen einer Protokolldatei mit vorgegebenem Namen ***/

	datei = fopen(datn,"a");
	if( datei==NULL )
	{	mistake(300);
		return(0);
	}
	if(!sp) printf(" Logging to file %s.\n",datn);
	protkopf();
	return( 1 );
}
