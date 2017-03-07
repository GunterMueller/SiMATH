/*M
.SH NAME
isupid4real - is univariate polynomial over integers of degree 4 real ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isupid4real( P )  
list P;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate, monic and irreducible polynomial over Z, deg(P) = 4.
.PP
Let P = x^4 - s*x^3 + p*x^2 - q*x + n, with integer coefficients s, p, q, n.
.PP
Then isupid4real verifies, whether the following conditions hold.  
.TP 4
C1)
p - 3/8*s^2  < 0,
.TP 4
C2)
p^2 - s^2*p + 3/16*s^4 + s*q - 4*n > 0, and
.TP 4
C3)
4*(p^2 - 3*s*q + 12*n)^3 - (2*p^3 - 72*p*n + 27*s^2*n - 9*s*p*q + 27*q^2)^2 > 0 .
.PP
i.e. whether P = 0 has 4 real roots and consequently generates a real quartic number field.
.PP
isupid4real returns
.TP 4
1,
if the conditions C1), C2) and C3) hold, and
.TP 4
0,
else.
  
.SH SEE ALSO
Literature: B.N. Delone and D.K. Faddeev: 
            The Theory of Irrationalities of the third 
            degree, p.184.
     
M*/
               
/*H
	Version 1       19.05.1993      Joachim Stein
   DATE isupid4real   : 931130
H*/

#include <_arith2.h>

single isupid4real( P )

list P;                     

{
  int h1,h2;                    /* Hilfsvariablen                            */
  rat s,p,q,n;                  /* Hilfsvariablen fuer Polynom-Koeffizienten */
  rat R1,R2,R3,R3a,Rh,Rhh;      /* Hilfsvariablen fuer reell-Bedingungen     */
  single i;                     /* Laufvariable                              */

  bind( P );
  init( h1, h2 );           
  init( s, p, q, n );           
  init( R1, R2, R3, R3a, Rh, Rhh );

/** Berechnung der Koeffizienten **/ 
  do
  {
    h1 = lfirst( P );
    h2 = lsecond( P );                                    
    if ( h1 ==  3 ) s = itor( h2 );
    if ( h1 ==  2 ) p = itor( h2 );
    if ( h1 ==  1 ) q = itor( h2 );
    if ( h1 ==  0 ) n = itor( h2 );
    P = lred2( P );
  }
  while ( P != _0 );

  s = rneg( s );
  q = rneg( q );

/** Berechnung der reel - Bedingungen **/
  R1 = rexp( s, 2 );
  Rh = list2( 3, 8 );
  R1 = rprod( R1, Rh );
  R1 = rdif( p, R1 );
  if ( rsign( R1 ) != -1 ) return( 0 );
 
  R2 = rexp( p, 2 );
  Rh = rexp( s, 2 );
  Rh = rprod( Rh, p );
  R2 = rdif( R2, Rh );  
  Rh = list2( 3, 16 );
  Rhh = rexp( s, 4 );
  Rh = rprod( Rh, Rhh );
  R2 = rsum( R2, Rh ); 
  Rh = rprod( s, q );
  R2 = rsum( R2, Rh ); 
  Rh = itor( 4 );
  Rh = rprod( Rh, n );
  R2 = rdif( R2, Rh );  
  if ( rsign( R2 ) != 1 ) return( 0 );

/** Berechnung der Diskriminante - 3. reel-Bedingung **/
  R3 = rexp( p, 2 );
  Rh = itor( 3 );
  Rh = rprod( Rh, s );
  Rh = rprod( Rh, q );
  R3 = rdif( R3, Rh );  
  Rh = itor( 12 );
  Rh = rprod( Rh, n );
  R3 = rsum( R3, Rh );  
  R3 = rexp( R3, 3 );
  Rh = itor( 4 );
  R3 = rprod( R3, Rh );

  
  R3a = rexp( p, 3 );
  Rh = itor( 2 );
  R3a = rprod( R3a, Rh );

  Rh = itor( 72 );
  Rh = rprod( Rh, p );
  Rh = rprod( Rh, n );
  R3a = rdif( R3a, Rh );

  Rh = itor( 27 );
  Rhh = rexp( s, 2 );
  Rh = rprod( Rh, Rhh );
  Rh = rprod( Rh, n );
  R3a = rsum( R3a, Rh );

  Rh = itor( 9 );
  Rh = rprod( Rh, s );
  Rh = rprod( Rh, p );
  Rh = rprod( Rh, q );
  R3a = rdif( R3a, Rh );
               
  Rh = itor( 27 );
  Rhh = rexp( q, 2 );
  Rh = rprod( Rh, Rhh );
  R3a = rsum( R3a, Rh ); 

  R3a = rexp( R3a, 2 );    

  R3 = rdif( R3, R3a );  
  if ( rsign( R3 ) != 1 ) return( 0 );

  return( 1 );
}                         
