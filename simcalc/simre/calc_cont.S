/*C
			calc_cont( fkeller )

	"calculator content".
	int calc_cont(fkeller); list fkeller;
	X = calc_cont( fkeller );

	fkeller ist eine Liste, die aus einem Polynom ueber Z und einer
	Variablen besteht.
	Bei korrektem Lauf liefert calc_cont den Inhalt des Polynoms bezueglich 
	dieser  Variablen zurueck, sonst ERROR. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	15.04.1996	S.Schmitt
H*/
 
#include <_calc.h>

int calc_cont( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single ken, r,pos,s;
	obj c,var;
	list VN,VL,PP;
	init( c,var,VN,VL,PP );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( llength(fkeller)!=2 ) return( ERROR );

	/*** Variable ***/

	var = lfirst( fkeller );
	fkeller = lsecond( fkeller );
	ken = lsecond( var );
	if( ken != 2 )
	{       mistake( 177 );
		return( -BASIS );
	}
	var = lfirst( var );
	c = lsecond( var );
	var = lfirst( var );
	if( llength( c ) != 2 || lfirst( c ) != 1
	    || lsecond( c ) != 1 || llength( var ) != 1 )
	{       mistake( 177 );
		return( -BASIS );
	}

	/*** Polynom ***/

	ken = lsecond( fkeller );
	if( ken!=2 )
	{       mistake( 194 );
		return( ERROR );
	}
	fkeller=lfirst(fkeller);
	VL=lfirst(fkeller);

	/*** var ist in VL? ***/

	var = lfirst( var );
	pos = lsrch( var, VL );
	if(!pos)
	{	mistake(177);
		return(ERROR);
	}	

	r=llength(VL);
	fkeller=lsecond(fkeller);

	/*** permutieren ***/

	s=1;
	PP=_0;
	VN=_0;
	while(s<=r)
	{	c=lfirst(VL);
		VL=lred(VL);
		if(s!=pos) 
		{	PP=lcomp(s,PP);
			VN=lcomp(c,VN);
		}
		s++;
	}
	PP=lcomp(pos,PP);
	PP=linv(PP);
	VN=linv(VN);
	fkeller=pvpermut(r,fkeller,PP);

	/*** Rechnung, Ergebnis ist Polynom in r-1 Variablen ***/
	 
	c=picont(r,fkeller);
	if(r>1)
	{	c=list2(VN,c);
		c=list2(c,2);
	}
	else c=list2(c,0);

	return(c);
}
