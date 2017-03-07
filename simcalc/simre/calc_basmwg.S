/*C
			calc_basmwg( fkeller ) 

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_basmwg( fkeller );  list fkeller;
	X = calc_basmwg( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. calc_basmwg
	berechnet die Basis der Mordell-Weil-Gruppe. X ist die Anzahl
	der Basispunkte (= Rang der elliptischen Kurve).

	Laeuft calc_basmwg fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.05.1993      S.Schmitt
H*/


# include<_calc.h>


list calc_basmwg(fkeller)
list fkeller;
{	obj k, B, P, x, y, z;
	list AVL;
	single r, s;
	init( k, B, P, x, y, z, AVL );
	bind( fkeller );
	
	k=lsecond(fkeller);
	if( k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
	B=ecracbmwg(fkeller);
	if(B==(-1))
	{	mistake(258);
		return(ERROR);
	}
	r=llength(B)/2;
	if( r )
	{	if(!assch)
		{	printf(" basis :  ");
			if(ps) fprintf( datei, "out: basis :  ");
			s=0;
		}
		if( avsch ) AVL = _0;
		while(B!=_0)
		{	P=lfirst(B);
			if( avsch ) AVL = lcomp( list2(P,(-4)), AVL );
			if(!assch)
			{       x=lfirst(P);
				y=lsecond(P);
				z=lthird(P);
			    	if(z!=1)
				{	k = iprod(z,z);
					x=rcons(x,k);
					k=iprod(k,z);
					y=rcons(y,k);
					z = rden(x);
					k = rden(y);
					z = ilcm(z,k);
					z = itor(z);
					x = rprod(x,z);
					y = rprod(y,z);
					x = rnum(x);
					y = rnum(y);
					z = rnum(z);
				}
				if(s)
				{	printf("          ");
					if(ps) fprintf( datei, "          ");
				}
				s=1;
				printf("PT(%i, %i, %i)\n",x,y,z);
				if(ps) fprintf( datei, "PT(%i, %i, %i)\n",x,y,z);
			}
			B=lred2(B);
		}
		if( avsch ) 
		{	AVL = linv(AVL);
			av_basad( AVL );
		}
	}
	k=list2(r,0);
	return(k);
}	
