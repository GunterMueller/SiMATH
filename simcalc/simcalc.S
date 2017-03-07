/*C     Wegen srctrans steht an dieser Stelle MACRO !

	Hauptprogramm des Simath - Calculators * simcalc *

	Ein Eingabestring wird vom Bildschirm eingelesen.
	Das Programm entscheidet, ob und an welche Unterprogramme der
	Eingabestring weitergegeben wird.
	Dabei koennen folgende Faelle eintreten:
	1.) Falls das erste eingelesene Zeichen ein '%' ist,
	    so koennen folgende Faelle eintreten:
	    a. %?
	       Die letzten zehn Rechenanweisungen werden auf Bildschirm
	       geschrieben.
	    b. %n
	       Die Rechenanweisung mit der Kennziffer n wird auf Bild-
	       schirm geschrieben und kann ueberarbeitet werden.
	    c. %
	       Die letzte Rechenanweisung wird auf Bildschirm geschrie-
	       ben und kann ueberarbeitet werden.
	2.) Falls die Eingabe nur aus einem carriage return besteht, so
	    wird nichts ausgefuehrt.
	3.) Falls das erste eingelesene Zeichen das END-Zeichen ist,
	    so bricht das Programm ab.
	4.) Falls das erste eingelesene Zeichen ein '$' ist, so wird
	    der dem '$' folgende Shell-Befehl ausgefuehrt.
	5.) Falls das erste eingelesene Zeichen ein '!' ist, so wird
	    eine simulierte Shell-Ebene geschaffen.
	6.) Falls das erste eingelesene Zeichen ein '?' ist, so wird
	    der Eingabestring an das Unterprogramm inform weitergegeben.
	7.) Falls das erste eingelesene Zeichen ein '&' ist, so wird
	    die Datei calc.intro aufgelistet.
	8.) Falls das erste eingelesene Zeichen das DELETE-Zeichen ist,
	    so wird der aktuelle Programmzustand gerettet und das Pro-
	    gramm geht zu der von dem Systemaufruf setjmp markierten
	    Stelle.
	9.) Bei Eingabe von vardel wird die Funktion osloesche aufge-
	    rufen, die dem Benutzer anbietet Variablen zu loeschen.
       10.) Bei Eingabe von logon... wird der Eingabestring  an das
	    Unterprogramm logon weitergegeben zur Eroeffnung einer
	    Protokolldatei.
	    Bei Eingabe von logoff wird die aktuelle Protokolldatei
	    geschlossen und bei Eingabe von loglist wird die aktuelle
	    Protokolldatei, falls eine solche geoeffnet ist, auf
	    Bildschirm aufgelistet.
       11.) Bei Eingabe von staton wird der Statistikschalter eingeschaltet
	    und bei Eingabe von statoff wird dieser wieder auf 0 gesetzt.
       12.) Bei Eingabe von owoff  wird der Ueberschreibeschutz ausgeschaltet
	    und bei Eingabe von owon wird dieser wieder auf 1 gesetzt.
       13.) Bei Eingabe von fopen, fclose und fread wird eine Einlesedatei
	    geoeffnet, geschlossen oder aus ihr gelesen. Mit openf sieht
	    man, welche Dateien zum Lesen geoeffnet sind.
       14.) Alle uebrigen Eingabestrings werden zuerst an das Unter-
	    programm error weitergegeben, wo der Eingabestring auf
	    syntaktische Korrektheit untersucht wird.
	    Ist dies der Fall, so wird der Eingabestring an das Unter-
	    programm rechnung weitergegeben, wo er ausgewertet wird.
	    Stehen in einem Eingabestring mehrere durch '_',';' ge-
	    trennte Befehle, so wird der Eingabestring sukzessive ab-
	    gearbeitet. Mehrere Eingabestrings sind nur moeglich bei
	    arithmetischen Ausdruecken.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  2      10.01.1990      U.Schneiders ( MX- AS- Version )
	Version  2.1    17.09.1990      U.Schneiders ( ow, fread etc. )
	Version  3      23.12.1991      U.Schneiders ( SM_HOME )
	Version  3.1    07.01.1993      U.Schneiders (scr_page fuer MX)
H*/

# include <_calc.h>

# include <unistd.h>

struct var varlist[VARLISTLENGTH], localvar[VARLISTLENGTH];
char *funstr[USER_FUNC];
obj AV[AVLENGTH];
char AVNAME[3];

FILE *datei, *fpt[10], *fopen();
char *comm,*dhelp, *datn, *fname[10];
single ps, hps, tdiff, tabs, statsch, owsch, owalt, fz; 
single DIGITS, OUTPUTDIG, MX, MXNUM, MXUSER, DEPTH; 
single SIEMENS, RANKCM;
floating HEIGHTBOUND;
list ecqnfsch;
single ecsch, modsch, ssch, pzsch, nfsch, gfsch, gfchar, nfon;
single avsch;
single fosch, schleife, breaksch;
single assch, prfehl;
single anzloc, funktion;
list VNF, VGF;

/* NEU am 11.06.96 eingefuegt single SS_MESS; */

single SS_MESS;

static char *string, *bz[10];
jmp_buf res;
extern single sch1;

void interrupt()
{
	char *h;
	single i;
	size_t j;

	if ( sch1) {
		printf("\n ********    Result is computed.     ********\n");
		printf(" ********   Output is interrupted.   ********\n\n");
		if ( ps) {
		       fprintf(datei, "\nout: ********    Result is computed.     ********\n");
		       fprintf(datei, "out: ********   Output is interrupted.   ********\n\n");
		}
	}
	else {
		j=0;
		while(j <= strlen( string ) ) {j += 78; putc('\n', stdout);}
		printf("\n ********     Calculation is interrupted.     ********\n\n");
		if ( ps) fprintf(datei,"\nout: ********     Calculation is interrupted.     ********\n\n");
	}
	*string = '\0';
	tdiff = settime(); tabs+=tdiff;
	if ( statsch ) statistic( tdiff );

	for( i = NUM_FUNC; i < VARLISTLENGTH; i++ )        
	{  	if(*varlist[i].varname == '\0' ) break;     
        	if( varlist[i].varwert == -BASIS ) 
	        {      varlist[i].varwert = 0;
  	               *varlist[i].varname = '\0';
		}
	} 

	setocnt( stdout, MARGIN);
	putc(27,stdout); putc('[',stdout); putc('7',stdout); putc('p',stdout);
	longjmp(res,0);
}

void inter_core()
{	single i;
	
	printf("\n ********     Fatal Error     ********\n\n");
	if(ps) fprintf(datei,"\nout: ********      Fatal Error      ********\n\n");
	*string = '\0';
	tdiff = settime(); tabs+=tdiff;
	if ( statsch ) statistic( tdiff );

	for( i = NUM_FUNC; i < VARLISTLENGTH; i++ )        
	{  	if(*varlist[i].varname == '\0' ) break;     
        	if( varlist[i].varwert == -BASIS ) 
	        {      varlist[i].varwert = 0;
  	               *varlist[i].varname = '\0';
		}
	} 

	setocnt( stdout, MARGIN);
	putc(27,stdout); putc('[',stdout); putc('7',stdout); putc('p',stdout);
	longjmp(res,0);
}


main()
{
	/*** Deklarationen und Vorbesetzungen ***/

	single stz;
	single i, y, pi, psch;
	single vorb = 0;
	char s, *strcat(), *hil, *getline(),*getenv();
	char *h;
	FILE *dat;
	single m, n, sch = 1;
	double fltoCfl();

if( llength( _0 ) )
{
	gfsalgenies();
}

	SS_MESS = 1;
	setstack(2500);
	
	init( VNF, VGF, HEIGHTBOUND, ecqnfsch );
	MX = VARLISTLENGTH;
	MXNUM = NUM_FUNC;
	MXUSER = USER_FUNC;

# ifdef ___CASI
	SIEMENS=1;
# else
	SIEMENS=0;
# endif

	string = malloc( MAXL ); h = malloc( MAXL );
	hil = malloc(30); comm = malloc(10); dhelp = malloc(25);
	*string = '\0'; *h = '\0';
	*hil = '\0'; *comm = '\0'; *dhelp = '\0';

	if( !isatty(fileno(stdin))) comm="cat";
	else
	{

		comm = getenv("PAGER");
		if(comm == NULL) comm = "more";
	}

	i=getpid();
	sprintf(hil,"%d",i);
	strcat2(dhelp, "/tmp/___H.sIm",hil);

	for (i = 9; i >= 0; i--)
	{
		fname[i] = malloc( 15 );
		*fname[i] = '\0';
	}
	datn = malloc( 20 );
	fz = 0;

	strcat4(h, comm," ",SM_HOME,"/calcul/calc.intro");
	system(h);

/* NEU am 29.12.94 eingefuegt */	ITERMAX = 500;

	ps = 0; hps = 0; statsch = 0; owsch = 1; owalt=1; DIGITS = 37; 
	OUTPUTDIG = 0; DEPTH=30;
	ecqnfsch = _0; ecsch = 0; modsch = 0; ssch = 0; pzsch = 0; 
	nfsch = 0; gfsch = 0; gfchar = 0; schleife = 0; fosch=0; nfon=0;
	avsch=1;
	breaksch=0; assch=0; prfehl=0; anzloc=0; funktion=0;	
	tdiff=settime(); tabs+=tdiff;
	for(n=0;n<MXUSER;n++)
	{	funstr[n]=malloc(5);
		*funstr[n]='\0';
	}
	for ( n=0; n<MX; n++ ) {
		varlist[n].varname = malloc(26);
		localvar[n].varname = malloc(26);
		*varlist[n].varname = '\0';
		*localvar[n].varname = '\0';
		localvar[n].varwert = 0;
		localvar[n].typ = 0;
	}
	n = MX-1;
	init(varlist[0..n].varwert);
	init(localvar[0..n].varwert);
	n = AVLENGTH-1;
	init( AV[0..n] );
# ifdef ___LARGE_SYSTEM
	gcreinit( 65535,128 );
#endif 

	HEIGHTBOUND = itofl(11);
	_H_BOUND = fltoCfl(HEIGHTBOUND); 
	RANKCM=0;
	_R_C_M=RANKCM;

	VNF = _0;
	VGF = _0;
	AVNAME[0] = 'A';
	AVNAME[1] = 'V';
	AVNAME[2] = '\0';
	structin( 1 );
	stz = ST_INDEX;
	MARGIN = 1;
	LN_SIZE = 79;

	/*** Einlesen aus Datei simcalc.rc ***/

	hil = getenv("HOME");
	strcat2(h,hil,"/.simcalcrc");
	if((!access(".simcalcrc",F_OK) && !access(".simcalcrc",R_OK))
	  || (!access(h,F_OK) && !access(h,R_OK)))
	{	if(!access(".simcalcrc",R_OK) )
			dat = fopen(".simcalcrc","r");
		else    dat = fopen(h,"r");
		pi=1;
		for( y = 0; y < 100; y++ )
		{
		       for(i=0;i<pi;i++) *(string+i)='\0';
			if( (int) calc_fgets( string, MAXL, dat ) == (int) NULL )
			{       mistake( 104 );
				break;
			}
			pi=strlen(string);
			if(pi>=MAXL)
			{	printf(" Input too long!\n\n");
				break;
			}
			seqbasad(string, interrupt, inter_core, 1,0);
		}
		for(i=0;i<pi;i++)  *(string+i) = '\0';
		fflush(dat);
		fclose(dat);
	}
	pi = strlen(h);
	for(i=0;i<pi;i++) *(h+i)='\0';
			
	/*** Einlesen des Eingabestrings ***/

	while ( sch ) {
		setjmp( res );
		owsch=owalt;
		assch=0;
		if(schleife)
		{	schleife=0;
			schleiaus();
		}	
		if(funktion)
		{	funktion=0;
			localback(anzloc);
		}	
		signal( SIGINT, interrupt );
		ST_INDEX = stz;

		if ( ps ) fprintf( datei, "\n" );

		setocnt( stdout, 0);
		strcpy(string,"> ");
		if( !isatty(fileno(stdin))) 
			{	if( (int) calc_fgetsp( h, MAXL, stdin ) == (int) NULL )
				h = "quit";
			else 
			{	printf("> ");
				puts(h);
				printf("\n");
			}

		}
		else h = getline(string, 0);
		strcpy( string, h );
	
		s = (*string);
		switch( s ) {

	/*** alter String ***/

		case '%':
			mistake(275);
			break;

	/*** Leerer String ***/

		case 10: break;

	/*** Abbruch ***/

		case EOF:
		case 4 : 
			  xprintf("\n\n                                   B Y E\n\n\n");
			  sch = 0;
			  break; 

	/*** Systembefehle ***/

		case '$':if ( ps ) fprintf(datei,"in : %s\n",string); 
			 system( string+1 );
			 *h = '\0';
			 *string='\0';
			 break;

	/*** Simulierte Shell-Ebene ***/

		case '!': if( !isatty(fileno(stdin) ) )
			  {	mistake(254);
				break;
			  }
			  if ( ps ) fprintf(datei,"in : %s\n",string);
			  printf(" >>> branching to a subshell\n");
			  printf("     Type `CTRL/D' or \"exit\" in order to return to simcalc.\n\n");
			  system("$SHELL");
			  putchar('\n');
			  *string='\0';
			  break;

	/*** '?'-Eingabe ***/

		case 63: if ( ps ) fprintf(datei,"in : ? %s\n",string+1);
			 inform( string+1 );
			 *string = '\0';
			 break;

	/*** '&'-Eingabe ***/

		case '&': pi=1;
			  while(*(string+pi) == ' ') pi++;
			  if(*(string+pi)!='\0')
			  {	
				/*mistake(253);*/
				printf( " ***** Error: Illegal input!\n");
				*string = '\0';
				break;
			  }
			  einzinf( "&" );
			  if ( ps ) fprintf(datei,"in : & %s\n",string+1); 
			  *string = '\0';
			  break;

		default:

	/*** Beenden des simcalc ***/

			if( !strncmp( string, "quit", 4 ) || !strncmp( string, "exit", 4 ) )
			{
			    string += 4;
			    pi = 0; psch = 1;
			    while( pi < strlen(string) && psch)
			    { if(*(string+pi) != ' ')
			      { mistake(253);
				psch = 0;
			      }
			      pi++;
			    }
			    if(psch) {
			    	xprintf("\n\n                                   B Y E\n\n\n");
			    	sch = 0;
			    }
			    break;
			}

	/*** Loeschen von Variablen ***/

			 if ( !strncmp( string, "vardel", 6 ) ) {
		                if( !isatty(fileno(stdin) ) )
			  	{	mistake(253);
					*string='\0';
					break;
			  	}
			 	string += 6;
				pi = 0; psch = 1;
				while( pi < strlen(string) && psch)
				{	if (*(string+pi) != ' ')
					{  mistake(253);
					   psch = 0;
					}
					pi++;
				}
				if( psch )
				{    if ( ps )
				     fprintf( datei, "in : vardel\n");
				     m = osloesche();
				     while ( m == -1 ) m = osloesche();
				}
				*string = '\0';
				break;
			 }

	/*** Einlesen von Datei ***/

			 if ( !strncmp( string, "openf", 5 ) )
			 {      string += 5;
				pi = 0; psch = 1;
				while( pi < strlen(string) && psch )
				{       if ( *(string+pi) != ' ' )
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( psch )
					fileaus();
				*string = '\0';
				break;
			 }


	/*** Ueberschreibeschutzverwaltung ***/

			 if ( ps ) fprintf(datei,"in : %s\n",string);

			 if ( !strncmp( string, "loglist",7 ) )
			 {      string += 7;
				pi = 0; psch = 1;
				while( pi < strlen(string) && psch )
				{       if ( *(string+pi) != ' ' )
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( psch )
				{       if ( ps )
					{    char *hilf;
				             hilf = malloc(30);
					     *hilf = '\0';
					     strcat3(hilf,comm," ",datn);
					     fflush( datei );  
					     system(hilf);
					     free(hilf);
					     break;
					}
					else
					{    printf(" No log file.\n");
					     break;
					}
				}
				*string = '\0';
			 }

	/*** Uebergabe an seqbasad zur Auswertung ***/

			seqbasad(string, interrupt, inter_core, 0,0);
			*string = '\0';
		}
	}
}
