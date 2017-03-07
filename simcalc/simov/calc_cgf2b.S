/*C
			calc_cgf2b( fkeller )

	"calculator current Galois-field".
	list calc_cgf2b(fkeller); list fkeller;
	L = calc_cgf2b( fkeller );

	fkeller ist eine Liste bestehend aus drei Objekten, die eine
	Primzahl, eine Variable und ein irreduzibles Polynom in dieser 
	Variablen bzw. der Grad der Koerpererweiterung mit zugehoerigen 
	Kennungen darstellt.
	calc_cgf2b merkt sich intern ueber den Schalter gfsch, dass
	bezueglich des Polynoms F, das in fkeller steht, die Arithmetik
	des endlichen Koerpers K, der von F erzeugt wird, von P( K ) 
	sowie von Matrizen und Vektoren ueber diesen Strukturen zu 
	verstehen ist, ebenso die Arithmetik fuer elliptische Kurven 
	ueber K.
	Wird das Polynom veraendert, so werden alle Elemente in K,
	P( K ) sowie Matrizen und Vektoren ueber diesen Strukturen,
	sowie elliptische Kurven ueber K, bzgl. des neuen endlichen 
	Koerpers aufgefasst, d.h. reduziert bzw eingebettet.
	Es wird an die Variable curGaloisField zurueckgegeben.
	In L wird fuer Charakteristik > 2 das Ergebnis von gfsalgen
	und fuer Charakteristik = 2 das Ergebnis von gf2impsbgen
 	zurueckgegeben.
	Laeuft calc_cgf2b fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      14.08.1998      S.Schmitt (von calc_curgf getrennt)
H*/

 
# include <_calc.h>


list calc_cgf2b( fkeller )
list fkeller;
{
	single hn, i, l, h, k, sch, r, n, hab=0,ein=0,fsch;
	pol A, F, P;
	list V, Vt, AL, EMB;
	obj H, K, ko[5];
	char *ant, *an, c, *getline();

	init( A, F, P, V, Vt, AL, EMB, H, K ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"curgf2bit" );
		return( ERROR );
	}


	/*** 2.Argument Var., die noch nicht als Var.name benutzt wurde ***/

	V = lsecond( fkeller );
	k = lsecond( V );
	if( k != 2 )
	{       mistake( 197 );
		return( ERROR );
	}
	V = lfirst( V );
	Vt = lfirst( V );
	hn = lsecond( V );
	if( llength( hn ) != 2 || lfirst( hn ) != 1 || lsecond( hn ) != 1 || llength( Vt ) != 1 )
	{       mistake( 197 );
		return( ERROR );
	}
	
	/*** Polynom oder Grad ***/

	P = lfirst( fkeller );
	k = lsecond( P );
	if( k && k != 2 && k != 18  )
	{       mistake( 273 );
		return( ERROR );
	}
	F = lfirst( P );
	if( !k && ( !isatom(F) || F<2 ) )
	{	mistake(273);
		return(ERROR);
	}

	ant = malloc(MAXLV);
	*ant = '\0';
	an = malloc(MAXLV);
	*an = '\0';
	
	if(k)
	{ 	V = lfirst( F );
		if( llength( V ) != 1 || !oequal( V, Vt ) )
		{      	 mistake( 273 );
			free(an);
			free(ant);
			return( ERROR );
		}
		F = lsecond( F );
		if(k==2)	 F=pitopms(1,F,2);
		else
		{	P=lfirst(varlist[modsch].varwert);
			if(!ssch || !pzsch || P!=2)
			{	mistake(266);
				free(an);
				free(ant);
				return(ERROR);
			}
		}		
		n=pdegree(1,F);	
		if(n<2)
		{	mistake(273);
			free(an);
			free(ant);
			return(ERROR);
		}
		if(lsecond(F) !=1) F= pmimonic(1,2,F);
		if( !isimupms( 2, F ) )
		{       mistake( 273 );
			free(an);
			free(ant);
			return( ERROR );
		}
		P=ptodp(1,F);
		AL=gf2impsbgen(n,P);
	}
	else 
	{	n=F;
		F=0;
	}
	if(gfsch && gfchar == 2)
	{	A=lfirst(varlist[gfsch].varwert);
		hn = lfirst(A);	
		if(hn <= n && !(n%hn))
		{	for(i=0;i<MX;i++)
	    		{   if(strlen(varlist[i].varname) && varlist[i].typ!=2 && varlist[i].typ!=(-3) && varlist[i].varwert != ERROR )
	        		{	h=lsecond(varlist[i].varwert);
					if((h>30 && h<37) || (h>-17 && h<-13))  
					{  hab=1;
					   break;
					}
				}
	        		if(!i) i=MXNUM-1;
			}
			if(hab && !assch && isatty(fileno(stdin))){
			printf(" Do you want to embed all elements over \n the old Galois-field in the new one? (y/n) ");
			if(ps) fprintf( datei,"out: Do you want to embed all elements over \n the old Galois-field in the new one? (y/n)\n");
			setocnt( stdout, 0 );
			*ant = '\0';
			ant = getline("",-1);
			c = (*ant);
			setocnt(stdout,0);
			if ( ps ) fprintf( datei, "in : %c", c );
			if( c == 'y' ) 
			{	ein = 1;
				if(k) 
				{
# ifdef ___CASI
				      EMB = gf2iessp(A,AL,n);
# else
				      EMB = gf2ies(A,AL,n);
# endif
				}
				else 
				{
# ifdef ___CASI
				      EMB = gf2iessp(A,0,n);
# else
				      EMB = gf2ies(A,0,n);
# endif
				      AL = lfirst(EMB);
				}
			}
			else if(!k) AL = gf2impsbgen(n,0);
			}
			else if(!k) AL=gf2impsbgen(n,0);
		}
		else	if(!k) AL = gf2impsbgen(n,0);
	}
	else	if(!k) AL = gf2impsbgen(n,0);
	if(!k) 
	{ 	F=sbtoudpm2(AL);
		F=dptop(1,F);
	}
	VGF=Vt;	
	
	/*** Abspeichern des cur. Galois-field in varlist ***/

	if( !gfsch )
	{       for( k = MXNUM; k < MX; k++ )
		{       if( !strlen( varlist[k].varname ) )
			{       strcpy( varlist[k].varname, "curGaloisField" );
				gfsch = k;
				break;
			}
		}
	}
	else
/* Angleichung der Charakteristik */
	{     av_loesche(30);
	      if(2!=gfchar)
	      {	
		     for(k=0;k<MX;k++)
		     {   if(strlen(varlist[k].varname) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
		         {	h=lsecond(varlist[k].varwert);
				H=lfirst(varlist[k].varwert);	
				switch(h)
				{  case 31: H=gfseltogf2el(AL,H);	 
					    varlist[k].varwert=list2(H,31);
					    break;
				   case 32: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=pgfstopgf2(r,AL,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,32);
					    break;
				   case 33: H=magfstomagf2(AL,H);
					    varlist[k].varwert=list2(H,33);
					    break;
				   case 34: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=mpgfstompgf2(r,AL,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,34);
					    break;
				   case 35: H=vecgfstovgf2(AL,H);
					    varlist[k].varwert=list2(H,35);
					    break;
				   case 36: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=vpgfstovpgf2(r,AL,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,36);
				   	    break;
				   default : break;
				}
		        }
		        if(!k) k=MXNUM-1;
		    }
		    structsort();		
	       }

/*** Reduzieren nach Grad ***/
	            A=lfirst(varlist[gfsch].varwert);
		    if(gfchar==2)
		    { 	K=sbtoudpm2(A);
			K=dptop(1,K);
		    }
		    else     K=lfirst(A);  
		    hn=pdegree(1,K);
		    if(n<hn)
		    {	for(k=0;k<MX;k++)
			{   if(strlen(varlist[k].varname) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
			    {	h=lsecond(varlist[k].varwert);
				H=lfirst(varlist[k].varwert);	
				switch(h)
				{  case 31: H=gf2elred(H,AL);	 
					    varlist[k].varwert=list2(H,31);
					    break;
				   case 32: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=pgf2red(r,H,AL);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,32);
					    break;
				   case 33: H=magf2red(H,AL);
					    varlist[k].varwert=list2(H,33);
					    break;
				   case 34: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=mapgf2red(r,H,AL);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,34);
					    break;
				   case 35: H=vecgf2red(H,AL);
					    varlist[k].varwert=list2(H,35);
					    break;
				   case 36: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=vecpgf2red(r,H,AL);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,36);
				   	    break;
				   case (-14): i=0;
					       while(H!=_0)
					       { ko[i]=lfirst(H);
						 ko[i]=gf2elred(ko[i],AL);
						 H=lred(H);
						 i++;
					       }
					       V=ecgf2disc(AL,ko[0],ko[1],ko[2],ko[3],ko[4]);
					       if(!V)
					       { if(!assch){
						 printf(" The variable %s is deleted!\n",varlist[k].varname);
						 if(ps) fprintf(datei,"out: The variable %s is deleted!\n",varlist[k].varname);
						 }
					         varlist[k].varwert=0;
						 if(k==ecsch)  ecsch=0;
						 strcpy(varlist[k].varname,"\0");
					       }
					       else
					       { H=list5(ko[0],ko[1],ko[2],ko[3],ko[4]);
						 varlist[k].varwert=list2(H,(-14));
					       }
					       break;
				   case (-15):
				   case (-16): if(!H) break;
					       V=_0;
					       while(H!=_0)
					       { K=lfirst(H);
						 K=gf2elred(K,AL);
						 V=lcomp(K,V);
						 H=lred(H);
					       }
					       V=linv(V);
					       varlist[k].varwert=list2(V,h);
					       break;
				   default : break;
				}
			     }
			     if(!k) k=MXNUM-1;
			}
			structsort();		
		    }
		    else if(ein)   
		    {	for(k=0;k<MX;k++)
		        {   if(strlen(varlist[k].varname) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
			    {	h=lsecond(varlist[k].varwert);
				H=lfirst(varlist[k].varwert);	
				switch(h)
				{  case 31: H=gf2efe(EMB,H);	 
					    varlist[k].varwert=list2(H,31);
					    break;
				   case 32: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=pgf2efe(r,EMB,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,32);
					    break;
				   case 33: H=magf2efe(EMB,H);
					    varlist[k].varwert=list2(H,33);
					    break;
				   case 34: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=mapgf2efe(r,EMB,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,34);
					    break;
				   case 35: H=vecgf2efe(EMB,H);
					    varlist[k].varwert=list2(H,35);
					    break;
				   case 36: V=lfirst(H);
					    r=llength(V);
					    H=lsecond(H);
					    H=vecpgf2efe(r,EMB,H);
					    H=list2(V,H);
					    varlist[k].varwert=list2(H,36);
				   	    break;
				   case (-14): fsch = 0;
					       printf("\n If you know the number of points of the elliptic curve\n");
					       if(ps) fprintf( datei,"\nout: If you know the number of points of the elliptic curve\n");
			 		       printf( " %s = EC(",varlist[k].varname );
			 		       if( ps ) fprintf( datei, " %s = EC(",varlist[k].varname );
					       P=H;
			 		       while( P != _0 )
			 		       {   V = lfirst( P );
						   P = lred( P );
						   putgf2el( A,V, VGF );
						   if( P != _0 ) printf( ", " );
						   if( ps )
						   {       fputgf2el( A, V, VGF, datei );
						           if( P != _0 ) fprintf( datei, ", " );
						   }
			 		       }
			 		       printf( ")\n" );
			 		       if( ps ) fprintf( datei, ")\n" );
					       printf(" over the old Galois-field and you want to know the number of points\n over the new one, please type 'y'. (y/n) ");
					       if(ps) fprintf( datei, "     over the old Galois-field and you want to know the number of points\n over the new one, please type 'y'. (y/n) ");
					       setocnt( stdout, 0 );
					       *ant = '\0';
					       ant = getline("",-1);
					       c = (*ant);
					       setocnt(stdout,0);
					       if ( ps ) fprintf( datei, "in : %c", c );
					       if( c == 'y' ) 
					       {  printf(" Please type the number of points over the old Galois-field\n or the variable in which this number is stored: ");
						  if(ps) fprintf( datei,"out: Please type the number of points over the old Galois-field\n or the variable in which this number is stored: ");
					          setocnt( stdout, 0 );
					          *ant = '\0';
						  *an = '\0';
					          ant = getline("",-1);
					          setocnt(stdout,0);
					          if ( ps ) fprintf( datei, "in : %s", ant );
	                                          if(strchr(ant,'[')!=NULL) 
						  { if( !(artovar(ant,an) ) )
						    fsch = 1;
					            else
						    strcpy( ant, an );
				                  }
						  else
						  {
						   l = strlen(ant);
						   if(strcmp(ant,"@"))
						   { if(isdigit(*ant))
						    { for(i=1;i<l;i++)
						        if(!isdigit(*(ant+i)))
						        {fsch = 1;
						         break;
						        }	
						    }
						    else if(isalpha(*ant))
						    { if(l>20) fsch = 1;
						      else
						      { for(i=1;i<l;i++)
						          if(!isalnum(*(ant+i)))
						 	  { fsch = 1;
							    break;
							  }
						      }
						   }
						   else fsch=1;
						  }
						 }
						 if(fsch)
						   mistake(253);
						 else
						 { 
						   V = basad(ant);
						   if( V!=ERROR && V!=ERROR-1 )
						   {
						   P = lsecond(V);
						   if(P) mistake(253);
						   else
						   { V = lfirst(V);
					             ko[0] = lfirst(H);
						     ko[1]=lsecond(H);
						     ko[2]=lthird(H);
						     ko[3]=lfourth(H);
						     ko[4]=lfifth(H);
						     P=ecgf2npfe(A,ko[0],ko[1],ko[2],ko[3],ko[4],V,EMB);
						     P = lred(P);
						     ko[0]=lfirst(P);
						     ko[1]=lsecond(P);
						     ko[2]=lthird(P);
						     ko[3]=lfourth(P);
						     ko[4]=lfifth(P);
						     H=list5(ko[0],ko[1],ko[2],ko[3],ko[4]);	
						     varlist[k].varwert=list2(H,-14);
						     fsch = 2;
						     P=lsixth(P);
						     printf(" The number of points over the new Galois-field is %i.\n",P);
						     if(ps) fprintf(datei,"out: The number of points over the new Galois-field is %i.\n",P);
						   }
						   }
						 }
					       }
					       if(fsch !=2 )
					       {  P=_0;
						  while(H!=_0)
						  {  V=lfirst(H);
						     H=lred(H);
						     V=gf2efe(EMB,V);
						     P=lcomp(V,P);
						 }
						 P=linv(P);
						 varlist[k].varwert = list2(P,-14);
					       }
					       break;
				   case (-15):
				   case (-16): P = _0;
					       while(H!=_0)
					       {  V = lfirst(H);
						  H = lred(H);
						  V = gf2efe(EMB,V);
						  P = lcomp(V,P);
					       }
					       P=linv(P);
					       varlist[k].varwert = list2(P,h);
					       break;
				   default : break;
			       }
			    }
			    if(!k) k=MXNUM-1;
			}
		    }
  	}
	gfchar=2;
	H=list2(AL,30);
	varlist[gfsch].varwert=H;
	F=list2(VGF,F);
	F=list2(F,2);
	free(an);
	free(ant);
	return(F);
}
