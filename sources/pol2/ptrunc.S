/*M
.SH NAME
ptrunc - polynomial truncation, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol ptrunc(r, P, v, d) single r, v, d; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B d
is an integer number, 0 < d < BASIS.
.TP 4
.B v
is an integer number, 0 <= v <= r.
.TP 4
.B P
is a polynomial in the r variables X1,...Xr.
.PP
ptrunc returns the polynomial P1, where
.IP
P1 = P mod (X1,...,X(r-v))^d.
                                           
M*/
          
/*H
	Version 1	15.03.95	Wolfgang Schwarz
   DATE ptrunc        : 951201
H*/

#include <_pol2.h>

pol ptrunc(r,P,v,d)
single r,v,d;
pol P;
{
	list Pinv,P1,a;
	single rs,vs,e;
	bind(P);
	init(Pinv,P1,a);

	if (!P) return(0);
	if (!r) return(P);

	if (r) {rs = r-1; if (v) vs = v-1; else vs=0;}

	Pinv = lcinv(P);
	P1=_0;
	while (Pinv != _0)
	{	a = lfirst(Pinv);
		Pinv = lred(Pinv);
		e = lfirst(Pinv);
		Pinv = lred(Pinv);
		if (v)
		     {	if (r) a = ptrunc(rs,a,vs,d);
		     }
		else {	if (e >= d) break;
			if (r) a = ptrunc(rs,a,vs,d-e);
		     }
		if (a) P1 = lcomp2(e,a,P1);
	}
	if (P1==_0) P1=0;
	return(P1);
}
