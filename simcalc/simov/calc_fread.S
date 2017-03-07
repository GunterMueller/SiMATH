/*C
			calc_fread( string, fkt, fktco )

	"calculator file read".
	single calc_fread( string, fkt, fktco ); char *string;
					void (*fkt)(), (*fktco)();
	X = calc_fread( string, fkt, fktco );
	Aus der Einlesedatei mit dem Namen string wird eine Zeichen-
	reihe eingelesen. Falls der string leer ist, so wird die 
	Zeichenreihe aus der Datei namens ___INP eingelesen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.09.1990      U.Schneiders
	Version  2      28.08.1991      U.Schneiders
	Version  3	03.12.1993	S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

single calc_fread( string, fkt, fktco )
char *string;
void (*fkt)(), (*fktco)();
{
	single klsch=(-1),d, h, i, j, l,sp=0, zahl=5;
	char c, *calc_fgets();

	while ( *(string+zahl) == ' ' ) zahl++;
	if( *(string+zahl) != '\0' && *(string+zahl) == '(' )
	{	zahl++;
		while (*(string+zahl) == ' ') zahl++;
		if(*(string+zahl)=='\0' || *(string+zahl) ==',')
		{	mistake1(34,"fread");
			return(0);
		}
		klsch=1;
	}

	/*** Bestimmung des Feldes i in fname[] und fpt[] ***/

	if ( *(string+zahl) == '\0' || ( *(string+zahl) > 47 && *(string+zahl) < 58 ) 
		|| ( klsch && *(string+zahl)==')' ) || *(string+zahl) == ';' )
	{       if(klsch && *(string+zahl) == ')') klsch=0;
		if(*(string+zahl) == ';') sp=1;
		for( i = 0; i < 10; i++ )
			if( !strcmp( fname[i], "___INP" ) ) break;
		if( i == 10 )
		{       mistake1( 103,"___INP" );
			return( 0 );
		}
	}
	else if(klsch==1)
	{       for( i = 0; i < 10; i++ )
		{       l = strlen( fname[i] );
			if( l && !strncmp( fname[i], string+zahl, l ) )
			{       zahl = zahl+l;
				while(*(string+zahl) == ' ') zahl++;
				if(*(string+zahl) != '\0' && *(string+zahl) == ',')
				{   zahl++;
				    while(*(string+zahl) == ' ') zahl++;
				    if(*(string+zahl) == '\0' || *(string+zahl) == ')')
				    {  mistake1(34,"fread");
				       return(0);
				    }
				}
				else if (*(string+zahl) == '\0')
				{   mistake(1);
				    return(0);
				}
				break;
			}
		}
	}     
	else if(klsch == (-1))
	{	mistake1(34,"fread");
		return(0);
	}

	if( i == 10 )
	{       mistake( 300 );
		return( 0 );
	}

	while ( *(string+zahl) == ' ' ) zahl++;

	/*** Lesen einer Zeile ***/

	if ( *(string+zahl) == '\0' || *(string+zahl) == ';' || ( klsch>=0  && *(string+zahl) == ')') )
	{
		if(klsch >=0)
		{	zahl++;
			while(*(string+zahl) == ' ') zahl++;
			if(*(string+zahl)!='\0' && *(string+zahl)!=';')
			{	mistake1(34,"fread");
				return(0);
			}	
			if(*(string+zahl) != '\0' && *(string+zahl)== ';') sp=1;
		}
		for(l=0;l<=zahl;l++) *(string+l)='\0';
		if( ( calc_fgets( string, MAXL, fpt[i] ) == NULL ) )
		{       mistake( 104 );
			return( 0 );
		}
		if(sp)
		{	l=strlen(string);
			*(string+l)=';';
			*(string+l+1) = '\0';
		}
		if(strlen(string)>=MAXL)
		{	printf(" Input too long!\n\n");
			return(0);
		}
		seqbasad(string,fkt,fktco,1,0);

	}

	/*** Lesen mehrerer Zeilen ***/

	else
	{       l = 0;
		while( *(string+zahl) != '\0' )
		{       c= *(string+zahl);
			if( klsch <= 0 && c == ')')
			{	mistake(1);
				return(0);
			}
			if(c==')') klsch = 0;
			if(c==';') sp=1;
			if( l < 2 )
			{       if( ( c < 48 || c > 57 || ( c == 48 && !l ) ) && ( ( c != ')' && c != ';' && c != 32 ) || l != 1 ) )
				{       mistake1( 34,"fread" );
					return( 0 );
				}
				if( !l )   h = c-48;
				else if( c != 32 && c != ';' && c != ')' )      
					h = h*10 + c - 48;
				l++;
				zahl++;
			}
			else
			{       if( c != 32 && c != ';' && c != ')' )
				{       mistake1( 34,"fread" );
					return( 0 );
				}
				l++;
				zahl++;
			}
		}
		if(klsch ==1)
		{	mistake(2);
			return(0);
		}

		d=zahl+1;
		for( l = 0; l < h; l++ )
		{
		       for(j=0;j<d;j++) *(string+j)='\0';
			if( calc_fgets( string, MAXL, fpt[i] ) == NULL )
			{       mistake( 104 );
				return( 0 );
			}
			d=strlen(string);
			if(sp)
			{ 	*(string+d)=';';
				*(string+d+1) = '\0';
				d++;
			}
			if(d>=MAXL)
			{	printf(" Input too long!\n\n");
				return(0);
			}
			seqbasad(string, fkt,fktco, 1,0);
		}

	}
	return( 1 );
}
