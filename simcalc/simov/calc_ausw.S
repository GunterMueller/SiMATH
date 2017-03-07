/*C
			calc_ausw( sch, arg, d, loc)

	"calculator Auswertung".
	list calc_ausw(sch,arg,d, loc); char *arg; single sch, *d, loc;
	erg = calc_ausw( sch,arg, d, loc );
	Die zu sch gehoerende Funktion wird bestimmt und mit den
	Parametern aus arg ausgewertet.  Die Laenge des ausgewerteten 
	Strings wird *d zugewiesen. erg ist das Ergebnis der \
	Funktionsauswertung.
	Laeuft calc_ausw fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      18.05.1994      S.Schmitt/U.Schneiders
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

void inter_asw()
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

void inter_aswco()
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


 

list calc_ausw( sch, arg, d, loc)
char *arg;
single sch, *d, loc;

{       /*** Deklarationen und Vorbesetzungen ***/

	single l=1, zk=0, zt=0, kl=1, klm=0, gz=0;
	single stel, t=0, n=0, j, i, g, stat;
	single merk=0;
	list erg;
	char arg1[ MAXLV ];
	init(erg);

	if(loc) stel=localvar[-sch-2].varwert;
	else stel=varlist[-sch].varwert;
	*d=0;

	/** Parameter Anzahl **/
	
	if(*(funstr[stel]+t)!='~') zt=1;	
	while(*(funstr[stel]+t)!='~')
	{	if(*(funstr[stel]+t)=='#') zt++;
		t++;
	}
	while(*(arg+l)!=')')
	{	if(*(arg+l)!=' ')
		{	zk=1; 
			break;
		}
		l++;
	}
	l=1;
	while(kl)
	{	switch(*(arg+l))
		{	case '(': kl++;
				  break;
			case ')': kl--;
				  break;
			case '{': klm++;
				  break;
			case '}': klm--;
				  break;
			case ',': if(!klm && kl==1) zk++;
				  break;
		}
		l++;
	}
	*d=l;
	if(zt!=zk)
	{	mistake(3);
		return(ERROR);
	}

	kl=1;
	for(l=0;l<anzloc;l++)
		if(!strcmp(localvar[l].varname,"#")) kl++;	
	if(kl>DEPTH)
	{	mistake(330);
		prfehl=(-1);
		return(ERROR);
	}
	strcpy(localvar[anzloc].varname,"#");
	localvar[anzloc].varwert = 0;
	anzloc++;
        if(anzloc>=MX)
        {	mistake1(317,MX);
		localback(1);
		return(ERROR);
        }

	/** Parameter Auswertung **/

	t=0;
	if(zt){
	kl=1; klm=0; l=1; zk=0; zt=0;
	*arg1 = '\0';	
	while(kl)
	{	if(sodd(gz) || *(arg+l)!=' ')
		{	*(arg1+zk) = *(arg+l);	
			zk++;
		}
		switch(*(arg+l))
		{	case '(': if(seven(gz)) kl++;
				  break;
			case ')': if(seven(gz)) kl--;
				  break;
			case '{': if(seven(gz)) klm++;
				  break;
			case '}': if(seven(gz)) klm--;
				  break;
			case '"': if(*(arg+l-1) !='\\')
				  	++gz;
				  break;
			case ',': if(seven(gz) && !klm && kl==1)
				  {   if(zk<2)
				      {	mistake(3);
					localback(zt+1);
					return(ERROR);
				      } 
				      *(arg1+zk-1) = '\0'; 
				      if(funktion) 
				      {	merk=1;
					funktion++;
				      }
				      erg = basad(arg1);
				      if(merk)
				      {	merk=0;
					funktion--;
				      }
				      if(erg==ERROR || erg==ERROR-1)
				      {	if(erg==ERROR-1) mistake(32);
					localback(zt+1);
					return(ERROR);
				      }
				      while(*(funstr[stel]+t)!='#')
				      {   localvar[anzloc-1].varname[n]= *(funstr[stel]+t);
				          n++;
				          t++;
				      }
				      t++;
				      localvar[anzloc-1].varname[n]='\0';
				      localvar[anzloc-1].varwert=erg;
				      zt++;
				      strcpy(localvar[anzloc].varname,"#");
				      localvar[anzloc].varwert = zt;
				      anzloc++; 
				      if(anzloc>=MX)
				      {	mistake1(317,MX);
					localback(zt+1);
					return(ERROR);
				      }
				      for(j=0;j<zk;j++) *(arg1+zk)='\0';
				      zk=0; n=0;
				  }	
				  break;
		}
		l++;
	}
	if(zk<2)
	{	mistake(3);
		localback(zt+1);
		return(ERROR);
	}
	*(arg1+zk-1) = '\0'; 
	if(funktion)
	{	merk=1;
		funktion++;
	}
	erg = basad(arg1);
	if(merk)
	{/*	merk=0;*/
		funktion--;
	}
	if(erg==ERROR || erg==ERROR-1)
	{	if(erg==ERROR-1) mistake(32);
		localback(zt+1);
		return(ERROR);
	}
        while(*(funstr[stel]+t)!='~')
        {   localvar[anzloc-1].varname[n]= *(funstr[stel]+t);
	    n++;
	    t++;
	}
	localvar[anzloc-1].varname[n]='\0';
	localvar[anzloc-1].varwert = erg;
	zt++;
	strcpy(localvar[anzloc].varname,"#");
	localvar[anzloc].varwert = zt;
	anzloc++;
	if(anzloc>=MX)
	{	mistake1(317,MX);
		localback(zt+1);
		return(ERROR);
        }
	}

	/** lokale Variablen **/

	t++;	
	if(!strncmp(funstr[stel]+t,"local(",6))
	{	t=t+5; 
		while(*(funstr[stel]+t)!=')')
		{       g=strlen(arg1);
			for(i=0;i<g;i++) arg1[i]='\0';
			i=0;
			t++;
			if(!isalpha(*(funstr[stel]+t)))
			{	mistake(5);
				localback(zt+1);
				return(ERROR);
			}
			while(isalnum(*(funstr[stel]+t))) 
			{	arg1[i]=funstr[stel][t];
				t++;
				i++;
			}
			if(i>20) 
			{	mistake(5);
				localback(zt+1);
				return(ERROR);
			}
			if(i>=2 && arg1[0]==AVNAME[0] && arg1[1]==AVNAME[1]
				&& (i==2 || arg1[2]=='['))
			{	mistake1(227,AVNAME);
				localback(zt+1);
				return(ERROR);
			}
			if(*(funstr[stel]+t)=='[')
			{	t++;
				arg1[i]='[';
				i++;
				g=1;
				while(g)
				{	if(*(funstr[stel]+t)=='[') g++;
					else if(*(funstr[stel]+t)==']') g--;
					arg1[i]=funstr[stel][t];	
					i++;
					t++;
				}
				arg1[i]='\0';
				if(!artovar(arg1,localvar[anzloc-1].varname))
				{
			/*		g=strlen(localvar[anzloc-1].varname);
					for(i=0;i<g;i++) *(localvar[anzloc-1].varname+i) = '\0';*/
					localback(zt+1);
					return(ERROR);
				}
			}
			else
			{	arg1[i]='\0';
				strcpy(localvar[anzloc-1].varname,arg1);
			}
			if(!invsploc(localvar[anzloc-1].varname,1))
			{
				/*g=strlen(localvar[anzloc-1].varname);
				for(i=0;i<g;i++) *(localvar[anzloc-1].varname+i)='\0';*/
				localback(zt+1);
				return(ERROR);
			}
			for(g=anzloc-zt-1;g<anzloc-1;g++)
			{	if(!strcmp(localvar[anzloc-1].varname, localvar[g].varname))
				{	mistake(316);
			/*		g=strlen(localvar[anzloc-1].varname);
					for(i=0;i<g;i++) *(localvar[anzloc-1].varname+i) = '\0';*/
					localback(zt+1);
					return(ERROR);
				}
			}	
			localvar[anzloc-1].varwert = _0;
			zt++;
			strcpy(localvar[anzloc].varname,"#");
			localvar[anzloc].varwert = zt;
			anzloc++;
			if(anzloc>=MX)
		        {	mistake1(317,MX);
				localback(zt+1);
				return(ERROR);
		        }
		}
		t++;
		if(*(funstr[stel]+t)=='\0'|| (*(funstr[stel]+t)!=';' && *(funstr[stel]+t)!='_') )
		{	if(*(funstr[stel]+t)!='\0') mistake(32);
			localback(zt+1);
			return(ERROR-1);
		}
		t++;
	}
/*	strcpy(localvar[anzloc].varname,"#");
	localvar[anzloc].varwert = zt;
	anzloc++;
	if(anzloc>=MX)
        {	mistake1(317,MX);
		localback(zt+1);
		if(merk) funktion=0;
		return(ERROR);
        }*/
/**for(i=0;i<anzloc;i++)
{	printf("localvar[%i].varname = %s\n",i,localvar[i].varname);
	printf("localvar[%i].varwert = %obj\n\n",i,localvar[i].varwert);
}**/
	stat=statsch;
	statsch=0;
	merk=funktion;
	funktion=1;
	seqbasad(funstr[stel]+t,inter_asw,inter_aswco, 0,0);
	funktion=merk;
	statsch=stat;
	stat=1;
	if(breaksch) 
	{	breaksch=0;
		if(!prfehl) erg=localvar[anzloc-2].varwert;
	/**	else 
		{	prfehl=0;
			erg=ERROR-1;
		}**/
		zt++;
		stat=0;
	}
	else if(!prfehl) erg=ERROR-1;
	if(prfehl)
	{	erg=ERROR;
		if(!funktion) prfehl=0;
	}
	localback(zt+1);
	if(stat && !schleife && assch<2 && !funktion)
	{	tdiff = settime(); tabs+=tdiff;
		if(statsch) statistic(tdiff);
	}
	return(erg); 
}
