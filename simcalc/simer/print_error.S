/*C
			print_error( string, laenge )

	"print error examination".
	single print_error(string); char *string; single *laenge;

	Der Eingabestring wird auf syntaktische Fehler und unzulaessige
	Zeichen untersucht.
	Falls der Eingabestring fehlerfrei ist, so wird die Anzahl
	der Gleichheitszeichen, sonst -1 an das aufrufende Programm 
	zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.04.1994      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

single print_error( s, laenge )
char *s;
single *laenge;

{
	single i, l=1, z=1, z1=0, z2 = 0, kop=1, m=0;
	single gz=0;
	char hilf[MAXLV];
	*hilf = '\0';

	*laenge = 0;

	/*** Ueberpruefen der Klammerstruktur ***/

	while ( *(s+l) != '\0' && z )
	{       switch( *( s+l ) )
		{       case '(': if(seven(z2)) ++z;
				  break;
			case ')': if(seven(z2)) --z;
				  break;
			case '{': if(seven(z2)) ++z1;
				  break;
			case '}': if(seven(z2)) --z1;
				  break;
			case '"': /** \" ausserhalb von strings **/
				  if(seven(z2) && *(s+l-1)=='\\')
				  {	mistake(3);
					return(-1);
				  }
				  if(*(s+l-1) !='\\')
				  {	if(kop) kop = 0;
					else kop = 1;
				  	++z2;
					i=0;
				  }
				  else i=1;

				  /** Folgezeichen von string **/
				  if(seven(z2))
				  {	l++;
					while(*(s+l)!='\0'&&*(s+l)==' ')
						l++;	
					if(*(s+l)=='\0'|| (*(s+l)!=',' && *(s+l)!=')'))
					{	mistake(3);
						return(-1);
					}
					if(*(s+l)==')') z--;
				  }
				  /** prechar von string **/
				  else if(!i)
				  {	i=prechar(s,l);
					if(i!=',' && i!='(')
					{	mistake(3);
						return(-1);
					}
				  }
				  break;
			case '=': if(seven(z2)) 
				  {	i=prechar(s,l); 
				  	if(i == '=') gz--;
				  	else if(i!= '>' && i != '<' && i != '!') gz++;
				  }
				  break;
			default: break;
		}
		if(kop && ( (*(s+l)==',' && z==1 && z1==0 ) || !z))
		{	*(hilf+m) = '\0';
			if(m && !error(hilf)) 
			{
				return(-1);
			}
			for(i=0;i<m;i++) *(hilf+i)='\0';
			m=0;
		}	
		else if(kop && *(s+l)!=' ' && *(s+l)!='"' ) 
		{	*(hilf+m) = *(s+l);
			m++;
		}
		++l;
	}

	if ( z > 0 ) {
		mistake( 2 );
		return( -1 );
	}
	
	*laenge = l;
	return(gz);
}
