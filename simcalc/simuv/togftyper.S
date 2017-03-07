/*C
			togftyper( a1, t1, esch )

	"to Galois-field typer"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	obj togftyper( a1, t1, esch );  obj a1; single t1, esch;
	X = togftyper( a1, t1, esch );

	a1 ist ein Objekt mit Kennung t1 = -6, -7, -8.
	X ist a1 umgewandelt als Objekt ueber einem Galois-Feld.
	Laeuft togftyper fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      28.12.1994      U.Schneiders
H*/

#include <_calc.h>
obj togftyper( a1, t1, esch )
obj a1;
single t1, esch;
{	obj erg, ko;
	init(erg,ko);
	bind( a1 );

	/*** Elliptische Kurve ueber GF nur in Char. 2 ***/
	if(t1==(-5) || !ssch || lfirst( varlist[modsch].varwert )!= 2)
	{	if(esch) mistake(266);
		return(ERROR);
	}

	switch( t1 )
	{       case (-6): erg=_0;
			   while( a1!= _0 )
			   {	ko=lfirst(a1);
				a1=lred(a1); 
				if(ko)
				{	ko=list2(0,ko);
					ko=udpm2tosb(ko);
				}
				erg=lcomp(ko,erg);
			   }
			   erg = linv(erg);	
			   break;
		case (-7):
		case (-8): if( a1 )
			   {    erg=_0;
			   	while( a1!= _0 )
			   	{	ko=lfirst(a1);
					a1=lred(a1); 
					if(ko)
					{	ko=list2(0,ko);
						ko=udpm2tosb(ko);
					}
					erg=lcomp(ko,erg);
			   	}
			   	erg = linv(erg);	
			   }
			   else erg=0;
			   break;
	}
	
	return( erg );
}
