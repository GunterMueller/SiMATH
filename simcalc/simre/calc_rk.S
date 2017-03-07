/*C
			calc_rk( fkeller )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_rk( fkeller );  list fkeller;
	X = calc_rk( fkeller );

	fkeller enthaelt eine elliptische Kurve ueber Q bzw. ueber einen
	quadratischen Zahlkoerper, eine elliptische Kurve ueber Q bzw. 
	ueber einen quadratischen Zahlkoerper sowie Konstante RCM=0,1,2,3, 
	oder eine Matrix ueber Z, Q, Zahlkoeper, GF(p^n), p Primzahl,
	Polynome ueber Z oder Q oder rationale Funktionen ueber Q.
	X ist der Rang der Kurve bzw. der Rang der Matrix.
	Ist neben der elliptischen Kurve auch die Konstante RCM 
	angegeben, so werden die folgenden Algorithmen benutzt:

        RCM = 0: Das ist der default-Fall: Falls eine 2-Isogenie
	existiert, wird der Rang mit 2-Abstieg berechnet. Falls nicht,
	so benutzt man den allgemeinen 2-Abstieg. Falls man dann immer
	noch kein Ergebnis hat, so wird im Fall einer elliptischen 
	Kurve ueber Q der Rang mit dem Algorithmus von Manin berechnet.
        RCM = 1: entspricht dem Aufruf rk2d: Falls eine 2-Isogenie
	existiert, wird der 2-Abstieg benutzt. Ansonsten wird
	ERROR zurueckgegeben.
        RCM = 2: entspricht dem Aufruf rkg2d: Es wird der allgemeine
	2-Abstieg benutzt.
        RCM = 3: entspricht dem Aufruf rkbsd: Es wird Manins Algorithmus
	benutzt (fuer elliptische Kurven ueber Q).
	(Siehe dazu die Doku von ecrrank().)


	Laeuft calc_rk fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      26.04.1993      S.Schmitt
	Version  2	01.07.1994	S.Schmitt
	Version  2.1	04.03.1996	S.Schmitt ( GF(2) )
	Version  3	06.03.1997	S.Schmitt ( 2 Parameter )
	Version  3.1	28.04.1997	S.Schmitt ( qnf )
H*/

# include<_calc.h>

list calc_rk(fkeller)
list fkeller;
{	single k, r, bou, RCM=(-1), ver=(-1);
	obj D, M;
	init( D, M );
	bind(fkeller);

	/** testing the input **/

	if(llength(fkeller)>4)
	{	mistake1(34, "rk");
		return(ERROR);
	}

	/** fkeller = (verbose, bound, RCM, E(qnf)) **/

	if(llength(fkeller)==4)
	{	M=lfirst(fkeller);
		D=lsecond(fkeller);
		if(lsecond(M) || lsecond(D))	
		{	mistake1(34,"rk");
			return(ERROR);
		}
		M=lfirst(M);
		D=lfirst(D);
		if(!issingle(D) || D<=0 || !issingle(M) || (M && M!=1))
		{	mistake1(34, "rk");
			return(ERROR);
		}
		ver=M;
		bou=D;
		fkeller=lred2(fkeller);
	}
		
	/** RCM **/

	if(llength(fkeller)==2)
	{	M=lfirst(fkeller);
		fkeller=lsecond(fkeller);
		if(lsecond(M))
		{	mistake(185);
			return(ERROR);
		}
		M=lfirst(M);
		if(!issingle(M) && (M<0 || M>3))
		{	mistake(185);
			return(ERROR);
		}
		RCM = _R_C_M;	
	}
	else fkeller=lfirst(fkeller);
	k=lsecond(fkeller);

	/** elliptic curve **/

	if(k<0)					
	{ 	if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
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
		if(k>=(-2) && ver>=0)
		{	mistake1(34, "rk");
			return(ERROR);
		}

		/** RCM **/

		if(RCM>=0)
		{	if(k<=(-9))	
			{	if(M==3)
				{	mistake(155);
					return(ERROR);
				}
				else if(M) M=M-1;
			}
			else if(k>=(-2))
			{	if(M==1 && ecrordtor(fkeller)%2)
				{	mistake(149);
					return(ERROR);
				}
				_R_C_M=M;
			}
		}	

		if(k>=(-2)) 
		{	r=ecrrank(fkeller);
			if(RCM>=0) _R_C_M=RCM;
			if( r==ERROR )
			{	mistake(268);
				return(ERROR);
			}
		}
		else 
		{	if(ver<0)
			{	ver=1;
				bou=20;
			}
			r=carrqnf1(D, fkeller,M, ver, bou);
			if( r==ERROR )
			{	mistake(198);
				return(ERROR);
			}
		}
		r=list2(r,0);
		return(r);
	}

	/** Matrices **/	
	
	if(ver>=0 || RCM>=0)
	{	mistake1(34, "rk");
		return(ERROR);
	}

	if( (k<5 || k>9) && k!=26 && k!=33)
	{	mistake(322);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);
	switch(k)
	{	case 5: fkeller=maitomar(fkeller);
			r=marrk(fkeller);
			break;	
		case 6:	r=marrk(fkeller);
			break;
		case 7: r=llength(lfirst(fkeller));
			fkeller=lsecond(fkeller);
			fkeller=mapitomarfr(r,fkeller);
			r=marfrrk(r,fkeller);
			break;
		case 8: r=llength(lfirst(fkeller));
			fkeller=lsecond(fkeller);
			fkeller=maprtomarfr(r,fkeller);
			r=marfrrk(r,fkeller);
			break;
		case 9: r=llength(lfirst(fkeller));
			fkeller=lsecond(fkeller);
			r=marfrrk(r,fkeller);
			break;
		case 26:M=lfirst(varlist[nfsch].varwert);
			r=manfrk(M,fkeller);
			break;
		case 33:M=lfirst(varlist[gfsch].varwert);
			if(gfchar!=2) r=magfsrk(gfchar,M,fkeller);
			else r=magf2rk(M,fkeller);
			break;
	}
	r=list2(r,0);
	return(r);
}

