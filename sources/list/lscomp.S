/*M
.SH NAME
lscomp - list of singles comparison, lexicographical order

.SH SYNOPSIS
.nf
#include<_list.h>

single lscomp(L1, L2) 
list L1, L2;
   
.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists of single precision numbers, length(L1) = length(L2).
.PP
lscomp returns 
.TP 4
0,
if L1 = L2.
.TP 4
1, 
if L1 > L2 with regard to the lexicographical order.
.TP 4
-1,
else.

M*/
         
/*H
	Version 1       13.11.1987      B. Weis
   DATE lscomp        : 890501
H*/


#include <_list.h>

single lscomp(L1,L2)
list L1, L2;
{
	single a=0, l1, l2;

/* Berechnung von a */

	while (L1 != _0) {
		l1 = lfirst(L1);
		l2 = lfirst(L2);
		if (l1 < l2) {a = -1; break;}
		if (l1 > l2) {a = 1; break;}
		L1 = lred(L1);
		L2 = lred(L2);
		}

/* Ausgabe */

	return(a);
}
