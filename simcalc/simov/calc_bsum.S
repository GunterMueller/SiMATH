/*C
			calc_bsum( arg, d )

	"calculator big sum".
	list calc_bsum(arg,d); char *arg; single *d;
	erg = calc_bsum( arg, d );
	Der zum bsum-Aufruf gehoerige Eingabestring wird bestimmt und 
	ausgewertet. Die Laenge des ausgewerteten Strings wird *d 
	zugewiesen. erg ist das Ergebnis der Summe.
	Laeuft calc_bsum fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      08.08.1994      S.Schmitt
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

void inter_bsum()
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

void inter_bsumco()
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


 

list calc_bsum( arg, d )
char *arg;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single merk=(-1), l,i=1, j=0, mk=0, sch=0, k, dl, h, kl=0, stat, ow; 
	single as, t, t1, t2, ts, gz=0, awe=(-1), loc=0;
	obj a1, a2, b1, b2, bs, e;
	char arg1[ MAXLV ], arg2[MAXLV],  seq1[MAXLV];
	char name[25], hname[50];
	list sum, awert;
	init(a1, a2, b1, b2, bs, e, sum, awert );
	arg += 1;
	*arg1 = '\0';
	*arg2='\0';
	*seq1='\0';
	*name='\0';
	*hname='\0';
	awert = _0;

	*d = 0;

	/*** Erkennung und Auswertung der zu einer Summe  
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
				  else 
				  {     *(seq1+j) = '\0';
					if(!isbracor(seq1,0))
					{	*d = (*d) + 1;
						return(ERROR);
					}
				  }
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
		return( -BASIS );
	}
	i=(-1);
	if((l=strlen(arg1))==0 || instring(arg1,"_",&i) || ( instring(arg1,";",&i) && i!=(l-1) ) || !strlen(arg2) || !strlen(seq1))
	{	mistake1(34,"sum");
		return(ERROR);
	}

	/*** arg1 ***/

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
						return(ERROR);
					}
					h++;
				}
				if(h>20)
				{	mistake(7);
					return(ERROR);
				}
				absvalex(hname+h+1, ind);
				a1=basad(ind);
				if(a1==ERROR || a1==ERROR-1)
				{	if(a1==ERROR-1) mistake(32);
					fosch=1;
					return(ERROR);
				}
				if( lsecond(a1) || !isatom(lfirst(a1)) || (a1=lfirst(a1))<0 || a1>= 10000 )
				{	
					mistake(307);
					fosch=1;
					return(-BASIS);
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
					return( -BASIS );
		  		}
				*(hname+dl) = '\0';
				strcpy( name, hname );
				if(!isalpha(*name))
				{	mistake(5);
					return(ERROR);
				}	
				while ( h < dl ) {
			  	if ( !isalnum(*(name+h)) )
			  	{     mistake( 5 );
					return( -BASIS );
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
	
	if(!schleife || schleife==1)   /** in aeusserster Summe **/
	{	merk=schleife;
		schleife=2;
	}
	ow=owsch;
	owsch=0;
	stat=statsch;
	statsch=0;

	as=assch;
	assch=1;	
	rechnung(arg1+t, inter_bsum, inter_bsumco, 1);
	assch=as;
	prfehl = 0;	
	if(merk>=0 && fosch==1)
	{	statsch=stat;
		owsch=ow;
		fosch=0;
		schleife=merk;
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
		if(merk==1) varlist[k].typ = (-1);
		t1=varlist[k].typ;
	}
	else 
	{	a1 = localvar[k].varwert;
		if(merk==1) localvar[k].typ = (-1);
		t1 = localvar[k].typ;
	}
	if(t1==2 || t1==(-3) || lsecond(a1))
	{	mistake1(34,"sum");
		if(merk>=0)
		{	statsch=stat;
			owsch=ow;
			schleife=merk;
		}
		return(ERROR);
	}
	b1=lfirst(a1);

	/*** arg2 ***/

	a2=basad(arg2);
	if(a2==ERROR || a2 == ERROR-1)
	{	if( a2 == ERROR-1 ) mistake(32);
		if(merk>=0)
		{	statsch=stat;
			owsch=ow;
			schleife=merk;
		}
		return(ERROR);
	}
	t2=lsecond(a2);
	if(t2)
	{	mistake1(34,"sum");
		if(merk>=0)
		{	statsch=stat;
			owsch=ow;
			schleife=merk;
		}
		return(ERROR);
	}
	b2=lfirst(a2);

	/** Test, ob a1<=a2 (leere Summe) **/

	a1=icomp(b1,b2);

	if( a1>0 ) 
	{
		if(merk>=0)
		{	statsch=stat;
			owsch=ow;
			schleife=merk;
		}
		return(list2(0,0));
	}

	/*** Summe ***/

	sum=0;
	ts=0;
	gz=1;
	while(1)
	{	a2=basad(seq1);
		if(a2==ERROR || a2 == ERROR-1)
		{	if( a2 == ERROR-1 ) mistake(32);
			if(merk>=0)
			{	statsch=stat;
				owsch=ow;
				schleife=merk;
			}
			return(ERROR);
		}
		t2=lsecond(a2);
		if((t2<0 && t2!=(-3) && t2!=(-4) && t2!=(-7) && t2!=(-8) && t2!=(-11) && t2!=(-12)) || t2==16 || t2==23 || t2==30 || t2>39)
		{	mistake1(34,"sum");
			if(merk>=0)
			{	statsch=stat;
				owsch=ow;
				schleife=merk;
			}
			return(ERROR);
		}
		if(gz && ((t2>4 && t2<10) || t2==19 || t2==20 || t2==26 || t2==27 || t2==33 || t2==34))
		{	gz=llength(lfirst(a2));
			sum=maconsdiag(gz,0);
			ts=5;
		}
		else if(gz && ((t2>9 && t2<15) || t2==21 || t2==22 || t2==28 || t2==29 || t2==35 || t2==36))
		{	gz=llength(lfirst(a2));
			sum=_0;
			while(gz>0)
			{	sum=lcomp(0,sum);
				gz--;
			}
			ts=10;
		}
		else if(gz && t2<0)
		{ 	sum = list3( 0, 1, 0 );
			if( t2==(-3) || t2==(-7) || t2==(-11) || t2==(-15))
				ts=(-3);
			else    ts=(-4);
		}
		gz=0;
		b1=lfirst(a2);
		bs=sum;
		sum=calc_sum(bs,b1,ts,t2);
		if(sum==ERROR)
		{	if(merk>=0)
			{	statsch=stat;
				owsch=ow;
				schleife=merk;
			}
			return(ERROR);
		}
		ts=lsecond(sum);
		sum=lfirst(sum);

	/** Laufvariable nach Auswertung von seq1 **/

		if(!loc)
		{	a1=varlist[k].varwert;
			t1 = varlist[k].typ;
		}
		else
		{	a1 = localvar[k].varwert;
			t1 = localvar[k].typ;
		}
		if(t1==2 || t1==(-3) || lsecond(a1))
		{	mistake1(34,"sum");
			if(merk>=0)
			{	statsch=stat;
				owsch=ow;
				schleife=merk;
			}
			return(ERROR);
		}
		b1=lfirst(a1);

	/** Abbruchbedingung der Summe **/

		b1=isum(b1,1);
		a1=icomp(b1,b2);
		if(a1>0) break;
		b1=list2(b1,0);
		if(!loc) varlist[k].varwert=b1;
		else localvar[k].varwert = b1;
	}
	if(merk>=0)
	{	statsch=stat;	
		owsch=ow;
		schleife=merk;
	}
	return(list2(sum,ts));
}
