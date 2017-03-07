/*M
.SH NAME
lcomp4 - list composition, 4 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lcomp4(a, b, c, d, L)
obj a,b,c,d,;
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, ..., a_n).
.PP
lcomp4 returns the list
.IP
(a, b, c, d, a_0, ..., a_n) or
.IP
(a, b, c, d) if L is the empty list.

M*/

/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lcomp4        : 890501.941201
H*/
#include <_list.h>
list lcomp4(a,b,c,d,L) 
	obj a, b, c, d; 
	list L; 
	{ 
	bind(a,b,c,d,L); 
	return( lcomp(a,lcomp(b,lcomp(c,lcomp(d,L)))) ); 
	} 
