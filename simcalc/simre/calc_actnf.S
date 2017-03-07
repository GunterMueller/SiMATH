/*C
			calc_actnf( fkeller )

	"calculator actual number field".
	list calc_actnf(fkeller); list fkeller;
	L = calc_actnf( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt, das ein
	irreduzibles Polynom in 1 Variablen mit zugehoeriger Kennung
        darstellt.
	calc_actnf merkt sich intern ueber den Schalter nfsch, dass
	bezueglich des Polynoms F, das in fkeller steht, die Arithmetik
	des Zahlkoerpers K, der von F erzeugt wird, von P( K ) sowie
	von Matrizen und Vektoren ueber diesen Strukturen zu verste-
	hen ist, ebenso die Arithmetik fuer elliptische Kurven ueber K.
	Wird das Polynom veraendert, so werden alle Elemente in K,
	P( K ) sowie Matrizen und Vektoren ueber diesen Strukturen,
	sowie elliptische Kurven ueber K, bzgl. des neuen Zahlkoerpers
        aufgefasst, d.h. reduziert.
	Er wird an die Variable act.number-field zurueckgegeben.
	In L wird F in dense-Darstellung zurueckgegeben.
	Laeuft calc_actnf fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.04.1992      U.Schneiders
	Version  2	03.02.1994	S.Schmitt/U.Schneiders
	Version  2.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list calc_actnf( fkeller )
list fkeller;
{
	single fn, i, h, k, grsch, r;
	list ecalt;
	pol A, F, P;
	list V, Vt;
	obj hn, H, K, ko[5];
	char *name;
	init( ecalt,A, F, P, V, Vt, hn, H, K ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"curnf" );
		return( ERROR );
	}

	/*** 1.Argument Var., die noch nicht als Var.name benutzt wurde ***/

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

	P = lfirst( fkeller );
	k = lsecond( P );
	if( k != 2 && k != 3 )
	{       mistake( 161 );
		return( ERROR );
	}
	F = lfirst( P );
	V = lfirst( F );
	if( llength( V ) != 1 || !oequal( V, Vt ) )
	{       mistake( 161 );
		return( ERROR );
	}
	VNF = V;
	F = lsecond( F );
	if( k == 3 ) F = prnumden( 1, F, &hn );
	if( !isiupi( F ) )
	{       mistake( 161 );
		return( ERROR );
	}

	F = ptodp( 1, F );

	fn = dpdegvec( 1, F );
	fn = lfirst( fn );
	if( fn < 2 )
	{  	mistake( 161 );
		return( ERROR );
	}

	ecalt = ecqnfsch;
	if(lfirst(F) == 2)
	{	if(lsecond(F) == 1 && lthird(F) == 0)
		{	H=lfourth(F);
			H=ineg(H);
			A=isfp(H);
			if(oequal(A,H))  ecqnfsch = list1(H);
		}
		else
		{	
		/** F= HX^2+AX+K , berechne quadratfreien Anteil (als ganze
		    Zahl) von a^2-4b, a=A/H, b=K/H **/

			A=lthird(F);
			K=lfourth(F);
			H=lsecond(F);
			A=rcons(A,H);	
			K=rcons(K,H);
			K=rprod(itor(4),K);
			H=rprod(A,A);
			K=rdif(H,K);		/** a^2-4b **/

			H=rden(K);
			K=rnum(K);
			ko[0]=isfp(H);		/** sfp von Nenner **/
			K=iprod(K,ko[0]);	/** erweitern so dass **/
		        H=iprod(H,ko[0]);       /** Nenner Quadrat ist **/
			H=isqrt(H);
			ko[0]=isfp(K);		/** quadratfreier Anteil **/
			K=iquot(K,ko[0]);
			K=isqrt(K);
			H=rcons(K,H);
			ecqnfsch=list3(ko[0],A,H);
		}
	}
	else ecqnfsch = _0;

	/*** Abspeichern des cur. number field in varlist ***/

	if( !nfsch )
	{       for( k = MXNUM; k < MX; k++ )
		{       if( !strlen( varlist[k].varname ) )
			{       name = "curNumberField";
				strcpy( varlist[k].varname, name );
				nfsch = k;
				break;
			}
		}
	}

	else
	{       /*** Reduzieren mod neuem Polynom, falls sein Grad kleiner ***/
		av_loesche(23);
		A = lfirst( varlist[nfsch].varwert );
		hn = dpdegvec( 1, A );
		hn = lfirst( hn );
		if( fn<hn ) grsch = 1;  /** neuer Grad < alter Grad **/
		else        grsch = 0;

		if( grsch )
		{   for( k = 0; k < MX; k++ )
		    {   if( strlen( varlist[k].varname ) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
		        {   h = lsecond( varlist[k].varwert );
			    switch( h )
			    {   case 24: H = lfirst( varlist[k].varwert );
					 H = nfelred( A, H, F );
					 varlist[k].varwert = list2( H, 24 );
					 break;
				case 25: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 H = pnfred( r, A, H, F );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 25 );
					 break;
				case 26: H = lfirst( varlist[k].varwert );
					 H = manfred( A, H, F );
					 varlist[k].varwert = list2( H, 26 );
					 break;
				case 27: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 H = mapnfred( r, A, H, F );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 27 );
					 break;
				case 28: H = lfirst( varlist[k].varwert );
					 H = vecnfred( A, H, F );
					 varlist[k].varwert = list2( H, 28 );
					 break;
				case 29: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 H = vecpnfred( r, A, H, F );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 29 );
					 break;
				case (-9):
				case (-10):H = lfirst( varlist[k].varwert );

					/*** E singulaer? ***/

					i = 0;  
					while( H != _0 )
					{       ko[i] = lfirst( H );
						ko[i] = nfelred( A, ko[i], F );
						H = lred( H );
						i++;
					}
					if( h == -9 )   V = ecnfsnfdisc( F, ko[0], ko[1] );
					else  V = ecnfdisc( F, ko[0], ko[1], ko[2], ko[3], ko[4] );
					if( !V )
					{       if(!assch){
						if ( ps ) 
		                                {  fprintf( datei, "out: The variable %s is deleted.\n", varlist[k].varname );
		                                }
		                                printf(" The variable %s is deleted.\n",varlist[k].varname );
						}
		                                varlist[k].varwert = 0;
		                                if( k == ecsch ) ecsch = 0;
		                                strcpy(varlist[k].varname,"\0");
						/*structsort();*/
					}
					else
					{	if(ecqnfsch!=_0)
						{  H=lfirst(ecqnfsch);
						   if(h==(-9)) V = ecqnfinit(H,0,0,0,ko[0],ko[1]);
					           else V=ecqnfinit(H,ko[0],ko[1],ko[2],ko[3],ko[4]);
						}
						else 
						{  if( h == -9 ) V = list2( ko[0], ko[1] );
						   else V = list5( ko[0], ko[1], ko[2], ko[3], ko[4] );
						}
					}
					varlist[k].varwert = list2( V, h );
				        break;
				case (-11):
				case (-12):H = lfirst( varlist[k].varwert );
			         	   if( !H )
					   {       H = list2( 0, -11 );
						   break;
					   }
					   V = _0;
					   while( H != _0 )
					   {       K = lfirst( H );
					           K = nfelred( A, K, F );
						   V = lcomp( K, V );
						   H = lred( H );
					   }
					   V = linv( V );
					   varlist[k].varwert = list2( V, h );
					   break;
				default: break;
			    }
			}
			if( !k ) k = MXNUM - 1;
		    }
		    structsort();
		}
		else if((ecalt==_0 && ecqnfsch!=_0) 
		    || (ecalt!=_0 && !ecqnfsch==_0))
		{   for( k = 0; k < MX; k++ )
		    {   if( strlen( varlist[k].varname ) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
		        {   h = lsecond( varlist[k].varwert );
			    switch( h )
			    {	case (-9):
				case (-10):H=lfirst(varlist[k].varwert);
					   if(ecalt)
					   {   V=lfirst(lfirst(H));
					       if(h==(-9)) V=lred3(V);
					   }
					   else
					   {	i=0;
						while(H!=_0)
						{ ko[i]=lfirst(H);
						  H=lred(H);
						  i++;
					 	}
						H=lfirst(ecqnfsch);
						if(h==(-9))
						   V=ecqnfinit(H,0,0,0,ko[0],ko[1]);
						else V=ecqnfinit(H,ko[0],ko[1],ko[2],ko[3],ko[4]);
					   }
					   varlist[k].varwert = list2(V,h);
					   break;
				default:break;
			     }
			 }
		   	 if(!k) k=MXNUM-1;
		    }
		}	
		else if(ecalt!=_0 && ecqnfsch!=_0 )
		{   for( k = 0; k < MX; k++ )
		    {   if( strlen( varlist[k].varname ) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
		        {   h = lsecond( varlist[k].varwert );
			    switch( h )
			    {	case (-9):
				case (-10):H=lfirst(varlist[k].varwert);
					   H=lfirst(H);
					   V=lfirst(H);
					   ko[0]=lfirst(V);
					   ko[1]=lsecond(V);
					   ko[2] = lthird(V);
					   ko[3] = lfourth(V);
					   ko[4] = lfifth(V);
					   H=lfirst(ecqnfsch);
					   V=ecqnfinit(H,ko[0],ko[1],ko[2],ko[3],ko[4]);
					   varlist[k].varwert = list2(V,h);
					   break;
				default:break;
			     }
			 }
		   	 if(!k) k=MXNUM-1;
		     }
		}
	}
	H = list2( F, 23 );
	varlist[nfsch].varwert = H;
	return( P );
}
