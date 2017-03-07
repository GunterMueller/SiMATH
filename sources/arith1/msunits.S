/*M
.SH NAME
msunits - modular single units

.SH SYNOPSIS
.nf
#include<_arith1.h>

list msunits(m)
single m;

.SH DESCRIPTION
msunits() returns the ascendingly sorted list of
all unit in Z/mZ for m >0.
M*/
/*H
	Version 1       06.03.1987              Pascale Serf
   DATE msunits       : 890501.9011__
H*/



# include <_arith1.h>

list msunits(m)
single m;
{
	single i;
	list L;

	init(L);

	L = _0;
	for ( i=0 ; i<m ; i++ ) if ( sgcd(i,m) == 1 ) L = lcomp(i,L);
	return(linv(L));
}
