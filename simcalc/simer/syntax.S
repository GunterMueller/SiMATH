/*C
			syntax( s, p, fusch )

	"syntax test".
	X = syntax( s, p, fusch );
	char *s;
	single p, fusch;

	syntax untersucht den restlichen Eingabestring s, der p Gleich-
	heitszeichen enthaelt, auf syntaktische Fehler und unzulaessige
	Zeichen. Bei Verdacht auf Matrizen oder Vektoren wird ismatrvec
	aufgerufen. Falls die Eingabe s syntaktisch korrekt ist, wird 1, sonst
	0 zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.01.1988      C.Hollinger/U.Schneiders
	Version  2      26.09.1988      C.Hollinger/U.Schneiders
	Version  2.1    26.08.1991      U.Schneiders ( brackex MX300 )
	Version  3      31.12.1991      U.Schneiders ( Reelle Zahlen )
H*/

#include<_calc.h>

single syntax( s, p, fusch)
char *s;
single p, fusch;

{
	single i, j=0, k, kl, l, sch, z, z1, z2;
	single unsch=0, stpsch=0, r, rsch, big=0; 
	single progsch=0, progklam=0;
	single isb=0,pre, loc;

/****   wichtige Schalter:

	fusch		fusch=1 <-> in einer Funktion
	j		zaehlt die bisher ueberprueften Zeichen von s
	k		bei Namen: Stelle in localvar/varlist
	sch		sch=1, falls Name in localvar/varlist gefunden wurde
	z2		Laufindex fuer hilf (Name)
	unsch		_ - Schalter, pro _ ist ein = erlaubt  ????zusammen-
	stpsch		; - Schalter, pro ; ist ein = erlaubt  legen????????
	rsch		Reelle Zahlen, rsch=1 <-> .   rsch=2 <-> e/E
	big		big=1: sum oder prod, im 1.Argument ist ein = erlaubt
	progsch		=1: if, dowhile, while  =2: for, forstep, forprime
	progklam	zaehlt () bei progsch, bestimmt dadurch den string, der
zu dem jeweiligen Ausdruck gehoert.
	pre		Ergebnis von prechar
	loc		=1: Variable in localvar gefunden	****/

	char c, *s1, hilf[21];
	char arg[MAXL];
	s1 = s;

	/*** Ueberpruefen des Anfangs eines Ausdrucks ***/

	while ( *s == ' ' ) s += 1, ++j;

	if ( *s != '-' && !( isalnum( *s ) ) && *s != '(' && 
	     *s != '[' && *s != '@' && *s != '{' && *s != '.' ) 
	{       errm( 0, 0, s1, 0 );
		if ( ps ) ferrm( 0, 0, s1 );
		mistake( 254 );
		return( 0 );
	}
	if(*s == '(' )  isb=1;

	/*** Ueberpruefung sonstiger syntaktischer Fehler ***/

	z1 = 1; rsch = 0;
	while ( *s != '\0' ) {
		z = 0;
		while ( isdigit( *s ) ) {
			s += 1; ++j;
			l = j-1;
			while ( *s == ' ' ) {
				s += 1; ++j;

				/** Zahlen mit ' ' dazwischen **/

				if ( isdigit( *s ) ) {  
					errm( l, j, s1, 0 );
					if ( ps ) ferrm( l, j, s1 );
					return( 0 );
				}
			}
			z = 1;
		}
		if ( z || *s == '.' )     /** Folgezeichen einer Zahl **/
		{       

		/** Damit bei gethex auch nach einer Zahl ein Buchstabe
		    stehen kann, muss in dfolc auch ein Buchstabe
		    erlaubt sein. In funccl_htoi wird dann spaeter
		    getestet, ob es auch die richtigen Buchstaben sind. **/

			if(hilf!='\0' && !strcmp(hilf,"gethex")) j=(-j); 
			if ( !dfolc( *s, l, j, s1 ) ) return(0);
		        if(hilf!='\0' && !strcmp(hilf,"gethex")) j=(-j);

			/*** Verdacht auf reelle Zahl ***/

			if( *s == '.' ) 
			{       if( rsch || *(s+1) == '\0' )
				{       errm( l, j, s1, 0 );
					if ( ps ) ferrm( l, j, s1 );
					return( 0 );
				}
				rsch = 1;
				s = s+1; ++j;
				continue;       /** naechstes Zeichen **/
			}
			else if( (*s == 'e' || *s == 'E') && strcmp(hilf,"gethex") )
			{       if( rsch == 2 || *(s+1) == '\0' )
				{       errm( l, j, s1, 0 );
					if ( ps ) ferrm( l, j, s1 );
					return( 0 );
				}
				rsch = 2;
				while( *(s+1) == ' ' )
				{       s = s+1; ++j;
				}
				if( *(s+1) == '+' || *(s+1) == '-' )
				{       s = s+1; ++j;
				}
				s = s+1; ++j;
				while( *s == ' ' )
				{       s = s+1; ++j;
				}
				continue;	/** naechstes Zeichen **/
			}
			else    rsch = 0;	/** keine reelle Zahl **/

		}

		/** rsch = 0, sonst Fehler (nach . bzw. e/E keine Zahl) **/

		if( rsch )
		{       l = j-1;
			errm( l, j, s1, 0 );
			if ( ps ) ferrm( l, j, s1 );
			return( 0 );
		}

		z = 0;
		z2 = 0;

		/** Name einer Funktion, eines Polynoms, usw. @ gesondert wegen
		    Polynomsubstitution fuer @.**/

		if(*s == '@') 
		{	z2=1;
			while(*(s+z2)==' ') z2++;
			if(*(s+z2)=='(') 
			{	j=j+z2;
				s = s + z2;
				z=(-1);	/** Verdacht auf Polynomsubst. @ **/
			}
		}
		while ( isalpha( *s ) ) {
			if ( z2 < 21 )
			{
				hilf[ z2 ] = *s; ++z2;
			}
			s += 1; ++j;
			while ( isdigit( *s ) )
			{
				if ( z2 < 21 )
				{
					hilf[ z2 ] = *s; ++z2;
				}
				s += 1; ++j;
			}
			l = j-1;
			z = 1;
		}
		if ( z ) {
			if(z>0) while ( *s == ' ' ) s += 1, ++j;
			if ( z<0 || *s == '(' )
			{       if(progsch) progklam++;
				if ( z>0 && z2 == 21 )	/** Name zu lang **/
				{       mistake( 7 );
				        return ( 0 );
				}
				else
				{       if(z>0)
				 	{   hilf[ z2 ] = '\0';
					    sch = 0; fusch = 1; loc=0;

				/** Suche nach hilf in localvar und varlist **/

					    if(funktion)
					    {	k=invectloc(hilf);
						if(k!=ERROR) 
						{	sch=1;
							loc=1;
						}
					    }
					    if(!funktion || !loc)
					    {  k=1;
					       while ( !sch && k < MX && strlen(varlist[k].varname) )
					       {  if ( !strcmp(hilf, varlist[k].varname))
						       sch = 1;
					          k++;
					       }
					       if(k<=MXNUM && !sch) k++;
				            }
					    if(!loc && k>130 && k<137 && !progklam) progklam=1;	
					    if( !loc && k>130 && k<137 ) 
					    {	if( k < 134 ) progsch=1;  /** if, while, dowhile **/
					            else progsch = 2;         /**forstep, forprime, for **/
					    }
					    else if(!loc && (k==177 || k==178)) big=1;	/** sum, prod **/	

		/** print und decl (assch setzen, um 'neue' Funktionen
			zu ueberlesen) **/
					    else if(!loc && (k==164 || k==165)) 
					    {	if(k==164) /** print **/
						{	if(!assch) assch=2;
							sch=print_error(s,&kl);
							if(assch==2) assch=0;
						}
						else 	   /** decl **/
						{	i=assch;
							assch=1;
							sch=decl_error(s,&kl);
							assch=i;
						}
						if(sch<0) return(0);
						s=s+kl;
						j=j+kl;
						while ( *s == ' ' ) s += 1, ++j;
						p=p-sch;
						if(*s == '\0') return(1);
						sch = -1;
				            }

					/** Falscher Name **/

					    else if(sch && !loc && varlist[k-1].typ==3 && !SIEMENS)
					    { 	mistake( 5 );
						return( 0 );
					    }

					    if(!sch && !progsch && !assch)
					    {    mistake( 5 );
					         return ( 0 );
					    }  
					} /** Ende if(z>0). Hier auch Test fuer
					      Polsubst. fuer @ **/

		    			if ( z<0 || loc || k > MXNUM )
					/*** keine Standardfunktion ***/
					     {  kl = 1; 
						i=0;
						while( kl != 0 )
						{  j++;
						   switch( *(s+1) )
						   {    case '(': if(seven(i)) kl ++;
								  break;
							case ')': if(seven(i)) kl--;
								  break;
							case '"': if( *s != '\\')
								    i++;
								  break;
							default: break;
						   }
						   s+=1;
						   if ( *s == '=' ) p--;
						}
					    }
					     else if(sch!=(-1))  /* k <= MXNUM und sch = 1 */
					     { l = j;
					       while ( *(s+1) == ' ' ) s += 1, ++j;
					       if ( *(s+1) == '\0' ) {
					       errm( l, l, s1, 0 );
					       if ( ps ) ferrm( l, l, s1 );
					       return( 0 );
					       }
					       if( k!=95 && k!=98 && k!=100 && k!=168 && k!=224) 	/** discnf, intbas, unit, proot, classnum **/

					  /** Operator Folgezeichen **/

					       z1 = ofolc( *( s+1 ), l, j+1, s1 );
					       else
				               z1 = ofolc_ov( *(s+1),l, j+1, s1 );
					       s += 1; ++j;
					       if ( z1 == 0 ) return(0);

					       /*** Verdacht auf reelle Zahl ***/

					       if( *s == '.' )
					       {       if( rsch )
						       {       errm( l, j, s1, 0 );
							       if ( ps ) ferrm( l, j, s1 );
							       return( 0 );
						       }
						       rsch = 1;
						       s = s+1; ++j;
						       continue;
					       }

					    }
				}
			} /** Ende if(*s=='(') **/
			else if((strcmp(hilf,"fread") || !isdigit(*s)) && !alfolc( *s, l, j, s1 ) ) return( 0 );
		} /** Ende if(z), d.h. falls Ausdruck mit Buchstabe anfaengt **/
		c = *s;
		switch( c ) {
			case '@': l = j;
				  while ( *(s+1) == ' ' ) s += 1, ++j;
				  if ( !dfolc( *(s+1), l, j+1, s1 ) ) return( 0 );
				  s += 1; ++j;
				  break;
			case '>':
			case '<':
			case '&':
			case '|':
			case '_':
			case ';':
			case ',':
			case '[':
			case '^':
			case '+':
			case '*':
			case '/':
			case '-':
			case '=':
			case ':': l = j;
				  while ( *(s+1) == ' ' ) s += 1, ++j;
				  if ( *(s+1) == '\0' && c != ';' ) {
					errm( l, l, s1, 0 );
					if ( ps ) ferrm( l, l, s1 );
					return( 0 );
				  }
				  if( *(s+1) == '\0' && c==';')
				  {	s++;
					z1=1;
					break;
				  }
				  /*** um z.B. gcd(2_3,4) zu vermeiden ***/
				  if( !progsch && fusch && (c=='_' || (c==';' && *(s+1)!='\0')))	 
				  {	errm( l, l, s1, 0 );
					if ( ps ) ferrm( l, l, s1 );
					return( 0 );
				  }
				  if( fusch && ( c==';' || c=='_' ) ) fusch = 0;

				  if((progsch && c==',') || c=='_' || c== ';' ) isb=1;
				  if((c=='&' && *(s+1)!='&') || (c== '|' && *(s+1)!='|'))  
				  {	errm(l,l,s1, 0);
					if(ps) ferrm(l,l,s1);
					return(0);
				  }
				  if(c=='&' || c=='|' || ((c=='>' || c=='<' || c== '=') && *(s+1)== '=')) 
				  {	s++;
					j++;
					l=j;
				  	while ( *(s+1) == ' ' ) s += 1, ++j;
				  	if ( *(s+1) == '\0' ) {
						errm( l, l, s1, 0 );
						if ( ps ) ferrm( l, l, s1 );
						return( 0 );
					}
					if(c=='='&& progsch) p++;
				  }
		
				  if(c=='_' && !progsch) unsch++;
				  if(c==';' && !progsch) stpsch++;

				  if(c=='=' && progsch) p--;
				  if(c=='=' && big)
				  { 	p--;
					big=0;
				  }
				  if(c==',' && big) big=0;
				  if(c==',' && progsch && (*(s+1)==',' || *(s+1) == ')')) z1=1;
				  else if(c==';' && progsch && (*(s+1)==',' || *(s+1)==')' || *(s+1) == ';' || *(s+1) == '_' )) z1=1;
				  else if(c=='_' && progsch && (*(s+1)==';' || *(s+1)=='_')) z1=1;
				  else z1 = ofolc( *( s+1 ), l, j+1, s1 );
				  if(!z1) return(0);
				  s += 1; ++j;

				  /*** Verdacht auf reelle Zahl ***/

				  if( *s == '.' )
				  {       if( rsch )
					  {       errm( l, j, s1, 0 );
						  if ( ps ) ferrm( l, j, s1 );
						  return( 0 );
					  }
					  rsch = 1;
					  s = s+1; ++j;
					  continue;
				  }

				  break;
			case '(': l = j;
				  if(progsch) progklam++;
				  while ( *(s+1) == ' ' ) s += 1, ++j;
				  if ( *(s+1) == '\0' ) {
					errm( l, l, s1, 0 );
					if ( ps ) ferrm( l, l, s1 );
					return( 0 );
				  }
				  z1 = ofolc( *( s+1 ), l, j+1, s1 );
				  if(!z1) 
				  {
					return(0);
				  }	
				  s += 1;
				  r=strlen(arg);
				  for(i=0;i<r;i++) *(arg+i) = '\0';
				  brackex( s, arg );
				  r = strlen( arg );
				  for( i = 0; i <= r; i++ )
					if( *( arg+i ) == '=' )  
					{	pre=prechar(arg,i);
						if(pre == '=') p++;
					        else if(pre!='>' && pre!='<' && pre!='!') 
						{  p--;
						   if(progsch==2) isb=1;
						}
					}
				  j=j+r+1;
				  s=s+r;
				  while ( *(s+1) == ' ' ) s += 1, ++j;
			
				  if(!sofolc(*(s+1),l+r+1,j+1,s1)) return(0);


			/** (arg) ist eigener Ausdruck **/

				  if(isb && ((progsch &&(*(s+1)==',' || *(s+1)==')')) || *(s+1)=='\0' || *(s+1)==';' || *(s+1)=='_')) r=isbracor(arg,1);
	
			/** in arg darf kein '=' stehen **/

				  else r = isbracor( arg,0 );
				  s++; j++;
				  isb=0;
				  if( !r )    return( 0 );
				  break;
			case '{': /*** Verdacht auf Matrix oder Vektor. ***/
				  l = ismatrvec( s,&i );
				  if( !l ) return( 0 );
				  p = p - i;
				  s = s + l - 1;
				  j = j+l-1;
				  break;
			case '!': l=j;
				  while(*(s+1) == ' ') s++,j++;
				  if(*(s+1) == '\0' && p<2) return(1);
				  if(*(s+1) == '=')
				  {	s++;
					j++;
					l=j;
				  	while ( *(s+1) == ' ' ) s += 1, ++j;
				  	if ( *(s+1) == '\0' ) {
						errm( l, l, s1, 0 );
						if ( ps ) ferrm( l, l, s1 );
						return( 0 );
					}
					if(*(s+1) != '=')
				  	    z1 = ofolc( *( s+1 ), l, j+1, s1 );
					else z1=1;
				  }
				  else  z1 = sofolc(*(s+1),l,j+1,s1);
				  s++;
				  j++;
				  break;
			case ')':
			case ']': l = j;
				  if(progsch && c==')') progklam--;
				  if(progsch && !progklam) progsch=0;
				  while( *(s+1) == ' ' ) s += 1, ++j;
				  if ( *(s+1) == '\0' && p < 2 ) return( 1 );
				  if(*(s+1) == '=')
				  {	s++;
					j++;
					l=j;
					while(*(s+1) == ' ') s++;
					if( progsch && c == ']' && *(s+1) != '=' ) p--;
					if(*(s+1) == '\0' || (c==')' && *(s+1) != '=') )
					{  errm(l,l,s1, 0);
					   if(ps) ferrm(l,l,s1);
					   return(0);
					}	
					else z1=1;
					s+=1; 
					j++;
				  }
				  else if(c!=']' || *(s+1)!='(')
				  {	 z1 = sofolc( *( s+1 ), l, j+1, s1 );
					 s+=1;
					 j++;
				  }
	
	/** Polynomsubstitution oder benutzerdefinierte Funktion 
	    mit array **/

				  else 
				  { 	s += 2;
				  	r=strlen(arg);
				  	for(i=0;i<r;i++) *(arg+i) = '\0';
				  	brackex( s, arg );
				  	r = strlen( arg );
				  	for( i = 0; i <= r; i++ )
					   if( *( arg+i ) == '=' )  
					   {	pre=prechar(arg,i);
						if(pre == '=') p++;
					        else if(pre!='>' && pre!='<' && pre!='!') 
						{  p--;
						   if(progsch==2) isb=1;
						}
					   }
				  	j=j+r+2;
				  	s=s+r;
				  	while ( *(s+1) == ' ' ) s += 1, ++j;
					if(*s==' ') s+=1, j++;	
					fusch=0;
				  }
				  break;
			case '}': l = j;
				  while( *(s+1) == ' ' ) s += 1, ++j;
				  if ( *(s+1) == '\0' && p < 2 ) return( 1 );
				  z1 = matrfolc( *( s+1 ), l, j+1, s1 );
				  s += 1, ++j;
				  break;
		}
		if ( z1 == 0 ) return( 0 );  

	}
      if ( p >= 2 +unsch+stpsch )
      {    mistake( 8 );
	   return( 0 );
      }
      return( 1 );
}
