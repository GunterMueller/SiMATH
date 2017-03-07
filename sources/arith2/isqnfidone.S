/*M
.SH NAME
isqnfidone - is quadratic number field ideal one?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfidone(D, A)  
int D; 
list A;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B A
is an ideal in the ring of integers O_K of the field K (for representation of ideals s. qnfidprod).
.PP
isqnfidone returns
.TP 4
1,
if A is the unit ideal, and
.TP 4
0,
else.

.SH SEE ALSO
qnfidprod 

M*/
                        
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE isqnfidone    : 931130
H*/

#include <_arith2.h>

isqnfidone( D, A )
int  D;
list A;
{
  bind( D, A );

  if( lfirst( A ) == 1 ) 
  { 
      single s;
      int    b, c;

      init( b, c );

      b = lsecond( A );
      c = lthird ( A );
      s = lfourth( A );

      if( ( ( s == 1 )  &&  ( b == 1 )  &&  !c )
       || ( ( s == 2 )  &&  ( b == 2 )  && ( c == 1 ) ) )
      {
	  /***  A = [ 1, 1, 0, 1 ]  <-->  Z + D^(1/2) * Z  oder  ***/
	  /***  A = [ 1, 2, 1, 2 ]  <-->  Z + (1+D^(1/2))/2 * Z  ***/
	  return( 1 );
      }
   }
   return( 0 );
}
