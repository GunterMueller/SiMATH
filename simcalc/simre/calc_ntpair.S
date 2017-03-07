/*C
			calc_ntpair( fkeller )

	"calculator Neron-Tate pairing".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ntpair( fkeller );  list fkeller;
	L = calc_ntpair( fkeller );

	fkeller enthaelt zwei Punkte auf der aktuellen elliptischen   
	Kurve. Berechnet wird ihre Neron-Tate Paarung auf NTH_EPS
	Stellen genau.
	Laeuft calc_ntpair fehlerhaft ab, so ist L = ERROR.
C*/
/*H
	Version  1      14.07.1994      S.Schmitt
	Version  2      30.04.1997      S.Schmitt (qnf)
H*/

#include <_calc.h>

list calc_ntpair( fkeller )
list fkeller;

{
	single k, kP, kQ;
	list P;
	obj D, y, x,z,L;
	init( P,D, y, x,z, L );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if(llength(fkeller)!=2)
	{	mistake(3);
		return(ERROR);
	}	

	/** the points **/

	P=lfirst(fkeller);
	kP = lsecond( P );
	if( kP != (-3) && kP != (-4) && kP!=(-11) && kP!=(-12))
	{	mistake( 220 );
		return(ERROR);
	}
	P=lfirst(P);
	fkeller=lsecond(fkeller);
	kQ=lsecond(fkeller);
	if( kQ != (-3) && kQ != (-4) && kQ!=(-11) && kQ!=(-12))
	{	mistake(220);
		return(ERROR);
	}
	fkeller=lfirst(fkeller);

	/** the elliptic curve **/

	if( !ecsch )
	{	mistake( 111 );
		return( ERROR );
	}

	k = lsecond( varlist[ecsch].varwert );
	if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
	{       mistake( 45 );
		return( ERROR );
	}
	if((kP<=(-11) || kQ<=(-11) || k<=(-9) || (nfsch && nfon)) 
	   && ecqnfsch==_0)
	{	mistake(220);
		return(ERROR);
	}

	L = lfirst( varlist[ecsch].varwert );

	/** right representation for qnf **/

	if(kP<=(-11) || kQ<=(-11) || k<=(-9) || (nfsch && nfon))
	{	D=lfirst(ecqnfsch);
		if(k>=(-2))
		{	L=tonftyper(L,k);
			k=k-8;
		}
		if(kP>=(-4)) 
		{	P=tonftyper(P,kP);	
			kP=kP-8;
		}
		if(kQ>=(-4)) 
		{	fkeller = tonftyper(fkeller,kQ);	
			kQ = kQ-8;
		}
		if(llength(ecqnfsch)==3) 
		{	P = nftoqnf(P,kP);
			fkeller = nftoqnf(fkeller, kQ);
		}
		if(kP==(-11))
		{	if(!P) x=list3(0,1,0);
			else 
			{	x=lcopy(P);
				z=list3(1,0,1);
				x=lsuffix(x,z);
			}
		}
		else x=P;
		if(kQ==(-11))
		{	if(!fkeller) y=list3(0,1,0);
			else 
			{	y=lcopy(fkeller);
				z=list3(1,0,1);
				y=lsuffix(y,z);
			}
		}	
		else y=fkeller;
	}

	/** are the points on the elliptic curve? **/

	if((k>=(-2) && (!isponecrac(L,P) || !isponecrac(L,fkeller))) || 
	   (k<=(-9) && (!isponecqnf(D,L,P) || !isponecqnf(D,L,fkeller))))
        {    mistake( 112 );
	     return( ERROR );
        }
	
	/*** calculation ***/

	switch(k)
	{	case -1:
		case -2: x=ecimina1(L);
			 z = ecracbtmin( L );
			 P = ecrbtp( P, z );
			 fkeller=ecrbtp(fkeller,z);
			 L=eciminnetapa(L,P,fkeller);
			 break;
		case -9: 
		case -10: L=ecqnfnetapa(D,L,x,y);
			  break;
	}

	L = list2( L, 15 );
	return( L );

}
