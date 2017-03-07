/*M
.SH NAME
flsquot - floating point single quotient

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsquot(f,n)
floating f;
single n;

.SH DESCRIPTION
for n!=0 flsquot() returns f/n.
M*/
/*H    
	Version 1 	05.04.91	Marc Conrad.
   DATE flsquot       : 910715
H*/

#include<_arith1.h>

floating flsquot(f,n)  
floating f;       
single n;
{
     /* Falls f=0 oder n=1 ist */       
	if (!f) return(0); 
	else if ( n == 1) return( f );   
        else {
		single exp, lf;
		floating erg;
		
		bind ( f );
		init ( erg );    

		exp = flexpo(f);
                f = lred( f );
                lf = llength(f);
		while (lf < FL_EPS + 2  ) 
			lf++, f = lcomp(0,f), exp--;    
		isqrem(f,n,&erg,&lf);
		lf = ( issingle(erg) ? 1 : llength(erg) );
   
		return ( flcut( erg, exp, lf ) );      
		}              
}
