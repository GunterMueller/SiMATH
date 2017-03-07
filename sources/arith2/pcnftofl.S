/*M
.SH NAME 
pcnftofl - pure cubic number field element to floating point element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single pcnftofl(D, a)
int      D; 
nfel     a; 

.SH DESCRIPTION
pcnftofl() converts a pure cubic number field element into a floating point element.
.PP
.TP 4
.B D
is a cubefree integer not equal to 0 or 1.
.TP 4
.B a
is an element of the pure cubic number field K = Q(D^(1/3)).
M*/
/*H
        Version 1       20.02.1998     Andreas Heiser
   DATE pcnftofl      : 
H*/
	
#include<_arith2.h>
	
floating  pcnftofl(D,a)
int	D;
nfel	a;
{	floating	f,th;
	
	init(f,th);
	bind(D,a);

	f=0;
	if(a)
	{	if(!lsecond(a))
			f=flquot(itofl(lthird(a)),itofl(lfirst(a)));
		else
		{	th=flquot(itofl(1),itofl(3));
			th=flpow(itofl(D),th);
			if(lsecond(a)==1)
			{	f=flprod(itofl(lthird(a)),th);
				f=flsum(f,itofl(lfourth(a)));
				f=flquot(f,itofl(lfirst(a)));
			}
			else
			{	f=flprod(itofl(lfourth(a)),th);
				f=flsum(f,itofl(lfifth(a)));
				th=flpow(th,itofl(2));
				th=flprod(itofl(lthird(a)),th);
				f=flsum(f,th);
				f=flquot(f,itofl(lfirst(a)));
			}
		}
		
	}
	return(f);
}
