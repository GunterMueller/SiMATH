/*M
.SH NAME
islistgfs - is list of Galois-field with single characteristic elements ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single islistgfs(p, AL, L)  
obj p, AL, L;
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen). 
.PP
islistgfs returns
.TP 4
1,
if L can be seen as a list, containing elements of GF(p^n), and
.TP 4
0,
else.
.PP
For L the empty list, GF(p^n) returns 1.

.SH SEE ALSO
gfsalgen

M*/
                      
/*H
	Version 1       03.06.88                    J.Schmitt
   DATE islistgfs     : 890501
H*/


# include <_arith2.h>

single islistgfs(p,AL,L)
single p;
list AL;
obj L;
{
	obj a;

	if ( !islist(L) ) return(0);
	while (L != _0) {
		a = lfirst(L);
		if (!isgfsel(p,AL,a)) return(0);
		L = lred(L);
		}
	return(1);
}
