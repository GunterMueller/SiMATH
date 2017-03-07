/*M
.SH NAME
lsmins - list of singles minimum special version

.SH SYNOPSIS
.nf
#include<_list.h>

list lsmins(L1, L2) 
list L1, L2;

.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists of singles, length(L1) = length(L2).
.PP
Let L1 = (m1,...,mr) and L2 = (n1,...,nr). lsmins returns a list
.IP
(a1, ..., ar), where
.IP
ai = min{mi, ni}  1 <= i <= r.
                              
M*/
               
/*H
	Version 1	31.05.1987      B. Weis
	Version 2       16.11.1987      neuer Name BW MAR
   DATE lsmins        : 890501
H*/


# include <_list.h>

list lsmins(L1,L2)
list L1,L2;
{
	single l1, l2;
	list L;
	bind2(L1,L2);
	init(L);

/* Berechnung von L */

	L = _0;
	while (L1 != _0) {
		l1 = lfirst(L1);
		L1 = lred(L1);
		l2 = lfirst(L2);
		L2 = lred(L2);
		l1 = ( l1 < l2 ? l1 : l2 );
		L = lcomp(l1,L);
		}
	L = linv(L);

/* Ausgabe */

	return(L);
}
