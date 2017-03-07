/*M
.SH NAME
flinit - floating point initialisation

.SH SYNOPSIS
.nf
#include<_arith1.h>

single flinit(k)
single k;

.SH DESCRIPTION
flinit() returns the current value of the global
constant FL_EPS and set it's new value. FL_EPS+1
is the maximum length of the lists used for
the internal representation of floating point
numbers. The first entry represents the exponent,
the tail of the list represents the mantissa.
.PP
.TP 4
.B k >= 0
will set the precision to k decimal places,
.nf
i.e. compute a value for FL_EPS that fulfils
1/2 * (2^30)^( 1 - FL_EPS ) < 1/2 * 10^( 1 - k ).  
.TP 4
.B k < 0
will directly set the value of FL_EPS, i.e.
the maximum length of the lists.
M*/
/*H
	Version 1	25.03.91	Marc Conrad
   DATE flinit        : 910715
H*/

#include<_arith1.h>
single flinit(k)  
single k;     
{	
	FL_EPS = ( (k)<0 ?  -(k) : (int) 
	floor(((k)+1) * 0.1107309364962455 ) + 2);  
	return( FL_EPS ); 
}
