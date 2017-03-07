/*C
		       loem( va )

	"Loeschen einer ganzen Variablengruppe".
	single loem(va); char *va;
	sch = loem( va );
	Das Programm dient zum Loeschen einer ganzen Variablengruppe im
	Programm osloesche. Die Eingabe von a* bewirkt z.B., dass alle
	Variablen, die mit a beginnen, geloescht werden.
	sch ist -2, falls keine Variable geloescht wird.
	sch ist 1, falls eine Variablengruppe geloescht wird.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.08.1987      M.Mang/H.Stroeher
	Version  1.1    29.11.1990      U.Schneiders ( ecsch )
	Version  2      25.05.1992      U.Schneiders ( modsch, nfsch )
	Version  2.1	26.04.1993	S.Schmitt
	Version  2.2	12.07.1993	U.Schneiders
H*/

#include <_calc.h>

single loem(va)
char *va;
{
	single l=0, gef= (-2), h, j, k;
	obj A, H, V, i;
	obj ko[5];
	init( A, H, V, i );
	init( ko[1..4] );

	if ( ctest( va, '*' ) ) return( loeaok( va ) );
	while ( l < MX ) {
	    while ( l<MX && !muster( va, varlist[l].varname ) ) ++l;
	    if ( l == MX ) {
		if ( gef == -2 ) {
		     printf(" Variables of the form %s not found.\n", va );
		     if ( ps ) {
		       fprintf( datei, "out: Variables of the form ");
		       fprintf( datei, "%s not found.\n", va );
		     }
		 }
		 return( gef );
	    }
	    else {
		if ( varlist[l].typ == 1 || varlist[l].typ == 3 ) ++l;
		else{
		     if ( ps ) fprintf( datei, "out: The variable %s is deleted.\n", varlist[l].varname);
		     printf(" The variable %s is deleted.\n",varlist[l].varname);
	             if(varlist[l].typ==2)
		     {	h=varlist[l].varwert;
		        k=strlen(funstr[h]);
			for(j=0;j<k;j++) funstr[h][j]='\0';
			free(funstr[h]);
			funstr[h]=malloc(5); 
			funstr[h][0]='\0';
		     }
		     varlist[l].varwert = 0; gef = 1;
		     strcpy(varlist[l].varname,"\0");
		     varlist[l].typ=0;

		     if( l == ecsch ) ecsch = 0;
		     else if( l == modsch )
		     {	modsch = 0;
			av_loesche(16);
		        for( k = 0; k < MX; k++ )
		        {   if( strlen( varlist[k].varname) && varlist[k].typ!=2)
			    {   h = lsecond( varlist[k].varwert );
			        if( h > (-9) && h < (-4) )
			        {   H = lfirst( varlist[k].varwert );
				    if( h==(-5) || h==(-6) )   
			       	    {   i = 0;  
					while( H != _0 )
					{       ko[i] = lfirst(H);
						ko[i] = itor( ko[i] );
						H = lred( H );
						i++;
					}
					if( h==(-5)) V=ecrinit(0,0,0,ko[0],ko[1]);
					else  V=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
					V=list2(V,(-2));
					V=kenntest(V); 
					varlist[k].varwert = V;
				    }
				    else if(h==(-7))
				    {	if(!H)  V=list3(0,1,0);
					else
					{   ko[0]=lfirst(H);
					    ko[1]=lsecond(H);
					    V=list3(ko[0],ko[1],1);
					}
					V=list2(V,(-3));
					varlist[k].varwert=V;
				    }	
				    else  if(h==(-8))
				    {	if(!H)   V=list3(0,1,0);
					else
					{   ko[0]=lfirst(H);
					    ko[1]=lsecond(H);
					    ko[2]=lthird(H);
					    V=list3(ko[0],ko[1],ko[2]);
					}
					V=list2(V,(-4));
					varlist[k].varwert=V;
				    }
			        }
				else if( h > 16 && h < 23 )
				{    H = lfirst( varlist[k].varwert );
				     switch( h )
				     {	case 17: h = 0; break;
				     	case 18: h = 2; break;
				     	case 19: h = 5; break;
				     	case 20: h = 7; break;
				     	case 21: h = 10; break;
				     	case 22: h = 12; break;
				     }
				     varlist[k].varwert = list2( H, h );
				}
				else if( h == 16 )
				{     if ( ps ) fprintf( datei, "out: The variable %s is deleted.\n", varlist[k].varname );
		                      printf(" The variable %s is deleted.\n",varlist[k].varname );
		                      varlist[k].varwert = 0;
		                      strcpy(varlist[k].varname,"\0");
                                 }
			    }
			    if( !k )  k = MXNUM - 1;
		         }
		      }

		      else if( l == nfsch )
		      {	nfsch = 0; VNF = _0; ecqnfsch=_0;
			av_loesche(23);
		        for( k = 0; k < MX; k++ )
		        {   if( strlen( varlist[k].varname) && varlist[k].typ!=2)
			    {   h = lsecond( varlist[k].varwert );
				if( ( h > 22 && h < 30 ) || ( h > -13 && h < -8 ) )
				{     if ( ps ) fprintf( datei, "out: The variable %s is deleted.\n", varlist[k].varname );
		                      printf(" The variable %s is deleted.\n",varlist[k].varname );
		                      varlist[k].varwert = 0;
		                      if( k == ecsch ) ecsch = 0;
		                      strcpy(varlist[k].varname,"\0");
                                 }
                             }
			     if( !k )   k = MXNUM - 1;
			  }
			/** structsort erst spaeter? 
			  structsort();
					***/
		      }

		      else if( l == gfsch )
		      {	gfsch = 0; gfchar = 0; VGF = _0;
			av_loesche(30);
		        for( k = 0; k < MX; k++ )
		        {   if( strlen( varlist[k].varname) && varlist[k].typ!=2)
			    {   h = lsecond( varlist[k].varwert );
				if( ( h > 29 && h < 37 ) || ( h > -17 && h < -12 ) )
				{     if ( ps ) fprintf( datei, "out: The variable %s is deleted.\n", varlist[k].varname );
		                      printf(" The variable %s is deleted.\n",varlist[k].varname );
		                      varlist[k].varwert = 0;
		                      if( k == ecsch ) ecsch = 0;
		                      strcpy(varlist[k].varname,"\0");
                                 }
                             }
			     if( !k )   k = MXNUM - 1;
			  }
			/*** structsort erst spaeter?
			  structsort();
					***/
		      }

		}
	    }
	}
	return( gef );
}
