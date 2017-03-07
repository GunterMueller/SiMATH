/*C
			calc_prim( fkeller )

	"calculator primitive part".
	int calc_prim(fkeller); list fkeller;
	X = calc_prim( fkeller );

	fkeller ist eine Liste, die aus einem Polynom ueber Z und einer
	Variablen besteht.
	Bei korrektem Lauf speichert calc_prim den Inhalt des Polynoms bzgl.
	dieser Variablen in AV[0] und liefert den primitiven Anteil zurueck, 
	sonst ERROR. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	15.04.1996	S.Schmitt
H*/
 
#include <_calc.h>

int calc_prim( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single ken, r,pos,s;
	obj c,var;
	list PZ,PP,VL,VL1,VN,AVL;
	init( c,var,PZ,PP,VL,VL1,VN,AVL);
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

	/*** permutieren, falls notwendig ***/

	if(pos!=r)
	{	s=1;
		PP=_0;
		PZ=_0;
		VN=_0;
		VL1=lcopy(VL);
		while(s<=r)
		{	c=lfirst(VL1);
			VL1=lred(VL1);
			if(s!=pos) 
			{	PP=lcomp(s,PP);
				VN=lcomp(c,VN);
				if(s<pos) PZ=lcomp(s,PZ);
				else	PZ=lcomp((s-1),PZ);
			}
			else PZ=lcomp(r,PZ);
			s++;
		}
		PP=lcomp(pos,PP);
		PP=linv(PP);
		VN=linv(VN);
		PZ=linv(PZ);
		fkeller=pvpermut(r,fkeller,PP);
	}

	/*** Rechnung, Inhalt ist Polynom in r-1 Variablen,
		       Ergebnis ist Polynom in r Variablen. ***/
	 
	c=picontpp(r,fkeller,&PP);

	if(avsch)
	{	if(r>1)
		{	if(pos==r)
			{	VL1=lcopy(VL);
				VL1=linv(VL1);
				VL1=lred(VL1);
				VN=linv(VL1);
			}
			c=list2(VN,c);
			c=list2(c,2);
			c=kenntest(c);
		}
		else c=list2(c,0);
		AVL=list1(c);
		av_basad(AVL);
	}
	
	/*** Zurueck permutieren ***/

	if(pos!=r) PP=pvpermut(r,PP,PZ);
	fkeller=list2(VL,PP);
	fkeller=list2(fkeller,2);
	return(fkeller);
}
