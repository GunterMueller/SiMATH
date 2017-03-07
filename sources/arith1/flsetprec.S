/*M
.SH NAME
flsetprec - floating point set precision

.SH SYNOPSIS
.nf
#include<_arith1.h>

single flsetprec(k,N)
single k;
int N;

.SH DESCRIPTION
flsetprec() returns the current value of the global
constant FL_EPS and set it's new value. See the
documentation of flinit() for further details.
.PP
.TP 4
.B N > 0
will compute a value for FL_EPS that fulfils
.nf
1/2 * (2^30)^( 1 - FL_EPS ) <  1 / ( N * 2^k )
i.e. the relative error of all following
floating point operations will be at most
| ( x - f ) / x | < 1 / ( N * 2^k )
.TP 4
.B N <= 0
will directly set the value of FL_EPS, i.e.
the maximum length of the lists to |k|.

.SH SEE ALSO
flinit()
M*/
/*H
	Version 1       11.09.1991      Marc Conrad
   DATE flsetprec     : 911215.9203__
H*/

#include<_arith1.h>

single flsetprec( k, N )
single k;
int N;
{
bind( N );  
                    
if ( isign( N ) > 0 )
	FL_EPS =  ( (k - 1) + ilog2( N ) )/30 + 2;       
else FL_EPS = sabs( k );

return ( FL_EPS );
}
