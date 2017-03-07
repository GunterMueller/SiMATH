/*C
			basad ( arg )

	"basement-administration".      ( rekursiv )
	int basad(arg); char *arg; 
	erg = basad( arg );

	basad regelt die Kellerverwaltung des Calculators.
	In erg wird das Ergebnis des Eingabestrings "arg" und die
	Kennung des zu erg gehoerigen Zahlbereiches abgelegt.
	Laeuft eine Berechnung fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2.1    03.10.1988      C.Hollinger/U.Schneiders
	Version  2.2    24.01.1989      C.Hollinger/U.Schneiders
	Version  2.3    27.06.1989      C.Hollinger   (M,V ueber rat.Fu.)
	Version  2.4    26.08.1991      U.Schneiders ( absvalex, brackex
						       MX300 )
	Version  2.5    07.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  2.6    12.05.1992      U.Schneiders ( M, NF )
	Version  2.7    28.06.1993      U.Schneiders ( GF )
H*/

# include <_calc.h>

extern jmp_buf res;
extern single sch1;

inter_bas()
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

void inter_basco()
{	single i;

	printf("\n ********      Fatal Error      ********\n\n");
	if(ps) fprintf(datei,"\nout: ********      Fatal Error      ********\n\n");
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



int basad( arg )
char *arg;
{       /*** Deklarationen und Vorbesetzungen ***/

	int zk, bel, erg;
	list keller, H;
	char arg2[MAXL];
	char hilf, zkstr[ 27 ];
	single prio = -1, vprio = -2, argl, d, erk, i, laenge, sch;
	single fe, loc=0, n = 0, r, kl, l, j, k, kenmax;
	init(zk,bel, erg);
	init( keller, H );

	/*** Verarbeitung unaerer Minuszeichen am Anfang eines
	     Eingabestrings ***/

	keller = _0; 
	H = _0;

	/*** Vorangehende - ***/
	while( *(arg+n) == '-' ) ++n;
	if ( ( n%2 ) == 1 ) arg += (n-1);
	else arg += n;

	laenge = strlen( arg );
	hilf = *arg;
	while ( laenge )  {

	/*** Aufloesung des Eingabestrings ***/

		zk = istyp( hilf, arg, &erk, &prio, &argl );

		if ( zk == -BASIS ) 
		{
			return( -BASIS );
		}
		/*** Matrizen- oder Vektoraufbau. ***/

		if( erk == 35 || erk == 40 )
		{       l = 1;  kl = 1;
			while( kl )
			{     switch( *( arg+l ) )
			      {       case '{': kl++;
						break;
				      case '}': kl--;
						break;
			      }
			      l++;
			}
			argl = l;
			strncpy( arg2, arg, l );
			*( arg2+l ) = '\0';
		}
		
		arg += ( argl - 1 );
		laenge -= argl;
		hilf = *arg;
		arg += 1;
		switch( erk ) {

	/*** Verwaltung von Operatoren und eventuelle Auswertung ***/

		case 10 : while ( vprio >= prio && ( vprio != 8 || prio != 7 ) )
			  {      keller = eval( keller, &vprio );
				 if ( keller == -BASIS ) 
				 {
					return( -BASIS );
				 }
			  }
			  H = list2( zk,prio );
			  keller = lcomp( H,keller );
			  vprio = prio;
			  break;

	/*** Verwaltung der Modularrechnung und eventuelle Auswertung ***/

		case 13 : while ( vprio >= prio ){
				 keller = eval( keller, &vprio );
				 if ( keller == -BASIS ) 
				 {
					return( -BASIS );
				 }
			  }
			  H = list2( zk,prio );
			  keller = lcomp( H,keller );
			  vprio = prio;
			  hilf = '(';
			  break;

	/*** Verwaltung der Fakultaetrechnung ***/

		case 14 : keller = ifak( keller, vprio );
			  if ( keller == -BASIS ) 
			   {
				return( -BASIS );
			   }
			  break;

	/*** Verwaltung geklammerter Ausdruecke ***/

		case 15 : brackex( arg, arg2 );
			  if( instring(arg2,"_",&i) || instring(arg2,";",&i) || isass(arg2))
		          {	
				seqbasad(arg2,inter_bas,inter_basco,0,1);
				laenge -= strlen(arg2)+1;
				arg += strlen(arg2)+1;
				keller = ERROR-1;
				break;
			  }
			  laenge -= strlen( arg2 ) + 1;
			  arg += strlen( arg2 ) + 1;
			  hilf = ')';
			  H = basad( arg2);
			  if ( H == -BASIS || H == -BASIS-1 )
			  {
				return( H );
			  }
			  if( lsecond( H ) > 4 )     H = kenntest( H );
			  keller = lcomp( H, keller );
			  break;

	/*** Verwaltung der Betragsrechnung ***/

		case 16 : absvalex( arg, arg2 );
			  laenge -= strlen( arg2 ) + 1;
			  arg += strlen( arg2 ) + 1;
			  hilf = ']';
			  H = basad( arg2 );
			  if ( H == -BASIS || H == -BASIS-1 ) 
			  {     if( H == -BASIS-1 ) 
				{  mistake(32);
/**neu**/
				   errm(0,strlen(arg2)-1,arg2,1);
				   if(ps) ferrm(0,strlen(arg2)-1,arg2);
/**Ende**/
				}
				return( -BASIS );
			  }
			  j = lsecond( H );
			  if( j < 0 || ( j > 1 && j < 15 ) || ( j > 15 && j!=24 && j != 37 ) )
			  {     mistake( 9 );
/**neu**/
				k=strlen(arg2);
				arg2[k+2]='\0';
				arg2[k+1]=']';
				for(i=k;i>0;i--) arg2[i]=arg2[i-1];
				arg2[0]='[';
				errm(0,k+1,arg2,1);
				if(ps) ferrm(0,k+1,arg2);
/**Ende**/
				return( -BASIS );
			  }
			  H = lfirst(H);
			  if( j == 24 )
			  {	bel = lfirst( varlist[nfsch].varwert );
				erg = list4( 2, 1, 0, 1 );
				if(!oequal(bel,erg))
				{	mistake(9);
/**neu**/
					k=strlen(arg2);
					arg2[k+2]='\0';
					arg2[k+1]=']';
					for(i=k;i>0;i--) arg2[i]=arg2[i-1];
					arg2[0]='[';
					errm(0,k+1,arg2,1);
					if(ps) ferrm(0,k+1,arg2);
/**Ende**/
					return( ERROR );
				}
				j=nftyper(H,0,24,37,&bel,&erg);
				H = bel;
			  }
			  switch( j )
			  {     case 0: H = iabs( H );
					break;
				case 1: H = rabs( H );
					break;
				case 15:H = flabs( H );
					H = fltofl( H );
					break;
				case 37:H = cabsv( H );
					H=fltofl(H);
					j=15;
					break;
			  }
			  H = list2( H, j );
			  keller = lcomp( H, keller );
			  break;

	/*** DEPTH, DIGITS, OUTPUTDIG, HEIGHTBOUND, LINELN ***/

		case 17 : H=list2( DEPTH,0);
			  keller=lcomp(H,keller);
			  break;	
		case 18 : H = list2( DIGITS, 0);
			  keller = lcomp(H,keller);
			  break;

		case 19 : H = list2(OUTPUTDIG,0);
			  keller = lcomp(H,keller);
			  break;

		case 22 : H = list2(HEIGHTBOUND,15);
			  keller = lcomp(H,keller);
			  break;

		case 23 : H = list2(LN_SIZE,0);
			  keller = lcomp(H,keller);
			  break;


	/*** Verwaltung ganzer Zahlen ***/

		case 20 : H = list2( zk,0 );
			  keller = lcomp( H,keller );
			  break;

	/*** Verwaltung reeller Zahlen ***/

		case 21 : H = list2( zk,15 );
			  keller = lcomp( H,keller );
			  break;

	/*** Variablenverwaltung ***/

		case 25 : j=0;
			  if ( zk == 64 ) 
			  {	strcpy( zkstr, "@" );
				sch = 0;
			  }

			  /*** Bearbeitung von AV[j] ***/

			  else if( llength(zk)>=2 && lfirst(zk)==AVNAME[0] && lsecond(zk)==AVNAME[1] && (llength(zk)==2 || !isalnum(lthird(zk))) )
			  {	if( llength(zk)==2 || lthird(zk)!='[' )
				{	mistake1(227,AVNAME);
					return(ERROR);
				}	
				
				zk = lred3(zk);	
				while( lfirst(zk) != ']' )
				{	j = 10*j + lfirst(zk) - 48;
					zk = lred(zk);	
				}
				if( j>= AVLENGTH )
				{	mistake(137);
					return(ERROR);
				}
				if( !AV[j] )
				{	sprintf(zkstr, "AV[%d]", j);
					mistake1(138,zkstr);
					return(ERROR);
				}
				keller = lcomp( AV[j], keller );
				break;	
			  }
			  else 
			  {	loc=0;
				if(funktion) 
				{	sch=varlsloc(zk,-1,zkstr);
					if(sch!=(-1)) loc=1;
				}
				if(!funktion || sch==(-1)) sch=varls(zk,-1,zkstr);
				if ( sch  == -1 ) return( -BASIS );
			  }
		          if(			  !strcmp(zkstr, "logon" )
		  || !strcmp(zkstr, "logoff" ) || !strcmp(zkstr, "staton" )
		  || !strcmp(zkstr, "statoff") || !strcmp(zkstr, "owon" )  
		  || !strcmp(zkstr, "owoff" )  || !strcmp(zkstr, "openf" ) 
		  || !strcmp(zkstr, "help" )   || !strcmp(zkstr, "func" )  
		  || !strcmp(zkstr, "ifunc" )  || !strcmp(zkstr, "rfunc" ) 
		  || !strcmp(zkstr, "log" )    || !strcmp(zkstr, "loglist")
		  || !strcmp(zkstr, "stat" )   || !strcmp(zkstr, "vardel") 
 		  || !strcmp(zkstr, "pfunc" )  || !strcmp(zkstr, "subst" ) 
		  || !strcmp(zkstr, "sysvar" ) || !strcmp(zkstr, "mfunc" ) 
		  || !strcmp(zkstr, "vfunc" )  || !strcmp(zkstr, "ow" )    
		  || !strcmp(zkstr, "fopen" )  || !strcmp(zkstr, "fclose" )
		  || !strcmp(zkstr, "fread" )  || !strcmp(zkstr, "fload" )
		  || !strcmp(zkstr, "file" )   || !strcmp(zkstr, "ecfunc" )
		  || !strcmp(zkstr, "flfunc" ) || !strcmp(zkstr, "modfunc")
		  || !strcmp(zkstr, "nffunc" ) || !strcmp(zkstr, "gffunc" )
		  || !strcmp(zkstr, "quit" )   || !strcmp(zkstr, "exit" )
		  || !strcmp(zkstr, "break" )  || !strcmp(zkstr,"progfunc")
		  || !strcmp(zkstr,"continue") || !strcmp(zkstr, "nfon" ) 
		  || !strcmp(zkstr, "nfoff" )  || !strcmp(zkstr, "avon" ) 
		  || !strcmp(zkstr, "avoff" )  || !strcmp(zkstr, "helpfunc" )
		  || !strcmp(zkstr, "ppon" )   || !strcmp(zkstr, "ppoff" )
		  || !strcmp(zkstr, "pp" ))
		  	  {	
				mistake1( 227, zkstr ); 
				return( -BASIS );
			  }
			  if( sch >= MXNUM || loc )  i = sch;
			  else
			  {     i = 0;
				while( i<MX && strcmp(zkstr,varlist[i].varname) ) ++i;
				if ( i == MX ) {
				     if(j)
				     {	mistake(308);
					return(ERROR);
				     }
				     if( zk == 64 )
				     {       mistake( 5 );
					     return( ERROR );
				     }
				     H = _0;
				     r = 0;
				     while ( zkstr[r] != '\0' )  {
					   if(zkstr[r]=='[')
					   {  mistake(308);
					      return(ERROR);
					   }
					   H=lcomp( zkstr[r], H );
					   ++r;
				     }
				     H = linv( H );
				     H = list1( H );
				     bel = list2( 1, 1 );
				     bel = list2( H, bel );
				     bel = list2( bel, 2 );
				     keller=lcomp( bel, keller );
				     break;
				}
				if ( j==0 && i<MX && ( varlist[i].typ == 1 || varlist[i].typ == 3 ) ) {
				     mistake1( 228, zkstr );
				     return( -BASIS );
				}
				if( varlist[i].varwert == -BASIS )
				{       mistake1( 229, varlist[i].varname ); 
				        return( -BASIS );
				}
			  }
			  if(loc && i>=0 && localvar[i].varwert==_0)
			  {	if(prfehl!=(-1)) 
				{	mistake(320);
/**neu**/
					errm(0,strlen(zkstr)-1,zkstr,1);
					if(ps) ferrm(0,strlen(zkstr)-1,zkstr);
/**Ende**/
				}
				return(ERROR);
			  }
			  if((loc && i<0) || (!loc && (varlist[i].typ==2 || varlist[i].typ==(-3))))

			  {	if(!loc || prfehl!=(-1))
				{	mistake(32);
/**neu**/
					errm(0,strlen(zkstr)-1,zkstr,1);
					if(ps) ferrm(0,strlen(zkstr)-1,zkstr);
/**Ende**/
				}
				return(-BASIS);
			  }
			  if(loc) keller = lcomp(localvar[i].varwert,keller);
			  else keller = lcomp(varlist[i].varwert,keller);
			  break;

	/*** Verwaltung von Funktionsaufrufen ***/

		case 30 : loc = 0;
			  if(hilf=='@')	 /** bei Polsubst @ aufpassen **/
			  {	sch = 0;
				if(localvar[0].varwert==_0) fe=1;
			  }
			  else {
			  j=(-1);  /*** fuer AV ***/
			  if( llength(zk)>=3 && lfirst(zk) == AVNAME[0] 
                          && lsecond(zk) == AVNAME[1] && lthird(zk) == '[' )
			  {	j=0; 
				zk = lred3(zk);
				while( lfirst(zk) != ']' )
				{	j = j*10 + lfirst(zk) - 48;
					zk = lred(zk);	
				}
				if( j >= AVLENGTH )
				{	mistake( 137 );
					return(ERROR);
				}
				sprintf(zkstr, "AV[%d]", j);
				if( !AV[j] )
				{	mistake1(139,zkstr);
					return(ERROR);
				}
				sch = MXNUM;
			  }
			  else 
			  {
			    if(funktion)
			    {	sch=varlsloc(zk,-1,zkstr);
				if(sch!=(-1)) loc=1; 
			    }
			    if(!funktion || sch==(-1)) sch=varls(zk,-1,zkstr);
			  }
			  if ( sch == -1 )
			  {
				 return( -BASIS );
			  }
		     if ( !sch && !loc ) {
			mistake1( 230, zkstr );
			return( -BASIS );
		     }
		     fe=0;
		     if(loc && sch>=0 && localvar[sch].varwert == _0 ) fe=1; 
		     else if( (loc && sch>=0) || j>= 0 )
		     {	if( j>=0 ) bel = lsecond(AV[j]);
			else       bel=lsecond(localvar[sch].varwert);
			if(bel<2 || bel==5 || bel==6 || bel==10 || bel==11
			|| bel==15 || bel==16 || bel==17 || bel==19 || bel==21
			|| bel==23 || bel==24 || bel==26 || bel==28 || bel==30
			|| bel==31 || bel== 33 || bel==35 || bel==37)
			fe=1;
		     }
		     } /** Ende else zu if(hilf=='@') **/
		     if(fe)
		     {	if(prfehl!=(-1)) mistake1(230,zkstr);
			return(ERROR);
		     }
		     if ( !loc && sch == 1 )    H = funccl1(arg, &d);
		     else if ( !loc && (sch == 2 || sch == 3 )) H = funccl2(arg, &d);
		     else if( !loc && sch == 4 ) 
		     {     H = _0;
			   if( *arg != '(' || *(arg+1) != ')' )
			   {	mistake1( 231, zkstr );
				return( ERROR );
			   }
			   d = 1;
		     }
		     else if( !loc && sch == 14 )
		     {	H=_0;
			if( *arg != '(' || *(arg+1) != ')' ) H=funccl1(arg, &d);
			else d = 1;
		     }
		
		     else if( !loc && sch == 5 ) H = funccl_curnf( arg, &d ); 
		     else if( !loc && sch == 6 ) H = funccl_curgf( arg, &d );
		     else if( !loc && sch == 9 ) H = funccl_GF2b( arg, &d );
		     else if( !loc && sch == 10 ) H = funccl_cgf2b( arg, &d );
		     else if( !loc && sch == 11 ) H = funccl_btoi( arg, &d );
		     else if( !loc && sch == 12 ) H = funccl_htoi( arg, &d );
		     else if( !loc && sch == 13 ) H = funccl_otoi( arg, &d );
		     else if( !loc && sch == 7 ) 
		     {	    H=_0;
		       	    if(!strcmp(zkstr,"if")) erg = calc_if(arg,&d);
			    else if(!strcmp(zkstr,"while")) erg = calc_while(arg,&d);
			    else if(!strcmp(zkstr,"dowhile")) erg=calc_dowhile(arg,&d);
			    else if(!strcmp(zkstr,"forstep")) erg = calc_forstep(arg,&d);
			    else if(!strcmp(zkstr,"forprime")) erg = calc_forpr(arg,&d);
			    else if(!strcmp(zkstr,"for")) erg = calc_for(arg,&d);
			    else if(!strcmp(zkstr,"print")) erg = calc_print(arg, &d);
			    else if(!strcmp(zkstr,"sum")) H=calc_bsum(arg,&d);
			    else H=calc_bprod(arg,&d);

			    if(H==_0)
			    {

/**neu**/			if(erg!=ERROR-1 && erg!=ERROR)
				{    j=strlen(arg);
				     k=strlen(zkstr);
				     for(i=j+k;i>=k;i--) arg2[i]=arg[i-k];
				     for(i=0;i<k;i++) arg2[i]=zkstr[i];
				     arg2[j+k+1] = '\0';
				     errm(k+lfirst(erg),k+lsecond(erg),arg2,1);
				     if(ps) ferrm(k+lfirst(erg),k+lsecond(erg),arg2);
				     return(ERROR);
				}
/**Ende**/
				arg += d+1;
			    	if(erg!=ERROR && (keller!=_0 || *arg != '\0') )
			    	{ mistake(154);
			      	  return(ERROR);
			    	}
			    	return(erg);
			    }
			    else if(H==ERROR) 
			    {
				return(ERROR);
			    }
			    else 
			    {	keller=lcomp(H,keller);
				laenge = laenge-d-1;
				arg += d+1;
				break;
			    }
			
		     }
		     else if( !loc && sch == 8 )
		     {	erg = calc_decl(arg, &d);
			if(erg!=ERROR && (keller!=_0 || *(arg+d)!='\0'))
			{	mistake(154);
/**neu**/
				i=1;
				j=1;
				k=0;
				while(i)
				{  switch(*(arg+j))
				   {  case ')': if(seven(k)) i--;
						break;	
				      case '(': if(seven(k)) i++;
						break;
				      case '"': if(*(arg+j-1) !='\\') k++;
						break;
			           }
				   j++;
				}
				k=strlen(zkstr);
				arg2[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg2[i]=arg[i-k];
				for(i=0;i<k;i++) arg2[i]=zkstr[i];
				errm(0,j+k-1,arg2,1);
				if(ps) ferrm(0,j+k-1,arg2);
/**Ende**/
				return(ERROR);
			}
			return(erg);
		     }
		     else if(sch<0)
		     {	
			erg = calc_ausw(sch,arg,&d, loc);
			arg +=d;
			if(erg==ERROR-1 && (keller!=_0 || *arg!='\0'))
			{	mistake(154);
				return(ERROR);
			}
			else if(erg==ERROR || erg==ERROR-1) return(erg);
			else keller = lcomp(erg,keller);
			laenge = laenge - d;
			break;
		     }
			   
		     if ( H == -BASIS ) 
		     {
/**neu**/
				i=1;
				j=1;
				k=0;
				while(i)
				{  switch(*(arg+j))
				   {  case ')': if(seven(k)) i--;
						break;	
				      case '(': if(seven(k)) i++;
						break;
				      case '"': if(*(arg+j-1) !='\\') k++;
						break;
			           }
				   j++;
				}
				k=strlen(zkstr);

				arg2[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg2[i]=arg[i-k];
				for(i=0;i<k;i++) arg2[i]=zkstr[i]; 
				errm(k,j+k-1,arg2,1);
				if(ps) ferrm(k,j+k-1,arg2);
/**Ende**/

			return( -BASIS );
		     }
		     if( H  == -BASIS-1 && !loc && ( sch == 2 || sch == 5 || sch == 6 || sch == 10 ) ) {
				mistake( 232 );
/**neu**/			
				arg++;
				brackex(arg,arg2);
				j=strlen(arg2);
				k=strlen(zkstr);
				/*for(i=0;i<k;i++) arg[i]=zkstr[i];
				arg[k]='(';
				for(i=k+1;i<=k+j;i++) arg[i]=arg2[i-k-1];
				arg[k+j+1]=')';	
				arg[j+k+2]='\0'; */
				for( i=j; i; i-- ) arg2[i+k]=arg2[i-1];
				for( i=0; i<k; i++ ) arg2[i] = zkstr[i];
				arg2[k] = '(';
				arg2[k+j+1] = ')';
				arg2[k+j+2] = '\0';

				errm(0,j+k+1,arg2,1);
				if(ps) ferrm(0,j+k+1,arg2);
/**Ende**/

 				return( -BASIS );
		     }

		     if ( H == -BASIS-1 && !loc && sch == 3 )
                     {     
			   H = funccl1( arg, &d );
		           if( H == ERROR ) 
			   {
/**neu**/			
				arg++;
				brackex(arg,arg2);
				j=strlen(arg2);
				k=strlen(zkstr);
				for( i=j; i; i-- ) arg2[i+k]=arg2[i-1];
				for( i=0; i<k; i++ ) arg2[i] = zkstr[i];
				arg2[k] = '(';
				arg2[k+j+1] = ')';
				arg2[k+j+2] = '\0';
				errm(0,j+k+1,arg2,1);
				if(ps) ferrm(0,j+k+1,arg2);
/**Ende**/

				return( ERROR );
			   }
			   H = list1( H );
		     }

/** !loc && !sch fuer Polsubst mit @ **/

		     if ( (!loc && !sch) || sch >= MXNUM || loc)
		     {  arg++;
			brackex( arg, arg2 );
			if(strchr(arg2,'"')!=NULL)
			{	mistake(3);
/**neu**/			
				j=strlen(arg2);
				k=strlen(zkstr);
				/*for(i=0;i<k;i++) arg[i]=zkstr[i];
				arg[k]='(';
				for(i=k+1;i<=k+j;i++) arg[i]=arg2[i-k-1];
				arg[k+j+1]=')';	
				arg[j+k+2]='\0';*/
				for( i=j; i; i-- ) arg2[i+k]=arg2[i-1];
				for( i=0; i<k; i++ ) arg2[i] = zkstr[i];
				arg2[k] = '(';
				arg2[k+j+1] = ')';
				arg2[k+j+2] = '\0';
				errm(0,j+k+1,arg2,1);
				if(ps) ferrm(0,j+k+1,arg2);
/**Ende**/

				return(ERROR);
			}
			d = strlen( arg2 ) + 1;
                        r=0;
			l=0; 
			kl = 0; 
			for(i=0;i<d-1;i++)
			{ 	switch( arg2[i] )
				{    case '(': kl ++;
					       break;
				     case ')': kl--;
					       break;
				     case '{': l++;
					       break;
				     case '}': l--;
					       break;
				}
				if( !kl && !l && arg2[i]==',' ) r++;
			}
			arg2[d-1]=')';
			arg2[d]='\0';
			i = ispolsubst( arg2 , r );
		        if ( !i ) 
			{
/**neu**/
			   k=strlen(zkstr);
			   /*for(j=0;j<k;j++) arg[j]=zkstr[j];
			   arg[k]='(';
			   for(j=k+1;j<=k+1+d;j++) arg[j]=arg2[j-k-1];*/

			   for(j=k+1+d;j>k;j--) arg2[j]=arg2[j-k-1];
			   for( j=0; j<k; j++ ) arg2[j]=zkstr[j];
			   arg2[k]='(';
			   errm(0,k+d,arg2,1);
			   if(ps) ferrm(0,k+d,arg2);
/**Ende**/
			   return( ERROR );
			}
			arg2[d-1]='\0';
			if(!loc && !sch) H=subst(arg2, varlist[0].varwert);
			else if(j>=0) H=subst(arg2,AV[j]);
			else if(loc) H=subst(arg2,localvar[sch].varwert);
			else H = subst( arg2, varlist[sch].varwert );
			if( H == -BASIS )  
			{
				return( -BASIS ) ;
			}
			else     keller = lcomp( H, keller );
			arg += d;
		     }
		     laenge -= d + 1;
		     if(!loc && !sch) break;

		     if ( sch < MXNUM && !loc && sch != 7 && sch!=8)
		     { 	
/**			arg += d+1; **/
			if(!strcmp(zkstr,"return") && (keller!=_0 || *(arg+d+1)!='\0'))
			{	mistake(154);
/**neu**/
				i=1;
				j=1;
				k=0;
				while(i)
				{  switch(*(arg+j))
				   {  case ')': if(seven(k)) i--;
						break;	
				      case '(': if(seven(k)) i++;
						break;
				      case '"': if(*(arg+j-1) !='\\') k++;
						break;
			           }
				   j++;
				}
				k=strlen(zkstr);
				/*arg[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg[i]=arg[i-k];
				for(i=0;i<k;i++) arg[i]=zkstr[i]; */

				arg2[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg2[i]=arg[i-k];
				for(i=0;i<k;i++) arg2[i]=zkstr[i]; 
				errm(0,j+k-1,arg2,1);
				if(ps) ferrm(0,j+k-1,arg2);
/**Ende**/
				return(ERROR);
			} 
			erg = feval( zkstr, H );
			if(erg==ERROR-1 && (keller!=_0 || *(arg+d+1)!='\0'))
			{	mistake(32);
/**neu**/
				i=1;
				j=1;
				k=0;
				while(i)
				{  switch(*(arg+j))
				   {  case ')': if(seven(k)) i--;
						break;	
				      case '(': if(seven(k)) i++;
						break;
				      case '"': if(*(arg+j-1) !='\\') k++;
						break;
			           }
				   j++;
				}
				k=strlen(zkstr);
				/*arg[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg[i]=arg[i-k];
				for(i=0;i<k;i++) arg[i]=zkstr[i];*/

				arg2[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg2[i]=arg[i-k];
				for(i=0;i<k;i++) arg2[i]=zkstr[i]; 
				errm(0,j+k-1,arg2,1);
				if(ps) ferrm(k,j+k-1,arg2);
/**Ende**/
				return(ERROR);
			}
			if ( erg == -BASIS ) 
			{
/**neu**/
				i=1;
				j=1;
				k=0;
				while(i)
				{  switch(*(arg+j))
				   {  case ')': if(seven(k)) i--;
						break;	
				      case '(': if(seven(k)) i++;
						break;
				      case '"': if(*(arg+j-1) !='\\') k++;
						break;
			           }
				   j++;
				}
				k=strlen(zkstr);

				arg2[j+k]='\0';
				for(i=j+k-1;i>=k;i--) arg2[i]=arg[i-k];
				for(i=0;i<k;i++) arg2[i]=zkstr[i]; 
				errm(k,j+k-1,arg2,1);
				if(ps) ferrm(k,j+k-1,arg2);
/**Ende**/

				return( -BASIS );
			}
			arg += d+1;
			if(erg!=ERROR-1) keller = lcomp(erg,keller);
			else return(ERROR-1);  /** return **/
		     }
		     break;

	/*** Verwaltung der Matrizenrechnung ***/

		case 35: 
		         if(1){
			 char el[MAXL];
			 H = _0;
			 kenmax = 0;
			 j = 2;
			 while( arg2[j] != '\0' )
			 {  erg = _0;
			    while( arg2[j] != '}' )
			    {   kl = 0;
				k = 0;
/**neu**/			i=j;	/**Ende**/
				while( kl || ( arg2[j] != ',' && arg2[j] != '}' ) )
				{       switch( arg2[j] )
					{       case '(': kl++;
							  break;
						case ')': kl--;
							  break;
						default:  break;
					}
					el[k] = arg2[j];
					k++; j++;
				}
				if( arg2[j] == ',' ) j++;
				el[k] = '\0';
				bel = basad( el );
				if( bel == -BASIS || bel == -BASIS-1 ) 
				{       if( bel == -BASIS-1 ) 
					{  mistake(32);
/**neu**/
					   errm(0,k-1,el,1);
					   if(ps) ferrm(0,k-1,el);
/**Ende**/
					}
					return( -BASIS );
				}
				if( lsecond( bel ) < 0  ||
				( lsecond(bel)>4 && lsecond(bel)<17 ) ||
				( lsecond(bel)>18 && lsecond(bel)<24) ||
				( lsecond(bel)>25 && lsecond(bel)<31) ||
				lsecond(bel)>32 ) 
				{       mistake( 77 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}
				if( ( ( kenmax == 17 || kenmax == 18 
				 || kenmax == 31 || kenmax == 32 ) 
			         && ( lsecond( bel ) == 24 || lsecond( bel ) == 25 ) )
				 || ( ( kenmax == 24 || kenmax == 25 )
                                 && ( lsecond( bel ) == 17 || lsecond( bel ) == 18 
				 || lsecond(bel)==31 || lsecond(bel)==32 ) ) )
				{	mistake( 165 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}  		
				if( lsecond( bel ) > kenmax )
				{       if( kenmax == 1 && lsecond( bel ) == 2 ) kenmax = 3;
					else if( ( kenmax == 2 || kenmax == 3 ) && lsecond( bel ) == 17 ) kenmax = 18;
					else if( ( kenmax == 2 || kenmax == 3 || kenmax == 18 ) && lsecond( bel ) == 31 ) kenmax = 32;
					else if( ( kenmax == 2 || kenmax == 3 ) && lsecond( bel ) == 24 ) kenmax = 25;
					else if( kenmax == 4 && lsecond( bel ) > 16 )
					{	mistake( 160 );
/**neu**/
						errm(i,i+k-1,arg2,1);
						if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
						return( ERROR );
					}
					else  kenmax = lsecond( bel );
					if( ( kenmax > 4 && kenmax < 17 ) 
					|| ( kenmax > 18 && kenmax < 24 ) 
					|| ( kenmax > 25 && kenmax < 31 ) 
					|| kenmax > 32 )
					{       mistake( 77 );
/**neu**/
						errm(i,i+k-1,arg2,1);
						if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
						return( -BASIS );
					}
				}
				if( lsecond( bel ) == 1 && kenmax == 2 ) kenmax = 3;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 ) && kenmax == 17 ) kenmax = 18;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 || lsecond(bel) == 18 ) && kenmax == 31 ) kenmax = 32;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 ) && kenmax == 24 ) kenmax = 25;
				else if( lsecond( bel ) == 4 && kenmax > 16 )
				{	mistake( 160 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}
/**** HIER GF2			if( kenmax > 30 && gfchar == 2 )
				{	mistake( 221 );
***neu
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
***Ende
					return( ERROR );
				} ****/
				erg = lcomp( bel, erg );
			   }
			   j = j + 2;
			   erg = linv( erg );
			   H = lcomp( erg, H );
			 }
			 if( kenmax < 5 ) kenmax = kenmax + 5;
			 else kenmax = kenmax + 2;
			 H = linv( H );
			 H = mlist( H, kenmax );
			 if( H == ERROR ) 
			 {
/**neu**/
				errm(0,strlen(arg2)-1,arg2,1);
				if(ps) ferrm(0,strlen(arg2)-1,arg2);
/**Ende**/
				return( ERROR ); 
			}
			 keller = lcomp( H, keller );
			 }
			 break;

	/*** Verwaltung der Vektorrechnung ***/

		case 40: 
			 if(1){
			 char el[MAXL];
			 H = _0;
			 kenmax = 0;
			 j = 1;
			 while( arg2[j] != '\0' )
			 {      kl = 0;
				k = 0;
				i=j;
				while(kl || ( arg2[j] != ',' && arg2[j] != '}'))
				{       switch( arg2[j] )
					{       case '(': kl++;
							  break;
						case ')': kl--;
							  break;
						default:  break;
					}
					el[k] = arg2[j];
					k++; j++;
				}
				j++;
				el[k] = '\0';
				bel = basad( el );
				if( bel == -BASIS || bel == -BASIS-1 ) 
				{       if( bel == -BASIS-1 ) 
					{   mistake(32);
/**neu**/
					    errm(0,k-1,el,1);
					    if(ps) ferrm(0,k-1,el);
/**Ende**/
					}
					return( -BASIS );
				}
				if( lsecond( bel ) < 0  ||
				( lsecond(bel)>4 && lsecond(bel)<17 ) ||
				( lsecond(bel)>18 && lsecond(bel)<24) ||
				( lsecond(bel)>25 && lsecond(bel)<31) ||
				lsecond(bel)>32 ) 
				{       mistake( 77 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}
				if( ( ( kenmax == 17 || kenmax == 18 
				 || kenmax == 31 || kenmax == 32 ) 
			         && ( lsecond( bel ) == 24 || lsecond( bel ) == 25 ) )
				 || ( ( kenmax == 24 || kenmax == 25 )
                                 && ( lsecond( bel ) == 17 || lsecond( bel ) == 18 
				 || lsecond(bel)==31 || lsecond(bel)==32 ) ) )
				{	mistake( 165 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}  		
				if( lsecond( bel ) > kenmax )
				{       if( kenmax == 1 && lsecond( bel ) == 2 ) kenmax = 3;
					else if( ( kenmax == 2 || kenmax == 3 ) && lsecond( bel ) == 17 ) kenmax = 18;
					else if( ( kenmax == 2 || kenmax == 3 || kenmax == 18 ) && lsecond( bel ) == 31 ) kenmax = 32;
					else if( ( kenmax == 2 || kenmax == 3 ) && lsecond( bel ) == 24 ) kenmax = 25;
					else if( kenmax == 4 && lsecond( bel ) > 16 )
					{	mistake( 160 );
/**neu**/
						errm(i,i+k-1,arg2,1);
						if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
						return( ERROR );
					}
					else  kenmax = lsecond( bel );
					if( ( kenmax > 4 && kenmax < 17 ) 
					|| ( kenmax > 18 && kenmax < 24 ) 
					|| ( kenmax > 25 && kenmax < 31 ) 
					|| kenmax > 32 )
					{       mistake( 77 );
/**neu**/
						errm(i,i+k-1,arg2,1);
						if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
						return( -BASIS );
					}
				}
				if( lsecond( bel ) == 1 && kenmax == 2 ) kenmax = 3;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 ) && kenmax == 17 ) kenmax = 18;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 || lsecond(bel) == 18 ) && kenmax == 31 ) kenmax = 32;
 				else if( ( lsecond( bel ) == 2 || lsecond( bel ) == 3 ) && kenmax == 24 ) kenmax = 25;
				else if( lsecond( bel ) == 4 && kenmax > 16 )
				{	mistake( 160 );
/**neu**/
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
/**Ende**/
					return( ERROR );
				}
/**** HIER GF2
				if( kenmax > 30 && gfchar == 2 )
				{	mistake( 221 );
**neu
					errm(i,i+k-1,arg2,1);
					if(ps) ferrm(i,i+k-1,arg2);
**Ende
					return( ERROR );
				} ****/
				H = lcomp( bel, H );
			 }
			 if( kenmax < 5 ) kenmax = kenmax + 10;
			 else kenmax = kenmax + 4;
			 H = linv( H );
			 H = vlist( H, kenmax );
			 if( H == ERROR ) 
			 {
/**neu**/
				errm(0,strlen(arg2)-1,arg2,1);
				if(ps) ferrm(0,strlen(arg2)-1,arg2);
/**Ende**/
				return( ERROR );
			 }
			 keller = lcomp( H, keller );
			 }
			 break;

		/*** der unendl. ferne affine Punkt einer ell. Kurve ***/

		case 45 : H = list3( 0, 1, 0 );
			  H=list2(H,(-3));
			  keller = lcomp( H,keller );
			  break;

		/*** Auswertung von Pi ***/

		case 46 : H = flPi();
			  H = list2(H,15);
			  keller = lcomp(H,keller);
			  break;
		

		/*** Auswertung von i bzw. I ***/

		case 47 : H = itofl(1);
			  H = list2(0,H);
			  H = list2(H,37);
			  keller = lcomp(H,keller);
			  break;
		}
	}

	/*** Auswertung des Verwaltungskellers ***/

	if ( keller == -BASIS || keller == -BASIS-1 ) return( keller );
	while ( llength( keller ) - 1 ) {
		keller = eval( keller, &vprio );
		if ( keller == -BASIS ) return( -BASIS );
	}
	erg = lfirst( keller );
	if( ( lsecond( erg ) < 5 && lsecond( erg ) > (-3) ) || lsecond( erg ) == 15 )
		erg = kenntest( erg );
	return( erg );
}
