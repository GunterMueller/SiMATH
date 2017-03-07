/*C
			calc_whei( fkeller )

	"calculator Weil height".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	floating calc_whei( fkeller );  list fkeller;
	L = calc_whei( fkeller );

	fkeller is a list containing the representation of a
	point on the current elliptic curve over Q or over a 
	quadratic number field.
	calc_whei returns the Weil height with a precision of
	DIGITS digits.
	calc_whei returns ERROR, if an error occurs.
C*/
/*H
	Version  1      14.07.1994      S.Schmitt
	Version  2      03.03.1997      S.Schmitt (qnf)
H*/

#include <_calc.h>

list calc_whei( fkeller )
list fkeller;

{
	single k,t;
	obj L,D,x,y;
	init( L,D,x,y );
	bind( fkeller );

	/*** testing the input ***/

	t = lsecond( fkeller );
	if(t!=(-3) && t!=(-4) && t!=(-11) && t!=(-12))
	{       mistake( 220 );
		return( ERROR );
	}
	if( !ecsch )
	{	mistake( 111 );
		return( ERROR );
	}
	k = lsecond( varlist[ecsch].varwert );
	if( k!=(-1) && k!=(-2) && k!=(-9) && k!=(-10) )
	{       mistake( 45 );
		return( ERROR );
	}
	if((t<=(-11) || k<=(-9) || (nfsch && nfon)) && ecqnfsch==_0)
	{	mistake(220);
		return(ERROR);
	}

	L = lfirst( varlist[ecsch].varwert );
	fkeller = lfirst( fkeller );
	if(t<=(-11) || k<=(-9) || (nfsch && nfon))
	{	D=lfirst(ecqnfsch);
		if(k>=(-2)) 
		{	L=tonftyper(L,k);
			k=k-8;
		}
		if(t>=(-4)) 
		{	fkeller=tonftyper(fkeller,t);
			t=t-8;
		}
		if(llength(ecqnfsch)==3) fkeller=nftoqnf(fkeller,t);
	}

	if((k>=(-2) && !isponecrac(L, fkeller)) || 
	   (k<=(-9) && !isponecqnf(D,L,fkeller)))
        {    mistake( 112 );
	     return( ERROR );
        }
	

	/*** calculation ***/

	switch(t)
	{	case -3:
		case -4: L=ecracweilhe(L,fkeller);
			 break;
		case -11: if(!fkeller)
			  {	L=0;
				break;
			  }
			  L=ecqnfwehe(D,L,fkeller);
			  break;
		case -12: if(!lthird(fkeller)) 
			  {	L=0;
				break;
		   	  }
			  fkeller=ecqnfprojtop(D,fkeller);
			  L=ecqnfwehe(D,L,fkeller);
			  break;
	}
	L = list2( L, 15 );
	return( L );
}
