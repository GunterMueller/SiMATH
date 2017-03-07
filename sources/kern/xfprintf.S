/*c
			xfprintf(pf, format [, arg]...)

	"file print formated, internal version"
	Quellbibliothek: srclib.kern
	Include-Datei:	 _simath.h
	!!! wird nur vom System ueber das Macro fprintf benutzt !!!
	single xfprintf(pf, format [,arg]...)	 FILE *pf; char *format;
	t = xfprintf(pf, format [,arg]...);
	Es duerfen hoechstens 99 Argumente uebergeben werden.
	(Dabei werden Dateizeiger und Formatstring nicht mitgezaehlt.)
	Sie werden gemaess den Formatanweisungen in "format" auf
	die Datei *pf ausgegeben.
	Bei Erfolg ist t=0, andernfalls ist t negativ.
	Zu den Formatangaben siehe CES-Buch 2, Seite 2-123.
	Dabei aendern sich folgende Parameter:
		l       (vor d, o, u, x) Format fuer ein Argument vom
			Typ "long int" ist redundant und wird 
			v e r b o t e n.
		d, o, u, x beziehen sich auf Zahlen vom Typ "single".
	Zusaetzliche Formatangaben:
	    %a		Dezimaldarstellung eines Atoms.
	    %b		Bitmuster einer Zahl vom Typ "single".
	    %i		Dezimaldarstellung einer ganzen Zahl.
	    %l		Liste.
	    %obj	Objekt (man unterscheide %o).
	    %r		Bruchdarstellung einer rationalen Zahl.
	    %.[m]r	Dezimaldarstellung einer rationalen Zahl;
			m gibt die Anzahl der Nachkommastellen an
			(%.r entspricht %.10r).  
	    %[m]p	Exponentdarstellung einer Fliesskommazahl; 
			m gibt die Anzahl der Mantissestellen an.
			(%p entspricht %8p).
	    %[n].[m]p	Festkommadarstellung einer Fliesskommazahl;
			n+1 ist dabei die Laenge des Strings vor dem
			Punkt (n Ziffern und eine Stelle fuer ein
			eventuelles Vorzeichen). Falls weniger als n
			Vorkommastellen vorhanden sind, werden Blanks
			vorangestellt, bei mehr als n Vorkommastellen
			werden alle Stellen ausgedruckt. m ist die
			Anzahl der Nachkommatellen, die ausgegeben
			werden (Voreinstellung: n = 1, m = 8).
	    %t		zum Argument single n, n < LN_SIZE: Einruecken
			der aktuellen Zeile um n Zeichen, vom Zeilen-
			anfang an gerechnet (falls moeglich).
c*/
/*H
	Version	 1	04.03.1987	R. Boeffgen
	Version	 2	07.04.1988	xausgabe -> fprintfsub	M.A. R.
	Version	 3	23.04.1988	SIMATH-Typen gebunden	 R.B.
	Version	 4	14.12.1988	an SUN-xfprintf angepasst.  PS
	Version	 5	26.04.1989	ueberfluessige Variablen b,...,z
					geloescht und Warnung in die Doku-
					mentation geschrieben, dass nicht
					mehr als 26 Argumente uebergeben
					werden duerfen.	 P.S.
	Version	 6	30.10.1989	V. Schwinn: fuer Apollo in xfprintf
					bei korrekter Beendigung vor return(0)
					fflush(pf) eingebaut.
	Version	 7	10.11.1989	simath - Header eingebunden J.S.
	Version	 8	07.12.1989	einheitl. Version fuer MX2(+), SUN
					und Apollo. P.S.	      
	Version	 9	30.10.1990	varargs eingebaut, damit das Pro-
					gramm auch auf SUN4 laeuft.  P.S.
	Version 10	28.03.1991	floatings eingebaut.  M.C.
	Version 11	09.07.1991	fflush(pf) auch fuer SUN-Rechner.  P.S.
	Version 12	27.08.1991	"switch (*pkey++)" ->
					"switch (hilf=(*pkey),pkey++,hilf)",
					da Apollo10000 sonst abstuerzt.
					xxfprintf als static-Modul.  PS
	Version 13	12.12.1991	fflush(pf) auch fuer MX300.  PS
	Version 14	01.12.1993	umgeschrieben wegen HP.	 MC
	Version 15	22.04.1994	malloc durch arrays ersetzt. MC
					MX-Version entfernt. MP
	Version 16	27.94.1996	"if isdigit (key)" replaced by 
					"if (isdigit (key))". MP
   DATE xfprintf      : 890501.891030.891110.900101.901120.910715.910915.911215.940315.941201.960601
H*/

# include <_simath.h>			/* why not _list.h? */

static single fprintfsub ( pf, pdvar, pvar , pa , pe , key, pk )
FILE *pf; 
double *pdvar; 
obj  *pvar;
char *pa, *pe;
single key, *pk;
{
	char *strncpy();
	single t = 0;

   /*** Bereich fuer Format- und Ausgabestring ***/
	static char xform[BUFSIZ], xstr[BUFSIZ];

   /*** Laenge des Formatstrings ***/
	short  len = pe - pa + 1;
   /*** Parameter fuer *pvar im Falle 'key==2' (double-Ausgabe) ***/
	double var;	
   /*** Formatschluessel interpretieren ***/
	switch ( key )
	{   
	    case 'p' :	t = fputfl( *pvar, *pk, pf ); break;
	    case 'x' :	t = fputflfx(*pvar, *pk, *(pk + 1), pf ); break;
	    case 'b' :	t = fputbits( *pvar, pf );  break;
	    case 'i' :	t = fputi( *pvar, pf );	 break;
	    case 'l' :	t = fputl( *pvar, pf );	 break;
	    case 'o' :	t = fputo( *pvar, pf );	 break;
	    case 'r' :	t = fputr( *pvar, pf );	 break;
	    case 't' :	t = ftab( *pvar, pf );	 break;
	    case '0' :	/* string-Abschnitt ohne Schluessel */
	    case  2  :	/* ... mit double-Schluessel */
	    case  1  :	/* ... mit anderem 'C'-bekanntem Schluessel */
			break;
	    default  :	t = fputrd( *pvar, -key, pf );
	}
	if ( t == EOF )	 return( EOF );
   /*** Formatstring nach 'xform' kopieren ***/
	if ( len )  strncpy( xform, pa, len );
	*(xform + len) = '\0';

   /*** Ausgabestring erstellen ***/
	if ( key == 2 )	 {
		/* double-Schluessel */
		var = *(double*)pdvar;
		sprintf( xstr, xform, var );
	}
	else	if ( pvar )  sprintf( xstr, xform, *pvar );
	else	sprintf( xstr, xform );

   /*** ausgeben ***/
	return( fputs(xstr,pf) );
}

/* Voreinstellung rationals */	   
#define RATDEFNK 10
/* Voreinstellung floats */
#define FLDEFVK 1    /* Vorkommastellen */
#define FLDEFNK 8    /* Nachkommastellen*/
#define FLDEFMT 8   /*	Mantissestellen */

static single xxfprintf ( pf, format, a, ad )
FILE *pf; 
char *format;
obj *a;	      
double *ad; 
{
	register short	stc=0, cnt=0, ct;
	char *ptr = format;

   /*** Felder zur Aufbereitung des Formatstrings ***/
	obj  *pvar = a;	 
	double *pdvar = ad; 

	static char *xpfeld[2][27];
	char **ppa = xpfeld[0],	 **ppe = xpfeld[1];
	static single xkfeld[27];    
	static single flfeld[54];
	single	key,  *pkey = xkfeld, *pfl = flfeld; 
	single b, c, hilf;

   /*** Aufbereitung des Formatstrings ***/
	do {
	    *(ppa + cnt) = ptr--;
	    while ( *++ptr != '\0' && ( *ptr != '%' || *++ptr == '%' ) );
	    *(ppe + cnt) = ptr-2;
	    switch ( key = *ptr )
	    {
	   /*** Stringende ***/
		case '\0':  ++ *(ppe + cnt++);	break;

	   /*** neue Schluessel ***/
		case 'a' :  *ptr = 'd';
			    *(pkey + cnt++) = 1;  break;    
		case 'p' :  *(pfl++) = FLDEFMT;
		case 'b' :
		case 'i' :
		case 'l' :
		case 'r' :
		case 't' :
		case 'o' :		  
			    if (key=='o' && ( *++ptr!='b' || *++ptr!='j' ))
				    key = 'C';
			    else  ptr++;
			    *(pkey + cnt++) = key;
			    break;

	   /*** Dezimalpunkt mit 'rat' oder mit 'C'-bekanntem Schluessel ***/
		case '.' :  if ( isdigit( key = *++ptr ) ) {
				*(pkey + cnt) =	 '0' - key;
				while ( isdigit( key = *++ptr ) )
				  *(pkey + cnt) = 10 * *(pkey + cnt) - key + '0';
				}     
			    else if( key == 'p') *(pkey + cnt) = -FLDEFNK;   
			    else *(pkey + cnt) = -RATDEFNK;
			    switch ( key )  {
				case 'r' :  ptr++; break;     

				case 'p' :  ptr++;
					    *(pfl++) = FLDEFVK; 
					    *(pfl++) = -(*(pkey + cnt));
					    *(pkey + cnt) = 'x';break;	 
					    
				case 'e' :
				case 'f' :
				case 'g' :  *(pkey + cnt) = 2;	break;
				case '\0':  key = 'X';
				default	 :  *(pkey + cnt) = 1;
			    }
			    cnt++;  break;

	   /*** anderer 'C'-bekannter Schluessel oder digits folgend ***/
		default	 :  if (isdigit(key)) {
				b = key - '0';
				while ( isdigit( key = *++ptr) ) 
				    b = 10 * b + key - '0';	  
				if (key == '.') {   
				    if (isdigit( key = *++ptr ) ) { 
					c = key - '0';
					while ( isdigit( key = *++ptr) ) 
					     c = 10 * c + key - '0';  
					}
				    else c = FLDEFNK;	    
				    if ( key  == 'p') { 
					*(pfl++) = b; *(pfl++) = c;	  
					*(pkey + cnt++) = 'x';	   
					ptr++;
					}
				    else c = -1;
				    }
				else if ( key == 'p') {
				    *(pfl++) = b; ptr++;   
				    *(pkey + cnt++) = 'p';  
				    c = 0;
				    }			  
				else c = -1;
				} 
			    else c = -1; 
			    if (c < 0 ) { 
			      while (!isalpha( key = *ptr ))  ptr++;
			      switch ( key )
			      {	      
				case 'p' :  *(pfl++) = b;
					    if ( c >= 0 ) { 
						*(pfl++) = c;
						*(pkey + cnt++) = 'x';	
						}
					    else *(pkey + cnt++) = 'p';	   
					    ptr++;
					    break; 
				case 'e' :
				case 'f' :
				case 'g' :  *(pkey + cnt++) = 2; break;
				default	 :  *(pkey + cnt++) = 1; break;
				}     
			      }
			    break;
	    }
	}
	while ( key != '\0' );


   /*** SIMATH-Datentypen in Referenzliste eintragen ***/
	for ( ct = cnt;	 --ct;	pvar++ )
		switch ( hilf=(*pkey), pkey++, hilf ) /* "*pkey" in Klammern   */
		{				      /* wegen Apollo und "*=" */
		    case  2  :	
		    case  1  :
		    case 'b' :
		    case 't' :
		    case '0' :	break;
		    case 'i' :		  
		    case 'p' :
		    case 'x' :
		    case 'l' :
		    case 'o' :
		    case 'r' :	bind( *pvar );
				/* Praeprozessor ueberlisten */
				stc++,	ST_INDEX++;
		} 

	pvar = a;
	pkey = xkfeld;
	pfl = flfeld;

   /*** abschnittsweise Ausgabe bis zum ersten Schluessel ***/
	if ( fprintfsub( pf, NULL, NULL, *ppa++, *ppe, (single)'0', pfl ) )  goto ERR;

   /*** Abschnitte mit Schluessel und nachfolgendem String ***/
	while ( --cnt )

       /*** 'C'-bekannter Schluessel mit 4- bzw. 8-byte-Variable ***/
	    if ( (key = *pkey++) == 1  ||  key == 2 )  {
		ppa++,	ptr = *ppe++;
		if ( fprintfsub( pf, pdvar, pvar, ptr+1, *ppe, key, pfl ) )  goto ERR;
		pvar++;	 
		pdvar++; 
	    }

       /*** 'simath'-Schluessel ***/	 
	    else if ( key == 'p' ) {	 
		ptr = *ppa++;
		if ( fprintfsub( pf, pdvar++, pvar++, ptr, *++ppe, key, pfl++ ) )  goto ERR;
	    }
	    else if ( key == 'x' ) {	 
		ptr = *ppa++;		   
		if ( fprintfsub( pf, pdvar++, pvar++, ptr, *++ppe, key, pfl ) )	 goto ERR;
		pfl += 2;
	    }
	    else  {
		ptr = *ppa++;
		if ( fprintfsub( pf, pdvar++, pvar++, ptr, *++ppe, key, pfl ) )	 goto ERR;
	    }

   /*** Ende ***/
	ST_INDEX -= stc;
	fflush(pf);
	return( 0 );

   /*** Fehlermeldung ***/
  ERR:	errmsgio( "fprintf", "EA108" );
	ST_INDEX -= stc;
	return( -1 );
}

	
/***	Header varargs.h einbinden, falls vorhanden, bzw. simu-	     ***/
/***	lieren, falls nicht vorhanden (naemlich auf MX2 und MX2+)    ***/

# include <varargs.h>

#undef printf
#undef fprintf

#define ARG_MAX_ANZAHL 101

xfprintf(va_alist)
va_dcl
{
	va_list pvar;
	char *formatstring,*p,ch;
	char on=0, reformatted=0; /* boolean */
	int args[ARG_MAX_ANZAHL];
	double dargs[ARG_MAX_ANZAHL];
	single i, argno, fmtlen;
	FILE *pf;

	va_start(pvar);

	/* target file */
	pf = va_arg(pvar, FILE*);

	/* Formatstring */
	formatstring = va_arg(pvar,char*);

	/* Argumentenliste durchhangeln */
	argno = 0;	    

	for ( p=formatstring; (ch=(*p))!='\0' ; p++ ) {
	    if ( ch == '%' ) {
		on = !on;
		fmtlen = 1;
	    }
	    else if ( on && isalpha( ch ) ) {
		if ( ch == 's' ) {
		    char *target, *newfmt, *fmtdtarget;
		    size_t prelength = p-formatstring-fmtlen, tlen;
		    FILE *devnull;

		    target = va_arg(pvar, char*);
		    if (fmtlen>1) {
			char *sfmt = (char*)malloc(fmtlen+2);

			strncpy(sfmt, p-fmtlen, fmtlen+1);
			*(sfmt+fmtlen+1)='\0';
			devnull = fopen("/dev/null","w");
			if (devnull != NULL) {
			    tlen = fprintf(devnull, sfmt, target);
			    fclose(devnull);
			}
			if (tlen<=0) {
			    /* when opening or writing to /dev/null fails
			     * we ASSUME there is no padding with spaces. */
			    tlen = strlen(target);
			}
			fmtdtarget = (char*)malloc(tlen+1);
			sprintf(fmtdtarget, sfmt, target);
			free(sfmt);
		    }
		    else {
			tlen = strlen(target);
			fmtdtarget = (char*)malloc(tlen+1);
			strcpy(fmtdtarget, target);
		    }
		    newfmt = (char*)malloc(strlen(formatstring)+tlen+1);
		    strncpy(newfmt,formatstring,prelength);
		    *(newfmt+prelength)='\0';
		    strcat(newfmt,fmtdtarget);
		    prelength = strlen(newfmt);
		    strcat(newfmt,(p+1));
		    p = newfmt + prelength;
		    if (reformatted)
			free(formatstring);
		    else
			reformatted = 1;
		    free(fmtdtarget);
		    formatstring = newfmt;
		}
		else if ( (ch == 'e') || 
			  (ch == 'f') || 
			  (ch == 'g') ) 
		    dargs[argno++] = va_arg(pvar, double);
		else
		    args[argno++] = va_arg(pvar, int);
		if ( argno >= ARG_MAX_ANZAHL ) { 
		    printf("Error in xfprintf:\n");
		    printf( "*** You have too many Arguments in your 'fprintf'-call ***\n"); 
		    exit(1); 
		}

		on = 0; 
	    }
	    else {
		fmtlen++;
	    }
	}

	if ( on ) {
	    printf("Error in xprintf: wrong format string: %s\n", formatstring );
	    exit(1);
	}


	va_end(pvar);

	i = xxfprintf( pf, formatstring, args, dargs);

	if (reformatted)
	    free(formatstring);

	return( i ); 

}	
