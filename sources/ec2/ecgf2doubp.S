/*M
.SH NAME
ecgf2doubp - elliptic curve over Galois-field with characteristic 2, double of point

.SH SYNOPSIS
.nf
#include<_ec2.h>

ecgf2doubp( G, a1, a2, a3, a4, a6, P)
obj G;
gf2el a1,a2,a3,a4,a6;
list P;

.SH DESCRIPTION
ecgf2doubp() computes 2*P on the elliptic curve
.TP 8
      E : y^2 + a1xy + a3y = x^3 + a2x^2 + a4x + a6
.PP
over GF(2^m)
.TP 4
.B G
is an univariate, irreducible polynomial of degree m in the
special bit representation (see udpgf2tosb()).
G generates GF(2^n).
.TP 4
.B a1, a2, a3, a4, a6
are the coefficients of E in the special bit
representation
.TP 4
.B P
is a list of 3 elements of GF(2^m) in the special
bit representation. P is a projective point of E.
M*/
/*H
         Version 1       22.08.1996      E.Herrmann
    DATE ecgf2doubp	: 961201
H*/

#include<_ec2.h>

list ecgf2doubp( G, a1, a2, a3, a4, a6, P)

obj     G;
gf2el   a1,a2,a3,a4,a6;
list P;

{

 list KEEP;
 gf2el n, b1, b2, x, y, x2, y2, z2, zaehler;

 bind(G, a1, a2, a3, a4, a6, P);
 init( n, b1, b2, x, y, x2, y2, z2, zaehler);
 init( KEEP);

 if( isppecgf2pai (G, P) )
 {
  n = udpm2togf2el(G, list2(0, 1));
  KEEP = list3(0, n, 0);
 }
 else {
   P = ecgf2srpp( G, P);
   x = lfirst( P);
   y = lsecond( P);

   n = gf2prod( G, a1, x);
   n = gf2sum( G, n, a3);

   if( icomp(n,0) == 0 )
   {
    n = udpm2togf2el(G, list2(0, 1));
    KEEP = list3(0, n, 0);
   }
 else
 {
    zaehler = gf2prod( G, x, x);
    b1 = gf2prod( G, a1, y);
    zaehler = gf2sum( G, zaehler, b1);
    zaehler = gf2sum( G, zaehler, a4);
    n = gf2quot( G, zaehler, n);
    b1 = gf2prod( G, a1, n);
    b2 = gf2prod( G, n, n);
    x2 = gf2sum( G, b1, b2);
    x2 = gf2sum( G, x2, a2);
    b1 = gf2sum( G, x, x2);
    y2 = gf2prod( G, n, b1);
    b1 = gf2prod( G, a1, x2);
    b1 = gf2sum( G, b1, a3);
    y2 = gf2sum( G, y2, b1);
    y2 = gf2sum( G, y2, y);
    z2 = udpm2togf2el(G, list2(0, 1));
    KEEP = list3( x2, y2, z2);
 }}
       return( KEEP);
};
