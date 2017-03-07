/*M
.SH NAME
lfirstf - list first as function

.SH SYNOPSIS
.nf
#include<_ec3.h>

obj lfirstf(L)
list L;

.SH DESCRIPTION
lfirstf() is identical to lfirst() but is no macro.

.SH SEE ALSO
lfirst
M*/

#include <_list.h>

list lfirstf(L) 
	list L; 
	{ return lfirst(L); } 
