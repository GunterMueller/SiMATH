/*C
			calc_minor( fkeller )

	"calculator minor matrix".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_minor( fkeller );      list fkeller;
	X = calc_minor( fkeller );

	1.Fall: fkeller besteht aus einer mxn-Matrix M und zwei Zahlen
		i,j mit 1<=i<=m, 1<=j<=n. X ist die Matrix die entsteht,
		wenn man in M die i-te Zeile und die j-te Spalte 
		streicht.
	2.Fall: fkeller besteht aus einer mxn-Matrix M, zwei Zahlen
		z,s mit 0<=z<=m, 0<=s<=n, und z Zahlen zi, 1<=i<=z,
		s Zahlen sj, 1<=j<=s mit 1<=zi<=m, 1<=sj<=n.
		X ist die Matrix die entsteht, wenn man in M die
		zi-ten Zeilen und die sj-ten Spalten streicht, 
	Laeuft calc_minor fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      04.07.1994      S.Schmitt
H*/

#include<_calc.h>

list calc_minor( fkeller )
list fkeller;

{	single spbit=0,ken,m,n, anzz, anzs,i,k,za;
	obj M,Ma,Z,S,j,VL,H;
	init( M, Ma, Z, S, j, VL, H );
	bind( fkeller );

	fkeller=linv(fkeller);
	VL=_0;

	/*** Ueberpruefung der Eingaben. ***/

	M=lfirst(fkeller);
	fkeller=lred(fkeller);
	ken=lsecond(M);
	if(llength(fkeller)<2 || ken<5 || (ken>9 && ken<19) || (ken>20 && ken<26) || (ken>27 && ken<33) || ken>34)
	{	mistake(3);
		return(ERROR);
	}
	M=lfirst(M);
	if(ken==19 && lfirst(varlist[modsch].varwert)==2) 
	{	spbit=1;
		M=mam2tomams(M);
	}
	Ma=lcopy(M);
	if(ken==7 || ken==8 || ken==9 || ken==20 || ken==27 || ken==34)
	{	VL=lfirst(Ma);
		Ma=lsecond(Ma);
	}
	n=llength(Ma);
	Z=lfirst(Ma);
	m=llength(Z);

	if(llength(fkeller)==2)
	{	Z=lfirst(fkeller);
		S=lsecond(fkeller);
		if(lsecond(Z) || lsecond(S))
		{	mistake(3);
			return(ERROR);
		}
		Z=lfirst(Z);
		S=lfirst(S);
		if(icomp(Z,0)<=0 || icomp(Z,n)>0 || icomp(S,0)<=0 || icomp(S,m)>0)
		{	mistake(3);
			return(ERROR);
		}
		Z=madel1rc(&Ma,Z,S);
		if(Ma==_0) M=list2(0,0);
		else 
		{	if(VL!=_0) Ma=list2(VL,Ma);
			if(spbit) Ma=mamstomam2(Ma);
			M=list2(Ma,ken);
		}
		return(M);
	}

	Z=lfirst(fkeller);
	S=lsecond(fkeller);
	fkeller=lred2(fkeller);
	if(lsecond(Z) || lsecond(S) || !issingle(lfirst(Z)) || !issingle(lfirst(S)))
	{	mistake(3);
		return(ERROR);
	}
	anzz=lfirst(Z);
	anzs=lfirst(S);
	if(anzz<0 || anzz>n || anzs<0 || anzs>m)
	{	mistake(3);
		return(ERROR);
	}
	if(llength(fkeller)!=(anzz+anzs))
	{	mistake(3);
		return(ERROR);
	}

	Z=_0;
	S=_0;
	for(i=1;i<=anzz;i++)
	{	j=lfirst(fkeller);
		fkeller=lred(fkeller);
		if(lsecond(j))
		{	mistake(3);
			return(ERROR);
		}
		j=lfirst(j);
		if(!issingle(j) || j<1 || j>n)
		{	mistake(3);
			return(ERROR);
		}
		H=lcopy(Z);
		for(k=1;k<i;k++)
		{	za=lfirst(H);
			H=lred(H);
			if(za==j)
			{	mistake(3);
				return(ERROR);
			}
		}	
		Z=lcomp(j,Z);
	}
	libsort(Z);
	for(i=1;i<=anzs;i++)
	{	j=lfirst(fkeller);
		fkeller=lred(fkeller);
		if(lsecond(j))
		{	mistake(3);
			return(ERROR);
		}
		j=lfirst(j);
		if(!issingle(j) || j<1 || j>m)
		{	mistake(3);
			return(ERROR);
		}
		H=lcopy(S);
		for(k=1;k<i;k++)
		{	za=lfirst(H);
			H=lred(H);
			if(za==j)
			{	mistake(3);
				return(ERROR);
			}
		}	
		S=lcomp(j,S);
	}
	libsort(S);

	madelsrc(&Ma,Z,S);
	if(Ma==_0) M=list2(0,0);
	else 
	{	if(VL!=_0)  Ma=list2(VL,Ma);
		if(spbit) Ma=mamstomam2(Ma);
		M=list2(Ma,ken);
	}
	return(M);
}
