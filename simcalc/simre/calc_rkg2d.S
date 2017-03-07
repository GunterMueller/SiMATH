/*C
			calc_rkg2d( fkeller )

        "calculator elliptic curve rank via general 2-descent"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_rkg2d( fkeller );  list fkeller;
	X = calc_rkg2d( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q oder ueber
	einen quadratischen Zahlkoerper. Im zweiten Fall koennen noch 
	einige Konstanten (bound, verbose) dabei sein.
	X ist der Rang der Kurve, berechnet nach der Methode des
	allgemeinen Zweier-Abstiegs.

	Laeuft calc_rkg2d fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.03.1997      S.Schmitt
	Version  2      29.04.1997      S.Schmitt (qnf)
H*/

# include<_calc.h>

list calc_rkg2d(fkeller)
list fkeller;
{	single k, ver=(-1), bou=(-1);
	obj D;
	init(D);
	bind(fkeller);

	/** fkeller = (E) or
	    fkeller = (bound, E(qnf)) or
	    fkeller = (verbose, bound, E(qnf) **/ 

	if(llength(fkeller)>3)
	{	mistake1(34, "rkg2d");
		return(ERROR);
	}

	/** fkeller = (verbose, bound, E(qnf)) **/

	if(llength(fkeller)==3)
	{	D=lfirst(fkeller);
		if(lsecond(D))	
		{	mistake1(34,"rkg2d");
			return(ERROR);
		}
		D=lfirst(D);
		if(!issingle(D) || (D && D!=1))
		{	mistake1(34, "rkg2d");
			return(ERROR);
		}
		ver=D;
		fkeller=lred(fkeller);
	}
	if(llength(fkeller)==2)
	{	D=lfirst(fkeller);
		if(lsecond(D))	
		{	mistake1(34,"rkg2d");
			return(ERROR);
		}
		D=lfirst(D);
		if(!issingle(D) || D<=0)
		{	mistake1(34, "rkg2d");
			return(ERROR);
		}
		bou=D;
		fkeller=lred(fkeller);
	}
		
	fkeller=lfirst(fkeller);
	k=lsecond(fkeller);

	/** elliptic curve **/

	k=lsecond(fkeller);
	if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
	{	mistake(213);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
		
	if((k<=(-9) || (nfsch && nfon)) && ecqnfsch==_0)
	{	mistake(213);
		return(ERROR);
	}
	if(k<=(-9) || (nfsch && nfon))
	{	D=lfirst(ecqnfsch);
		if(!issingle(D))
		{	mistake(210);
			return(ERROR);
		}
		if(D<0)
		{	mistake(213);
			return(ERROR);
		}
		if(k>=(-2))
		{	fkeller=tonftyper(fkeller,k);
			k=k-8;
		}
	}
	if(k>=(-2) && bou>=0)
	{	mistake1(34, "rkg2d");
		return(ERROR);
	}
	
	if(k<=(-9))
	{	if(ver<0) ver=1;
		if(bou<0) bou=20;
		k=carrqnf1(D, fkeller,1, ver, bou);
		if( k==ERROR )
		{	mistake(198);
			return(ERROR);
		}
	}
	else
	{	k=ecrrankg2d(fkeller);
		if( k==ERROR )
		{	mistake(268);
			return(ERROR);
		}
	}
	fkeller=list2(k,0);
	return(fkeller);
}

