/*M
.SH NAME
iecpsum - integer elliptic curve point sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

list iecpsum(p,P,Q,a)
int p,a;
list P,Q;

.SH DESCRIPTION
iecpsum() returns the sum P + Q of the points
P and Q on the elliptic curve E (see below) on success
and an empty list if it finds out that p is not
prime.

.PP
.TP 4
.B p
> 3 should be prime.
.TP 4
.B a
is a coefficient in Z/pZ.
.TP 4
.B P, Q
P = (Xp,Yp) and Q = (Xq,Yq) are points on the elliptic curve
E: y^2 = x^3 + ax + b (mod p)
where b is uniquely determined by the points P and Q. The point at infinity is represented by the atom 0.

.SH CAUTION
iecpsum() is used for primality tests.
Be aware that the "ecmp..." functions use a different (affine)
representation of elliptic curves!
M*/
/*H
	Version 1	16.01.1993	Georg Lay
   DATE iecpsum       : 930531.9311__
H*/

#include <_arith1.h>

list iecpsum (N,P,Q,a)
int 	N,a;
list	P,Q;
 { 
 int m,dx;
 int x1,x2,x3;
 int y1,y2,y3;

 init (m,dx);
 init (x1,x2,x3);
 init (y1,y2,y3);

 if (P == 0)				return (Q);
 if (Q == 0)				return (P);

 x1 = lfirst (P);	y1 = lsecond (P);
 x2 = lfirst (Q);	y2 = lsecond (Q);

 dx = midif (N,x2,x1);

 if (dx == 0)
   {
   dx = misum (N,y1,y2);

   if (dx == 0)				return (0);	/* P = -Q		*/
   if ((dx = miinv (N,dx)) == 0)        return (_0);

   m = iprod (x1,x1);
   m = iprod (m,3);
   m = isum  (m,a);
   m = mihom (N,m);
   m = miprod (N,m,dx);					/* m=(3*x1^2+a)/(y1+y2)	*/

   goto jmp1;
   }

 if ((dx = miinv (N,dx)) == 0)		return (_0);
 
 m = midif  (N,y2,y1);
 m = miprod (N,m,dx);                      		/* m = (y2-y1)/(x2-x1)	*/

 jmp1:;

 x3 = iprod (m,m);
 x3 = idif  (x3,x1);
 x3 = idif  (x3,x2);
 x3 = mihom (N,x3);					/* x3 = m^2 - x1 - x2	*/

 y3 = idif  (x1,x3);
 y3 = iprod (m,y3);
 y3 = idif  (y3,y1);
 y3 = mihom (N,y3);					/* y3 = m(x1-x3)-y1	*/

 return (list2 (x3,y3));
 }

