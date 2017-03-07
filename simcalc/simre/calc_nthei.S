/*C
			calc_nthei( fkeller )

	"calculator Neron-Tate height".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_nthei( fkeller );  list fkeller;
	L = calc_nthei( fkeller );

	fkeller is a list containing the representation of a
	point on the current elliptic curve over Q or over a 
	quadratic number field.
	calc_nthei returns the Neron-Tate height with a precision 
	of DIGITS digits.
	calc_nthei returns ERROR if an error occurs.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
	Version  2	08.04.1993	S.Schmitt/U.Schneiders
	Version  3	03.03.1997	S.Schmitt (qnf)
H*/

#include <_calc.h>

list calc_nthei( fkeller )
list fkeller;

{
	single k, kP;
	list P,D;
	obj x, z, L;
	init( P,D, x, z, L );
	bind( fkeller );

	/*** testing the input ***/
	
	kP = lsecond( fkeller );
	if(kP!=(-3) && kP!=(-4) && kP!=(-11) && kP!=(-12))
	{	mistake( 220 );
		return( ERROR );
	}
	if( !ecsch )
	{	mistake( 111 );
		return( ERROR );
	}

	k = lsecond( varlist[ecsch].varwert );
	if(k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10))
	{       mistake( 45 );
		return( ERROR );
	}
	if((kP<=(-11) || k<=(-9) || (nfsch && nfon)) && ecqnfsch==_0)
	{	mistake(220);
		return(ERROR);
	}

	L = lfirst( varlist[ecsch].varwert );
	P = lfirst( fkeller );
	if(kP<=(-11) || k<=(-9) || (nfsch && nfon))
	{	D=lfirst(ecqnfsch);
		if(k>=(-2))
		{	L=tonftyper(L,k);
			k=k-8;
		}
		if(kP>=(-4)) 
		{	P=tonftyper(P,kP);	
			kP=kP-8;
		}
		if(llength(ecqnfsch)==3) P=nftoqnf(P,kP);
	}
	if((k>=(-2) && !isponecrac(L,P)) || 
	   (k<=(-9) && !isponecqnf(D,L,P)))
        {    mistake( 112 );
	     return( ERROR );
        }
	
	/*** Abtesten des Fehlers in Progr. von J.St. ***/

	if(kP>=(-4))
	{	x = ecracdisc( L );
		x = lsecond( x );
		z=lthird(P);
		x = igcd( x, z );
		if( icomp( x, 1 ) )
		{	mistake( 191 );
			return( ERROR );
		}
	}

	/*** calculation ***/

	switch(kP)
	{ 	case -3:
		case -4: x=ecimina1(L);
			 z = ecracbtmin( L );
			 P = ecrbtp( P, z );
			 L=eciminnetahe(L,P);
			 break;
		case -11: if(!P) 
			  {	L=0;
				break;
			  }
			  z=list3(1,0,1);
			  x=lcopy(P);
			  x=lsuffix(x,z);
			  L=ecqnfnetahe(D,L,x);
			  break;
		case -12: if(!lthird(P))
			  {	L=0;
				break;
			  }
			  L=ecqnfnetahe(D,L,P);
			  break;
	}
	L = list2( L, 15 );
	return( L );

}
