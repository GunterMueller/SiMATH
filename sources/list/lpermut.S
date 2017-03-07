/*M
.SH NAME
lpermut - list permutation

.SH SYNOPSIS
.nf
#include<_list.h>

list lpermut(L, PP)  
list L, PP;
 
.SH DESCRIPTION
.TP 4
.B L 
is a list of length n, 0 <= n < BASIS.
.TP 4
.B PP
is a list, containing the first n natural numbers. PP describes a permutation.
.PP
Let PP = ((pi(1),...,pi(n)) and let L = (l(1),...,l(n)). Then lpermut returns the list
.IP
(l(pi(1)), ..., l(pi(n))).

M*/
      
/*H
	Version 1       23.10.1987      B. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE lpermut       : 890501.941201
H*/


#include <_list.h>

list lpermut(L,PP)
list L, PP;
{
	single pi;
	list L1;
	obj A;
	bind2(L,PP);
	init(L1);

/* Berechnung von L1 */

	L1 = _0;
	while (PP != _0) {
		pi = lfirst(PP);
		PP = lred(PP);
		A = lelt(L,pi);
		L1 = lcomp(A,L1);
		}
	L1 = linv(L1);

/* Ausgabe */

	return(L1);
}
