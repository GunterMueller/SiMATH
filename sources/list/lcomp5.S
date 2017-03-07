/*M
.SH NAME
lcomp5 - list composition, 5 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lcomp5(a, b, c, d, e, L)
obj a,b,c,d,e;
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, ..., a_n).
.PP
lcomp5 returns the list
.IP
(a, b, c, d, e, a_0, ..., a_n) or
.IP
(a, b, c, d, e) if L is the empty list.

M*/

/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lcomp5        : 890501.941201
H*/
#include <_list.h>
list lcomp5(a,b,c,d,e,L) 
	obj a, b, c, d,e; 
	list L; 
	{ 
	bind(a,b,c,d,e,L); 
	return( lcomp(a,lcomp(b,lcomp(c,lcomp(d,lcomp(e,L))))) ); 
	} 
