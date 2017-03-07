/*C
			einzinf( arg )

	"Einzelinformationen"
	einzinf(arg); char *arg;
	einzinf( arg );

	Das Programm liefert Informationen zu Operatoren, Variablen
	und Funktionsaufrufen, die auf stdout geschrieben werden.
	Fehlermeldungen und Informationen zu Variablen werden
	auch auf Protokolldatei geschrieben, falls eine solche
	Datei angelegt wurde.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      12.05.1987      M.Mang
	Version  2      16.06.1988      C.Hollinger/U.Schneiders
	Version  2.1     5.08.1988      C.Hollinger
	Version  3      23.12.1991      U.Schneiders ( SM_HOME )
	Version  3.1    07.01.1993      U.Schneiders (scr_page fuer MX)
H*/

#include <_calc.h>

einzinf ( arg )
char *arg;

{       /*** Deklarationen und Vorbesetzungen ***/

	char c, h[80], s[80];
	single i=0, j, l=0, sch=0;
	c = *arg;
	*h = '\0'; *s = '\0';

	/*** Vorbesetzung von s ***/

	strcat2( h, SM_HOME, "/calcul/" );

	if ( isdigit(c) || c=='\0' || issc(c) )
	{       switch( c )
		{       case '%': arg = "help.text/h.proz";
				  strcat2( s, h, arg );
				  scr_page( s );
				  break;
			case '$': arg = "help.text/h.shell";
				  strcat2( s, h, arg );
				  scr_page( s );
				  break;
			case '&': if(*(arg+1)!='&')
				  {
					arg++;
					while(*arg == ' ') arg++;
					if(*arg != '\0')
				  	{   printf(" Check your input!\n\n");
		   		      	    if ( ps )
		   		      		fprintf(datei,"out: Check your input!\n");
					    break;
				  	}
								
				  	arg = "calc.intro";
				  	strcat2( s, h, arg );
				  	scr_page( s );
				  }
				  else
				  {	arg = "help.text/h.and";
					strcat2(s,h,arg);
					scr_page(s);
				  }
				  break;
			case '|': if(*(arg+1) != '|')
				  {   printf(" Check your input!\n\n");
		   		      if ( ps )
		   		      fprintf(datei,"out: Check your input!\n");
				  }
				  else
				  {   arg = "help.text/h.or";
				      strcat2(s,h,arg);
				      scr_page(s);
				  }
				  break;
			case '<': if(*(arg+1) != '=')
				  	arg = "help.text/h.le";
				  else  arg = "help.text/h.leq";
				  strcat2(s,h,arg);
				  scr_page(s);
				  break;
			case '>': if(*(arg+1) != '=' )
					arg = "help.text/h.ge";
				  else arg = "help.text/h.geq";
				  strcat2(s,h,arg);
				  scr_page(s);
				  break;
			default:
		   printf(" Check your input!\n\n");
		   if ( ps )
		   fprintf(datei,"out: Check your input!\n");
		   break;
		}
	}
	else

	/*** Einzelinformationen zu Operatorzeichen ***/

	{ 
		strcat2( h, SM_HOME, "/calcul/help.text/h." );
		if ( isop(c) || ( c == '[' ) )
		{       sch = 1;
			switch (c)
			{       case '-' : arg = "sub"; break;
				case '+' : arg = "add"; break;
				case '*' : arg = "mul"; break;
				case '/' : arg = "div"; break;
				case ':' : arg = "gdiv"; break;
				case '!' : if(*(arg+1) != '=')
						arg = "faku"; 
					   else arg = "nequ";
					   break;
				case '^' : arg = "ex"; break;
				case '[' : arg = "bet"; break;
				case '=' : if(*(arg+1) != '=')
					   { 	printf(" Check your input!\n\n");
		   				if ( ps )
		   				fprintf(datei,"out: Check your input!\n");
						sch = (-1);
					   }
					   else arg = "equ";
					   break;
				default : sch = 0;
					  break;
			}
			if( sch == 1 )
		   	{ 
			     strcat2( s,  h, arg );
			     scr_page( s );
			}
		}
		if ( !strcmp( arg, "NEW" ) )
		{       strcat2( s,  h, arg );
			scr_page( s );
		}
		else if ( !strcmp( arg, "DIGITS" ) )
		{       printf("%t DIGITS = %i\n", 8, DIGITS );
			if ( ps ) fprintf( datei, "out: DIGITS = %i\n", DIGITS );
		}
		else if ( !strcmp( arg, "OUTPUTDIG" ) )
		{       printf("%t OUTPUTDIG = %i\n", 8, OUTPUTDIG );
			if ( ps ) fprintf( datei, "out: OUTPUTDIG = %i\n", OUTPUTDIG );
		}
		else if ( !strcmp( arg, "DEPTH" ) )
		{       printf("%t DEPTH = %i\n", 8, DEPTH );
			if ( ps ) fprintf( datei, "out: DEPTH = %i\n", DEPTH );
		}
		else if ( !strcmp( arg, "HEIGHTBOUND" ) )
		{       printf("%t HEIGHTBOUND = ", 8 );
			if(!OUTPUTDIG) putfl( HEIGHTBOUND, -DIGITS );
/******* RAUS ******
			else yputflfx(HEIGHTBOUND, 1, OUTPUTDIG );
********************/
			else putflfx(HEIGHTBOUND, 1, OUTPUTDIG );
			printf("\n");
			if( ps )
			{      fprintf( datei, "out: HEIGHTBOUND = ");
			       if(!OUTPUTDIG) fputfl( HEIGHTBOUND, -DIGITS, datei );
				else fputflfx(HEIGHTBOUND, 1, OUTPUTDIG,datei);
				fprintf( datei, "\n" );
			}
		}
		else if ( !strcmp( arg, "LINELN" ) )
		{       printf("%t LINELN = %i\n", 8, LN_SIZE );
			if ( ps ) fprintf( datei, "out: LINELN = %i\n", LN_SIZE );
		}
		else if( strlen(arg)>=2 && arg[0]==AVNAME[0] && arg[1]==AVNAME[1]
		    && ( strlen(arg)==2 || arg[2]=='[' ) )
		{	if( strlen(arg)==2 )
			{ printf(" Check your input!\n\n");
		          if ( ps )
		          fprintf(datei,"out: Check your input!\n");
			}	
			else
			{  j = 3;
			   while( arg[j]!=']' )
			   {	i = 10*i + arg[j] - 48;
		 		j++;
			   }
			   if( i>= AVLENGTH || strlen(arg)>(j+1) )
			   { printf(" Check your input!\n\n");
		             if ( ps )
		             fprintf(datei,"out: Check your input!\n");
			   }	
			   else if( !AV[i] )
			   {  printf (" %s not yet used.\n",arg);
			      if ( ps )
			      fprintf(datei,"out: %s not yet used.\n",arg);
			   }
			   else ausgabe( "", arg, AV[i], 0 );
			}
		}
			   
		else if ( !sch )

	/*** Einzelinformationen zu Variablen und Funktionsaufrufen ***/

		{       while ( l<MX && strcmp( arg,varlist[l].varname ) ) ++l;
			if ( l == MX)
			{       printf (" %s not yet used.\n",arg);
				if ( ps )
				  fprintf(datei,"out: %s not yet used.\n",arg);
			}
			else
			{       if( varlist[l].typ == 3 && !SIEMENS )
				{       printf (" %s not used.\n",arg);
					if ( ps )
				  	 fprintf(datei,"out: %s not used.\n",arg);
				}
				else if(varlist[l].typ==1 || varlist[l].typ==3)
				{       
					strcat2( s, h, arg );
					scr_page( s );
					if( ps && !strcmp( "log", arg ) )
					printf("\n\n        The current log file is %s.\n", datn);
					if( !ps && !strcmp( "log",arg ) )
					       printf("\n\n        No log file opened.\n");
				}
				else if(varlist[l].typ<=0) ausgabe ( "", arg,varlist[l].varwert, 0 );
				else  ausgfunc(varlist[l].varname, varlist[l].varwert);
			}
		}
	}
}
