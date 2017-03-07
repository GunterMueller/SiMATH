/*C
			calc_while( arg, d )

	"calculator while".
	list calc_while(arg,d); char *arg; single *d;
	erg = calc_while( arg, d );
	Der zum while-Aufruf gehoerige Eingabestring wird bestimmt und 
	ausgewertet. Die Laenge des ausgewerteten Strings wird *d 
	zugewiesen. erg ist das Ergebnis der while-Anweisung.
	Laeuft calc_while fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      05.11.1993      S.Schmitt/U.Schneiders
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

void inter_while()
{
	single i;

	if ( sch1) {
		printf("\n ********    Result is computed.     ********\n");
		printf(" ********   Output is interrupted.   ********\n\n");
		if ( ps) {
		       fprintf(datei, "\nout: ********    Result is computed.     ********\n");
		       fprintf(datei, "out: ********   Output is interrupted.   ********\n\n");
		}
	}
	else {
		printf("\n ********     Calculation is interrupted.     *********\n\n");
		if ( ps) fprintf(datei,"\nout: ********     Calculation is interrupted.     ********\n\n");
	}
	tdiff = settime(); tabs+=tdiff;
	/*if ( statsch ) statistic( tdiff );*/

	for( i = MXNUM; i < MX; i++ )        
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

void inter_wco()
{	single i;

	printf("\n ********     Fatal Error     ********\n\n");
	if(ps) fprintf(datei,"\nout: ********     Fatal Error     ********\n\n");
	tdiff = settime(); tabs+=tdiff;
	/*	if ( statsch ) statistic( tdiff );*/

	for( i = MXNUM; i < MX; i++ )        
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


 

list calc_while( arg, d )
char *arg;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single merk=0, i=1, j=0, mk=0, sch=0, k,ow, stat, gz=0;
	single aus=1;
	char arg1[ MAXLV ], seq1[MAXLV];
	list erg;
	init( erg );
	arg += 1;
	*arg1 = '\0';
	*seq1='\0';
	if(assch) aus=0;   /** keine Ausgabe am Ende **/
	assch=0;
	
	/*** Bearbeitung von while-Aufrufen ***/

	*d = 0;

	/*** Erkennung und Auswertung der zu einem Funktionsaufruf
	     gehoerenden Parameter ***/

	while ( i && sch<=1 ) {
		switch( *(arg+*d) ) {
			case '(': if(seven(gz)) ++i;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else  *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case ')': if(seven(gz)) --i;
				  if ( i ) 
				  {     if(!sch) *(arg1+j) = *(arg+*d); 
					else *(seq1+j)= *(arg+*d);
					++j;
				  }
				  else *(seq1+j) = '\0';
				  break;
			case '{': if(seven(gz)) ++mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case '}': if(seven(gz)) --mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case '"': if(*(arg + *d - 1) !='\\') gz++;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case ',': if ( i == 1 && !mk ) {
				  	if(!sch) *(arg1+j) = '\0'; 
					sch++;
					if(sch==1 && !isbracor(arg1,0)) 
					{	while(i)
						{  if(*(arg+*d)=='(')
							i++;
						   else if(*(arg+*d)==')')
							i--;
						   *d = (*d) + 1;
						}
						return(ERROR);
					}
				        j = 0;
				  }
				  else
                                  {     if(!sch) *(arg1+j) = *(arg+*d); 
				  	else *(seq1+j)= *(arg+*d);
				  	j++;
				  }	
				  break;
			default : if(!sch) *(arg1+j) = *(arg+*d); 
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
		}
		*d = (*d) + 1;
	}
	while(i)
	{	if(*(arg+*d)=='(')
			i++;
		else if(*(arg+*d)==')')
			i--;
		*d = (*d) + 1;
	}
	if ( sch != 1 ) 
	{	mistake(232);
		return( list2(0,strlen(arg)) );
	}
	if(strlen(arg1)==0 || instring(arg1,"_",&i) || instring(arg1,";",&i))
	{	mistake1(34,"while");
		return(list2(1,strlen(arg1)));
	}
	if(!schleife)    /** in aeusserster Schleife **/
	{	schleife=1;
		merk=1;
	}

	/** Auswertung von arg1 **/

	erg=basad(arg1);
	if(erg==ERROR || erg == ERROR-1) 
	{	if( erg == ERROR-1 ) mistake(32);
		if(merk) schleife=0;
		if(erg==ERROR-1) return(list2(1,strlen(arg1)));
		else return(ERROR);
	}
	k=lsecond(erg);
	if(k && k!=1 && k!=15 && k!=17 && k!=24 && k!=31 && k!=37)
	{	mistake1(34,"while");
		if(merk) schleife=0;
		return(list2(1,strlen(arg1)));
	}
	erg=lfirst(erg);
	ow=owsch;
	owsch=0;
	stat=statsch;
	statsch=0;

	/** while - Schleife **/

	while(erg)
	{	if(strlen(seq1)) 
		{	seqbasad(seq1,inter_while, inter_wco,0,0);
/**			if(fosch==1 && errstop())**/
			if(fosch==1 || fosch ==2 )
			{
				if(merk)
				{	owsch=ow;
					statsch=stat;
					fosch=0;
					schleife=0;
					schleiback();
				}
				return(ERROR);
			}
	/**		else if(fosch==1) fosch=0;**/
			else
			{	if(breaksch==1)    /** break **/
				{	breaksch=0;
					break;
				}
				else if(breaksch == 2)  /** continue **/
					breaksch = 0;
				else if(breaksch == (-1))  /**return aus Fkt.**/
				{	
					if(merk)
					{	owsch=ow;
						statsch=stat;
						schleife=0;
						schleiback();
					}
					return(ERROR-1);
				}
			}
		}
		else  
		{	if(merk) 
			{	owsch=ow;
				statsch=stat;
				schleife=0;
				schleiback();
			}
			return(ERROR);
		}

	/** Auswertung von arg1 **/

		erg=basad(arg1);
		if(erg==ERROR || erg == ERROR-1) 
		{	if( erg == ERROR-1 ) mistake(32);
			if(merk) 
			{	owsch=ow;
				statsch=stat;
				schleife=0;
				schleiback();
			}
			if(erg==ERROR-1) return(list2(1,strlen(arg1)));
			else return(ERROR);
		}
		k=lsecond(erg);
		if(k && k!=1 && k!=15 && k!=17 && k!=24 && k!=31 && k!=37)
		{	mistake1(34,"while");
			if(merk) 
			{	owsch=ow;
				statsch=stat;
				schleife=0;
				schleiback();
			}
			return(list2(1,strlen(arg1)));
		}
		erg=lfirst(erg);
	}	
	if(merk)
	{	owsch=ow;
		statsch=stat;
		schleife=0;
		schleiaus(aus);
	}
	return( ERROR-1 );
}
