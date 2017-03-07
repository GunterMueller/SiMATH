/*M
.SH NAME
lcomp3 - list composition, 3 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lcomp3(a, b, c, L)
obj a,b,c;
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, ..., a_n).
.PP
lcomp3 returns the list
.IP
(a, b, c, a_0, ..., a_n) or
.IP
(a, b, c) if L is the empty list.

M*/

/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lcomp3        : 890501.941201
H*/
#include <_list.h>
list lcomp3(a,b, c, L) 
	obj a, b, c; 
	list L; 
	{ 
	bind(a,b,c,L); 
	return( lcomp(a,lcomp(b,lcomp(c,L))) ); 
	} 
