/*M
.SH NAME
sfactors - single factors

.SH SYNOPSIS
.nf
#include<_arith1.h>

list sfactors(n)
single n;

.SH DESCRIPTION
sfactors() returns the list L = (p1,...,pn)
of the different prime factors p1<...<pn of
the single number n > 0.
M*/
/*H
					
	Version 1       10.03.1987      Pascale Serf
	Version 2 	06.06.1992	voellig neu.  MC
   DATE sfactors      : 890501.921130
H*/


# include <_arith1.h>
              
# define diw(E) { if (!(n%E)) {n /= E; F = lcomp(E,F);}  while ( !(n%E) ) n /= E; }   

list sfactors(m)
single m;
{
	list F;       
	unsigned n;
	single e,w;
	init(F);   
	n = (unsigned) m;
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
		while (!(n%e)) n /= e;  
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
	if (n != 1) F = lcomp((single) n,F);
	return(linv(F));
}               




