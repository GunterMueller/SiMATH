/*C
			calc_proot( fkeller )

	"calculator primitive root".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_proot( fkeller );      list fkeller;
	X = calc_proot( fkeller );

	fkeller besteht aus einer Zahl m aus Z, m>0, oder fkeller=_0.
	Im zweiten Fall nimmt man als m den curModulus.
	X ist eine Primitivwurzel mod m, falls eine existiert.
	Laeuft calc_proot fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      05.07.1994      S.Schmitt
	Version  1.1    05.03.1997      S.Schmitt (fkeller=_0)
H*/

#include<_calc.h>

list calc_proot( fkeller )
list fkeller;

{       single s;
	int n, m, q;
	init( n, m, q );
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if(fkeller==_0)
	{	if(!modsch)
		{	mistake(158);
			return(ERROR);
		}
		m=lfirst(varlist[modsch].varwert);
	}
	else 
	{  if(llength(fkeller)!=2 || (lsecond(fkeller) && lsecond(fkeller)!=16))
	   {       mistake( 3 );
	           return( ERROR );
	   }
	   m=lfirst(fkeller);
	   if(icomp(m,0)<=0)
	   {	mistake(323);
		return(ERROR);
	   }
	}
	if(icomp(m,1) && icomp(m,2) && icomp(m,4))  /** m!=1,2,4 **/
	{	s=isspprime(m,&q);
		if(!s)                              /** m!=p^n **/
		{   if(!icomp(q,2))
		    {   n=iquot(m,2);
			if(!isspprime(n,&q))        /** m!=2*p^n **/
			{   mistake(323);           
			    return(ERROR);	
			}
		    }
		    else
		    {	mistake(323);
			return(ERROR);
		    }
		}
		else if(!icomp(q,2))
		{	mistake(323);
			return(ERROR);
		}
	}
		    
	if(!icomp(m,1) || !icomp(m,2)) q=1;
	else q=miproot(m);
	if(fkeller==_0 || lsecond(fkeller)==16) return(list2(q,17));
	return(list2(q,0));   
}
