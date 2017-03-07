/*C
			funccl_cgf2b( arg, d )

	"function calling for curgf2bit".
	list funccl_cgf2b(arg,d); char *arg; single *d;
	fkeller = funccl_cgf2b( arg, d );
	Zunaechst wird getestet, ob dem Variablenname, der als
	1. Argument in arg steht, schon einmal ein Wert zugewie-
	sen wurde.
	Der zu einem mehrelementigen Funktionsaufruf gehoerige
	Eingabestring wird bestimmt und ausgewertet. Die
	Laenge des ausgewerteten Strings wird *d zugewiesen.
	Laeuft funccl_cgf2b fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      24.10.1995      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list funccl_cgf2b( arg, d )
char *arg;
int *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=1, j=0, k, mk=0, sch=1, sch1=0, z;
	char arg1[ MAXL ]; 
	char name[100];
	int erg;
	list V, fkeller;
	init( V, fkeller, erg );
	arg += 1;
	*arg1 = '\0';

	/*** Testen, ob in arg = (Y,...) Y schon als Variablen-
	     namen benutzt wurde ***/

	k = 0;
	while( arg[k] != ',' && arg[k+1] != '\0' )
	{	name[k] = arg[k];
		k++;
	}
	name[k] = '\0';
	k = 0;
	while( ( k < MX && strlen(varlist[k].varname) ) || !k )
        {    
	    if( !strcmp(name,varlist[k].varname) )
	    {	mistake1( 248, name );
		return( ERROR );
            }
	    k++;
        }  

	/*** Bearbeitung von mehrelementigen Funktionsaufrufen ***/

	fkeller = _0;
	*d = 0;

	/*** Erkennung und Auswertung der zu einem Funktionsaufruf
	     gehoerenden Parameter ***/

	while ( sch ) {
	   while ( i ) {
		switch( *(arg+*d) ) {
			case '(': ++i;
				  *(arg1+j) = *(arg+*d); ++j;
				  break;
			case ')': --i;
				  if ( i ) *(arg1+j) = *(arg+*d), ++j;
				  else {
					*(arg1+j) = '\0';
					if ( !sch ) {
						z = j-1; k = 0;
						while( arg1[k]=='(' )
						{  if( arg1[z]!=')' )
						   {   mistake(2);
						       return( -BASIS );
					           }
						   k++; z--;
						}
						while( arg1[k]=='0' && k<=z ) k++;
						if( k>z ) 
						{  erg = list2(0,0);
						   fkeller = lcomp(erg,fkeller); 
						   break;
						}
						if( z==k && arg1[k]=='1' )
					        {   erg = list2(1,0);
						    fkeller = lcomp( erg,fkeller );
						    break;
						}
						erg = list1( (z-k) );
						while( k <= z )
						{  if( arg1[k]!='0' && arg1[k]!='1' )
						   {	mistake(15);	
						        return( -BASIS );
						   }
						   erg = lcomp( arg1[k]-'0', erg );
						   k++; 
						}
						erg = linv( erg );
						erg = dptop(1,erg);
						V = pmakevl( name );
						erg = list2( V, erg );
						erg = list2( erg,2 );
					        fkeller = lcomp(erg,fkeller);
					}
				  }
				  break;
			case '{': ++mk;
				  *(arg1+j) = *(arg+*d); ++j;
				  break;
			case '}': --mk;
				  *(arg1+j) = *(arg+*d); ++j;
				  break;
			case ',': if ( i == 1 && !mk ) {
				       sch = 0;
				       *(arg1+j) = '\0';
				       if( !isbracor( arg1,0 ) )  
				       {
					  return( -BASIS );
				       }
				       erg = basad(arg1);
				       if( erg == -BASIS || erg == -BASIS-1 )   
				       { if( erg == -BASIS-1 ) mistake(32);
					  return( -BASIS );
				       }
				       j = 0;
				       *arg1 = '\0';
				       fkeller = lcomp(erg,fkeller);
				  }
				  else
                                  {    *(arg1+j) = *(arg+*d); ++j;   
				  }	
				  break;
			default : *(arg1+j) = *(arg+*d); ++j;
		}
		*d = (*d) + 1;
	   }
	   if ( !i && sch == 1 ) 
	   {
		return( -BASIS-1 );
	   }
	   if ( sch ) {
		sch1 += 2;
		strcpy(arg,arg1+1);
		*d=0; j=0; i=1;
	   }
	}
	*d += sch1;
	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"curgf2bit" );
		return( -BASIS );
	}
	return( fkeller );
}
