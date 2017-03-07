/*M
.SH NAME
lsixth - list sixth

.SH SYNOPSIS
.nf
#include<_ec3.h>

obj lsixth(L)
list L;

.SH DESCRIPTION
lsixth() returns the sixth object of the list L.
L must have at least 6 objects.
M*/

/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       19.12.1988      Unterprogramm statt Macro.  PS
	Version 3	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE lsixth        : 890501.941201
H*/

# include <_list.h>

obj lsixth(L)
list L;
{
	single i;

	for ( i=1 ; i<=5 ; i++ ) L = lred(L);
	return(lfirst(L));
}
