/*C
			calc_decl( arg, d )

	"calculator declaration".
	list calc_decl(arg,d); char *arg; single *d;
	erg = calc_decl( arg, d );
	Laeuft calc_decl fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.04.1994      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

list calc_decl( s, d )
char *s;
single *d;

{       /*** Deklarationen und Vorbesetzungen ***/
	
	single i, l=1, z=1, z1=0, z2 = 0;
	single m, stel, j, k, g, fe, loc=0;
	char name[30];
	char hilf[MAXLV];

	*hilf='\0';
	*name = '\0';
	*d = 0;

	while ( *(s+l) != '\0' && z )
	{      while(*(s+l)==' ') l++;

	/** Funktionsname **/

		i=0;
		while(isalnum(*(s+l))) 
		{	hilf[i]=s[l];
			l++;
			i++;
		}
		if(*(s+l)=='[')
		{	k=1;
			l++;
			hilf[i]='[';
			i++;
			while(k && *(s+l)!='\0')
			{	if(*(s+l)=='[') k++;
				else if(*(s+l)==']') k--;
				hilf[i]=s[l];	
				i++;
				l++;
			}
			hilf[i]='\0';
			if(!artovar(hilf,name))
			{	
				while(z)
		        	{	switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(*(s+l-1) !='\\') z2++;
							break;
						default: break;
					}
					l++;
				}
				*d=l;
				return(ERROR);
			}
		}
		else
		{	hilf[i]='\0';
			if(i>20)
			{	mistake(7);
				while(z)
		        	{	switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(*(s+l-1) !='\\') z2++;
							break;
						default: break;
					}
					l++;
				}
				*d=l;
				return(ERROR);
			}
			strcpy(name,hilf);
		}
		if( strlen(name)>=2 && *name==AVNAME[0] && *(name+1)==AVNAME[1] 
			&& ( *(name+2)=='\0' || *(name+2)=='[' ) )	
		{	mistake1(227,AVNAME);
			while(z)
		       	{	switch( *( s+l ) )
				{       case '(': if(seven(z2)) ++z;
			  			break;
					case ')': if(seven(z2)) --z;
			  			break;
					case '"': if(*(s+l-1) !='\\') z2++;
						break;
					default: break;
				}
				l++;
			}
			*d=l;
			return(ERROR);
		}	
		if(funktion) k=invectloc(name);
		if(!funktion || k==ERROR) k=invect(name);
		else loc=1;
		if((loc && localvar[k].typ!=2 && localvar[k].typ!=(-3))
		    || (!loc && (*(varlist[k].varname)=='\0' || ( varlist[k].typ != 2 && varlist[k].typ != -3 ))))
		{	stel=0;
			while(stel<MXUSER && *(funstr[stel])!='\0') stel++;
			if(stel==MXUSER)
			{	mistake(315);
				while(z)
		        	{	switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(*(s+l-1) !='\\') z2++;
							break;
						default: break;
					}
					l++;
				}
				*d=l;
				return(ERROR);
			}	
			if(!loc)
			{	strcpy(varlist[k].varname,name);
				if(schleife==1) varlist[k].typ=(-3);
				else varlist[k].typ=2;		
				varlist[k].varwert=stel;
			}
			else 
			{	if(schleife==1) localvar[k].typ = (-3);
				else localvar[k].typ=2;
				localvar[k].varwert = stel;
			}
		}
		else
		{	if(!loc)
			{	if(schleife==1) varlist[k].typ=(-3);
				stel=varlist[k].varwert;
			}
			else
			{	if(schleife==1) localvar[k].typ=(-3);
				stel = localvar[k].varwert;
			}
			i=strlen(funstr[stel]);
			for(j=0;j<i;j++) funstr[stel][j]='\0';
		}
	/**	free(funstr[stel]);
		funstr[stel]=malloc(strlen(s+l)+2); **/
		funstr[stel]=realloc(funstr[stel],strlen(s+l)+2); 
		funstr[stel][0]='\0'; 
			

		while(*(s+l)==' ') l++;

	/** Parameter **/

		l++;
		while(*(s+l)==' ') l++;
		i=0;
		while(*(s+l)!=')')
		{       fe=0; 
			g=strlen(hilf);
			for(j=0;j<g;j++) hilf[j]='\0';
			j=0;
			while(isalnum(*(s+l))) 
			{	hilf[j]=s[l];
				l++;
				j++;
			}
			if(j>20) fe=1;
			else 
			{	while(*(s+l)==' ') l++;
			if(*(s+l)=='[')
			{	g=strlen(name);
				for(m=0;m<g;m++) name[m]='\0';
				g=1;
				l++;
				hilf[j]='[';
				j++;
				while(g && *(s+l)!='\0')
				{	if(*(s+l)=='[') g++;
					else if(*(s+l)==']') g--;
					hilf[j]=s[l];	
					j++;
					l++;
				}
				hilf[j]='\0';
				if(!artovar(hilf,name)) fe=2;
			}
			else 
			{	hilf[j]='\0';
				strcpy(name,hilf);
			}
			}
			if(!fe && !invsploc(name,0)) fe=2;	
			if(fe)
			{	if(fe==1) mistake(5);
				while(z)
		        	{	switch( *( s+l ) )
					{       case '(': if(seven(z2)) ++z;
				  			break;
						case ')': if(seven(z2)) --z;
				  			break;
						case '"': if(*(s+l-1) !='\\') z2++;
							break;
						default: break;
					}
					l++;
				}
				*d=l;
		        	g=strlen(funstr[stel]);
				for(j=0;j<g;j++) funstr[stel][j]='\0';
				free(funstr[stel]);
				funstr[stel]=malloc(5); 
				funstr[stel][0]='\0';
		 		if(!loc)
				{	varlist[k].varwert = 0; 
		 			strcpy(varlist[k].varname,"\0");
		 			varlist[k].typ=0;
				}
				else 
				{	localvar[k].varwert = _0;
					localvar[k].typ=0;
				}

				return(ERROR);
			}
			g=0;
			while(g<i)
			{	m=strlen(hilf);
				for(j=0;j<m;j++) hilf[j]='\0';	
				j=0;
				while(funstr[stel][g]!='#')
				{	hilf[j]=funstr[stel][g];
					j++;g++;
				}
				hilf[j]='\0';
				if(!strcmp(hilf,name))
				{	mistake(3);
					while(z)
		        		{	switch( *( s+l ) )
						{       case '(': if(seven(z2)) ++z;
				  				break;
	
							case ')': if(seven(z2)) --z;
				  				break;
							case '"': if(*(s+l-1) !='\\') z2++;
								break;
							default: break;
						}
						l++;
					}
					*d=l;
		        		g=strlen(funstr[stel]);
					for(j=0;j<g;j++) funstr[stel][j]='\0';
					free(funstr[stel]);
					funstr[stel]=malloc(5); 
					funstr[stel][0]='\0';
		 			if(!loc)
					{	varlist[k].varwert = 0; 
		 				strcpy(varlist[k].varname,"\0");
		 				varlist[k].typ=0;
					}
					else
					{	localvar[k].varwert=_0;
						localvar[k].typ=0;
					}
					return(ERROR);
				}
				g++;
			}
			g=strlen(name);
			for(j=0;j<g;j++) funstr[stel][i+j]=name[j];
			i=i+g;
			while(*(s+l)==' ') l++;
			if(*(s+l)==',')
			{	funstr[stel][i]='#';
				i++;
				l++;
				while(*(s+l)==' ') l++;
			}
		}
		funstr[stel][i]='~';
		i++;
		l++;

	/** Gleichheitszeichen **/

		while(*(s+l)==' ') l++;
		l++;
		while(*(s+l)==' ') l++;

	/** Sequenz **/

	while(z && ( z1 || z!=1 || *(s+l)!=','))		
	{	switch( *( s+l ) )
		{       case '(': if(seven(z2)) ++z;
				  break;
			case ')': if(seven(z2)) --z;
				  break;
			case '{': if(seven(z2)) ++z1;
				  break;
			case '}': if(seven(z2)) --z1;
				  break;
			case '"': if(*(s+l-1) !='\\') z2++;
				  break;
			default: break;
		}
		if(z && (*(s+l)!=' ' || sodd(z2)))
		{	funstr[stel][i]=s[l];
			i++;
		}
		l++;
	}
	funstr[stel][i]='\0';
	if(*(s+l)==',')	l++;
	if(!assch) 
	{	if(!loc) ausgfunc(varlist[k].varname, stel);
		else ausgfunc(localvar[k].varname, stel);
	}
/**printf("*********funstr[%i]= %s \n",stel, funstr[stel]);**/
     }
     *d=l;
     if(!schleife && assch<2 && !funktion)
     {	tdiff = settime(); tabs+=tdiff;
	if(statsch) statistic(tdiff);
     }
     return( ERROR-1 );
}
