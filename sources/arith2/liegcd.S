/*M
.SH NAME
liegcd - list (vector) of integers extended greatest common divisor

.SH SYNOPSIS
.nf
#include <_arith2.h>

int liegcd (li,pl)
list li, *pl;

d = liegcd (li,pl);

.SH DESCRIPTION
.TP 4
.B li
is a list (a_1,a_2,...,a_n) of integers that is not empty.
.PP
liegcd() computes the graetes common divisor 
d = gcd (a_1,...,a_n) and a list
*pl = (c_1,...,c_n) of integers such that
d = a_1*c_1 + ... + a_n*c_n. 
M*/
/*H
	Version 1	21.01.1996	Georg Lay
   DATE liegcd        : 960501
H*/

#include <_arith2.h>

int liegcd (li,pl)
list li,*pl;
 {
 int   a,b,d;
 init (a,b,d);

 d = lfirst (li);
 *pl = list1 (1);

 for (li = lred (li); li != _0; li = lred (li)) {
   d = iegcd (d,lfirst (li), &a, &b);
   *pl = vecismul (a,*pl);
   *pl = lsuffix  (*pl,b);
   }

 return (d);
 }
