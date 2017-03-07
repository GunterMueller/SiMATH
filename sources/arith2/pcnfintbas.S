/*M
.SH NAME 
pcnfintbas - pure cubic number field integral basis

.SH SYNOPSIS
.nf
#include<_arith2.h>

list pcnfintbas(D)
int      D;

.SH DESCRIPTION
pcnfintbas() returns an integral basis of a pure cubic number field K = Q(D^(1/3)).
.TP 3 
It returns a list L = ( w1, w2, w3 ), where \  \  \  \  \  \  O_K = w1*Z + w2*Z + w3*Z is the ring of integers of K = Q(D^(1/3)).
.PP
.TP 4
.B D
is a cubefree integer not equal to 0 or 1.
M*/
/*H
        Version 1       20.02.1998      Andreas Heiser
   DATE pcnfintbas : 
H*/
	
#include <_arith2.h>

list pcnfintbas(D)
int	D;
{	pol	F;
	int	a,b,c,d;
	nfel	w1,w2,w3,h;
	list	L;

	init(F,a,b,c,d,w1,w2,w3,h,L);
	bind(D);
	L=ifact(D);L=ifel(L);
	F=list5(3,1,0,0,-D);
	a=1;b=1;
	while(L!=_0)
	{	c=iexp(lfirst(L),lsecond(L));
		if(mihom(2,lsecond(L)))
			a=iprod(a,c);
		else
			b=iprod(b,c);
		L=lred2(L);
	}
	b=isqrt(b);
	c=iprod(a,a);d=iprod(b,b);
	c=idif(c,d);
	w1=list3(1,0,1);
	w2=list4(1,1,1,0);
	if(mihom(9,c))
		w3=list5(b,2,1,0,0);
	else
	{	w3=nfprod(F,w2,w2);
		h=nfprod(F,w2,itonf(D));				
		w3=nfsum(F,w3,h);
		w3=nfsum(F,w3,itonf(d));
		h=nfprod(F,itonf(3),itonf(b));
		w3=nfquot(F,w3,h);
	}

	L=list3(w1,w2,w3);
	return(L);
}
