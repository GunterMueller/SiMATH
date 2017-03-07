/*C
			calc_if( arg, d )

	"calculator if".
	list calc_if(arg,d); char *arg; single *d;
	erg = calc_if( arg, d );
	Der zum if-Aufruf gehoerige Eingabestring wird bestimmt und 
	ausgewertet. Die Laenge des ausgewerteten Strings wird *d 
	zugewiesen. erg ist das Ergebnis der if-Anweisung.
	Laeuft calc_if fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      05.11.1993      S.Schmitt/U.Schneiders
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

void inter_if()
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
	if ( statsch ) statistic( tdiff );

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

void inter_ifco()
{	single i;

	printf("\n ********     Fatal Error     ********\n\n");
	if(ps) fprintf(datei,"\nout: ********     Fatal Error     ********\n\n");
	tdiff = settime(); tabs+=tdiff;
	if ( statsch ) statistic( tdiff );

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


 

list calc_if( arg, d )
char *arg;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=1, j=0, mk=0, sch=0, k, gz=0;
	char arg1[ MAXLV ], seq1[MAXLV], seq2[MAXLV];
	list erg;
	init( erg );
	arg += 1;
	*arg1 = '\0';
	*seq1='\0';
	*seq2='\0';

	/*** Bearbeitung von if-Aufrufen ***/

	*d = 0;

	/*** Erkennung und Auswertung der zu einem Funktionsaufruf
	     gehoerenden Parameter ***/

	while ( i && sch<=2 ) {
		switch( *(arg+*d) ) {
			case '(': if(seven(gz)) ++i;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(seq1+j)= *(arg+*d);
				  else *(seq2+j)= *(arg+*d);
				  j++;
				  break;
			case ')': if(seven(gz)) --i;
				  if ( i ) 
				  {     if(!sch) *(arg1+j) = *(arg+*d); 
					else if(sch==1) *(seq1+j)= *(arg+*d);
					else *(seq2+j)= *(arg+*d);
					++j;
				  }
				  else *(seq2+j) = '\0';
				  break;
			case '{': if(seven(gz)) ++mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(seq1+j)= *(arg+*d);
				  else *(seq2+j)= *(arg+*d);
				  j++;
				  break;
			case '}': if(seven(gz)) --mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(seq1+j)= *(arg+*d);
				  else *(seq2+j)= *(arg+*d);
				  j++;
				  break;
			case '"': if(*(arg + *d - 1) !='\\') gz++;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(seq1+j)= *(arg+*d);
				  else *(seq2+j)= *(arg+*d);
				  j++;
				  break;
			case ',': if ( i == 1 && !mk ) {
				  	if(!sch) *(arg1+j) = '\0'; 
				  	else if(sch==1) *(seq1+j)='\0';
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
				  	else if(sch==1) *(seq1+j)= *(arg+*d);
				  	else *(seq2+j)= *(arg+*d);
				  	j++;
				  }	
				  break;
			default : if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(seq1+j)= *(arg+*d);
				  else *(seq2+j)= *(arg+*d);
				  j++;
				  break;
		}
		*d = (*d) + 1;
	}
	while(i)
	{  if(*(arg+*d)=='(')
		i++;
	   else if(*(arg+*d)==')')
		i--;
	   *d = (*d) + 1;
	}
	if ( sch != 2 ) 
	{	mistake(232);
		return( list2(0,strlen(arg)) );
	}
	if(strlen(arg1)==0 || instring(arg1,"_",&i) || instring(arg1,";",&i))
	{	mistake1(34,"if");
		return(list2(1,strlen(arg1)));
	}

	/** Auswertung von arg1 **/

	
	erg=basad(arg1);
	if(erg==ERROR || erg == ERROR-1) 
	{	if( erg == ERROR-1 ) mistake(32);
		return(list2(1,strlen(arg1)));
	}
	k=lsecond(erg);
	if(k && k!=1 && k!=15 && k!=17 && k!=24 && k!=31 && k!=37)
	{	mistake1(34,"if");
		return(list2(1,strlen(arg1)));
	}
	erg=lfirst(erg);

	/** if (erg) then seq1 else seq2 **/

	if(erg) 
	{	if(strlen(seq1)) seqbasad(seq1,inter_if,inter_ifco,0,1);	
	}
	else
	{	if(strlen(seq2)) seqbasad(seq2,inter_if,inter_ifco,0,1);
	}
	return( ERROR-1 );
}
