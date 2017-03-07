/*M
.SH NAME
isqnfppihom0 - is quadratic number field element power of prime ideal homomorphism zero?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfppihom0(D, P, k, pi, z, b)
int D; 
list P; 
single k, z; 
nfel pi, b;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
.PP
Let K = Q(D^(1/2)) be a quadratic number field, and let O_K be the ring of integers of K.
.TP 4
.B P
is a prime ideal in O_K (for the representation of ideals s. qnfidprod).
.TP 4
.B k
is an integer number, k > 0.
.TP 4
.B pi
is a locally uniformizing parameter of P.
.TP 4
.B z 
specifies the law of decomposition of p, i.e z = 0, 1 or 2 for p in K inertial, ramified or split respectively.
.TP 4
.B b 
is an element of K (for representation of number field elements s. fputnfel), which is integer with respect to P, i.e. v_P(b) >= 0.
.IP
(Here, v_P() denotes the non archimedean valuation with regard to P.)
.PP
isqnfppihom0 returns
.TP 4
1,
if b = 0 modulo P^k, i.e. v_P(a) >= k, or
.TP 4
0,
else.

.SH SEE ALSO
 qnfidprod
 fputnfel

M*/
  
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE isqnfppihom0  : 931130
H*/

#include <_arith2.h>

single isqnfppihom0( D, P, k, pi, z, a )
int    D;
list   P;
single k, z;
nfel   pi, a;
{

    if( !a ) 
    {
	/*** 0 == 0 mod P fuer alle P ***/
        return( 1 );
    }
    else
    {
	single i;
        nfel b;
	
        bind( P, D, pi, a );
	init( b );
	
	i = k;
	b = a;

	while( 1 )
	{
	    if( qnfpihom( D, P, pi, z, b ) )
	    {
		return( 0 );
	    }
	    i--;
	    
	    if( !i )
	    {
	        return( 1 );
	    }

	    b = qnfquot( D, b, pi );
        }
    }
}
