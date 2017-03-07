/*M
.SH NAME
flquot - floating point quotient

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flquot(f,g)
floating f,g;

.SH DESCRIPTION
For g!=0 flquot() returns f/g.
M*/
/*H    
	Version 1       18.03.91        Marc Conrad
   DATE flquot        : 910715
H*/

#include<_arith1.h>

floating flquot(f,g)  
floating f,g;
{
     /* Falls f=0 oder g=0 ist */       
	if (!f) return(0);    
        else {
		single exp;
		floating erg;
		
		bind ( f, g );  
		init ( erg );  

		exp = flexpo(f) - flexpo(g);    

		f = flmant(f);
		g = flmant(g);   
 
		erg = rtofl(rcons(f,g));         
		exp += flexpo(erg);     
		if ( exp >= BASIS ) floverflow( 5 );
		else if( exp <= -BASIS ) return( 0 ); 

		lsfirst(erg,exp);
		return ( erg );      
		}
}	
