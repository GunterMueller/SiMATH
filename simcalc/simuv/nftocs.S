/*C
			nftocs( a )

	"number field element to complex number, special"
	Quellbibliothek: srclib.simuv
	Include-Datei:   _calc.h
	complex nftocs(a) nfel a;
	c = nftocs(a);
	a ist ein Element aus dem Zahlkoerper K=Q((-1)^1/2).
	c = a (aufgefasst als Element aus den komplexen Zahlen).
C*/
/*H
	Version 1	17.01.1995      S. Schmitt
H*/


#include <_calc.h>

complex nftocs(a)
nfel a;
{
	obj hn,r,b1,b2;
	bind(a);
	init(hn,r,b1,b2);

	if(!a) return(a);
	hn = lfirst(a);
	r = lsecond(a);
	if(!r) 
	{	b1 = lthird(a);
		b1 = rcons(b1,hn);
		b1 = rtoc(b1);
	}
	else 
	{	b2 = lthird(a);
		b1 = lfourth(a);
		b2 = rcons(b2,hn);
		b1 = rcons(b1,hn);
		b2 = rtofl(b2);
		b1 = rtofl(b1);
		b1 = list2(b1,b2);
	}
	return(b1);
}
