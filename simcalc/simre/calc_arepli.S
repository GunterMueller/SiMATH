/*C
			calc_arepli( fkeller )

	"calculator are points linearly independent".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_arepli( fkeller );      list fkeller;
	X = calc_arepli( fkeller );

	fkeller ist eine Liste von Punkten einer elliptischen Kurve
	ueber Q oder ueber einen quadratischen Zahlkoerper.
	calc_arepli untersucht, ob diese Punkte linear unabhaengig sind
	und gibt die Determinante der Matrix der Neron-Tate-Paarungen 
	zurueck.
C*/
/*H
	Version  1      29.12.1994      S.Schmitt
	Version  1.1    24.04.1997      S.Schmitt (qnf)
H*/

#include<_calc.h>

list calc_arepli( fkeller )
list fkeller;
{
	single k;
	list P,N,NH,L,LH,E;
	obj Q,z;
	floating ntp,r;
	init( P,N,NH,L,LH,E,Q,z,ntp,r );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if(llength(fkeller)<2)
	{	mistake(3);
		return(ERROR);
	}	
	if(!ecsch)
	{	mistake(111);
		return(ERROR);
	}
	k=lsecond(varlist[ecsch].varwert);
	if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
	{	mistake(95);
		return(ERROR);
	}
	if((k<=(-9) || (nfsch && nfon)) && ecqnfsch==_0)
	{	mistake(95);
		return(ERROR);
	}
	E=lfirst(varlist[ecsch].varwert);

	/** qnf **/

	if(k<=(-9) || (nfsch && nfon))
	{	Q=lfirst(ecqnfsch);
		if(k>=(-2)) E=tonftyper(E,k);
		L=_0;
		ntp=1;
		NH=list3(1,0,1);
		while(fkeller!=_0)
		{	P=lfirst(fkeller);
			fkeller=lred(fkeller);
			k=lsecond(P);
			if(k!=(-3) && k!=(-4) && k!=(-11) && k!=(-12))
			{	mistake(118);
				return(ERROR);
			}
			P=lfirst(P);
			if(k>=(-4)) 
			{	P=tonftyper(P,k);	
				k=k-8;
			}
			if(llength(ecqnfsch)==3) P=nftoqnf(P,k);
			if(!isponecqnf(Q,E,P))
			{	mistake(112);
				return(ERROR);
			}
			if(k==(-11) && P) 
			{ 	N=lcopy(P);
				N=lsuffix(N,NH);
				L=lcomp(N,L);
			}
			else if(k==(-11) || !lthird(P)) 
			{	ntp=0;
				break;
			}
			else L=lcomp(P,L);
		}
		if(ntp)
		{	L=linv(L);
			ntp=ecqnfreg(Q,E,L);
		}
	}

	/** Q **/

	else
	{	Q=ecimina1(E);
		z=ecracbtmin(E);	

		/** Punkte und Neron-Tate-Paarungen **/
	
		L=_0;N=_0;
		while(fkeller!=_0)
		{	P=lfirst(fkeller);
			k = lsecond( P );
			if( k != (-3) && k != (-4) )
			{	mistake( 118 );
				return( ERROR );
			}
			P=lfirst(P);
			fkeller=lred(fkeller);
			if( !isponecrac(E, P ) )
        		{    	mistake( 112 );
	     	     		return( ERROR );
        		}
			P = ecrbtp( P, z );
			L=lcomp(P,L);
			ntp=eciminnetapa(E,P,P);
			NH=list1(ntp);
			LH=lred(L);
			while(LH!=_0)
			{	Q=lfirst(LH);
				LH=lred(LH);
				ntp=eciminnetapa(E,P,Q);
				NH=lcomp(ntp,NH);
			}
			NH=linv(NH);
			N=lcomp(NH,N);
		}
	
		/** Matrix **/
	
		L=_0;LH=_0;NH=_0;
		while(N!=_0)
		{	LH=lfirst(N);
			N=lred(N);
			Q=_0;
			while(NH!=_0)
			{	P=lfirst(NH);
				NH=lred(NH);
				ntp=lfirst(P);
				LH=lcomp(ntp,LH);
				P=lred(P);
				Q=lcomp(P,Q);
			}
			if(Q!=_0) NH=linv(Q);
			L=lcomp(LH,L);
			for(k=0;k<=llength(NH);k++) LH=lred(LH);
			NH=lcomp(LH,NH);
		}
		L=linv(L);
	
		/** Determinante **/

		ntp=mafldet(L);
	}

	L=list2(ntp,15);
	if(!assch){
	r=rtofl(list2(1,1000));
	ntp=flabs(ntp);

/** unabhaengig, falls (1/1000) - |ntp| < 0, also falls
	|ntp| > 1/1000.				***/

	if(flcomp(r,ntp)>0) 
	{ printf(" The points are not linearly independent.\n");
	  if(ps) fprintf(datei,"out: The points are not linearly independent.\n");
	}
	else
	{ printf(" The points are linearly independent.\n");
	  if(ps) fprintf(datei,"out: The points are linearly independent.\n");
	}
	}
	return( L );
}
