/*M
.SH NAME
lredf - list reductum as function 

.SH SYNOPSIS
.nf
#include<_ec3.h>

lredf(L)
list L;

.SH DESCRIPTION
lredf() is identical to lred() but is no macro.
 
.SH SEE ALSO
lred
M*/

#include <_list.h>
list lredf( L ) 
	list L; 
	{ 
	return lred(L); 
	} 
