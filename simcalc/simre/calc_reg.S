/*C
			calc_reg( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_reg( fkeller );  list fkeller;
	X = calc_reg( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q oder einem 
	quadratischen Zahlkoerper. Falls die elliptische Kurve
	ueber einem Zahlkoerper gegeben ist, dann muessen ausserdem
	noch Punkte auf dieser Kurve angegeben sein. X ist der
	Regulator der Kurve auf NTHEPS Dezimalstellen genau.

	Laeuft calc_reg fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.04.1993      S.Schmitt
	Version  2      21.04.1997      S.Schmitt (qnf)
H*/

# include<_calc.h>

list calc_reg(fkeller)
list fkeller;
{	obj x, D, z;
	list E,L,P;
	single k,kP;
	init( x, D, z, E, L,P );
	bind(fkeller);

	if(llength(fkeller)>1)		/** qnf **/
	{	fkeller=linv(fkeller);
		E=lfirst(fkeller);
		fkeller=lred(fkeller);
		k=lsecond(E);
		if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
		{	mistake(187);
			return(ERROR);
		}
		if(ecqnfsch==_0 || (k>=(-2) && (!nfsch || !nfon)))
		{	mistake(187);
			return(ERROR);
		}
	 	D=lfirst(ecqnfsch);
		E=lfirst(E);
		if(k>=(-2))
		{	E=tonftyper(E,k);
			k=k-8;
		}
		L=_0;
		z=list3(1,0,1);
		while(fkeller!=_0)
		{	P=lfirst(fkeller);
			fkeller=lred(fkeller);
			kP=lsecond(P);
			if(kP!=(-3) && kP!=(-4) && kP!=(-11) && kP!=(-12))
			{	mistake(45);
				return(ERROR);
			}
			P=lfirst(P);
			if(kP>=(-4)) 
			{	P=tonftyper(P,kP);	
				kP=kP-8;
			}
			if(llength(ecqnfsch)==3) P=nftoqnf(P,kP);
			if(!isponecqnf(D,E,P))
			{	mistake(126);
				return(ERROR);
			}
			if(kP==(-11) && P) 
			{ 	x=lcopy(P);
				x=lsuffix(x,z);
				L=lcomp(x,L);
			}
			else if(kP==(-11)) return(list2(0,15));
			else if(!lthird(P)) return(list2(0,15));
			else L=lcomp(P,L);
		}
		L=linv(L);
		x=ecqnfreg(D,E,L);
		return(list2(x,15));
	}

	/** Q **/

	fkeller=lfirst(fkeller);
	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2))
	{	mistake(187);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
	x=ecrregulator(fkeller);
	if(x==(-1))
	{ 	mistake(259);
		return(ERROR);
	}
	x=list2(x,15);
	return(x);
}
