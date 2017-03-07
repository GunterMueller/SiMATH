/*C
			invect( name )

	"is in vector".    (rekursiv)
	single invect(name); char *name;
	i = invect( name );

	Das Programm ueberprueft, ob der Variablenname name ein Funk-
	tionsname, ein bereits benutzter Variablenname oder eine Un-
	bestimmte eines Polynoms ist. Gilt Letzteres, so muss der Be-
	nutzer einen neuen Variablennamen angeben. Sonst wird ihm die
	Moeglichkeit gegeben, bereits benutzte Variablen zu ueberschrei-
	eiben oder eine neue Variable anzulegen. Dabei gibt der Wert
	i die Stelle im aktuellen Variablenspeicher an, an der ein neu-
	er Eintrag vorgenommen werden soll.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  2      10.01.1990      U.Schneiders ( MX- AS- Version )
	Version  2.1    23.12.1991      U.Schneiders ( SM_HOME )
	Version  2.2    25.05.1992      U.Schneiders
	Version  2.3    07.01.1993      U.Schneiders (scr_page fuer MX)
	Version  2.4    12.07.1993      U.Schneiders
	Version  2.5    29.11.1994      S.Schmitt/U.Schneiders (isatty)
	Version  2.6    25.04.1995      S.Schmitt/U.Schneiders (AV)
H*/

# include <_calc.h>


int invect(name)
char *name;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=0, n=0, sch;
	list V;
	char c, *getline();
	char hname[27];
	char *an;
	init( V );
	an = malloc(MAXLV);
        *an = '\0';
	*hname = '\0';

        

	/*** Loeschen ueberfluessiger ' ' ***/

	signal(SIGINT,SIG_IGN);
	while ( *name == ' ' ) ++name;

	c = *name;

	/*** Informationen zu aktuellem Variablenspeicher durch
	     Aufruf des Programms inform ***/

	if ( c == '?' )
	{       inform( name+1 );
		signal(SIGINT,SIG_IGN);
		printf(" new variable name: ");
		if ( ps ) fprintf(datei,"out: new variable name: ");
		setocnt( stdout, 0 );
		*name = '\0';
		*an = '\0';
		an = getline("",-1);
		if(!strcmp(an,"quit")) *an = 4;
		if(ps) fprintf(datei,"\nin: %s\n",an);
		i=artovar(an,name);
		if(!i)         /*um nochmalige Eingabe zu ermoeglichen*/
		{	strcpy( name, "@" );
			i=invect(name);
		}
		else i = invect(name);
	}

	/*** Abfangen falscher Eingaben und Ausgabe der
	     Help-Datei ***/

	else
	{   sch = 0;  
		
	    /*** Ueberpruefen, ob name == curEllCurve, curModulus,
		 curNumberField, curGaloisField ist ***/

	    if( !strcmp( name, "curEllCurve" ) )
	    {   printf(" Please use curec to specify the current elliptic curve!\n\n" );
	       if( ps ) fprintf(datei, "out: Please use curec to specify the current elliptic curve!\n\n" );
		sch = 1;
	     }
	    if( !strcmp( name, "curModulus" ) )
	    {   printf(" Please use curmod to specify the current modulus!\n\n" );
	        if( ps ) fprintf(datei, "out: Please use curmod to specify the current modulus!\n\n" );
		sch = 1;
	     }
	    if( !strcmp( name, "curNumberField" ) )
	    {   printf(" Please use curnf to specify the current number field!\n\n" );
	       if( ps ) fprintf(datei, "out: Please use curnf to specify the current number field!\n\n" );
		sch = 1;
	     }
	    if( !strcmp( name, "curGaloisField" ) )
	    {   printf(" Please use curgf to specify the current Galois-field!\n\n" );
	       if( ps ) fprintf(datei, "out: Please use curgf to specify the current Galois-field!\n\n" );
		sch = 1;
	     }

	     /*** Ueberpruefen, ob name = Var. des curNumberField 
		  oder des curGaloisField ist ***/

	     if( VNF != _0 )
	     {	V = lfirst( VNF );
		n = 0;
		while( V != _0 )
		{	hname[n] = lfirst( V );
			V = lred( V );
			n++;
		}
		hname[n] = '\0';
		if( !strcmp( name, hname ) )
		{  printf(" An assignment to the variable used in curnf is not allowed!\n\n" );
		   if( ps ) fprintf(datei, "out: An assignment to the variable used in curnf is not allowed!\n\n" );
		   sch = 1;
		}
	     }
	     if( VGF != _0 )
	     {	V = lfirst( VGF );
		n = 0;
		while( V != _0 )
		{	hname[n] = lfirst( V );
			V = lred( V );
			n++;
		}
		hname[n] = '\0';
		if( !strcmp( name, hname ) )
		{  printf(" An assignment to the variable used in curgf is not allowed!\n\n" );
		   if( ps ) fprintf(datei, "out: An assignment to the variable used in curgf is not allowed!\n\n" );
		   sch = 1;
		}
	     }

	     /*** name != AV && name != AV[... ***/

	     if( strlen(name)>=2 && name[0]==AVNAME[0] && name[1]==AVNAME[1]
              && ( strlen(name)==2 || name[2]=='[' ) ) 
	      {	printf(" %s is a keyword and therefore", AVNAME );
		printf(" must not be used as a variable name!\n\n");
		if(ps) 
                {  fprintf(datei, "out: %s is a keyword and ", AVNAME );
		   fprintf(datei, " therefore must not be used as a variable name!\n\n");
		}
		sch = 1;
	      }

	     if( sch && !isatty(fileno(stdin)) )
	     {   printf(" The value is assigned to '@'.\n");
	         if ( ps ) fprintf( datei, "out: The value is assigned to '@'.\n");
		strcpy( name, "@" );
		return(0);
	     }
	     else if( sch )
	     {	printf(" new variable name: ");
		if ( ps )
		fprintf(datei,"out: new variable name: ");
		setocnt( stdout, 0 );
		*name = '\0';
		*an = '\0';
		an = getline("",-1);
		if(!strcmp(an,"quit")) *an = 4;
		if(ps) fprintf(datei,"\nin: %s\n",an);
		i=artovar(an,name);
		if(!i) 
		{	strcpy( name, "@" );
			i=invect(name);
		}
		else i = invect(name);
	   }

	   else  /*** sch == 0 ***/
	   { while ( *(name+n) != '\0' && n<26 )
	    {   if ( !isalnum( *(name+n) ) && *(name+n)!='[' && *(name+n)!=']' )
		{       c = '@';
			break;
		}
		++n;
	    }
	    if ( !isalpha(c) || c == 10 )
	    {   printf(" Illegal variable name!\n\n");
		if ( ps ) fprintf(datei,"out: Illegal variable name!\n");

	        if( !isatty(fileno(stdin)) )
	        {   printf(" The value is assigned to '@'.\n");
	            if ( ps ) fprintf( datei, "out: The value is assigned to '@'.\n");
		   strcpy( name, "@" );
		   return(0);
	        }
		else
		{
		printf(" new variable name: ");
		if ( ps ) fprintf(datei,"out: new variable name: ");
		setocnt( stdout, 0 );
		*name = '\0';
		*an = '\0';
		an = getline("",-1);
		if(!strcmp(an,"quit")) *an = 4;
		if(ps) fprintf(datei,"\nin: %s\n",an);
		i=artovar(an,name);
		if(!i) 
		{	strcpy(name,"@");
			i=invect(name);
		}
		else i = invect(name);
	        }
	    }

	/*** Ueberpruefung des eingegebenen Variablennamen, ob
	     dieser bereits als Funktions- oder Variablenname
	     benutzt wurde ***/

	    else
	    {  if ( n == 26 )
	       {        mistake( 7 );
	        	if( !isatty(fileno(stdin)) )
	        	{   printf(" The value is assigned to '@'.\n");
	            	    if ( ps ) fprintf( datei, "out: The value is assigned to '@'.\n");
		   	    strcpy( name, "@" );
			    return(0);
	        	}
			else
			{
			printf(" new variable name: ");
			if ( ps )
			fprintf(datei,"out: new variable name: ");
			setocnt( stdout, 0 );
			*name = '\0';
			*an = '\0';
			an = getline("",-1);
			if(!strcmp(an,"quit")) *an = 4;
			if(ps) fprintf(datei,"\nin: %s\n",an);
			i=artovar(an,name);
			if(!i) 
			{        strcpy(name,"@");
				 i=invect(name);
			}
			else i = invect(name);
			}
	       }
	       else
	       {   while( ( i < MX && strlen(varlist[i].varname) ) || !i )
		   {    if( strcmp(name,varlist[i].varname) )
			{   if ( varlist[i].typ!=2 && varlist[i].typ!=(-3) && varlist[i].varwert && varlist[i].varwert!= ERROR &&
				 ( ( lsecond(varlist[i].varwert)>1 && lsecond(varlist[i].varwert)<5 )
				 || ( lsecond(varlist[i].varwert)>6 && lsecond(varlist[i].varwert)<10 )
				 || ( lsecond(varlist[i].varwert)>11 && lsecond(varlist[i].varwert)<15 ) 
                                 || lsecond(varlist[i].varwert)==18  || lsecond(varlist[i].varwert)==20 || lsecond( varlist[i].varwert ) == 22
                                 || lsecond(varlist[i].varwert)==25  || lsecond(varlist[i].varwert)==27 || lsecond( varlist[i].varwert ) == 29 
                                 || lsecond(varlist[i].varwert)==32  || lsecond(varlist[i].varwert)==34 || lsecond( varlist[i].varwert ) == 36 
				 || lsecond(varlist[i].varwert)==38 || lsecond(varlist[i].varwert)==39 ) )
			    {   sch = ispolvar( name, i );

	/*** Meldungsblock, falls ein Variablenname bereits eine Unbe-
	     stimmte eines Polynoms, dann muss ein neuer Variablenname
	     angegeben werden.   ***/

				if ( sch && !i )
		                {   if ( ps ) fprintf( datei, "out: The variable @ is deleted.\n");
		                    printf(" The variable @ is deleted.\n");
		 		    varlist[0].varwert = 0; 
		 		    strcpy(varlist[0].varname, "\0"); 
		 		    varlist[0].typ=0;
				    ++i;
				}	
				else if ( sch ) {
			if( lsecond(varlist[i].varwert)<5 || lsecond(varlist[i].varwert)==18 
		        || lsecond(varlist[i].varwert)==25 || lsecond(varlist[i].varwert)==32 
			|| lsecond(varlist[i].varwert)==38 || lsecond(varlist[i].varwert)==39 )
			printf(" %s is a variable of the polynomial", name );
			else if( lsecond( varlist[i].varwert ) < 10 || lsecond( varlist[i].varwert ) == 20 
			|| lsecond( varlist[i].varwert ) == 27 || lsecond( varlist[i].varwert ) == 34 )
			printf(" %s is a variable of one of the polynomials of the matrix", name );
			else
			printf(" %s is a variable of one of the polynomial of the vector", name );
			printf( " %s\n", varlist[i].varname );
			printf(" and therefore must not be used as a variable name.\n\n");
			if ( ps )
			{ if( lsecond(varlist[i].varwert)<5 || lsecond(varlist[i].varwert)==18 
		        || lsecond(varlist[i].varwert)==25 || lsecond(varlist[i].varwert)==32 
			|| lsecond(varlist[i].varwert)==38 || lsecond(varlist[i].varwert)==39 )
			   fprintf(datei,"out: %s is a variable of the polynomial", name );
			  else if( lsecond( varlist[i].varwert ) < 10 || lsecond( varlist[i].varwert ) == 20 
			|| lsecond( varlist[i].varwert ) == 27 || lsecond( varlist[i].varwert ) == 34 )
			   fprintf(datei,"out: %s is a variable of one of the polynomials of the matrix", name );
			   else
			   fprintf(datei,"out: %s is a variable of one of the polynomials of the vector", name );
			   fprintf(datei, " %s\n", varlist[i].varname );
			   fprintf(datei,"     and therefore must not be used as a variable name.\n\n");
			}

	        	if( !isatty(fileno(stdin)) )
	        	{   printf(" The value is assigned to '@'.\n");
	            	    if ( ps ) fprintf( datei, "out: The value is assigned to '@'.\n");
		            strcpy( name, "@" );
			    return(0);
	        	}
			else
			{
			printf(" new variable name: ");
			if ( ps )
			   fprintf(datei,"     new variable name: ");
			setocnt( stdout, 0 );
			*name = '\0';
			*an = '\0';
			an = getline("",-1);
			if(!strcmp(an,"quit")) *an = 4;
			if(ps) fprintf(datei,"\nin: %s\n",an);
			i=artovar(an,name);
			if(!i) 
			{	strcpy(name,"@");
				i=invect(name);
			}
			else i = invect(name);
			break;
			}
				}
				else ++i;
			}
			else ++i;
		    }
		    else {

	/*** Meldungsblock, falls ein Funktionsname als Variablenname
	     benutzt werden soll ***/

		       if ( varlist[i].typ == 1 || varlist[i].typ == 3 ) {
			printf(" %s is a function or keyword and\n",name);
			printf(" therefore must not be used as a variable name.\n\n");
			if ( ps ) {
			   fprintf(datei,"out: %s is a function or keyword and\n",name);
			   fprintf(datei,"     therefore must not be used as a variable name.\n\n");
			}

	                if( !isatty(fileno(stdin)) )
	        	{   printf(" The value is assigned to '@'.\n");
	            	    if ( ps ) fprintf( datei, "out: The value is assigned to '@'.\n");
		            strcpy( name, "@" );
			    return(0);
	                }
			else
			{
			printf(" new variable name: ");
			if ( ps )  fprintf(datei,"     new variable name: ");
			setocnt( stdout, 0 );
			*name = '\0';
			*an = '\0';
			an = getline("",-1);
			if(!strcmp(an,"quit")) *an = 4;
			if(ps) fprintf(datei,"\nin: %s\n",an);
			i=artovar(an,name);
			if(!i) 
			{	strcpy(name,"@");
				i=invect(name);
			}
			else i = invect(name);
			break;
			}
		       }

	/*** Meldungsblock, falls ein Variablenname bereits benutzt ist
	     und Moeglichkeit des Ueberschreibens oder Wahl eines
	     neuen Variablennamens, wobei Informationen zum aktuellen
	     Variablenspeicher angefordert werden koennen ***/

		   else if( owsch && isatty(fileno(stdin))) {
			printf(" %s is already used.\n",name);
			printf(" overwrite? (y/n) ");
			if ( ps ) {
		     fprintf( datei, "out: %s is already used.\n", name );
		     fprintf( datei, "     overwrite? (y/n)\n");
			}
			setocnt( stdout, 0 );
			*an = '\0';
			an = getline("",-1);
			c = (*an);
			if ( ps ) fprintf( datei, "in : %c", c );
			if( c != 'y' ) {
				if ( c != '?') {
				    printf("\n new variable name: ");
				    if ( ps )
			   fprintf( datei,"\nout: new variable name: ");
				    setocnt( stdout, 0 );
				    *name = '\0';
				    *an = '\0';
				    an = getline("",-1);
				    if(!strcmp(an,"quit")) *an=4;
 				    if(ps) fprintf(datei,"\nin : %s\n",an);
				    i=artovar(an,name);
				    if(!i) 
				    {	strcpy(name,"@");
				    	i=invect(name);
				    }
				    else i=invect(name);
				}
				else {
				    setocnt( stdout, 0 );
				    if(ps) fprintf(datei,"\nin : %s\n",an); 
				    i = invect(an);
				}
			}
			else {
				setocnt( stdout, 0 );
				if ( ps ) fprintf( datei, "\n" );
			}
			break;
		   }
		   else if( owsch )
		   {	printf(" The variable is overwritten.\n" );
			if(ps) fprintf(datei, "out: The variable is overwritten.\n" );
			setocnt( stdout, 0 );
			break;
	
		   }
		   else  {
				setocnt( stdout, 0 );
				break;
		   }
		    }
		}
	       }
	    }
	   }
	}
	free(an);
	return( i );
}
