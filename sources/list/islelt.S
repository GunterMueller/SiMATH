/*M
.SH NAME
islelt - is list element ?

.SH SYNOPSIS
.nf
#include<_list.h>

single islelt(L, a)  
list L; 
obj a;
 
.SH DESCRIPTION
islelt returns a single, say k, where k denotes the position of the first occurrence of the object a in the list L. If the list l does not contain the object a, islelt returns 0. 

M*/
         
/*H
	Version  1      23.07.1993     	M. Conrad
   DATE islelt        : 931130
H*/
#include<_list.h>

single islelt(L, a)
	list L;
	obj a;

{
	single k = 1;

	bind(a, L);

	while (L != _0) {
		if (oequal(lfirst(L), a))
			return (k);
		k++;
		L = lred(L);
	}
	return (0);
}
