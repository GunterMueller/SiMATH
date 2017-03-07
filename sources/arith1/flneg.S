/*M
.SH NAME
flneg - floating point negation

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flneg(A)
floating A;

.SH DESCRIPTION
flneg() returns -f.
The calculation is exact, i.e. independent of FL_EPS.
M*/
/*H
	Version  1 	18.03.91	Marc Conrad
   DATE flneg         : 910715
H*/


# include <_arith1.h>

floating flneg ( f )      
floating f;
{
	if ( !f )  return( 0 );
	{
		single a;
		list g;
		bind( f );   
		init(g);   
                                
		/* Exponent */
		a = lfirst(f);
		f = lred(f);     
		g = list1(a);
                
		/* Mantisse negieren */
		while ( f != _0 ) { 
			a = lfirst( f );  
			f = lred( f );    
                 	g = lcomp(-a,g);
                        }
		return(linv(g));
	}
}
