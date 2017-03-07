/*M
.SH NAME
islisti - is list of integers ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single islisti(L)
obj L;

.SH DESCRIPTION
islisti() returns 1 in case L is an (empty) list of integers,
and 0 otherwise.
M*/
/*H
					
	Version 1	08.12.1991	Georg Lay
   DATE islisti       : 920331
H*/

#include <_arith1.h>

single islisti (L)
obj L;
 {
 bind (L);

 if (L == _0)				return (1);
 if (!islist (L))			return (0);

 for (; L != _0; L = lred (L))
   if (!isint (lfirst (L)))		return (0);

 return (1);
 }
