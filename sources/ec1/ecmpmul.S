/*M
.SH NAME
ecmpmul - elliptic curve over modular primes multiplication-map

.SH SYNOPSIS
.nf
#include <_ec1.h>

list ecmpmul (p, a1, a2, a3, a4, a6, n, P1)
int     p, a1, a2, a3, a4, a6, n;
list    P1;

.SH DESCRIPTION
ecmpmul() computes n*P on the elliptic curve
.TP 8
        E : y^2 + a1xy + a3y = x^3 + a2x^2 + a4x + a6
.TP 4
.B p
is a prime
.TP 4
.B a1, a2, a3, a4, a6
are the coefficients of E
.TP 4
.B n
is a non-negativ integer
.TP 4
.B P1
is a list of 3 elements of Z/pZ, eg. P is a projective
Point of E.
M*/
/*H
         Version 1       12.08.1996     E.Herrmann
   DATE ecmpmul	: 961201
H*/

#include<_ec1.h>


list ecmpmul(p, a1, a2, a3, a4, a6, n, P1)

int     p,a1,a2,a3,a4,a6,n;
list    P1;
{

 single k;
 int i,j,l,z;
 list ERG,L;
 list VEC[8];

 init( ERG, L, l, i, j, z);
 init(VEC[0], VEC[1], VEC[2], VEC[3]);
 init(VEC[4], VEC[5], VEC[6], VEC[7]);
 bind( p, a1, a2, a3, a4, a6, n, P1);
 /*
   init 1
 */
 P1 = ecmpsrpp(p, P1);
 VEC[0] = list3(0, 1, 0);
 ERG = lcopy(VEC[0]);
 VEC[1] = lcopy(P1);
 /*
   special case
 */
 if( issingle(n))
 {
  j = n;
  z=1;
  while( z<= n)
 {
  if( j &01 == 1 )
  ERG = ecmpsum( p, a1, a2, a3, a4, a6, ERG, P1);
  j >>=1; z <<=1;
  P1 = ecmpsum( p, a1, a2, a3, a4, a6, P1, P1);
 }
 }
 else{
  for( k=2; k<8; k++)
  VEC[k]= ecmpsum(p, a1, a2, a3, a4, a6, P1,VEC[k-1]);
/*
   init 2
*/
 j= n;
 L= _0;
 l=1; z=-1;
/*
  Octal rep
*/
 while( icomp( j,l)>=0 )
 {
 k = mshom(8, n); l=isprod(l,8);
 L= lcomp(k,L);
 n=irshift(n); n=irshift(n);
 n=irshift(n); z=isum(z,1);
 }
/*
  sum
*/
 for( l=0; l<z; l=isum(l,1) )
 {
  k = lfirst(L);
  ERG=ecmpsum( p,a1,a2,a3,a4,a6,ERG,VEC[k]);
/*

  'shift'
*/
 ERG=ecmpdoubp( p, a1, a2, a3, a4, a6, ERG);
 ERG=ecmpdoubp( p, a1, a2, a3, a4, a6, ERG);
 ERG=ecmpdoubp( p, a1, a2, a3, a4, a6, ERG);
 L= lred(L);
 }
/*
  'last 3 bits'
*/
 ERG= ecmpsum( p, a1, a2, a3, a4, a6, ERG, VEC[lfirst(L)]);
 }
 return( ERG);
};

