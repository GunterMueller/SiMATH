/*M
.SH NAME
lecins - list element constructive insert

.SH SYNOPSIS
.nf
#include<_list.h>

list lecins(L, k, a)  
list L; 
single k; 
obj a;
 
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ..., a_n).
.TP 4
.B k 
is an integral number, 0 <= k <= n.
.PP
lecins returns the list
.IP
(a_1, ..., a_k, a, a_k+1, ..., a_n).

M*/
       
/*H
	Version  1      23.07.1993	Marc Conrad
   DATE lecins        : 931130
H*/


#include <_list.h>

list lecins(L, i, a)
	list L;
	single i;
	obj a;
{
	if (i == 0)
		return (lcomp(a, L));
	{
		list K, M;

		bind(L);
		init(K, M);

		K = _0;

		while (i > 0) {
			K = lcomp(lfirst(L), K);
			L = lred(L);
			i--;
		}
		L = lcomp(a, L);
		M = linv(K);
		lsred(K, L);
		return (M);
	}
}






