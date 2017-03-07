/*C
			calc_for( arg, d )

	"calculator for".
	list calc_for(arg,d); char *arg; single *d;
	erg = calc_for( arg, d );
	Der zum for-Aufruf gehoerige Eingabestring wird bestimmt 
	und ausgewertet. Die Laenge des ausgewerteten Strings wird *d 
	zugewiesen. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.11.1993      S.Schmitt
H*/

# include <_calc.h>


extern jmp_buf res;
extern single sch1;

void inter_f()
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


void inter_fco()
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


list calc_for( arg, d )
char *arg;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single merk=0, l,i=1, j=0, mk=0, sch=0, k, dl, h, kl=0, ow, stat; 
	single as=1,t, t1, t2, aus=1, gz=0, awe=(-1), loc=0;
	obj a1, a2, b1, b2, e;
	char arg1[ MAXLV ], arg2[MAXLV],  seq1[MAXLV];
	char name[25], hname[50];
	list awert;
	init(a1, a2, b1, b2, e, awert );
	arg += 1;
	*arg1 = '\0';
	*arg2='\0';
	*seq1='\0';
	*name='\0';
	*hname='\0';
	awert = _0;
	if(assch) as=0;  /** keine Ausgabe am Ende **/
	assch=0;


	*d = 0;

	/*** Erkennung und Auswertung der zu einem Funktionsaufruf  
	     gehoerenden Parameter ***/

	while ( i && sch<=2 ) {
		switch( *(arg+*d) ) {
			case '(': if(seven(gz)) ++i;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(arg2+j)= *(arg+*d);
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case ')': if(seven(gz)) --i;
				  if ( i ) 
				  {     if(!sch) *(arg1+j) = *(arg+*d); 
					else if(sch==1) *(arg2+j)= *(arg+*d);
					else *(seq1+j)= *(arg+*d);
				        ++j;
				  }
				  else *(seq1+j) = '\0';
				  break;
			case '{': if(seven(gz)) ++mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(arg2+j)= *(arg+*d);
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case '}': if(seven(gz)) --mk;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(arg2+j)= *(arg+*d);
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case '"': if(*(arg + *d - 1) !='\\') gz++;
				  if(!sch) *(arg1+j) = *(arg+*d); 
				  else if(sch==1) *(arg2+j)= *(arg+*d);
				  else *(seq1+j)= *(arg+*d);
				  j++;
				  break;
			case ',': if ( i == 1 && !mk ) {
				  	if(!sch) 
					{	*(arg1+j) = '\0'; 
						t=0;
						l = strlen(arg1);
						while(*(arg1+t)=='(' && 
                                                (*(arg1+l-1)==')' || 
						((l-2)>=0 && *(arg1+l-1)==';' && *(arg1+l-2)==')' )))
						{	t++;
							l--;
						        if( *(arg1+l)==';')
						           *(arg1+l-1)=';';
							*(arg1+l) = '\0';
						}
					}
				  	else if(sch==1) *(arg2+j)='\0';
					sch++;
					if(sch==1 && !error(arg1+t)) 
					{	while(i)
						{  if(*(arg+*d)=='(')
							i++;
						   else if(*(arg+*d)==')')
							i--;
						   *d = (*d) + 1;
						}
						return(ERROR);
					}
					if(sch==2 && !isbracor(arg2,0))
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
				  	else if(sch==1) *(arg2+j)= *(arg+*d);
				  	else *(seq1+j)= *(arg+*d);
				  	j++;
				  }	
				  break;
			default : if( *(arg+*d) != ' ' || sodd(gz) )
				  {  if(!sch) *(arg1+j) = *(arg+*d); 
				     else if(sch==1) *(arg2+j)= *(arg+*d);
				     else *(seq1+j)= *(arg+*d);
				     j++;
				  }
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

	/** 1. oder 2. Argument leer oder
	    im 1. oder 2. Argument _ bzw. ; **/

	i=(-1);
	sch=0;
	if((l=strlen(arg1))==0 || instring(arg1,"_",&i) || ( instring(arg1,";",&i) && i!=(l-1) ) ) sch=1;
	else if( !strlen(arg2) || instring(arg2,"_",&j) || instring(arg2,";",&j) ) sch=2;
	if(sch)
	{	mistake1(34,"for");
		if(sch==2) return(list2(strlen(arg1)+2,strlen(arg1)+strlen(arg2)+2));
		else return(list2(1,strlen(arg1)+1));
	}
	if(i==(l-1)) aus=0;

	/*** arg1 ***/

/*	i=0;
	l = strlen(arg1);
	while( *(arg1+i) == '(' && *(arg1+l-1) == ')' )
	{	i++;
		l--;
		*(arg1+l) = '\0';
	}
	t = i; */
	
	/*while( *(arg1+i) == ' ' || *(arg1+i) == '(') i++;*/
	dl=0;
	h=1;
	i = t;
	while( i < l ) {

	/*** Erkennung von Variablennamen ***/

		if ( *(arg1+i) == '(' ) kl++;
		if ( *(arg1+i) == ')' ) kl--;
		if ( *(arg1+i) == '=' && ( kl == 0 ) ) {
		  j=prechar(arg1,i);
		  if(j != '!' && j != '>' && j != '<' && j != '=')
		  {	 j=i;
			 j++;
			 while(*(arg1+j) == ' ') j++;
			 if(*(arg1+j) != '=')
			 {      if(*(hname+dl-1) == ']'){
				char ind[MAXLV];
				*ind = '\0';
				h=0;
				while(*(hname+h)!='[') 
				{	if(!isalnum(*(hname+h)))
					{	mistake(5);
						return(list2(1,j));
					}
					h++;
				}
				if(h>20)
				{	mistake(7);
					return(list2(1,j));
				}
				absvalex(hname+h+1, ind);
				a1=basad(ind);
				if(a1==ERROR || a1==ERROR-1)
				{	if(a1==ERROR-1) mistake(32);
					fosch=1;
					return(list2(1,j));
				}
				if( lsecond(a1) || !isatom(lfirst(a1)) || (a1=lfirst(a1))<0 || a1>= 10000 )
				{	
					mistake(307);
					fosch=1;
					return(list2(1,j));
				}
				for(j=h+1;j<dl;j++) *(hname+j)='\0';
				sputi(a1, hname+h+1);
				j=h+2;
				if(a1>=10) j++;
				if(a1>=100) j++;
				if(a1>=1000) j++;
				*(hname+j)=']';
				*(hname+j+1) = '\0';
				strcpy(name, hname);
				break;
				}
				else {
		  		if(dl>20)
		  		{     mistake( 7 );
					return( list2(1,j) );
		  		}
				*(hname+dl) = '\0';
				strcpy( name, hname );
				if(!isalpha(*name))
				{	mistake(5);
					return(list2(1,j));
				}	
				while ( h < dl ) {
			  	if ( !isalnum(*(name+h)) )
			  	{     mistake( 5 );
					return( list2(1,j) );
			  	}
			  	++h;
				}
				break;
				}
			}
		  }
		}
		if ( *(arg1+i) != ' ' ) *(hname+dl) = *(arg1+i),++dl;
		++i;
	}
	if(*name == '\0') strcpy(name,"@");

	/** alter Wert der Variable name **/
	if(!strcmp(name,"@")) k=0;
	else  
	{	if(funktion) k=invectloc(name);
		if(!funktion || k==ERROR) k=invectsp(name);
		else loc=1;
	}
	if(k==ERROR) 
	{
		return(ERROR);
	}
	if(k!=MX) 
	{	if(!loc)
		{	if(varlist[k].typ==2 || varlist[k].typ==(-3))
				awe=varlist[k].varwert;
			else awert=varlist[k].varwert;
		}
		else
		{	if(localvar[k].typ==2 || localvar[k].typ==(-3))
				awe = localvar[k].varwert;
			else awert = localvar[k].varwert;
		}
	}
	
	/** Auswertung von arg1 **/
	
	if(!schleife)   /** in aeusserster Schleife **/
	{	merk=1;
		schleife=1;
	}
	ow=owsch;
	owsch=0;
	stat=statsch;
	statsch=0;

	rechnung(arg1+t, inter_f, inter_fco, 1);
	prfehl = 0;	
	if(merk && fosch==1)
	{	owsch=ow;
		statsch=stat;
		fosch=0;
		schleife=0;
		schleiback();
		if(awert!=_0)
		{	 if(!loc)
			 {	varlist[k].varwert = awert;
			 	varlist[k].typ = 0;
			 	strcpy( varlist[k].varname, name );
			 }
			 else
			 {	localvar[k].varwert = awert;
				localvar[k].typ = 0;
			 }
		}
		else if(awe!=(-1))
		{	if(!loc)
			{	varlist[k].varwert = awe;
				varlist[k].typ = 2;
				strcpy( varlist[k].varname,name );
			}
			else
			{	localvar[k].varwert = awe;
				localvar[k].typ=2;
			}
		}
		/*else
		{	*varlist[k].varname = '\0';
			varlist[k].varwert=0;
			varlist[k].typ = 0; 
			structsort();
		}*/
	
		return(ERROR);
	}
	if(fosch==1) 
	{	if(awert!=_0)
		{	 if(!loc)
			 {	varlist[k].varwert = awert;
			 	varlist[k].typ = 0;
			 	strcpy( varlist[k].varname, name );
			 }
			 else
			 {	localvar[k].varwert = awert;
				localvar[k].typ = 0;
			 }
		}
		else if(awe!=(-1))
		{	if(!loc)
			{	varlist[k].varwert = awe;
				varlist[k].typ = 2;
				strcpy( varlist[k].varname,name );
			}
			else
			{	localvar[k].varwert = awe;
				localvar[k].typ=2;
			}
		}
		/*else
		{	*varlist[k].varname = '\0';
			varlist[k].varwert=0;
			varlist[k].typ = 0;
			structsort();
		}*/
		return(ERROR);
	}
	if(k==MX)
	{   if(!strcmp(name,"@")) k=0;
	    else 
	    {	k=MXNUM;
		while(strcmp(varlist[k].varname,name)) k++;
	    }
	}
	if(!loc) 
	{	a1=varlist[k].varwert;
		t1=varlist[k].typ;
	}
	else 
	{	a1 = localvar[k].varwert;
		t1 = localvar[k].typ;
	}
	if(t1==2 || t1==(-3) || ((t1=lsecond(a1)) && t1!=1 && t1!=15))
	{	mistake1(34,"for");
		if(merk)
		{	owsch=ow;
			statsch=stat;
			schleife=0;
			schleiback();
		}
		return(list2(1,strlen(arg1)));
	}
	a1=lfirst(a1);

	/*** arg2 ***/

	a2=basad(arg2);
	if(a2==ERROR || a2 == ERROR-1)
	{	if( a2 == ERROR-1 ) mistake(32);
		if(merk)
		{	owsch=ow;
			statsch=stat;
			schleife=0;
			schleiback();
		}
		return(ERROR);
	}
	t2=lsecond(a2);
	if(t2 && t2!=1 && t2!=15)
	{	mistake1(34,"for");
		if(merk)
		{	owsch=ow;
			statsch=stat;
			schleife=0;
			schleiback();
		}
		return(list2(strlen(arg1+2,strlen(arg1)+strlen(arg2)+2));
	}
	a2=lfirst(a2);

	/** Test, ob a1<=a2 **/

	t=typer(a1,a2,t1,t2,&b1,&b2,1);

	if(!t) a1=icomp(b1,b2);
	else if(t==1) a1=rcomp(b1,b2);
	else a1=flcomp(b1,b2);

	if( a1>0 ) 
	{	mistake1(34,"for");
		if(merk)
		{	owsch=ow;
			statsch=stat;
			schleife=0;
			schleiback();
		}
		return(list2(1,strlen(arg1)+strlen(arg2)+2));
	}

	/*** for - Schleife ***/

	if(t==1) e = itor(1);
	else if(t==15)  e = itofl(1);
	if(aus) sprintf(hname,"%s + 1",name);
	while(1)
	{	if(strlen(seq1)) seqbasad(seq1,inter_f,inter_fco,0,0);
		if(fosch==1 || fosch==2)
		{	if(merk)
			{	owsch=ow;
				statsch=stat;
				fosch=0;
				schleife=0;
				schleiback();
			}
			return(ERROR);
		}
		else
		{	if(breaksch==1)    /** break **/
			{	breaksch=0;
				break;
			}
			else if(breaksch == 2 )   /** continue **/
				breaksch = 0;
			else if(breaksch == (-1))  /** return aus Fkt. **/
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

	/** Laufvariable nach Auswertung von seq1 **/

		if(!loc)
		{	a1=varlist[k].varwert;
			t1 = varlist[k].typ;
		}
		else
		{	a1 = localvar[k].varwert;
			t1 = localvar[k].typ;
		}
		if(t1==2 || t1==(-3) || ((t1=lsecond(a1)) && t1!=1 && t1!=15))
		{	mistake1(34,"for");
			if(merk)
			{	owsch=ow;
				statsch=stat;
				schleife=0;
				schleiback();
			}
			return(ERROR);
		}
		a1=lfirst(a1);
		if(t1==t) b1=a1;
		else
		{	t2=typer(a1,b2,t1,t,&b1,&a2,1);
			b2=a2;
			t=t2;
			if(t==1) e = itor(1);
			else if(t==15) e = itofl(1);
		}

	/** Abbruchbedingung der Schleife **/

		switch(t)
		{	case 0: b1=isum(b1,1);
				a1=icomp(b1,b2);
				break;
			case 1: b1=rsum(b1,e);
				a1=rcomp(b1,b2);
				break;
			case 15:b1=flsum(b1,e);
				a1=flcomp(b1,b2);
				break;
		}
		if(a1>0) break;
		b1=list2(b1,t);
		b1=kenntest(b1);	
		if(!loc) varlist[k].varwert=b1;
		else localvar[k].varwert = b1;
		if(aus) ausgabe(hname,name,b1,1);
	}
	if(merk)
	{	owsch=ow;
		statsch=stat;	
		schleife=0;
		schleiaus(as);
	}
	return( ERROR-1 );
}
