/*C
			calc_deg(  fkeller )

	" calculator degree ".
	single calc_deg( fkeller );  list fkeller;
	X = calc_deg( fkeller );

	fkeller enthaelt ein Polynom P und gegebenenfalls eine Variable. 
	calc_deg bestimmt den Grad von P bzgl. der Hauptvariablen bzw.
	bzgl. der angegebenen Variable.
	Laeuft calc_deg fehlerhaft ab, so ist  X  = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      05.03.1997      S.Schmitt
H*/

#include<_calc.h>
single calc_deg( fkeller )
list fkeller;

{
	single k, r, pos;
	list VL, varl;
	obj var, P;
	init( VL, varl, var, P);
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	r=llength(fkeller);
	if(r!=1 && r!=2)
	{       mistake1( 34,"deg" );
		return( -BASIS );
	}

	if(r==1) P=lfirst(fkeller);
	else P=lsecond(fkeller);
	k = lsecond( P );
	if( ( k>3 && k!=15 && k!=17 && k!=18 && k!=24 && k!=25 
		    && k!=31 && k!=32 && k!=37 && k!=38 && k!=39 ) 
	   || k < 0 )
	{       mistake( 183 );
		return( -BASIS );
	}
	if( k<2 || k==15 || k==17 || k==24 || k==31 || k==37 ) 
		return(list2(0,0));

	P=lfirst(P);
	if(r==1)
	{	P=lsecond(P);
		P=lfirst(P);
		return(list2(P,0));
	}

	VL = lfirst( P );
	r = llength( VL );
	P = lsecond( P );

	var = lfirst( fkeller );
	k = lsecond( var );
	if( k != 2 )
	{       mistake( 184 );
		return( -BASIS );
	}
	var = lfirst( var );
	varl = lfirst( var );
	var = lsecond( var );
	if( llength( var ) != 2 || lfirst( var ) != 1
	    || lsecond( var ) != 1 || llength( varl ) != 1 )
	{       mistake( 184 );
		return( -BASIS );
	}
 	varl = lfirst( varl );
	pos = lsrch( varl, VL );
	if( !pos ) return(list2(0,0));
	if( pos==r ) return(list2(lfirst(P),0));
	varl=list1(pos);
	k=1;
	while(VL!=_0)
	{	VL=lred(VL);
		if(k!=pos) varl=lcomp(k, varl);
		k++;
	}	
	P = pvpermut( r, P, varl );
	return(list2(lfirst(P),0));
}

