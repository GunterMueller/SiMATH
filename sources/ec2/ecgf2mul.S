/*M
.SH NAME
ecgf2mul - elliptic curve over Galois-field with characteristic 2, multiplication-map

.SH SYNOPSIS
.nf
#include<_ec2.h>

ecgf2mul( G, a1, a2, a3, a4, a6, n, P)
obj G;
gf2el a1,a2,a3,a4,a6;
int n;
list P;

.SH DESCRIPTION
ecgf2mul() computes n*P on the elliptic curve 
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
.B n
is a non-negativ integer 
.TP 4
.B P
is a list of 3 elements of GF(2^m) in the special
bit representation. P is a projective point of E.
M*/
/*H
        Version 1       14.08.1996      E.Herrmann
   DATE ecgf2mul	: 961201
H*/

#include<_ec2.h>

list ecgf2mul( G, a1, a2, a3, a4, a6, n, P1)
obj 	G;
gf2el	a1,a2,a3,a4,a6;
int	n;
list 	P1;
{

 single k;
 int i,j,l,z;
 gf2el el;
 list ERG,L;
 list VEC[8];
 
 init( k,i,j,l,z,el,ERG,L);
 init(VEC[0], VEC[1], VEC[2], VEC[3]);
 init(VEC[4], VEC[5], VEC[6], VEC[7]);
 bind( G, a1, a2, a3, a4, a6, n, P1);
/*
 init 1  
 */
 P1 = ecgf2srpp(G, P1); 
 el = udpm2togf2el( G, list2(0,1));
 VEC[0] = list3(0, el, 0);
 ERG = lcopy(VEC[0]);

 if( issingle( n ))
 {
  k = n;
  z=1;
  while( z<= n)
  {
   if( k & 01 == 1)
   ERG = ecgf2sum( G, a1, a2, a3, a4, a6, ERG, P1);
   k >>=1; z <<=1;
   P1 = ecgf2sum( G, a1, a2, a3, a4, a6, P1, P1);
  }
 }
 else {  
 VEC[1] = lcopy(P1);
/* 
 init 2
*/
  for( k=2; k<8; k++)  
  VEC[k]= ecgf2sum(G, a1, a2, a3, a4, a6, P1,VEC[k-1]);


/*
 init 3 
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
    ERG=ecgf2sum( G,a1,a2,a3,a4,a6,ERG,VEC[k]);
/* 
  'shift'
 */
    ERG=ecgf2doubp( G, a1, a2, a3, a4, a6, ERG);
    ERG=ecgf2doubp( G, a1, a2, a3, a4, a6, ERG);
    ERG=ecgf2doubp( G, a1, a2, a3, a4, a6, ERG);
    L= lred(L);
   } 
/*
 'last 3 bits'
*/  
    ERG= ecgf2sum( G, a1, a2, a3, a4, a6, ERG, VEC[lfirst(L)]);
    }
     return( ERG); 
};
