/*C
			ispolsubst( arg, kom )

	"is polynomial substitution".
	X =  ispolsubst( arg, kom );
	char * arg;
	single kom;

	Der in arg befindliche Eingabestring mit kom Kommata wird
	hinsichtlich seiner Kommastruktur auf syntaktische Korrektheit
	untersucht. Dabei wird der zwischen einem Gleichheitszeichen
	und einem Komma bzw. einer schliessenden Klammer befindliche
	string hilf wiederum mit syntax untersucht.
	ispolsubst liefert 1, falls arg syntaktisch korrekt ist, 0
	sonst.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.01.1988       C.Hollinger/U.Schneiders
H*/
/*cS
	ispolsubst ruft auf: isalnum, isalpha, syntax
Sc*/
 
#include<_calc.h>

single ispolsubst( arg,kom )
char *arg;
single kom;

{
	single erg, h, i, indg, indk, k, kl ,kl1, klm, pos ,sch, sch1,j;
	char aid[ MAXL ], hilf[ MAXL ];
	sch = 1; sch1 = 1;

	while( kom > 0 )
	{       k = 0;
		while( *(arg+k) != '\0')
		{	if(*(arg+k) == '=')
			{ 	i=prechar(arg,k);
				if(i=='!' || i== '<' || i== '>' || i== '=')  k++;
				else
				{	j=k;
					j++;
					while(*(arg+j) == ' ') j++;
					if(*(arg+j) != '=') break;	
					k=j;
					k++;
				}
			}
			else k++;
		}	
		if ( *( arg+k ) == '\0' )
		{       mistake( 3 );
			return( 0 );
		}

		/*** Bestimmung der zugehoerigen Kommastelle. ***/

		pos = 0;
		kl = 0; klm = 0; 
		while( kl != 0 || klm != 0 || *( arg+pos )!= ',' )
		{       switch( *(arg+pos) )
			{       case '(': kl++;
					  break;
				case ')': kl--;
					  break;
				case '{': klm++;
					  break;
				case '}': klm--;
					  break;
			}
			pos++;
		}
		indk = pos;
		indg = k;
		if ( indg > indk )
		{       mistake( 3 );
			return( 0 );
		}

       /* Vorausgehende Blanks werden ueberlesen. */

		k = 0;
		while (k < indg && *(arg + k) == ' ' ) k++;
		if ( k == indg )
		{       mistake( 4 );
			return( 0 );
		}
		if ( sch1 && isalpha( *( arg + k ) ) )
		{       k++;
			while ( k < indg && isalnum( *( arg + k ) ) ) k++;
			while ( k < indg && *( arg + k ) == ' ' ) k++;

	/* Erstes nicht-alphanumerisches Zeichen und nicht Blank */

			if ( k < indg ) sch = 0;
		}
		else sch = 0;
		if ( ( sch == 0 ) || ( sch1 == 0 ) )
		{       mistake( 5 );
			return( 0 );
		}
		k++;    /* direkt hinter = */
		h = 0;
		while( k < indk )
		{       hilf[ h ] = *( arg+k );
			h++;k++;
		}
		hilf[ h ] = '\0';
		h = -1;
		while( h == -1 || hilf[ h ] != '\0' )
		{       i = 0;
			h++;
			kl1 = 0; klm = 0; 
			while( kl1 || klm || hilf[ h ] != '\0' )
			{       if(hilf[h] == '=')
				{	pos=prechar(hilf,h);
					if(pos == '!' || pos == '>' || pos == '<' || pos == '=')
					{	aid[i]=hilf[h];
						h++;i++;
					}
					else
					{	j=h;
						j++;
						while(hilf[j]==' ') j++;
						if(!kl1 && !klm && hilf[j] != '=') break;
						aid[i]=hilf[h];
						h++;
						i++;
					}
				}
				else
				{ 	switch( hilf[h] )
					{  case '(': kl1++;
						     break;
					   case ')': kl1--;
						     break;
					   case '{': klm++;
						     break;
					   case '}': klm--;
						     break;
					}
					aid[ i ] = hilf[ h ];
					h++;i++;
				}
			}
			if( !i )
			{       mistake( 6 );
				return( 0 );
			}
			aid[ i ] = '\0';
			erg = syntax( aid, 0, 1 );
			if ( !erg )
			{        mistake( 3 );
				 return( 0 );
			}
		}
		kom--;
		arg = arg+k+1;
	}
	if ( kom == 0 )
	{       k = 0;
		while( *(arg+k) != '\0')
		{	if(*(arg+k) == '=')
			{ 	i=prechar(arg,k);
				if(i=='!' || i== '<' || i== '>' || i== '=')  k++;
				else
				{	j=k;
					j++;
					while(*(arg+j) == ' ') j++;
					if(*(arg+j) != '=') break;	
					k=j;
					k++;
				}
			}
			else k++;
		}	
		if ( *( arg+k ) == '\0' )
		{       mistake( 3 );
			return( 0 );
		}
		indg = k;

       /* Vorausgehende Blanks werden ueberlesen. */

		k = 0;
		while (k < indg && *(arg + k) == ' ' ) k++;
		if ( k == indg )
		{       mistake( 4 );
			return( 0 );
		}
		if ( sch1 && isalpha( *( arg + k ) ) )
		{       k++;
			while ( k < indg && isalnum( *( arg + k ) ) ) k++;
			while ( k < indg && *( arg + k ) == ' ' ) k++;

	/* Erstes nicht-alphanumerisches Zeichen und nicht Blank */

			if ( k < indg ) sch = 0;
		}
		else sch = 0;
		if ( ( sch == 0 ) || ( sch1 == 0 ) )
		{       mistake( 5 );
			return( 0 );
		}
		k++;    /* direkt hinter = */
		h = 0;
		while( *( arg+k ) != '\0' )
		{       hilf[ h ] = *( arg+k );
			h++;k++;
		}
		h--;
		hilf[ h ] = '\0';
		h = -1;
		while( h == -1 || hilf[ h ] != '\0' )
		{       i = 0;
			h++;
			kl1 = 0; klm = 0;
			while( kl1 || klm || hilf[ h ] != '\0' )
			{       if(hilf[h] == '=')
				{	pos=prechar(hilf,h);
					if(pos == '!' || pos == '>' || pos == '<' || pos == '=')
					{	aid[i]=hilf[h];
						h++;i++;
					}
					else
					{	j=h;
						j++;
						while(hilf[j]==' ') j++;
						if(!kl1 && !klm && hilf[j] != '=') break;
						aid[i]=hilf[h];
						h++;
						i++;
					}
				}
				else
				{ 	switch( hilf[h] )
					{  case '(': kl1++;
					  	     break;
					   case ')': kl1--;
					  	     break;
					   case '{': klm++;
						     break;
					   case '}': klm--;
						     break;
					}
					aid[ i ] = hilf[ h ];
					h++;i++;
				}
			}
			if( !i )
			{       mistake( 6 );
				return( 0 );
			}
			aid[ i ] = '\0';
			erg = syntax( aid, 0, 1 );
			if ( !erg )
			{        mistake( 3 );  /*Hier doppelte Fehlermeld.*/
				 return( 0 );
			}
		}
	}
	return( 1 );
}
