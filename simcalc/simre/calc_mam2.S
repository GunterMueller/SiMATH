/*C     		calc_mam2( fkeller )

	"calculator matrix over Z/2Z in special bit representation".
	list calc_mam2(fkeller); list fkeller;
	L = calc_mam2( fkeller );

	fkeller ist eine Liste bestehend aus positiven ganzen Zahlen,
	welche eine Matrix ueber Z/2Z in spezieller Bit-Darstellung 
	repraesentiert (vgl. mamstomam2.S). Der erste Eintrag in der Liste 
	fkeller ist die Anzahl der Spalten der Matrix. 
        Beispiel: Die Liste
        fkeller = ( 3  ( 7 )  ( 5 )  ( 1 ) ) 
	stellt die Matrix
        (
	(1 1 1)
        (1 0 1)
        (0 0 1)
        )
	dar.

	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      18.03.1996      S.Schmitt
H*/
 
#include <_calc.h>

list calc_mam2( fkeller )
list fkeller;
{	single l,k;
	obj M,Z;
	init(M,Z);	
	bind(fkeller);

	if(!modsch || lfirst(varlist[modsch].varwert)!=2)
	{	mistake(153);
		return(ERROR);
	}
	if(llength(fkeller)<2)
	{	mistake1(34,"mam2");
		return(ERROR);
	}
	fkeller=linv(fkeller);
	M=lfirst(fkeller);
	if(llength(M)!=2 || lsecond(M) || !issingle(lfirst(M)))
	{	mistake(337);
		return(ERROR);
	}
	l=lfirst(M);
	fkeller=lred(fkeller);
	M=list1(l);
	while(fkeller!=_0)
	{	Z=lfirst(fkeller);
		fkeller=lred(fkeller);
		if(lsecond(Z))
		{	mistake(164);
			return(ERROR);
		}
		Z=lfirst(Z);
		if(Z<0 || ilog2(Z)>l) 
		{	mistake(166);
			return(ERROR);
		}
		Z=list1(Z);
		M=lcomp(Z,M);
	}
	M=linv(M);
	M=list2(M,19);
	return(M);
}
