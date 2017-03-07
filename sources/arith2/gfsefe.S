/*M
.SH NAME
gfsefe - Galois-field with single characteristic embedding in field extension

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsefe(p, ALm, a, g)  
single p; 
list ALm; 
gfel a, g;
  
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.PP
For n a natural number (1 < n <BASIS), let m be a natural number with n < m < BASIS and n divides m.
.TP 4
.B ALm
is the arithmetic list of GF(p^m), generated for example by gfsalgen.
.TP 4
.B a 
is an element in GF(p^n).
.PP
Let F be the isomorphic embedding of GF(p^n) into GF(p^m), given by gfalgenies, and let G be the seperable generator of GF(p^n) over GF(p). 
.TP 4 
.B g
as polynomial is equal to the F(G).
.PP
gfsefe returns the representation of a as an element of GF(p^m).
 
.SH SEE ALSO
 gfsalgen
 gfsalgenies

M*/
                    
/*H     
        Version 1       19.06.1989      V. Schwinn
	Version 1.1	07.10.1993	S.Schmitt/U.Schneiders ( 0 )
   DATE gfsefe        : 890801.9203__.931130
H*/

#include <_arith2.h>

gfel gfsefe( p, ALm, a, g )
single p;
list ALm;
gfel a, g;

{ single k, exp;                        /* exp = Exponent von a = a(t)  */
  gfel ERG, sum, koeff;                 /* Ergebn., Zwischensumme, Koef-  
                                           fizient von a(t) als gfel    */
  list Z;                               /* Hilfszeiger                  */
  if(!a)  return(0);
 
  bind( ALm, a, g );
  init( ERG, sum, koeff, Z );
        
  ERG = 0;
  sum = 0;         
  Z = a;

  while ( Z != _0 )
  { exp = lfirst( Z );
    Z = lred( Z );
    k = lfirst( Z );
    koeff = list2( 0, k );             
    Z = lred( Z );
    sum = gfsexp( p, ALm, g, exp );   
    sum = gfsprod( p, ALm, sum, koeff );
    ERG = gfssum( p, ALm, ERG, sum ); 
  }
 
  return( ERG );
}











