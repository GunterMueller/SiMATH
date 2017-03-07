/*C
			gfrffact( p,Q,L )

	"Galois-field roots from fact".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list gfrffact( p,Q,L );      single p; list Q,L;
	X = gfrffact( p,Q,L );

	p ist die Charakteristik von GF(p^n), Q das erzeugende Polynom 
	fuer GF(p^n) und L die Liste der Faktorisierung ( fuer p=2:
	Rueckgabe von upgf2bofact, fuer p>2: Rueckgabe von upgfscfact ).
	gfrffact berechnet aus dieser Liste alle Nullstellen des 
	faktorisierten Polynoms ueber GF(p^n).
	(Dieses Programm wird fuer calc_froot gebraucht.)
C*/
/*H
	Version  1      29.12.1994      S.Schmitt
H*/

#include<_calc.h>

list gfrffact( p,Q,L )
single p;
list Q,L;

{       list H,Nst;
	obj P,el1,el0;
	init(H,Nst,P,el1,el0);
	bind( Q,L );

	Nst=_0;
	H=list2(0,1);

	while(L!=_0)
	{	P=lfirst(L);
		L=lred(L);
		if(lfirst(P)==1)
		{	if(llength(P)==2) Nst=lcomp(0,Nst);
			else
			{	el1=lsecond(P);
				el0=lfourth(P);
				if(p==2)
				{   el0=gf2neg(Q,el0);
				    if(!oequal(el1,H)) el0=gf2quot(Q,el0,el1);
				}
				else
				{   el0=gfsneg(p,Q,el0);
				    if(!oequal(el1,H)) el0=gfsquot(p,Q,el0,el1);				}
				Nst=lcomp(el0,Nst);
			}
		}
	}
	if(p!=2) Nst=linv(Nst);
	return(Nst);
}
