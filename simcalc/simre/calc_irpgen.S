/*C
			calc_irpgen( fkeller )

	"calculator diagonal matrix construction".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_irpgen( fkeller );      list fkeller;
	X = calc_irpgen( fkeller );

	fkeller besteht aus einer Primzahl p, einer Variablen x, 
	einer Zahl n aus Z, n>0, und einer Zahl t=0 oder 1, bzw.
	nur aus x, n und t. Im 2.Fall ist p = curModulus.
	X ist ein irreduzibles Polynom in der Variablen x ueber Z/pZ 
	vom Grad n.
	Falls t=0, wird zuerst nach einem Trinom gesucht, ansonsten
        nach einem beliebigen Polynom.
	Laeuft calc_irpgen fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.07.1994      S.Schmitt
	Version  1.1	11.10.1994	U.Schneiders
H*/

#include<_calc.h>

list calc_irpgen( fkeller )
list fkeller;

{       single t,n,p,m;
	obj P,V;
	init(P,V);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength( fkeller ) != 3 && llength(fkeller)!=4 )
	{       mistake( 3 );
		return( ERROR );
	}

	/** t>=0 **/

	P=lfirst(fkeller);
	if(lsecond(P) || !issingle(lfirst(P)))
	{	mistake(326);
		return(ERROR);
	}
	t=lfirst(P);
	if(t<0)
	{	mistake(326);
		return(ERROR);
	}  

	/** n>0 **/

	P=lsecond(fkeller);
	if(lsecond(P) || !issingle(lfirst(P)))
	{	mistake(325);
		return(ERROR);
	}
	n=lfirst(P);
	if(n<=1)
	{	mistake(325);
		return(ERROR);
	}

	/** V Variable **/

	P=lthird(fkeller);
	if( lsecond(P) != 2 )
	{       mistake( 264 );
		return( ERROR );
	}
	P = lfirst( P );
	V = lfirst( P );
	P = lsecond( P );
	if(llength(P)!=2 || lfirst(P)!=1 || lsecond(P)!= 1 || llength(V)!=1 )
	{       mistake( 264 );
		return( ERROR );
	}

	/** p Primzahl **/

	if(llength(fkeller)==4)
	{	P=lfourth(fkeller);
		if(lsecond(P) || !issingle(lfirst(P)))
		{	mistake(324);
			return(ERROR);
		}
		p=lfirst(P);
		m=2;
	}
	else
	{	if(!modsch || !pzsch)
		{	mistake(324);
			return(ERROR);
		}
		p=lfirst(varlist[modsch].varwert);
		m=18;
	}
	if(issprime(p,&P)<=0)
	{	mistake(324);
		return(ERROR);
	}	

	if(p!=2 && t && t!=3 )
	{	mistake(326);
		return(ERROR);
	}
	if(p==2 && (t==1 || (t && seven(t))))
	{	mistake(326);
		return(ERROR);
	}
	if( t > (n+1) )
	{	mistake(326);
		return(ERROR);
	}

	/** Rechnung **/

	P=0;
/*	if(!t)
	{	if(p==2) P=upm2imtgen(n);
		else P=upmsimtgen(p,n);
	}
	if(!P)
	{	if(p==2) P=upm2imgen(n);
		else P=upmsimgen(p,n);
	}*/

	if( p!=2 )
	{	if(t)
		{	P=upmsimtgen(p,n);
			if(P==0) P= upmsimgen(p,n);
		}
		else	P=upmsimgen(p,n);
	}
	else
	{	if(!t)  P=upm2imgen(n);
		else    
		{	P=upm2imncgen(n,t,1000);
			if(P==0) P=upm2imgen(n);
		}
	}
	P=list2(V,P);
	P=list2(P,m);
	return(P);
}
