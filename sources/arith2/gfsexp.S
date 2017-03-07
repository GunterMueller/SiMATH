/*M
.SH NAME
gfsexp - Galois-field with single characteristic exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsexp(p, AL, a, m)  
single p, m; 
list AL; 
gfel a; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a
is an element of GF(p^n).
.TP 4
.B m
is an integer number, 0 <= m < BASIS.
.PP
gfsexp returns an element of GF(p^n), say b, where
.IP
b = a^m.
   
.SH SEE ALSO
gfsalgen

M*/
        
/*H
	Version 1       19.06.1989               V. Schwinn
   DATE gfsexp        : 890801
H*/


# include <_arith2.h>

gfel gfsexp(p, AL, a, m)
single p;
list AL;
gfel a;
single m;

{ single m1;
  gfel ERG, sum;
                 
  init( ERG, sum );
  bind( AL, a);


  /***    Spezialfall : Ergebnis 0    ***/
  if ( a==0 && m>0 ) return(0);

  /***    allgemeiner Fall, d.h. Ergebnis != 0    ***/
  ERG = list2( 0, 1 );
  sum = a;
  m1 = m;

  while ( m1 != 0 ) 
  { if ( sodd(m1) ) ERG = gfsprod(p, AL, ERG, sum );
    sum = gfsprod( p, AL, sum, sum );
    m1 = divs( m1 , 2 );
  }         

  return(ERG);
}
