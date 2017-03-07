/*C
			inprog( string, pos )

	"is in string".
	single inprog(string,pos); char *string; list *pos;
	X = inprog( string, pos);

	Falls in der Zeichenkette string einer der Funktions-
	aufrufe if, while, dowhile, for, forstep oder forprime
	enthalten ist, so wird die Anzahl dieser Funktionsaufrufe
	an das aufrufende Programm zurueckgeliefert, andernfalls der 
	Funktionswert 0.
	*pos ist eine Liste mit den Positionen der Funktionsaufrufe
	in string.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      05.11.1993      S.Schmitt/U.Schneiders
H*/
/*cS
	inprog ruft auf: isalpha, lcomp, linv, strlen, strncmp

		   Macros:
Sc*/
 
#include <_list.h>

int inprog( string , pos )
char *string;
list *pos;

{       /*** Deklarationen und Vorbesetzungen ***/

	single j, k,i,erg;
	i=0;
	j = strlen( string );
	*pos=_0;
	erg=0;

	/*** Suche von fkt in string ***/

	while ( i <= j ) {

	/***   if   ***/

		if ( (j-i)>=2 && !strncmp( string+i,"if", 2 ) ) 
		{	k=i+2;
			if(!i || !isalpha(string[i-1]))
			{ 	while(*(string+k)!='\0' && *(string+k)==' ')
					k++;
				if(*(string+k)=='\0') 
				{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;	
		}

	/***   while   ***/

		if( (j-i)>=5 && !strncmp( string+i,"while",5) )
		{	k=i+5;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}

	/***   dowhile   ***/

		if( (j-i)>=7 && !strncmp( string+i,"dowhile",7) )
		{	k=i+7;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}

	/***   forstep   ***/

		if( (j-i)>=7 && !strncmp( string+i,"forstep",7) )
		{	k=i+7;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}
	
	/***   forprime   ***/

		if( (j-i)>=8 && !strncmp( string+i,"forprime",8) )
		{	k=i+8;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}
	
	/***   for   ***/

		if( (j-i)>=3 && !strncmp( string+i,"for",3) )
		{	k=i+3;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}

	/***   decl   ***/

		if( (j-i)>=4 && !strncmp( string+i,"decl",4) )
		{	k=i+4;
			if(!i || !isalpha(string[i-1]))
			{	while(*(string+k)!='\0' && *(string+k)==' ') 
					k++;
				if(*(string+k)=='\0')
			 	{	*pos=linv(*pos);
					return(erg);
				}
				if(*(string+k)=='(')
				{	erg++;
					*pos=lcomp(i,*pos);
					k++;
				}
			}
			i=k;
		}
		else ++i;
	}
	*pos=linv(*pos);
	return( erg );
}
