/*M
.SH NAME
ecmpdoubp - elliptic curve over modular primes double of point

.SH SYNOPSIS
.nf

ecmpdoubp( p, a1, a2, a3, a4, a6, P)
int p, a1, a2, a3, a4, a6;
list P;

.SH DESCRIPTION
ecmpdoubp() computes 2*P on the elliptic curve
.TP 8
	E: y^2 + a1xy + a3y = x^3 + a2x^2 +a4x + a6
.PP
over Z/pZ.
.TP 4
.B p
is a prime
.TP 4
.B a1, a2, a3, a4, a6
are the coefficients of E 
.TP 4
.B P
is a list of 3 elements of Z/pZ. P is a projetive point
of E.
M*/
/*H
	Version 1	28.08.1996	E.Herrmann
   DATE ecmpdoubp	: 961201
H*/
	

#include<_ec1.h>

ecmpdoubp( p, a1, a2, a3, a4, a6, P)

int     p, a1, a2, a3, a4, a6;
list    P;
{

 list KEEP;
 int b1, n, zaehler, x, y, x2, y2;

 bind( p, a1, a2, a3, a4, a6, P);
 init(  b1, n, zaehler, x, y, x2, y2);
 init( KEEP);

 if( isppecmppai( p, P))
 KEEP = list3( 0,1,0);
 else {
 P = ecmpsrpp (p, P);
 x = lfirst( P);
 y = lsecond( P);

 n = miprod( p, a1, x); n = misum(p, n, a3);
 b1 = miprod( p, 2, y); n = misum(p, n, b1);

 if( n == 0 )
 KEEP = list3(0,1,0);
 else
 {
  zaehler = miprod( p, x, x);
  zaehler = miprod( p, zaehler, 3);
  b1 = miprod( p, a2, x); b1 = miprod( p, b1, 2);
  x2 = miprod( p, a1, y);
  zaehler = misum( p, zaehler, b1);
  zaehler = misum( p, zaehler, a4);
  zaehler = midif( p, zaehler, x2);
  n = miquot(p, zaehler, n);
/**************************************************/
  b1 = miprod( p, x, 2);
  x2 = miprod( p, n, n);
  x2 = midif( p, x2, b1);
  b1 = miprod( p, a1, n);
  x2 = misum( p, b1, x2);
  x2 = midif( p, x2, a2);
/**************************************************/
  b1 = midif( p, x, x2);
  y2 = miprod( p, n, b1);
  b1 = miprod( p, a1, x2);
  b1 = misum( p, b1, a3);
  y2 = midif( p, y2, b1);
  y2 = midif( p, y2, y);
  KEEP=list3( x2,y2,1);
 }}
   return( KEEP);
 
};
