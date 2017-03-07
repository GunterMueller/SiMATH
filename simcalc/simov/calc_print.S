/*C
			calc_print( arg, d )

	"calculator print".
	list calc_print(arg,d); char *arg; single *d;
	erg = calc_print( arg, d );
	Laeuft calc_if fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.04.1994      S.Schmitt/U.Schneiders
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

void inter_pr()
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

void inter_prco()
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


 

list calc_print( s, d )
char *s;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single l=1, z=1, z1=0, z2=0, m=0, kop = 1;
	single i, j, ow, stat;
	char hilf[MAXLV];
	*hilf = '\0';

	/*** Bearbeitung von print-Aufrufen ***/
	
	*d=0;
	assch = 2;
	ow=owsch;
	owsch=0;
	stat=statsch;
	statsch=0;

	/*** Erkennung und Auswertung der zu einem Funktionsaufruf
	     gehoerenden Parameter ***/
	
	while ( *(s+l) != '\0' && z )
	{       switch( *( s+l ) )
		{       case '(': if(seven(z2)) ++z;
				  break;
			case ')': if(seven(z2)) --z;
				  break;
			case '{': if(seven(z2)) ++z1;
				  break;
			case '}': if(seven(z2)) --z1;
				  break;
			case '"': if( z==1 && (!l || *(s+l-1) !='\\'))
				  {	if(kop) kop = 0;
					else kop = 1;
				  	++z2;
				  }
				  break;
			default: break;
		}
		if(kop && *(s+l)=='"' && z==1)   /** Ausgabe eines Strings **/
		{	*(hilf+m) = '\0';
			puts(hilf+1);
			if(ps) fputs(hilf+1, datei);
			for(i=0;i<m+1;i++) *(hilf+i)='\0';
			m=0;
		}		

		/** Rechnung **/

		else if(kop && ( (*(s+l)==',' && z==1 && z1==0 ) || !z))
		{	if(m){
			*(hilf+m) = '\0';
			if(strchr(hilf,';')!=NULL || strchr(hilf,'_')!=NULL
	     || (instring(hilf,"for", &i)  && !instring(hilf,"elform",&i))
	     || instring(hilf,"while", &i) || instring(hilf,"if", &i) 
	     || instring(hilf,"break", &i) || instring(hilf,"continue", &i)
	     || instring(hilf,"owon", &i)  || instring(hilf,"owoff",&i) 
	     || instring(hilf,"staton", &i)|| instring(hilf,"statoff",&i) 
	     || instring(hilf,"logon", &i) || instring(hilf,"logoff",&i) 
	     || instring(hilf,"loglist",&i)|| instring(hilf,"exit", &i) 
	     || instring(hilf,"quit", &i)  || instring(hilf,"vardel", &i) 
	     || instring(hilf,"print", &i) || instring(hilf,"fopen", &i) 
	     || instring(hilf,"fclose", &i)|| instring(hilf,"fread", &i) 
	     || instring(hilf,"openf", &i) || instring(hilf,"fload", &i)
	     || (instring(hilf,"decl",&i)  && !instring(hilf,"declaw",&j))
	     || (instring(hilf,"decl",&i)  && instring(hilf,"declaw",&j) 
	         && i!=j )
	     || instring(hilf,"return", &i)|| instring(hilf,"nfon", &i) 
	     || instring(hilf,"nfoff",&i)  || instring(hilf,"avon", &i) 
	     || instring(hilf,"avoff",&i)  || instring(hilf, "ppon", &i)
	     || instring(hilf, "ppon", &i ) ) 
			{	mistake(311);
				owsch=ow;
				statsch=stat;
				assch=0;
				while ( *(s+l) != '\0' && z )
				{       switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(!l || *(s+l-1) !='\\')
				  				++z2;
				  			  break;
						default: break;
					}
					l++;
					(*d)++;
				}
				return(ERROR);
			}
			*(hilf+m) = ';';
			*(hilf+m+1) = '\0';
			rechnung(hilf, inter_pr, inter_prco, 0);
			if(prfehl==1)
			{	schleiback();
				prfehl=0;
				owsch=ow;
				statsch=stat;
				assch=0;
				while ( *(s+l) != '\0' && z )
				{       switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(!l || *(s+l-1) !='\\')
				  				++z2;
				  			  break;
						default: break;
					}
					l++;
					(*d)++;
				}
				return(ERROR);
			}
			schleiaus(0);
			for(i=0;i<m;i++) *(hilf+i)='\0';
			m=0;
			}
		}	
		else if(kop && *(s+l)!=' ' && *(s+l)!='"' )  /** Rechnung kopieren **/
		{	*(hilf+m) = *(s+l);
			m++;
		}
		else if(!kop)   /** String kopieren **/
		{	if(*(s+l)=='"' && m>0) m--;   /** \" **/
			*(hilf+m) = *(s+l);
			m++;
		}
		++l;
		(*d)++;
	}
	owsch = ow;
	statsch = stat;
	assch=0;

	if(!schleife && assch<2 && !funktion)
	{	tdiff = settime(); tabs+=tdiff;
		if(statsch) statistic(tdiff);
	}
	printf("\n");
	if(ps) fprintf(datei,"\n");

	return( ERROR-1 );
}
