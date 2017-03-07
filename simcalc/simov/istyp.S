/*C
			istyp( hilf, arg, erk, prio, laenge )

	"is of type".
	int istyp(hilf,arg,erk,prio,laenge); 
			int *erk, *prio, *laenge; char hilf, *arg;
	X = istyp( hilf, arg, erk, prio, laenge );

	istyp erkennt, ob am Anfang des Strings arg eine Klammer,
	eine Zahl, eine Variable, ein Operator, eine Matrix, ein
	Vektor oder Funktionsaufruf steht und liefert den entspre-
	chenden Teilstring mit Erkennung erk, Prioritaet prio und
	Laenge laenge an die Kellerverwaltung zurueck. Um unaere
	und binaere Minuszeichen unterscheiden zu koennen wird das
	Zeichen hilf benoetigt.
	Laeuft istyp fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1.1    11.05.1987      H.Stroeher/M.Mang
	Version  1.2    24.01.1989      C.Hollinger/U.Schneiders
	Version  1.3    22.08.1991      U.Schneiders  ( char c )
	Version  2      14.01.1992      U.Schneiders  ( Reeller Zahlen )
	Version  3	22.10.1993	S.Schmitt/U.Schneiders (neue Prioritaeten)
H*/
/*cS
	istyp ruft auf:  flreads, instring, ireads, isminus, lcomp,
			 linv, mistake, strncpy
		Macros:  isalnum, isalpha, isdigit
Sc*/

#include <_calc.h>

int istyp( hilf, arg, erk, prio, laenge )
char hilf, *arg;
int *erk, *prio, *laenge;

{       /*** Deklarationen und Vorbesetzungen ***/

	int zw;
	list H;
	char c;
	single j=0, i=1, d=0, k=MAXL, rsch=0, kb;
	init( H, zw );
	*laenge = 1;
	*erk = 10;
	*prio = -10;
	c = *arg;

	/*** Erkennung und Unterscheidung von Minuszeichen und
	     Prioritaetsverteilung ***/

	switch( c )
	{       case '-': c = isminus( hilf );
			  if( c == '#' )  *prio = 7;
			  else            *prio = 5;
			  break;
	      /*** Erkennung von Operatorzeichen und Prioritaetsverteilung ***/

		case '^': *prio = 8;
			  break;
		case '*':
		case '/':
		case ':': *prio = 6;
			  break;
		case '+': *prio = 5;
			  break;
		case '!': if(*(arg+1) != '=')
			  {	*prio = 0;
			  	*erk = 14;
			  }
			  else
			  {	*prio=3;
				*laenge=2;
				c='_';
			  }
			  break;
		case '<':
		case '>': *prio=4;
			  if(*(arg+1) == '=') 
			  {	*laenge=2;
				if(c=='<') c='$';
				else c='%';
			  }
			  break;
		case '=': *prio=3;
			  *laenge=2;
			  c='~';
			  break;
		case '&': *prio=2;
			  *laenge=2;
			  break;
		case '|': *prio=1;
			  *laenge=2;
			  break;
		case '[': *prio = 9;
			  *erk = 16;
			  break;
		case '(': *prio = 10;
			  *erk = 15;
			  break;
		case '{': *prio = 0;
			  i = 1;
			  while( *(arg + i) == ' ' )    i++;
			  if( *(arg + i ) == '{' )      *erk = 35;
			  else    /*** Vektor ***/
				*erk = 40;
			  break;
		case '@': i = 1;
			  while( *(arg + i) == ' ' )    i++;
			  if( *(arg + i ) == '(' )      
			  {	*prio = 10;
				*erk = 30;
			  }
			  else
			  {	*prio = 0;
			  	*erk = 25;
			  }
			  break;
		case 'O': if( !isalnum( *( arg+i ) ) && *(arg+i)!='[')
			  {     *prio = 0;
				*erk = 45;
			  }
			  break;
		case 'P': if(*(arg+i)=='i' && !isalnum( *(arg+i+1))&& *(arg+i+1)!='[')
			  {	*prio= 0;
				*erk = 46;
				*laenge = 2;
			  }
			  break;
 		case 'i':
       		case 'I': if( !isalnum( *(arg+i) ) && *(arg+i)!='[')
			  {	*prio = 0;
				*erk = 47;
			  }
			  break;
		default: break;
	}
	if ( c == ',' )
	{       mistake( 27 );
		return( -BASIS );
	}
	if ( *prio != -10 ) {
		return( c );
	}
	else {
		char zk[MAXL],arg2[MAXL];
		*zk='\0'; *arg2='\0';

	/*** Erkennung von Zahlen ***/

		i = 0;
		if( isdigit( *arg ) || *arg == '.' )
		{       while( isdigit( *(arg+i) ) || *(arg+i) == '.' || *(arg+i) == 'e' || *(arg+i) == 'E' )
			{       if( *(arg+i) == '.' ) rsch = 1;
				else if( *(arg+i) == 'e' || *(arg+i) == 'E' )
				{       rsch = 1;
					if( *(arg+i+1) == '+' || *(arg+i+1) == '-' )
					{       *(zk+i) = *(arg+i);
						i++;
					}
				}
				*(zk+i) = *(arg+i);
				i++;
			}
			if( i )
			{       *(zk+i) = '\0';
				if( !rsch )
				{       zw = ireads( zk );
					*prio = 0; *erk = 20;
				}
				else
				{       zw = flreads( zk );
					if( zw == ERROR ) 
					{
						return( ERROR );
					}
					*prio = 0; *erk = 21;
				}
				*laenge = i;
				return( zw );
			}
		}

	/*** Erkennung von Variablen, Funktionsaufrufen und
	     des Operators 'mod' ***/

		if( strcmp( arg, "curmod" ) && !instring( arg, "curmod(", &k ) && strcmp( arg, "modfunc" ) && instring( arg, "mod", &k ) ) {
			if ( k == 0 ) {
			   if ( !strncmp( arg+3, "mod", 3 ) ) {
				mistake( 26 );
				return( -BASIS );
			   }
			   else {
				*erk = 13;
				*prio = 6;
				*laenge = 3;
				return( c );
			   }
			}
		}
		else k=MAXL;
		while ( c !='\0' && isalpha( c ) && i <= k ) {
			c = *( arg + i );
			++i;
			while ( isdigit( c ) ) {
				c = *( arg + i );
				++i;
			}
			if(c=='[')
			{	
			  	absvalex( arg+i, arg2 );
				H=_0;
			  	H = basad( arg2 );
			  	if ( H == -BASIS || H == -BASIS-1 ) 
			  	{       if( H == -BASIS-1 ) mistake(32);
					return( ERROR );
			  	}
			  	j = lsecond( H );
			  	if( j || !isatom(lfirst(H)) || (H=lfirst(H))<0 || H>=10000 )
				{	
					mistake(307);
					return( ERROR );
				}
				j=strlen(arg2);
				/** i++; 
				c= *(arg+i+j); **/
				i = i+j+1;
				c = *(arg+i);
				if(i==k) break;
			}
		}
		i = i-j;
		strncpy( zk, arg, i-1 );
		if(j)
		{	sputi(H, zk+i-1); 
			if(H>=10) i++, j--;
			if(H>=100) i++, j--;
			if(H>=1000) i++, j--;
			*(zk+i)=']';
			*(zk+i+1)='\0';
			i=i+j+1;
		}
		else *( zk+i-1 ) = '\0';
		if(!strcmp(zk,"DIGITS") )
		{
			*laenge = i-1;
			*prio = 0;
			*erk = 18;
			return(0);	
	        }
		if(!strcmp(zk,"OUTPUTDIG"))
		{
			*laenge = i-1;
			*prio = 0;
			*erk= 19;
			return(0);
		}
		if(!strcmp(zk,"DEPTH"))
		{
			*laenge = i-1;
			*prio = 0;
			*erk= 17;
			return(0);
		}
		if(!strcmp(zk,"HEIGHTBOUND"))
		{
			*laenge = i-1;
			*prio = 0;
			*erk= 22;
			return(0);
		}
		if(!strcmp(zk,"LINELN"))
		{
			*laenge = i-1;
			*prio = 0;
			*erk= 23;
			return(0);
		}
		if ( c == '(' ) {
			*prio = 10;
			*erk = 30;
		}
		else {
			*prio = 0;
			*erk = 25;
		}
		*laenge = i-1;
		zw = _0;
		bind( zw );
		while ( *( zk + d ) != '\0' ) {
			zw = lcomp( *( zk + d ),zw );
			++d;
		}
		zw = linv( zw );
		return( zw );
	}
}
