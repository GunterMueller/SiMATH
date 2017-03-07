/*M
.SH NAME
isspprime - is single power of a prime ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isspprime(a,pc)
single a,*pc;

.SH DESCRIPTION
For a >1
isspprime() returns 1 if a is a power of a prime,
and 0 otherwise. In the first case, *pc equals
the smallest prime which is a factor of a.
M*/
/*H              
	Version 1 	02.07.1992	Marc Conrad
   DATE isspprime     : 921130
H*/


# include <_arith1.h>        

single isspprime(x, p)
	single x, *p;
{               
	if (issprime(x, p)) return (1);

	do {
		x /= *p;
	} while (!(x % *p));

	return (x == 1);
}
