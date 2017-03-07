/*C
			ismatrvec( s,p )

	"Is matrix vector correct?".
	Quellbibliothek: srclib.error
	Include- Datei: _calc.h
	single ismatrvec( s,p )  char *s;single *p;
	X = ismatrvec( s,p );

	ismatrvec untersucht, ob der in s angegebene String eine Ma-
	trix oder ein Vektor mit syntaktisch korrekten Elementen ist.
	Ist dies der Fall, so gibt ismatrvec 1 zurueck, sonst 0. p
	gibt die Anzahl der in s enthaltenen Gleichheitszeichen an.
C*/
/*H
	Version  1      26.09.1988      C.Hollinger/U.Schneiders
	Version  2      23.01.1989      C.Hollinger/U.Schneiders
H*/
/*cS
	ismatrvec ruft auf: error, mistake

		    Macros:
Sc*/

#include<_calc.h>

single ismatrvec( s,p )
char *s;
single *p;

{
	single f, i, j, kl, l, matrsch, zl, zsch;
	char el[MAXL];
	*p = 0;

	if(strchr(s,'"')!=NULL || instring(s,"print",&i))
	{	mistake(67);
		return(0);
	}

	kl = 1; l = 1;  matrsch = 0;
	while( kl > 0 && kl < 3 && *( s+l ) != '\0' )
	{       switch( *( s+l ) )
		{       case '{':  kl++;
				   break;
			case '}':  kl--;
				   break;
			case '=':  (*p)++;
				   break;
		}

		/*** Verdacht auf Matrix. ***/

		if( kl > 1 )    matrsch = 1;
		l++;
	}
	if( kl < 0 )
	{       mistake( 1 );
		return( 0 );
	}
	if( kl > 0 )
	{       mistake( 2 );
		return( 0 );
	}

	if( l == 1 )    /*** {} ***/
	{       mistake( 67 );
		return( 0 );
	}
	l--;

	/*** Verdacht auf Matrix. ***/

	if( matrsch )
	{       i = 1;
		zsch = 0;
		/*while( s[i] != '\0' )*/
		while( s[i] == ' ' ) i++;
		while( i < l )
		{       /***  Zeilenuntersuchung  ***/
			if( zsch && s[i] == '\0' )   break;
			if( s[i] != '{' )
			{       mistake( 67 );
				return( 0 );
			}
			i++; zl = 0; kl = 0; j = 0;
			while( s[i] != '}' )
			{       switch( s[i] )
				{       case '(': kl++;
						  el[j] = s[i];
						  i++; j++;
						  break;
					case ')': kl--;
						  el[j] = s[i];
						  i++; j++;
						  break;
					case ',': if( kl )
						  {     el[j] = s[i];
							i++; j++;
						  }
						  else
						  {     el[j] = '\0';
							j = 0;
							while( el[j] == ' ' && el[j] != '\0' ) j++;
							if( el[j] == '\0' )
							{       mistake( 68 );
								return( 0 );
							}
							/***  Elementuntersuchung  ***/
							f = error( el );
							if( !f ) 
							{
							  return( 0 );
							}
							zl++;
							kl = 0; j = 0;
							i++;
						  }
						  break;
					default:  el[j] = s[i];
						  i++; j++;
						  break;
				}
			}
			el[j] = '\0';
			j = 0;
			while( el[j] == ' ' && el[j] != '\0' ) j++;
			if( el[j] == '\0' )
			{       mistake( 68 );
				return( 0 );
			}
			/***  Elementuntersuchung  ***/
			f = error( el );
			if( !f ) 
			{
				return(0);
			}
			zl++;
			if( !zsch ) zsch = zl;
			else if( zsch != zl )
			{       mistake( 69 );
				return( 0 );
			}
			i++;
			while( s[i] == ' ' ) i++;
		}
	}
	else    /*** Verdacht auf Vektor        ***/
	{       i = 1; kl = 0; j = 0;
		while( i < l )
		/*while( s[i] != '\0' )*/
		{       switch( s[i] )
			{       case '(': kl++;
					  el[j] = s[i];
					  i++; j++;
					  break;
				case ')': kl--;
					  el[j] = s[i];
					  i++; j++;
					  break;
				case ',': if( kl )
					  {     el[j] = s[i];
						i++; j++;
					  }
					  else
					  {     el[j] = '\0';
						j = 0;
						while( el[j] == ' ' && el[j] != '\0' ) j++;
						if( el[j] == '\0' )
						{       mistake( 68 );
							return( 0 );
						}
						/***  Elementuntersuchung  ***/
						f = error( el );
						if( !f ) 
						{
							return( 0 );
						}
						kl = 0; j = 0;
						i++;
					  }
					  break;
				default:  el[j] = s[i];
					  i++; j++;
					  break;
			}
		}
		el[j] = '\0';
		j = 0;
		while( el[j] == ' ' && el[j] != '\0' ) j++;
		if( el[j] == '\0' )
		{       mistake( 68 );
			return( 0 );
		}
		/***  Elementuntersuchung  ***/
		f = error( el );
		if( !f ) 
		{
			return(0);
		}
	}
	l++;
	return( l );
}
