/*M
.SH NAME
flpow - floating point power

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flpow(f,g)
floating f,g;

.SH DESCRIPTION
For f >=0 flpow() returns f^g.
By definition 0^0 = 1 and 0^g = 0 if g is not equal to 0.
M*/

/*H
	Version 1	09.12.1992	Marc Conrad     
   DATE flpow         : 930115
H*/


#include<_arith1.h>

floating flpow(b, a)
	floating b, a;
{
	floating c;   
	single rette_eps;

	bind(b, a);
	init(c );          

	if (!a ) return ( itofl( 1 ) );
	else if ( !b ) return ( 0 );

	rette_eps = FL_EPS;               
  
	c = flprod( a, itofl( flexpo( b ) ) );   
	c = flabs ( c );
	if ( flcomp( c, itofl( 1<<25 ) ) > 0 ) 	FL_EPS += 2;     
	else FL_EPS += 1;                 

	c = fllog(b);        
	FL_EPS = BASIS - 1;
	b = flprod(a, c);
        
	FL_EPS = rette_eps;
	b = flexp(b);

	return (b);
}

