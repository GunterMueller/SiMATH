/*M
.SH NAME
sfact - single factorization

.SH SYNOPSIS
.nf
#include<_arith1.h>

list sfact(n)
single n;

.SH DESCRIPTION
sfact() returns a list L = (p1,...,pn)
of the prime factors p1<=...<=pn
with n = p1 * ... * pn for n>0.
M*/
/*H
	Version 1       09.03.1987	Pascale Serf   
	Version 2       22.11.1990	neu geschrieben,
                                        Marc Conrad
   DATE sfact         : 890501.901120
H*/


# include <_arith1.h>                   
              
# define diw(E) while (!(n%E)) {n /= E; F = lcomp(E,F);}     

list sfact(m)
single m;
{
	list F;       
	unsigned n;
	single e,w;
	init(F);   
	n = m;
	F = _0;     
	diw(2)
	diw(3)
	diw(5)
	diw(7)
	diw(11)
	diw(13)
	diw(17)  
	diw(19)
	diw(23)
	diw(29)  

        if ( n > 960 ) {
		e = 31; 
		goto E; 
	D:      F = lcomp(e,F);
		n /= e;    
		e =  (e/30)*30 + 1;
	E:	w = ssqrt(n);
	        while (e <= w) {
			if (!(n%e)) goto D; e += 6;
			if (!(n%e)) goto D; e += 4;
			if (!(n%e)) goto D; e += 2;
			if (!(n%e)) goto D; e += 4;
			if (!(n%e)) goto D; e += 2;
			if (!(n%e)) goto D; e += 4;
			if (!(n%e)) goto D; e += 6;       
			if (!(n%e)) goto D; e += 2;
		}              
	}
	if (n != 1) F = lcomp((int)n,F);
	return(linv(F));
}
