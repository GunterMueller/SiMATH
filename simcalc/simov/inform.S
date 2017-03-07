/*C
			inform( string )

	"Information".
	inform(string); char *string;
	inform( string );
	Das Programm schreibt die in der Zeichenkette string gewuenschten
	Informationen zu Variablen, Operatoren und Funktionen auf
	stdout und Protokolldatei, falls eine solche geoeffnet ist.
	Bei Eingabe eines '?' wird der gesamte aktuelle Variablenspeicher
	mit zugehoerigen Werten aufgelistet.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  2      26.08.1991      U.Schneiders ( sortaus MX300
						       switch ersetzt? )
	Version  2.1    27.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  3      25.05.1992      U.Schneiders ( M, NF )
	Version  4      14.02.1995      S.Schmitt/U.Schneiders 
					( Pol. ueber R oder C )
	Version  5      25.04.1995      S.Schmitt/U.Schneiders (AV)
H*/
 
#include <_calc.h>

inform ( string )
char *string;

{       /*** Deklarationen und Vorbesetzungen ***/

	single z, d=0, i=0, j, k, l, sch=0, tsch=0;
	char va[21], var[10];
	list Lk, ausl;
	init( Lk, ausl );
	*va = '\0'; 

	signal(SIGINT,SIG_IGN);

	/*** Aufloesung des Eingabestrings und Information zu den
	     eingebenen Variablen ***/

	z = strlen( string );
	while ( z - i > 0 )
	{       ausl=_0;
		while(*(string+i)==' ' || *(string+i)==',') ++i;
		*(va+d) = *(string+i);
		i++; d++;
		if(*(string+i)==' ' || *(string+i)==',' || i >= z)
		{       *(va+d) = '\0';
			l = 0;
			if ( *va == '?' )
			{    Lk = list6( -7, -8, -15, -16, -11, -12 );
			     Lk = lcomp2( -3, -4, Lk);
			     Lk = lcomp6( -2, -5, -6, -14, -9, -10, Lk );
			     Lk = lcomp( -1, Lk );
			     Lk = lcomp6( 21, 22, 35, 36, 28, 29, Lk );
			     Lk = lcomp5( 10, 11, 12, 13, 14, Lk );
			     Lk = lcomp6( 19, 20, 33, 34, 26, 27 , Lk );
			     Lk = lcomp5( 5, 6, 7, 8, 9, Lk );
			     Lk = lcomp6( 30, 31, 32, 23, 24, 25, Lk );
			     Lk = lcomp6( 38, 39, 4, 16, 17, 18, Lk );
			     Lk = lcomp6( 0, 1, 15, 37, 2, 3, Lk );

			     printf("\n");
		             if(ps) fprintf(datei,"\n"); 
			     j = (-1);
			     while( Lk != _0 )
			     {  
				/*** Erkennung von ell. Kurven und Punkten ***/
				/*** Ausgabe erst nach anderen Strukturen  ***/
				k = lfirst( Lk );
				Lk = lred( Lk );

				while ( l < MX )
				{    if ( strcmp(varlist[l].varname,"\0") && varlist[l].typ <=0
				     &&  lsecond( varlist[l].varwert ) == k )
					{   if( !j ) printf("\n");
					    else if( j == (-1) ) j = 0;
					    if ( !j )
					    {   if ( ps ) fprintf( datei, "\n" );
					        if( !tsch ) typprint( k );
						if( ( k >= 5 && k <= 14 ) 
                                                  || ( k >= 19 && k <= 22 )
                                                  || ( k >= 26 && k <= 29 )
						  || ( k >= 33 && k <= 36 )
                                                  || k < 0 ) tsch = 1;
					    }
					    j++;
					    ausl = lcomp( l,ausl );
					}
				     l++;
				}
				sortaus( ausl );
				signal(SIGINT,SIG_IGN);
				l = 0; ausl = _0;

                                if( k == 27 || k == 29 || ( k < 0 && seven( k ) ) ) tsch = 0;
				j = 0;
			     }          /*** Ende der while( Lk ) - Schleife ***/

			     if( AV[0] )
			     {  printf("\n auxiliary variables:\n");
			 	if(ps) fprintf(datei,"\nout: auxiliary variables:\n" );
				k=0;
				while( AV[k] && k<AVLENGTH )
				{  sprintf(va,"%s[%d]",AVNAME,k);
				   ausgabe( "", va, AV[k], 0 );
				   k++; 
				}
			     }

			     printf("\n global variables:\n");
			     printf("%t DEPTH = %i\n", 8, DEPTH);
			     printf("%t DIGITS = %i\n", 8, DIGITS );
		             printf("%t HEIGHTBOUND = ", 8 );
			     if(!OUTPUTDIG) putfl( HEIGHTBOUND, -DIGITS );
/************ RAUS *****
			     else yputflfx(HEIGHTBOUND, 1, OUTPUTDIG );
***********************/
			     else putflfx(HEIGHTBOUND, 1, OUTPUTDIG );
			     printf("\n");
			     printf("%t LINELN = %i\n", 8, LN_SIZE);
			     printf("%t OUTPUTDIG = %i\n", 8,OUTPUTDIG);
			     if ( ps )
			     {  fprintf( datei,"\nout: global variables:\n" );
				fprintf( datei,"out: DEPTH = %i\n",DEPTH);
				fprintf( datei,"out: DIGITS = %i\n", DIGITS );
			        fprintf( datei, "out: HEIGHTBOUND = ");
			        if(!OUTPUTDIG) fputfl( HEIGHTBOUND, -DIGITS, datei );
				else fputflfx(HEIGHTBOUND, 1, OUTPUTDIG,datei);
				fprintf( datei, "\n" );
				fprintf( datei,"out: LINELN = %i\n",LN_SIZE);
				fprintf( datei,"out: OUTPUTDIG = %i\n", OUTPUTDIG);
			     }
			     ausl=_0;
			     l=0;
			     while ( l < MX )
			     {    if ( strcmp(varlist[l].varname,"\0") && varlist[l].typ ==2)
				     ausl = lcomp( l,ausl );
				  l++;
			     }
			     if(ausl!=_0) 
			     {	printf("\n");
				if(ps) fprintf(datei,"\n");
				sortfunc( ausl, 1 );
			     }
			break;
			}
			else
			   if ( strchr(va,'*') != NULL && !ctest(va,'*') )
			{    Lk = list6( -7, -8, -15, -16, -11, -12 );
			     Lk = lcomp2( -3, -4, Lk);
			     Lk = lcomp6( -2, -5, -6, -14, -9, -10, Lk );
			     Lk = lcomp( -1, Lk );
			     Lk = lcomp6( 21, 22, 35, 36, 28, 29, Lk );
			     Lk = lcomp5( 10, 11, 12, 13, 14, Lk );
			     Lk = lcomp6( 19, 20, 33, 34, 26, 27 , Lk );
			     Lk = lcomp5( 5, 6, 7, 8, 9, Lk );
			     Lk = lcomp6( 30, 31, 32, 23, 24, 25, Lk );
			     Lk = lcomp6( 38, 39, 4, 16, 17, 18, Lk );
			     Lk = lcomp6( 0, 1, 15, 37, 2, 3, Lk );

			     printf("\n");
			     if(ps) fprintf(datei,"\n");
 
			     j = (-1);
			     while( Lk != _0 )
			     {  
				/*** Erkennung von ell. Kurven und Punkten ***/
				/*** Ausgabe erst nach anderen Strukturen  ***/

				k = lfirst( Lk );
				Lk = lred( Lk );

				while ( l < MX )
				{  if ( muster( va, varlist[l].varname ) && varlist[l].typ<=0
				   && strcmp( varlist[l].varname, "\0" ) )
				   {    sch = 1;
					if ( lsecond( varlist[l].varwert ) == k )
					{   if ( !j ) printf("\n");
					    else if( j == (-1) ) j = 0;
					    if( !j )
					    {	if ( ps ) fprintf( datei, "\n" );
					    	if( !tsch ) typprint( k );
						if( ( k >= 5 && k <= 14 ) 
                                                  || ( k >= 19 && k <= 22 )
                                                  || ( k >= 26 && k <= 29 )
						  || ( k >= 33 && k <= 36 )
                                                  || k < 0 ) tsch = 1;
					    }
					    ++j;
					    ausl = lcomp( l,ausl );
					}
				   }
				    ++l;
				}
				sortaus( ausl ); ausl = _0;
				signal(SIGINT,SIG_IGN);
				l = 0;

                                if( k == 27 || k == 29 || ( k < 0 && seven( k ) ) ) tsch = 0;
				j = 0;
			     }          /*** Ende der while( Lk ) - Schleife ***/

			     if( AV[0] )
		             {  k=0; j=0;
				while( AV[k] && k < AVLENGTH )
				{  sprintf(var,"%s[%d]",AVNAME,k);
				   if( muster( va, var ) )
				   {  if(!j)  
			              {  printf("\n auxiliary variables:\n");
			 	         if(ps) fprintf(datei,"\nout: auxiliary variables:\n" );
					 j=1;
					 sch=1;
				      }
				      ausgabe( "", var, AV[k], 0 );
				   }
				   k++; 
				}
			     }

			     if( muster( va, "DEPTH" ) )
			     {  sch = 1;
				printf("\n global variable:\n");
				printf("%t DEPTH = %i\n", 8, DEPTH );
				if ( ps )
				{  fprintf( datei,"\nout: global variable:\n" );
				   fprintf( datei,"out: DEPTH = %i\n", DEPTH );
				}
			     }
			     if( muster( va, "DIGITS" ) )
			     {  sch = 1;
				printf("\n global variable:\n");
				printf("%t DIGITS = %i\n", 8, DIGITS );
				if ( ps )
				{  fprintf( datei,"\nout: global variable:\n" );
				   fprintf( datei,"out: DIGITS = %i\n", DIGITS );
				}
			     }
			     if( muster( va, "HEIGHTBOUND" ) )
			     {	sch = 1;
				printf("\n global variable:\n");
		             	printf("%t HEIGHTBOUND = ", 8 );
			     	if(!OUTPUTDIG) putfl( HEIGHTBOUND, -DIGITS );
/**************** RAUS *******
			     	else yputflfx(HEIGHTBOUND, 1, OUTPUTDIG );
*****************/
			     	else putflfx(HEIGHTBOUND, 1, OUTPUTDIG );
			     	printf("\n");
				if ( ps )
				{  fprintf( datei,"\nout: global variable:\n" );
			           fprintf( datei, "out: HEIGHTBOUND = ");
			           if(!OUTPUTDIG) fputfl( HEIGHTBOUND, -DIGITS, datei );
				   else fputflfx(HEIGHTBOUND, 1, OUTPUTDIG,datei);
				   fprintf( datei, "\n" );
				}
			     }
			     if( muster( va, "LINELN" ) )
			     {  sch = 1;
				printf("\n global variable:\n");
				printf("%t LINELN = %i\n", 8, LN_SIZE );
				if ( ps )
				{  fprintf( datei,"\nout: global variable:\n" );
				   fprintf( datei,"out: LINELN = %i\n", LN_SIZE );
				}
			     }
			     if( muster( va, "OUTPUTDIG" ) )
			     {  sch = 1;
				printf("\n global variable:\n");
				printf("%t OUTPUTDIG = %i\n", 8, OUTPUTDIG );
				if ( ps )
				{  fprintf( datei,"\nout: global variable:\n" );
				   fprintf( datei,"out: OUTPUTDIG = %i\n", OUTPUTDIG );
				}
			     }
			     ausl=_0;
			     l=0;
			     j=sch;
			     while ( l < MX )
			     {  if ( muster( va, varlist[l].varname ) && varlist[l].typ==2
				   && strcmp( varlist[l].varname, "\0" ) )
				   {    sch = 1;
					ausl = lcomp( l,ausl );
				   }
				   ++l;
			     }
			     if(ausl!=_0) 
			     {	if(j)
				{	printf("\n");
					if(ps) fprintf(datei,"\n");
				}
				sortfunc( ausl, 1 ); 
			     }
			     if ( sch == 0 )
			     {  printf(" Variables of the form %s not found.\n", va );
				if ( ps )
				{  fprintf( datei, "out: Variables of the form ");
				   fprintf( datei, "%s not found.\n", va );
				}
			     }
			     sch=0;
			   }
			   else einzinf( va );
		  d = 0;
		}
	}
	if(!schleife && assch<2 && !funktion)
	{	tdiff=settime(); tabs+=tdiff;
		if ( statsch ) statistic(tdiff);
	}
}
