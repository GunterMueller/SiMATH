/*M
.SH NAME
lscomps - list of singles comparison special version

.SH SYNOPSIS
.nf
#include<_list.h>

single lscomps(L1, L2) 
list L1, L2;

.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists of single precision numbers, length(L1) = length(L2).  
.PP
Let L1 = (m1,...,mr) and L2 = (n1,...,nr). lscomps returns
.TP 4
0, 
if L1 = L2.
.TP 4
1,
if L1 != L2 and mi <= ni for 1 <= i <= r.
.TP 4
2,
if L1 != L2 and ni <= mi for 1 <= i <= r.
.TP 4
3,
else.
    
M*/
            
/*H
	Version 1	31.05.1987      B. Weis
	Version 2       16.11.1987      neuer Name    BW MAR
   DATE lscomps       : 890501
H*/


# include <_list.h>

single lscomps(L1,L2)
list L1,L2;
{
	single n=0, n1=0, mi, ni;
	bind2(L1,L2);

/* Berechnung von n */

	while (L1 != _0) {
		mi = lfirst(L1);
		L1 = lred(L1);
		ni = lfirst(L2);
		L2 = lred(L2);
		if (mi < ni) n = 1;
		else {
			if (mi > ni) n1 = 2;
			}
		}
	n += n1;

/* Ausgabe */

	return(n);
}
