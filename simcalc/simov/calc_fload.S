/*C
			calc_fload( string, fkt, fktco )

	"calculator file load".
	single calc_fload( string, fkt, fktco ); char *string;
				    void (*fkt)(), (*fktco)();
				
	X = calc_fload( string, fkt, fktco );
	Die Einlesedatei mit dem Namen string wird zum Lesen ge-
	oeffnet, vollstaendig eingelesen und wieder geschlossen. 
	Falls der string leer ist, so ist die Einlesedatei ___INP. 
	Falls die Datei nicht vorhanden ist, wird X=0 zurueckgeliefert, 
	sonst X=1.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.09.1990      U.Schneiders
H*/

#include <_calc.h>

single calc_fload( string, fkt, fktco )
char *string;
void (*fkt)(), (*fktco)();
{
	FILE *lpt;
	single c,i,j,klsch = 0, sp=0;
	char s[30];
	string += 5;

	i=strlen(string);
	if(i && *(string+i-1) == ';') sp = 1;

	/*** First contact with the string ***/

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

	/*** looking at the name of the file ***/

	if(!klsch)
	{	if(*string == '\0' || *string == ';') strcpy(s, "___INP");
		else 
		{	mistake1(34,"fload");
			return(0);
		}
	}
	else
	{	j=0;
		if( *string != '\0' && isdigit( *string ) )
		{	mistake(303);
			return(0);
		}
		while(*string!='\0' && (isalsc(*string) || isdigit(*string)))
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
		{	mistake1(34,"fload");
			return(0);
		}
	}
	
	/*** open the file ***/

	lpt = fopen( s , "r" );
	if( lpt == NULL )
	{       mistake1( 102, s );
		return( 0 );
	}

	/** reading from file **/
	
	j=strlen(string);
	do
	{	for(i=0;i<j;i++) *(string+i)='\0';
		i=MAXL;
		j=0;
		while ( --i > 0  &&  (c = xfgetc(lpt)) != EOF )
		{ 	if ( (*(string+j) = c) == '\n' )  break;
			j++;
			if(j>(MAXL-1))
			{	ungetc(c,lpt);
				break;
			}
		}
		if( c != EOF ) j--;
		if(sp)
		{ 	*(string+j)=';';
			j++;
		}
		*(string+j+1) = '\0';
		if(j>=MAXL)
		{	printf(" Input too long!\n\n");
			return(0);
		}
		seqbasad(string, fkt,fktco, 1,0);
	}
	while(c!=EOF);

	/** closing the file **/

	fclose( lpt );
	if(!sp)
	{ 	printf(" File %s was loaded.\n", s );
		if( ps ) fprintf( datei, "out: File %s was loaded.\n", s);
	}
	return( 1 );
}
