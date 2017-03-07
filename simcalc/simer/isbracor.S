/*C
			isbracor( arg, sch )

	"is in brackets correct".
	X =  isbracor( arg, sch );
	char *arg;
	single sch;

	Ist arg von der Form ( arg ), so liefert isbracor 1 zurueck.
	Andernfalls ueberprueft isbracor, ob arg syntaktisch korrekt
	aufgebaut ist, vor allem, ob kein Gleichheitszeichen falsch
	gesetzt wurde. Liegt ein syntaktischer Fehler vor, so liefert
	isbracor 0, sonst 1 zurueck.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      22.03.1988       C.Hollinger/U.Schneiders
H*/

#include<_calc.h>

single isbracor( arg, sch )
char *arg;
single sch;

{       single i, l, kl;

	i = error( arg );
	if( !i ) return( 0 );
	i = 0;
	if( *arg == '(' )
	{       l = strlen( arg );
		if( *(arg + l ) == ')' )  return( 1 );
		else if(!sch)
		{       kl = 0;
			while( i < strlen(arg) )
			{       if ( *(arg+i) == '(' ) kl++;
				else if ( *(arg+i) == ')' ) kl--;
				if ( *(arg+i) == '=' && ( kl == 0 ) )
				{       l=prechar(arg,i);
					if(l != '!' && l != '<' && l != '>' && l != '=')
					{ i++;
					  while(*(arg+i) == ' ') i++;
					  if(*(arg+i) != '=')
					  {     mistake( 6 );
						return( 0 );
					  }
					}
				}
				++i;
			}
		}
	}
	else if(!sch)
	{       kl = 0;
		while( i < strlen(arg) )
		{       if ( *(arg+i) == '(' ) kl++;
			else if ( *(arg+i) == ')' ) kl--;
			if ( *(arg+i) == '=' && ( kl == 0 ) )
			{       l=prechar(arg,i);
				if(l != '!' && l != '<' && l != '>' && l != '=')
				{ i++;
				  while(*(arg+i) == ' ') i++;
				  if(*(arg+i) != '=')
				  {     mistake( 6 );
					return( 0 );
				  }
				}
			}
			++i;
		}
	}
	return( 1 );
}
