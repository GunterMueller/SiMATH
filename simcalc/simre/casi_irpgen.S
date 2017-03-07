/*C
			casi_irpgen( fkeller )

	"calculator irreducible polynomial construction".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list casi_irpgen( fkeller );      list fkeller;
	X = casi_irpgen( fkeller );

	fkeller besteht aus einer Primzahl p, einer Variablen x, 
	einer Zahl n aus Z, n>0, und einer Zahl t=0 oder 1, bzw.
	nur aus x, n und t (hier ist p = curModulus), bzw.
	aus x und n.
	In den ersten beiden Faellen ist X ein irreduzibles Polynom in 
	der Variablen x ueber Z/pZ vom Grad n.
	Falls t=0, wird zuerst nach einem Trinom gesucht, ansonsten
        nach einem beliebigen Polynom.
	Im 3. Fall ist X ein irreduzibles Polynom in der Variablen x
	ueber GF(p^m) vom Grad n.
	Laeuft casi_irpgen fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.07.1994      S.Schmitt
	Version  1.1	11.10.1994	U.Schneiders
	Version  2      27.11.1997      S.Schmitt (SIEMENS Version)
	Version  2.1    14.11.1998      S.Schmitt (GF(p^m))
H*/

#include<_calc.h>

list casi_irpgen( fkeller )
list fkeller;

{       single t,n,m,l;
	int p;
	obj P,V,Q;
	init(p,P,V,Q);
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/
# ifdef ___CASI

	l = llength(fkeller);
	if(l!=2 && l!=3 && l!=4)
	{       mistake( 3 );
		return( ERROR );
	}
	
	/** t>=0 **/

	if(l>2)
	{
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
		fkeller = lred(fkeller);
	}

	/** n>0 **/

	P=lfirst(fkeller);
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

	P=lsecond(fkeller);
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

	if(l>2)
	{	if(l==4)
		{	P=lthird(fkeller);
			if(lsecond(P))
			{	mistake(328);
				return(ERROR);
			}
			p=lfirst(P);
			m=2;
		}
		else if(l==3)
		{	if(!modsch || !pzsch)
			{	mistake(328);
				return(ERROR);
			}
			p=lfirst(varlist[modsch].varwert);
			m=18;
		}

		if(isiprime(p)<=0)
		{	mistake(328);
			return(ERROR);
		}	

		if(icomp(p,2) && t && t!=3 ) /** p!=2 **/
		{	mistake(326);
			return(ERROR);
		}
		if(t==3 && !issingle(p))
		{	mistake(324);
			return(ERROR);
		}
		if(!icomp(p,2) && (t==1 || (t && seven(t))))  /** p==2 **/
		{	mistake(326);
			return(ERROR);
		}
		if( t > (n+1) )
		{	mistake(326);
			return(ERROR);
		}
	}

	else    /** erzeugendes Polynom **/
	{
		if(!gfsch)
		{
			mistake(260);
			return(ERROR);
		}
		Q = lfirst(varlist[gfsch].varwert); 
		m = 32;
	}	

	/** Rechnung **/

	P=0;
	
	if(m==32)
	{
		if(gfchar==2)	P = upgf2imrgen(Q,n);
		else 		P = upgfsimrgen(gfchar,Q,n);
	}
	else if( icomp(p,2) )	/** p!=2 **/
	{	if(t)		/** -> p ist single **/
		{	P=upmsimtgen(p,n);
			if(P==0) P= upmiimrangen(p,n);
		}
		else	P=upmiimrangen(p,n);
	}
	else
	{	if(!t)  P=upmiimrangen(2,n);
		else    
		{	P=upm2imncgen(n,t,1000);
			if(P==0) P=upmiimrangen(2,n);
		}
	}
	P=list2(V,P);
	P=list2(P,m);
	return(P);
# endif
}
