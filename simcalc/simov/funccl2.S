/*C
			funccl2( arg, d )

	"function calling with at least two parameters".
	list funccl2(arg,d); char *arg; single *d;
	fkeller = funccl2( arg, d );
	Der zu einem mehrelementigen Funktionsaufruf gehoerige
	Eingabestring wird bestimmt und ausgewertet. Die
	Laenge des ausgewerteten Strings wird *d zugewiesen.
	Laeuft funccl2 fehlerhaft ab, so ist fkeller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
H*/
 
#include <_calc.h>

list funccl2( arg, d )
char *arg;
int *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=1, j=0, mk=0, sch=1, sch1=0;
	char arg1[ MAXL ];
	int erg;
	list fkeller;
	init( fkeller, erg );
	arg += 1;
	*arg1 = '\0';

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
					      if( !isbracor( arg1,0 ) )
					      {
						return( -BASIS );
					      }
					      erg = basad(arg1);
					      if( erg == -BASIS || erg == -BASIS-1 )
				              { if( erg == -BASIS-1 ) mistake(32);
						return( -BASIS );
					      }
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
	return( fkeller );
}
