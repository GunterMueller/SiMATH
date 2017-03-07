/*M
.SH NAME
lcomp2 - list composition, 2 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lcomp2(a, b, L)
obj a,b;
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, ..., a_n).
.PP
lcomp2 returns the list
.IP
(a, b, a_0, ..., a_n) or
.IP
(a, b) if L is the empty list.

M*/
            
/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lcomp2        : 890501.941201
H*/

#include <_list.h>
list lcomp2(a,b,L) 
	obj a, b; 
	list L; 
	{ 
	bind(a,b,L); 
	return( lcomp(a,lcomp(b,L)) ); 
	} 
