/*M
.SH NAME
ecmpsnfmontmul - elliptic curve over modular primes short normal form Montgomery
multiplication
.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsnfmontmul(p, a4, a6, n, coord)

int  n, p, a4, a6;
list coord;

.SH DESCRIPTION
Let P be a point in projective representation on the elliptic curve
.TP 8
      E : y^2 = x^3 + a4x + a6
.PP
hence P=(x,y,z). If coord is the list (x,z) this
function will return the x-coordinate of n*P as a list of two
elements (x_(nP),z_(nP)). The x-coordinate of n*P is then x_(nP)/z_(nP).
.TP 4
.B p
is a prime greater or equal 3
.TP
.B a4, a6
are the coefficients of E
.TP 4
.B n
is a non-negativ integer
.TP 4
.B coord
is a list of 2 elements of Z/pZ.
M*/
/*H
    Version 1        01.11.1997      Emanuel Herrmann
    DATE ecrinit   : 971201
H*/


#include<_ec2.h>

/********* ___ecmpsnf_add_spec **************/

static list ___ecmpsnf_add_spec(p,a4,a6, P, P_minus_Q, Q)

int p, a4, a6;
list P, Q, P_minus_Q;
{

 int tmp1, tmp2, tmp3, tmp4;
 int x_diff, z_diff, x_P;
 int x_Q, z_P, z_Q;

 bind(p, a4, a6, P, P_minus_Q, Q);

 init( tmp1, tmp2, tmp3, tmp4);
 init( x_diff, z_diff, x_P, x_Q, z_P, z_Q);

 x_P =  lfirst(P);
 z_P = lsecond(P);

 if( z_P == 0)
   return( Q);

 x_Q =  lfirst(Q); 
 z_Q = lsecond(Q);

 if( z_Q == 0)
   return(P);
/*
  x_P+Q
*/
 x_diff =  lfirst( P_minus_Q);
 z_diff = lsecond( P_minus_Q);
 if( z_diff == 0 )
   return(___ecmpsnfdp(p, a4, a6, P));

 tmp1 = miprod( p, x_P, x_Q);
 tmp2 = miprod( p, z_P, z_Q);
 tmp1 =  midif( p, tmp1, miprod(p, a4, tmp2));
 tmp1 = miprod( p, tmp1, tmp1);
 
 tmp2 = miprod( p, a6, miprod( p, z_P, z_Q));
 
 tmp3 = miprod( p, x_P, z_Q);
 tmp3 = misum( p, tmp3, miprod(p,x_Q,z_P));
 tmp2 = miprod(p, tmp2, tmp3);

 tmp2 = miprod( p, 4, tmp2);

 tmp2 = midif(p,tmp1, tmp2);
 tmp2 = miprod(p, tmp2, z_diff);
 
/*
 z_P+Q
*/
  tmp1 = miprod( p, x_P, z_Q);
  tmp1 = midif( p, tmp1, miprod( p, x_Q, z_P));
  tmp1 = miprod( p, tmp1, tmp1);
  tmp1 = miprod( p, tmp1, x_diff);
 

 return( list2(tmp2, tmp1));
};

/************ ___ecmpsnfdp  *************/

list ___ecmpsnfdp(p, a4, a6, P)

int p, a4, a6;
list P;
{

 int x, y, z, x2,z2, z3,z4,den, tmp, rs;
 list _Point;

 bind( p, a4, a6, P);
 init( x, y, z, x2,z2, z3,z4,den, tmp, rs);
 init(_Point);

 x = lfirst(P);
 z = lsecond(P);
 if( z == 0)
   return( list2(0,0));

 z2 = miprod(p,z,z);
 z3 = miprod(p,z, z2);
 z4 = miprod(p,z2,z2);

 x2  = miprod(p,x,x);
 y   = miprod(p,x2,x);
 y   =  misum(p,y,miprod(p,a6,z3)); 
 tmp = miprod(p,x,miprod(p,a4, z2));
 y   = misum(p,y,tmp);


/* formula of Montgomery */
/*    left-hand side     */

 den =  misum(p, y,y);
 den =  misum(p, den, den);
 den = miprod(p, den, z);
 
 /* right-hand side */
 
 rs = midif( p, x2, miprod(p, a4, z2));
 rs = miprod( p, rs, rs);
 
 tmp = miprod( p, 8, a6);
 tmp = miprod( p, tmp, x);
 tmp = miprod( p, tmp, z3);
 rs  =  midif( p, rs, tmp);

 _Point=list2(rs,den);

 return(_Point);
 
}

/*********** ecmpsnfmontmul ************/


list ecmpsnfmontmul( p,a4, a6, n, P1)
int n;
int a4, a6;
list P1;
{
 list P2, Pn, P_diff;
 int h, m;

 bind( a4, a6, n, P1, p );
 init( P2, Pn, P_diff,h,m  );


 m  = 1;
 h  = n;
 P2 = lcopy( P1 );
 Pn = list2( 0,0);

 P_diff = P1;

 while (icomp(m, n) <= 0)
 {
  if(mshom(2, h) == 1){
    Pn = ___ecmpsnf_add_spec(p,a4,a6, Pn, P_diff, P2);}
  else{
   P_diff= ___ecmpsnf_add_spec(p,a4,a6, P_diff, Pn, P2);}

 m = isprod(m, 2);
 h = isquot(h, 2);

 P2 = ___ecmpsnfdp(p, a4, a6, P2);
 }
 return( Pn );
};

