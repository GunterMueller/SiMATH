/*C
			calc_faintp( fkeller ) 

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_faintp( fkeller );  list fkeller;
	X = calc_faintp( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q. calc_faintp
	berechnet alle ganzen Punkte und stellt sie bzgl. der Torsions-
	gruppe und der Basis des freien Anteils dar. X ist ein ganzer
	Punkt.
	Laeuft calc_faintp fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.11.1994      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

list calc_faintp(fkeller)
list fkeller;
{	
	single k;	
	obj x, y, z;
	list L, T, B, HT, HB, P, Q;
	list AVL;
	init( x, y, z, L, T, B, HT, HB, P, Q, AVL );
	bind( fkeller );
	
	k=lsecond(fkeller);
	if( k!=(-1) && k!=(-2) )
	{	mistake(155);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);

	T=ecractorgr(fkeller);	/** Damit nichts schief laeuft **/

	L = ecracsaip(fkeller);
	
	if( L == _0 )
	{	if(!assch ) 
		{  printf(" No nontrivial integral point found!\n");
		   if(ps) fprintf(datei, "out: No nontrivial integral point found!\n");
		}
		L = list3(0,itor(1),0);
		L = list2( L, -4);
		return( L );
	}
	if( llength( L ) == 1 )
	{	mistake(296);
		return( ERROR );
	}

	B=ecracbmwg(fkeller);
	HB = _0;
	while( B!=_0 )
	{	P = lfirst(B);
		B = lred2(B);
		x=lfirst(P);
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
		P = list3( x,y,z );
		HB = lcomp( P, HB );
	}
	B = linv(HB);
		
	T=ecractorgr(fkeller);	/** Da die Torsionsgruppe unter Umstaenden
				    permutiert wird **/
	HT = _0;
	while( T!=_0 )
	{	P = lfirst(T);
		T = lred(T);
		x=lfirst(P);
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
		P = list3( x,y,z );
		HT = lcomp( P, HT );
	}
	T = linv(HT);

	Q = lfirst( L );
	Q = list2( Q, -4 );

	if(!assch)
	{  printf(" all nontrivial integral points modulo negation :\n");
	   if(ps) fprintf( datei, "out: all nontrivial integral points modulo negation :\n");
	}
	if(avsch) AVL=_0;
	while(L!=_0)
	{	P=lfirst(L);
		if(avsch) AVL=lcomp(list2(P,(-4)),AVL);
		if(!assch)
		{   x=lfirst(P);
		    y=lsecond(P);
		    z=lthird(P);
		    printf(" PT(%i, %i, %i) = ",x,y,z);
		    if(ps) fprintf( datei, "out: PT(%i, %i, %i) = ",x,y,z);
		    HT = lsecond(L);
		    HB = B;
		    k = lfirst( HT );
		    if( !k )
		    {	printf("PT(0, 1, 0)" );
			if(ps) fprintf(datei, "PT(0, 1, 0)" );
		    }
		    else
		    {	P = lelt( T, k );
			x = lfirst(P);
			y = lsecond(P);
			z = lthird(P);
			printf("PT(%i, %i, %i)", x,y, z);
			if(ps) fprintf(datei, "PT(%i, %i, %i)", x,y, z);
		    }
		    HT = lred( HT );
		    while( HT != _0 )
		    {	k = lfirst( HT );
			HT = lred( HT );
			P = lfirst( HB );
			HB = lred( HB );
			x = lfirst( P );
			y = lsecond(P);
			z = lthird(P);
			if(k<0)
			{	printf(" - ");
				if(ps) fprintf(datei, " - ");
				k=sabs(k);
			}
			else
			{	printf(" + ");
				if(ps) fprintf(datei, " + ");
			}
			if(k!=1)
			{	printf("%i*",k);
				if(ps) fprintf(datei, "%i*",k);
			}
			printf("PT(%i, %i, %i)", x, y, z );
			if(ps) fprintf(datei, "PT(%i, %i, %i)", x, y, z );
		    }
		    printf( "\n" );
		    if(ps) fprintf( datei, "\n" );

		}
		L=lred2(L);
	}
	if(!assch)
	{   printf("\n" );
	    if( ps) fprintf(datei, "\n" );
	}
	if(avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}
	return(Q);
}	
