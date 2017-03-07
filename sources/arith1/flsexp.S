/*M
.SH NAME
flsexp - floating point single exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsexp(f,n)
floating f;
single n;

.SH DESCRIPTION
flsexp() returns f^n, 
provided that f is not 0 in case n is <0.
By definition 0^0 equals 1.
M*/
/*H
	Version 1	31.04.91	Marc Conrad
	Version 2       19.08.91        vergessenen Fall n=-1 eingefuegt.  MC
   DATE flsexp        : 910715.910915
H*/

#include <_arith1.h>
floating flsexp ( f, n )            
floating f;
single n;               
{
    if ( !n )  return( list2(0,1));
    else if ( n==1 || !f )  return( f );
    else if ( n == -1 )  {
	bind( f );
	return ( flquot( list2(0,1), f ) );	
	}
    else {
	floating erg;
	single epsbak;     

	bind( f );   
	init( erg );       

	epsbak = FL_EPS;   
	FL_EPS++;
	if ( n > (1<<25) ) FL_EPS++;
	if (n < 0) {     
		FL_EPS++; 
		f = flquot( list2(0,1), f );
		    n = -n;        
	   	    }

	if (n%2) erg = f;
	else erg = list2(0,1);
	n /= 2;                

	while ( n > 1 )  {   
		f = flprod( f,f );     
		if (n%2)  erg = flprod( erg,f );   
		n /= 2;        
		}          

	f = flprod( f, f );                                        
	FL_EPS = epsbak;      
	erg = flprod(erg, f);
		return( erg );
	}
}
