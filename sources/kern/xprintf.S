/*M
.SH NAME
xprintf - print formated, internal version

.SH SYNOPSIS
.nf
#include<_list.h>
 
single xprintf( format [,arg]... )
char *format;

.SH DESCRIPTION
At most, 26 arguments (without the format-string) are allowed. 
printf writes the arguments to stdout (according to the directions given in format). printf returns 0 by success and a negative number else.
For the format string, see CES book 2, pp 2-123. The following changes are made:

.TP 4
l 
(as prefix of d, o, u, x) is not allowed.
.TP 4
d, o, u, x
refer only to numbers of type singles.
.PP
New formats:
.TP 4
%a
decimal notation of an atom.
.TP 4
%b
binary pattern of a number of type single.
.TP 4
%i
decimal notation of an integral number.
.TP 4
%l
list.
.TP 4
%obj 
object.
.TP 4
%r
representation of a rational number as fraction.
.TP 4
%.[m]r
decimal notation of a rational number. m denotes the number of decimal digits
(%.r is equal to %.10r).
.TP 4
%[m]p
exponent-representation of a number of type real. m denotes the number of the mantissa digits (default m = 8).
.TP 4
%[n].[m]p
representation of a number of type real with n digits in front of the decimal point and m digits after. Less than n digits in front of the decimal point will be filled with blanks, more than n digits will be printed anyhow. (default n = 1, m = 8).
.TP 4
%t
(to the argument single n, n < LN-SIZE) 
The beginning of the actual line will be idented by n characters (if possible).

M*/
/*H
	Version	 1	04.03.1987	R. Boeffgen
	Version	 2	07.04.1988	xausgabe -> printfsub	M.A. R.
	Version	 3	23.04.1988	SIMATH-Typen gebunden	 R.B.
	Version	 4	14.12.1988	an SUN-xprintf angepasst.  P.S.
	Version	 5	26.04.1989	ueberfluessige Variablen b,...,z
					geloescht und Warnung in die Doku-
					mentation geschrieben, dass nicht
					mehr als 26 Argumente uebergeben
					werden duerfen.	 P.S.
	Version	 6	30.10.1989	V. Schwinn: fuer Apollo in xprintf
					bei korrekter Beendigung vor return(0)
					fflush(stdout) eingebaut.
	Version	 7	10.11.1989	simath - Header eingebunden J.S.
	Version	 8	07.12.1989	einheitl. Version fuer MX2(+), SUN
					und Apollo. P.S.
	Version	 9	30.10.1990	varargs eingebaut, damit das Pro-
					gramm auch auf SUN4 laeuft.  P.S.
	Version 10	28.03.1990	floatings eingebaut.  M.C.
	Version 11	09.07.1991	fflush(stdout) auch fuer SUNs.	P.S.
	Version 12	27.08.1991	"switch (*pkey++)" ->
					"switch (hilf=(*pkey),pkey++,hilf)",
					da Apollo10000 sonst abstuerzt.
					xxprintf als static-Modul.  PS
	Version 13	12.12.1991	fflush(stdout) auch fuer MX300.	 PS
	Version 14	01.12.1993	Anpassung an HP.  MC
	Version 15	22.04.1994	malloc durch Arrays ersetzt. MC
					MX-Version entfernt. MP
	Version 16	27.94.1996	"if isdigit (key)" replaced by 
					"if (isdigit (key))". MP
   DATE xprintf	      : 890501.891030.891110.900101.901120.910715.910915.911215.940315.941201.960601
H*/

# include <_simath.h> 			/* why not _list.h? */

static single printfsub ( pdvar, pvar , pa , pe , key, pk )
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
	    case 'p' :	t = putfl( *pvar, *pk ); break;
	    case 'x' :	t = putflfx(*pvar, *pk, *(pk + 1) ); break;
	    case 'b' :	t = putbits( *pvar );  break;
	    case 'i' :	t = puti( *pvar );  break;
	    case 'l' :	t = putl( *pvar );  break;
	    case 'o' :	t = puto( *pvar );  break;
	    case 'r' :	t = putr( *pvar );  break;
	    case 't' :	t = tab( *pvar );   break;
	    case '0' :	/* string-Abschnitt ohne Schluessel */
	    case  2  :	/* ... mit double-Schluessel */
	    case  1  :	/* ... mit anderem 'C'-bekanntem Schluessel */
			break;
	    default  :	t = putrd( *pvar, -key );
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
	return( puts(xstr) );
}

/* Voreinstellung rationals */	   
#define RATDEFNK 10
/* Voreinstellung floats */
#define FLDEFVK 1    /* Vorkommastellen */
#define FLDEFNK 8    /* Nachkommastellen*/
#define FLDEFMT 8   /*	Mantissestellen */

static single xxprintf ( format, a, ad )
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
	if ( printfsub( NULL, NULL, *ppa++, *ppe, (single)'0', pfl ) )	goto ERR;

   /*** Abschnitte mit Schluessel und nachfolgendem String ***/
	while ( --cnt )

       /*** 'C'-bekannter Schluessel mit 4- bzw. 8-byte-Variable ***/
	    if ( (key = *pkey++) == 1  ||  key == 2 )  {
		ppa++,	ptr = *ppe++;
		if ( printfsub( pdvar, pvar, ptr+1, *ppe, key, pfl ) )	goto ERR;
		pvar++;	 
		pdvar++; 
	    }

       /*** 'simath'-Schluessel ***/	 
	    else if ( key == 'p' ) {	 
		ptr = *ppa++;
		if ( printfsub( pdvar++, pvar++, ptr, *++ppe, key, pfl++ ) )  goto ERR;
	    }
	    else if ( key == 'x' ) {	 
		ptr = *ppa++;		   
		if ( printfsub( pdvar++, pvar++, ptr, *++ppe, key, pfl ) )  goto ERR;
		pfl += 2;
	    }
	    else  {
		ptr = *ppa++;
		if ( printfsub( pdvar++, pvar++, ptr, *++ppe, key, pfl ) )  goto ERR;
	    }

   /*** Ende ***/
	ST_INDEX -= stc;
	fflush(stdout);
	return( 0 );

   /*** Fehlermeldung ***/
  ERR:	errmsgio( "printf", "EA108" );
	ST_INDEX -= stc;
	return( -1 );
}

	
/***	Header varargs.h einbinden, falls vorhanden, bzw. simu-	     ***/
/***	lieren, falls nicht vorhanden (naemlich auf MX2 und MX2+)    ***/

# include <varargs.h>

#undef printf
#undef fprintf

#define ARG_MAX_ANZAHL 100
/* maximale Anzahl von Argumenten pro printf-Aufruf */

single xprintf(va_alist)
va_dcl
{
	va_list pvar;
	char *formatstring,*p,ch;
	char on=0, reformatted=0; /* boolean */
	int args[ARG_MAX_ANZAHL];
	double dargs[ARG_MAX_ANZAHL];
	single i, argno, fmtlen;

	va_start(pvar);

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
		    printf("Error in xprintf:\n");
		    printf( "*** You have too many Arguments in your 'printf'-call ***\n");
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

	i = xxprintf( formatstring, args, dargs);

	if (reformatted)
	    free(formatstring);

	return( i );

}
