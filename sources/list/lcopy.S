/*M
.SH NAME
lcopy - list copy (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

list lcopy(L)  
list L;
.SH DESCRIPTION
.TP 4
.B L
is a list.
.PP
lcopy returns a copy of L.

M*/
    
/*H
	Version 1       24.2.1987               Pascale Serf
	Version 2       2.4.1987                komplette Neufassung
						  P.Serf
   DATE lcopy         : 890501
H*/


# include <_list.h>

list lcopy(L)
list L;
{
	list L1;
	obj a;

	bind(L);
	init2(L1,a);

	L1 = _0;
	while ( L != _0 ) {
		a = lfirst(L);
		L = lred(L);
		if ( !isatom(a) ) a = lcopy(a);
		L1 = lcomp(a,L1);
	}
	return(linv(L1));
}
