/*M
.SH NAME
upid4cubres - univariate polynomial over integers of degree 4 cubic resolvent

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol upid4cubres( P )  
pol P;
    
.SH DESCRIPTION
.TP 4
.B P
is an univariate, irreducible and monic polynomial over Z of degree 4.
.PP
For a polynomial in the form
.PP
  x^4 - s*x^3 + p*x^2 - q*x + n 
.PP
upid4cubres computes and returns the cubic resolvent, according to the furmula
.PP
  L(y) = y^3 - p*y^2 + (s*q-4*n)*y + (-s^2*n+4*p*n-q^2).

.SH SEE ALSO
Literature: J. Buchmann and D. Ford: 
            On the computation of totally real quartic 
            fields of small discriminant, 
            M. o. C. V.52.  p.161-174.   

M*/
                                   
/*H
	Version 1       25.05.1993      Joachim Stein
   DATE upid4cubres   : 931130
H*/

#include <_arith2.h>

list upid4cubres( P )

list P;                     

{    
  int    k[4];             /* die Koeffizienten des Polynoms            */
  int    h1,h2;            /* Hilfsvariablen                            */
  int    s,p,q,n;          /* Hilfsvariablen fuer Polynom-Koeffizienten */
  single i;                /* Laufvariable                              */

  bind( P );
  init( k[0..3] );
  init( h1, h2 );           
  init( s, p, q, n );           

/** Berechnung der Koeffizienten **/ 
  do
  {
    h1 = lfirst( P );
    h2 = lsecond( P );                                    
    if ( h1 ==  3 ) s =  h2;
    if ( h1 ==  2 ) p =  h2;
    if ( h1 ==  1 ) q =  h2;
    if ( h1 ==  0 ) n =  h2;
    P = lred2( P );
  }
  while ( P != _0 );

  s = ineg( s );
  q = ineg( q );

/** Berechnung der Koeffizienten der kubischen Resolvente **/
  k[3] = 1;
  k[2] = ineg( p );        
         h1 = iprod( s, q );          
         h2 = isprod( n, 4 );
  k[1] = idif( h1, h2 );          
         h1 = iexp( s, 2 );
         h1 = iprod( h1, n );
         h2 = iprod( p, n );
         h2 = isprod( h2, 4 );
         h1 = idif( h2, h1 );
         h2 = iexp( q, 2 );
  k[0] = idif( h1, h2 );

/** Polynom in rekursiver Darstellung **/
  P = _0;
  for ( i = 0; i <= 3; i++ )
  {
    if ( k[i] )  P = lcomp2( i, k[i], P );
  }
/** Polynom der kubischen Resolvente in rekursiver Darstellung - Ende **/
return( P );
}                         

