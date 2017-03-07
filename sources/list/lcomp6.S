/*M
.SH NAME
lcomp6 - list composition, 6 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lcomp6(a, b, c, d, e, f, L)  
obj a,b,c,d,e,f; 
list L;

.SH DESCRIPTION
.TP 4
.B L 
is a list, say L = (a_0, ..., a_n).
.PP
lcomp6 returns the list 
.IP
(a, b, c, d, e, f, a_0, ..., a_n) or
.IP
(a, b, c, d, e, f) if L is the empty list.

M*/
      
/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lcomp6        : 890501.941201
H*/
#include <_list.h>
list lcomp6(a,b,c,d,e,f,L) 
	obj a, b, c, d, e, f; 
	list L; 
	{ 
	bind(a,b,c,d,e,f,L); 
	return( lcomp(a, lcomp5(b,c,d,e,f,L)) ); 
	} 
