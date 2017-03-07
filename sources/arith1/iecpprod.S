/*M
.SH NAME
iecpprod - integer elliptic curve point product

.SH SYNOPSIS
.nf
#include<_arith1.h>

list iecpprod(p,m,P,a)
int p,m,a;
list P;

.SH DESCRIPTION
iecpprod() returns m * P = P + P + P + ... + P
on the elliptic curve E (see below) on success
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
.B m
>= 0 is the multiplier.
.TP 4
.B P
= (Xp, Yp) is a point on the elliptic curve
.PP
    E: y^2 = x^3 + ax + b (mod p),
.PP
    where b is uniquely determined by the point P.
    The point at infinity is represented by the atom 0.

.SH CAUTION
iecpprod() is used for primality tests.
Be aware that the "ecmp..." functions use a different (affine)
representation of elliptic curves!
M*/
/*H
	Version 1	16.01.1993	Georg Lay
	Version 2	01.09.1993	Doku korrigiert.  GL
   DATE iecpprod      : 930531.931130
H*/

#include <_arith1.h>

list iecpprod (N,E,P,a)
int N,E,P,a;
 {
 list Q;

 bind (E,P);
 init (Q);

 Q = 0;

 for (; E; E = iquot (E,2))
   {
   if (iodd (E))
     if ((Q = iecpsum (N,P,Q,a)) == _0)			return (_0);
   if ((P = iecpsum (N,P,P,a)) == _0)			return (_0);
   }

 return (Q);
 }

