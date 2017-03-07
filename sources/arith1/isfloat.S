/*M
.SH NAME
isfloat - is floating point ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isfloat(A)
obj A;

.SH DESCRIPTION
isfloat() returns 1 if A is a floating point number,
0 otherwise.
M*/
/*H
	Version 1       25.03.91        Marc Conrad
   DATE isfloat       : 910715
H*/

#include <_arith1.h>  

single isfloat( f ) 
obj f;
{       
	single a;

	bind ( f );        
	
	if (!f) a=1;
	else if (!islist( f ) || f==_0) a=0;     
	else if (!issingle( lfirst(f) ) ) a=0;
	else { 
		f =  lred( f );
                if ( f == _0 ) a=0;
		else if ( !lfirst( f ) ) a=0;   
		else if ( isint( f ) ) a=1;
		else if ( !issingle(lfirst(f)) ) a=0;
		else if ( lred( f ) == _0 ) a=1;
		else a=0;
		}      
	return( a );
	}
		
