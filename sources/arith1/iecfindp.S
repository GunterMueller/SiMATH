/*M
.SH NAME
iecfindp - integer elliptic curve, find point

.SH SYNOPSIS
.nf
#include <_arith1.h>

list iecfindp (p, a, b)
int p, a, b;

.SH DESCRIPTION
iecfindp() tries to find a point P on the
elliptic curve E over Z/pZ, which in short normal form is
.PP
    E: y^2 = x^3 + a*x + b
.PP
On success, iecfindp() returns a list (x_P,y_P) of two integers that
represent a point P on E. P is not the point at infinity. In case
p is not prime, iecfindp() returns an empty list ().

.PP
.TP 4
.B p
p > 2 is a probable prime number
.TP 4
.B a, b
are elements of Z/pZ, i.e. 0 <= a,b < p

.PP
The output of iecfindp() depends on the global variable SEMIRAND.
For a description of SEMIRAND, see irand().

.SH CAUTION
Beware of using iecfindp() with algorithms like "ecmp...()"
since they use a different representation of points.
M*/

/*H
	Version 1	16.01.1993	Georg Lay
	Version 2	01.05.1996	Neue Doku	GL
   DATE iecfindp      : 930531.9311__.9612__
H*/

#include <_arith1.h>

list iecfindp (p,a,b)
int		   p,a,b;
 {
 int   x,y;
 init (x,y);

 do 
   {
   x = irand (p);

   y = miprod (p,x,x);
   y = misum  (p,y,a);
   y = miprod (p,y,x);
   y = misum  (p,y,b);					/* y = x^3 + a*x + b	*/
   y = mipsqrt (p,y);

   if (y == -2)			return (_0);		/* p nicht prim		*/
   }
 while (y < 0);

 return (list2 (x,y)); 
 }

