/*C
			calc_actmod( fkeller )

	"calculator actual modulus".
	list calc_actmod(fkeller); list fkeller;
	L = calc_actmod( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt, das eine
	ganze Zahl mit zugehoeriger Kennung darstellt.
	calc_actmod merkt sich intern ueber den Schalter modsch, dass
	bezueglich des Moduls m, der in fkeller steht, die Arithmetik
	ueber Z/mZ, P( Z/mZ ) und ueber Matrizen und Vektoren ueber
	diesen beiden Strukturen zu verstehen ist.
	Ist m eine Primzahl, so ist auch die Arithmetik fuer ellipti-
	sche Kurven ueber Z/pZ definiert.
	Wird der Modul veraendert, so werden alle ueber Z/mZ, P( Z/mZ )
	aufgefassten Elemente sowie Matrizen und Vektoren ueber diesen
	Strukturen bzgl. des neuen Moduls aufgefasst, d.h. reduziert.
	Elliptische Kurven und Punkte ueber Z/pZ werden bzgl. des
	neuen Moduls reduziert, falls er eine Primzahl ist, sonst
	in elliptische Kurve und Punkte ueber Z ueberfuehrt.
	Er wird an die Variable act.modulus zurueckgegeben.
	In L wird m zurueckgegeben.
	Laeuft calc_actmod fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      17.03.1992      U.Schneiders
	Version  2	22.04.1993	S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list calc_actmod( fkeller )
list fkeller;
{
	single spbit=0,grsch, h, i, k, r;
	list H, V;
	obj A, M, ko[5];
	char *name;
	init( H, V, A, M );
	init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k )
	{       mistake( 156 );
		return( ERROR );
	}
	M = lfirst( fkeller );
	if( isign( M ) != 1 || M == 1 )
	{       mistake( 156 );
		return( ERROR );
	}

	if( isatom( M ) )
	{       ssch = 1;
		pzsch = issprime( M, &k );
		if( pzsch == (-1) )  pzsch = 0;
	}
	else  
	{       ssch = 0;
		H = ispd(M,&A);
		if(H==_0) pzsch = 1;	/** ist vielleicht Primzahl **/
		else pzsch = 0;		/** ist ganz sicher keine Primzahl **/
	}

	/*** Abspeichern des cur. modulus in varlist ***/

	if( !modsch )
	{       for( k = MXNUM; k < MX; k++ )
		{       if( !strlen( varlist[k].varname ) )
			{       name = "curModulus";
				strcpy( varlist[k].varname, name );
				modsch = k;
				break;
			}
		}
	}

	else
	{       /*** Reduzieren mod neuem Modul, falls neuer Modul kleiner ***/
		av_loesche(16);
		H = varlist[modsch].varwert;
		H = lfirst( H );
		if(H==2) spbit=1;
		if( icomp( H, M ) > 0 ) grsch = 1;
		else			grsch = 0;
		for( k = 0; k < MX; k++ )
		{   if( strlen( varlist[k].varname ) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
		    {   h = lsecond( varlist[k].varwert );

			/*** cur.modus, der nicht in varlist[modsch]
		     	     steht, wird in Zahl umgewandelt.  ***/

			if( k != modsch && h == 16 )
			{	H = lfirst( varlist[k].varwert );
				H = list2( H, 0 );
				varlist[k].varwert = H;
			}

			if( grsch )
			{   switch( h )
			    {   case 17: H = lfirst( varlist[k].varwert );
					 if( ssch )  H = mshom( M, H );
					 else        H = mihom( M, H );
					 varlist[k].varwert = list2( H, 17 );
					 break;
				case 18: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 if( ssch )   H = pitopms( r, H, M );
					 else         H = pitopmi( r, H, M );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 18 );
					 break;
				case 19: H = lfirst( varlist[k].varwert );
					 if( ssch )  H = maitomams( M, H );
					 else        H = maitomami( M, H );
					 if(M==2) H=mamstomam2(H);
					 varlist[k].varwert = list2( H, 19 );
					 break;
				case 20: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 if( ssch )   H = mapitomapms( r, H, M );
					 else         H = mapitomapmi( r, H, M );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 20 );
					 break;
				case 21: H = lfirst( varlist[k].varwert );
					 if( ssch )  H = vecitovecms( M, H );
					 else        H = vecitovecmi( M, H );
					 varlist[k].varwert = list2( H, 21 );
					 break;
				case 22: H = lfirst( varlist[k].varwert );
					 V = lfirst( H );
					 r = llength( V );
					 H = lsecond( H );
					 if( ssch )   H = vecpitovpms( r, H, M );
					 else         H = vecpitovpmi( r, H, M );
					 H = list2( V, H );
					 varlist[k].varwert = list2( H, 22 );
					 break;
				case (-5):
				case (-6): if( pzsch )
					   {    H = lfirst( varlist[k].varwert );

						/*** E singulaer? ***/

						i = 0;  A = H;
						while( A != _0 )
						{       ko[i] = lfirst( A );
							ko[i] = itor( ko[i] );
							A = lred( A );
							i++;
						}
						if( h==(-5)) A=ecrinit(0,0,0,ko[0],ko[1]);
						else  A=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
						V=ecracdisc(A);
						V = lfirst( V );
						if( iaval( M, V ) )
						{       A=list2(A,(-2));
							A=kenntest(A); 
							varlist[k].varwert = A;
							break;
						}

						V = _0;
						while( H != _0 )
						{       A = lfirst( H );
							if(ssch) A = mshom( M, A );
							else A = mihom( M, A );
							V = lcomp( A, V );
							H = lred( H );
						}
						V = linv( V );
						varlist[k].varwert = list2( V, h );
					   }
					   break;
				case (-7):
				case (-8): if( pzsch )
					   {    H = lfirst( varlist[k].varwert );
						if( !H )
						{       H = list2( 0, -7 );
							break;
						}
						V = _0;
						while( H != _0 )
						{       A = lfirst( H );
							if(ssch) A = mshom( M, A );
							else A = mihom( M, A );
							V = lcomp( A, V );
							H = lred( H );
						}
						V = linv( V );
						varlist[k].varwert = list2( V, h );
					   }
					   break;
				default: break;
			    }
			}
			else if( h == (-5) || h == (-6) )
			{   if( pzsch )
			    {   H = lfirst( varlist[k].varwert );
				i = 0;
			  	A = H;
				while( A != _0 )
				{       ko[i] = lfirst( A );
					ko[i] = itor( ko[i] );
					A = lred( A );
					i++;
				}
				if( h==(-5)) A=ecrinit(0,0,0,ko[0],ko[1]);
				else  A=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
				V=ecracdisc(A);
				V = lfirst( V );
				if( iaval( M, V ) )
				{       A=list2(A,(-2));
					A=kenntest(A); 
					varlist[k].varwert = A;
				}
			    }
			}
			else if(h==19 && spbit)
			{	H=lfirst(varlist[k].varwert);
				H=mam2tomams(H);
				H=list2(H,19);
				varlist[k].varwert=H;
			}
		    }
		    if( !k ) k = MXNUM - 1;
		}
		if( !pzsch )
		{   for( k = 0; k < MX; k++ )
		    {   if( strlen( varlist[k].varname ) && varlist[k].typ!=2 && varlist[k].typ!=(-3) && varlist[k].varwert != ERROR )
			{   h = lsecond( varlist[k].varwert );
			    if(h==(-5) || h==(-6))
			    {   i = 0;
			  	A = lfirst(varlist[k].varwert);;
				while( A != _0 )
				{       ko[i] = lfirst( A );
					ko[i] = itor( ko[i] );
					A = lred( A );
					i++;
				}
				if( h==(-5)) A=ecrinit(0,0,0,ko[0],ko[1]);
				else  A=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
				A=list2(A,(-2));
				A=kenntest(A); 
				varlist[k].varwert=A;
			    }
			    else if(h==(-7) || h==(-8))
			    {	H=lfirst(varlist[k].varwert);
				if(H==0)  A=list3( 0, 1, 0 );
				else
				{	if(h==(-7))
					{	ko[0]=lfirst(H);
						ko[1]=lsecond(H);
						A=list3(ko[0],ko[1],1);
					}
					else
					{	ko[0]=lfirst(H);
						ko[1]=lsecond(H);
						ko[2]=lthird(H);
						ko[3]=iprod(ko[2],ko[2]);
						ko[0]=iprod(ko[0],ko[2]);
						ko[1]=iprod(ko[1],ko[3]);
						A=list3(ko[0],ko[1],ko[2]);
					}
				}
				A=list2(A,h+4);
				varlist[k].varwert=A;
			    }
			}
			if( !k ) k = MXNUM - 1;
		    }
		}
	}
	H = list2( M, 16 );
	varlist[modsch].varwert = H;
	return( fkeller );
}
