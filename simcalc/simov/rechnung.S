/*C
			rechnung( string, fkt, fktco, sch )

	"Rechnung".
	rechnung(string,fkt,fktco, sch); char *string; int (*fkt)(), (*fktco)(); single sch;
	rechnung( string, fkt, fktco, sch );

	Der auszuwertende Teil der Zeichenkette string wird bestimmt
	und ausgewertet.
	Falls dem Ergebnis eine Variable zugewiesen wird, so wird die
	Variablenverwaltung aktiviert. Wenn dies nicht der Fall ist, so
	wird das Ergebnis der Systemvariablen @ zugewiesen.
	Ferner wird untersucht, ob die Ausgabe des Ergebnisses unter-
	drueckt werden soll, oder ob nicht.
	Mit fkt und fktco werden die interrupt-Funktionen uebergeben.
	sch gibt an, ob mehrere Befehle in einer Eingabezeile stehen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
H*/
 
#include <_calc.h>
single sch1 = 0;

rechnung( string, fkt, fktco, sch )
char *string;
void (*fkt)(), (*fktco)();
single sch;

{       /*** Deklarationen und Vorbesetzungen ***/

	list c;
	int hi;
	char arg[ MAXL ]; 
	char name[27];
	single as,z=0, i=0, d=0, k, j, kl = 0, l, n=1, sch2=0;
	single loc=0;
	double fltoCfl();
	init(c,hi);
	*arg = '\0'; *name = '\0';
	sch1 = 0; 

	while( i < strlen(string) ) {

	/*** Erkennung von Variablennamen ***/

		if ( *(string+i) == '"')
		{	if(!i || *(string+i-1) != '\\')
				z++;
		}	
		if ( *(string+i) == '(' ) kl++;
		if ( *(string+i) == ')' ) kl--;
		if ( *(string+i) == '=' && ( kl == 0 ) ) {
		  j=prechar(string,i);
		  if(j != '!' && j != '>' && j != '<' && j != '=')
		  {	 j=i;
			 j++;
			 while(*(string+j) == ' ') j++;
			 if(*(string+j) != '=')
			 {	if(*(arg+d-1) == ']'){
				char arg2[MAXLV];
				*arg2 = '\0';
				l=0;
				while(*(arg+l)!='[') 
				{	if(!isalnum(*(arg+l)))
					{	mistake(5);
						if(fosch!=2) fosch=1;
						prfehl=1;
						return(ERROR);
					}
					l++;
				}
				if(l==2 && arg[0]==AVNAME[0] && arg[1]==AVNAME[1])
				{	mistake1(227,AVNAME);
					if(fosch!=2) fosch=1;
					prfehl=1;
					return(ERROR);
				}
				if(l>20)
				{	mistake(7);
					if(fosch!=2) fosch=1;
					prfehl=1;
					return(ERROR);
				}
				absvalex(arg+l+1, arg2);
				c=basad(arg2);
				if(c==ERROR || c==ERROR-1)
				{	if(c==ERROR-1) mistake(32);
					if(fosch!=2) fosch=1;
					if(!prfehl) prfehl=1;
					return(ERROR);
				}
				if( lsecond(c) || !isatom(lfirst(c)) || (c=lfirst(c))<0 || c>= 10000 )
				{	
					mistake(307);
					if(fosch!=2) fosch=1;
					prfehl=1;
					return(-BASIS);
				}
				for(j=l+1;j<d;j++) *(arg+j)='\0';
				sputi(c, arg+l+1);
				j=l+2;
				if(c>=10) j++;
				if(c>=100) j++;
				if(c>=1000) j++;
				*(arg+j)=']';
				*(arg+j+1) = '\0';
				strcpy(name, arg);
				k=0;
				if(funktion) 
				{	k=invectloc(name);
					if(k!=ERROR) loc=1;
				}
				if(!funktion || k==ERROR) k = invect(name);
				signal(SIGINT,fkt);
				signal(SIGQUIT,fktco);
				signal(SIGILL,fktco);
				signal(SIGTRAP,fktco);
				signal(SIGABRT,fktco);
#ifdef HAVE_SIGEMT
				signal(SIGEMT,fktco);
#endif
				signal(SIGFPE,fktco);
				signal(SIGBUS,fktco);
				signal(SIGSEGV,fktco);
#ifdef HAVE_SIGSYS
				signal(SIGSYS,fktco); 
#endif
				++i;
				break;
				}
				else {
		  		if ( d > 20 )
		  		{     mistake( 7 );
				      if(fosch!=2) fosch=1;
					prfehl=1;
					return( -BASIS );
		  		}
				if(d==2 && arg[0]==AVNAME[0] && arg[1]==AVNAME[1])
				{	mistake1(227,AVNAME);	
				        if(fosch!=2) fosch=1;
					prfehl=1;
					return( -BASIS );
		  		}

				*(arg+d) = '\0';
				strcpy( name, arg );
				l=0;
				while ( l < d ) {
			  	if ( !isalnum(*(name+l)) )
			  	{     mistake( 5 );
					if(fosch!=2) fosch=1;
					prfehl=1;
					return( -BASIS );
			  	}
			  	++l;
				}
				k=0;
				if(funktion) 
				{	k=invectloc(name);
					if(k!=ERROR) loc=1;
				}
				if(!funktion || k==ERROR) k=invect(name);

				signal(SIGINT,fkt);
				signal(SIGQUIT,fktco);
				signal(SIGILL,fktco);
				signal(SIGTRAP,fktco);
				signal(SIGABRT,fktco);
#ifdef HAVE_SIGEMT
				signal(SIGEMT,fktco);
#endif
				signal(SIGFPE,fktco);
				signal(SIGBUS,fktco);
				signal(SIGSEGV,fktco);
#ifdef HAVE_SIGSYS
				signal(SIGSYS,fktco);
#endif
				++i;
				break;
				}
			}
		  }
		}
		if ( sodd(z) || *(string+i) != ' ' ) *(arg+d) = *(string+i),++d;
		++i;
	}

	j=strlen(name);
	if(j)
	{	for(d=0;d<j;d++)  *(arg+d) = '\0';
		d=0;
	
		/*** Aufbau des auszuwertenden Strings ***/
		z=0;

		while( i < strlen(string) ) {
			if(*(string+i)=='"')
			{	if(!i || *(string+i-1)!= '\\') z++;
			}
			if ( sodd(z) || *(string+i) != ' ' ) *(arg+d) = *(string+i),++d;
			++i;
		}
	}
	

	/*** Soll Ausgabe unterdrueckt werden ? ***/

	as=assch;
	if ( *(arg+d-1) == ';' ) {
		assch = 1;
		*(arg+d-1) = '\0';
	}
	else *(arg+d) = '\0';

	/*** Auswertung des Eingabestrings und Variablenverwaltung ***/

	if ( !strcmp("DIGITS", name ) )
	{       
		c = basad( arg );
		if( c != -BASIS && c!= -BASIS-1 )       stellen( c );
		else 
		{	if(fosch!=2) fosch=1;
			if(!prfehl) prfehl=1;
			if( c== -BASIS-1 ) mistake(32);
		}
	}
	else if( !strcmp("OUTPUTDIG", name ) )
	{
		c = basad(arg);
		if(c!= -BASIS && c!= -BASIS-1)
		{	if(lsecond(c) || (c=lfirst(c))<0 || c>DIGITS)
			{	mistake(306);
				if(fosch!=2) fosch = 1;
				prfehl=1;
			}
			else 
			{	OUTPUTDIG = c;
				printf("%t OUTPUTDIG = %i\n", 8, OUTPUTDIG );
				if ( ps )
				fprintf( datei, "out: OUTPUTDIG = %i\n",OUTPUTDIG );
			}
		}
		else 
   		{	if(fosch!=2) fosch=1;
			if(!prfehl) prfehl=1;
			if( c== -BASIS-1 ) mistake(32);
		}
	}
	else if( !strcmp("DEPTH", name ) )
	{
		c = basad(arg);
		if(c!= -BASIS && c!= -BASIS-1)
		{	if(lsecond(c) || (c=lfirst(c))<=0 || !isatom(c))
			{	mistake(329);
				if(fosch!=2) fosch = 1;
				prfehl=1;
			}
			else 
			{	DEPTH = c;
				printf("%t DEPTH = %i\n", 8, DEPTH );
				if ( ps )
				fprintf( datei, "out: DEPTH = %i\n",DEPTH );
			}
		}
		else 
   		{	if(fosch!=2) fosch=1;
			if(!prfehl) prfehl=1;
			if( c== -BASIS-1 ) mistake(32);
		}
	}
	else if( !strcmp("HEIGHTBOUND", name ) )
	{
		c = basad(arg);
		if(c!= -BASIS && c!= -BASIS-1)
		{	k=lsecond(c);
			if(k && k!=1 && k!= 15)
			{	mistake(297);
				if(fosch!=2) fosch = 1;
				prfehl=1;
			}
			else 
			{	c = lfirst( c );
				if(!k)	c = itofl( c );
				else if( k==1 ) c = rtofl( c );
				hi = flfloor( c );
				hi = ilog2( hi );
				k = flsign( c );
				if( k == (-1) || hi > 1000 )
				{	mistake(297);
					if( fosch!=2 ) fosch = 1;
					prfehl = 1;
				}
				else
				{
					HEIGHTBOUND = c;
					_H_BOUND = fltoCfl( HEIGHTBOUND );
					printf("%t HEIGHTBOUND = ", 8 );
					if(!OUTPUTDIG) putfl( HEIGHTBOUND, -DIGITS );
/******** RAUS ********
					else yputflfx(HEIGHTBOUND, 1, OUTPUTDIG );
***********************/
					else putflfx(HEIGHTBOUND, 1, OUTPUTDIG );
					printf("\n");
					if( ps )
					{      fprintf( datei, "out: HEIGHTBOUND = ");
			       		       if(!OUTPUTDIG) fputfl( HEIGHTBOUND, -DIGITS, datei );
					       else fputflfx(HEIGHTBOUND, 1, OUTPUTDIG,datei);
					       fprintf( datei, "\n" );
					}
				}
			}
		}
		else 
   		{	if(fosch!=2) fosch=1;
			if(!prfehl) prfehl=1;
			if( c== -BASIS-1 ) mistake(32);
		}
	}
	else if( !strcmp("LINELN", name ) )
	{
		c = basad(arg);
		if(c!= -BASIS && c!= -BASIS-1)
		{	if(lsecond(c) || (c=lfirst(c))<=0 || !isatom(c))
			{	mistake(142);
				if(fosch!=2) fosch = 1;
				prfehl=1;
			}
			else 
			{	LN_SIZE=c;
				printf("%t LINELN = %i\n", 8, LN_SIZE );
				if ( ps )
				fprintf( datei, "out: LINELN = %i\n",LN_SIZE );
			}
		}
		else 
   		{	if(fosch!=2) fosch=1;
			if(!prfehl) prfehl=1;
			if( c== -BASIS-1 ) mistake(32);
		}
	}
	else
	{       if ( strlen( name ) > 0 )
		{       if( k == MX )
			{       k = 1;
				while( k<MX && strlen(varlist[k].varname) )
					++k;
				if( k == MX )
				{       sch2=1;
					k = loesche( name );
				}
				while( k < -1 ) k = loesche( name );
			}
			if ( k > -1 )
		        {       if(!loc && !sch2){ if( !strlen( varlist[k].varname ) ) varlist[k].varwert = -BASIS;
				strcpy( varlist[k].varname, name );
				}
				c = basad( arg );
				if ( c != -BASIS && c != -BASIS-1 )
				{    if ( sch2 == 0 )
				     {    if(!loc){
					  strcpy( varlist[k].varname, name );
					  if(varlist[k].typ==2 || varlist[k].typ==(-3 ))
					  {	j=varlist[k].varwert;
					        i=strlen(funstr[j]);
						for(d=0;d<i;d++) funstr[j][d]='\0';
						free(funstr[j]);
						funstr[j]=malloc(5); 
						funstr[j][0]='\0';
						varlist[k].typ=0;
					  }
					  varlist[k].varwert = c;
					  if(schleife==1) varlist[k].typ = (-1);
					  if(as==2)  varlist[k].typ = (-2);
				          }
					  else{   
					  if(localvar[k].typ==2 || localvar[k].typ==(-3))
					  {	j=localvar[k].varwert;
						i=strlen(funstr[j]);
						for(d=0;d<i;d++) funstr[j][d]='\0';
						free(funstr[j]);
						funstr[j]=malloc(5);
						funstr[j][0]='\0';
						localvar[k].typ=0;
					  }
					  localvar[k].varwert=c;
					  if(schleife==1) localvar[k].typ=(-1); 
					  if(as==2)  localvar[k].typ=(-2);
					  }
					  sch1 = 1;
					  if ( !assch ) ausgabe ( arg, name, c, sch );
					  if(!schleife && assch<2 && !funktion)
					  {  tdiff = settime(); 
					     tabs+=tdiff;
					  }
					  if ( statsch ) statistic(tdiff);
				     }
				else
				{    while ( strcmp( "\0", varlist[n].varname ) )++n;
				     strcpy( varlist[n].varname, name );
				     if(varlist[n].typ==2 || varlist[k].typ==(-3))
				     {	j=varlist[n].varwert;
					i=strlen(funstr[j]);
					for(d=0;d<i;d++) funstr[j][d]='\0';
					free(funstr[j]);
					funstr[j]=malloc(5);
					funstr[j][0]='\0';
					varlist[n].typ=0;
				     }
				     varlist[n].varwert = c;
				     if(schleife==1) varlist[n].typ = (-1);
				     if(as==2) varlist[n].typ = (-2);
				     sch1 = 1;
				     if ( !assch ) ausgabe ( arg, name, c, sch );
				     if(!schleife && assch<2 && !funktion)
				     {   tdiff = settime(); 
  					 tabs+=tdiff;
				     }
				     if ( statsch ) statistic(tdiff);
				}
			   }
			   else if(c==-BASIS)
			   {    if(!loc && varlist[k].varwert == ERROR )
				{	strcpy( varlist[k].varname, "\0" );
					varlist[k].varwert = 0;
				}
				if(fosch!=2) fosch=1;
				if(!prfehl) prfehl=1;
				if( !loc && varlist[k].typ != 2 && varlist[k].typ!=(-3) ) varlist[k].typ=0;
				if(!loc) structsort();
			   }
			   else
			   {	if(!loc && varlist[k].varwert == ERROR )
				{	strcpy(varlist[k].varname, "\0");
					varlist[k].varwert = 0;
				}
				if(fosch!=2) fosch = 1;
				prfehl=1;
				if( !loc && varlist[k].typ != 2 && varlist[k].typ!=(-3) ) varlist[k].typ=0;
				if(!loc) structsort();
				mistake(32);
			   }
			}
		       if ( k == -1 )
		       {        
				c = basad( arg );
				if ( c != -BASIS && c != -BASIS-1 )
				{    strcpy( varlist[0].varname, "@" );
				     varlist[0].varwert = c;
				     if(schleife==1) varlist[0].typ = (-1);
				     if(as==2) varlist[0].typ = (-2);
				     sch1 = 1;
				     if ( !assch ) ausgabe ( arg, "@", c, sch );
				     if(!schleife && assch<2 && !funktion)
				     {  tdiff = settime(); 
					tabs+=tdiff;
				     }
				     if ( statsch ) statistic(tdiff);
				}
				else  if(c==-BASIS)
				{	varlist[0].typ = 0;
					if(fosch!=2) fosch=1;
					if(!prfehl) prfehl=1;
				}
				else 
				{	if(as==2)
					{	mistake(32);
						prfehl=1;
					}
					varlist[0].typ=0;
				}
			}
		}
		else
		{       
			c = basad( arg );
			if ( c != -BASIS && c != -BASIS-1 )
			{       strcpy( varlist[0].varname, "@" );
				varlist[0].varwert = c;
				if(schleife==1) varlist[0].typ = (-1);
				if(as==2) varlist[0].typ = (-2);
				sch1 = 1;
				if ( !assch ) ausgabe ( arg, "@", c, sch );
				if(!schleife && assch<2 && !funktion)
				{	tdiff = settime(); 
					tabs+=tdiff;
				}
				if ( statsch ) statistic(tdiff);
			}
			else if(c==-BASIS)
			{	varlist[0].typ = 0;
				if(fosch!=2) fosch=1;
				if(!prfehl) prfehl=1;
			}
			else 
			{	if(as==2)
				{	mistake(32);
					prfehl=1;
				}
				varlist[0].typ=0;
			}
		}
	}
	assch=as;
}
