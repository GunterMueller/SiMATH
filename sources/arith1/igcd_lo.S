/*M
.SH NAME
igcd_lo - integer greatest common divisor, lists only

.SH SYNOPSIS
.nf
#include<_arith1.h>

int igcd_lo(A,B)
int A,B;

.SH DESCRIPTION
igcd_lo() returns the greatest common divisor of A and B.
The computation is performed within the SIMATH memory
management only, i.e. without using the Essen Arithmetic
Package.
M*/
/*H
	Version  1      14.02.1992	Marc Conrad (altes igcd)
   DATE igcd_lo       : 920331
H*/


# include <_arith1.h>

int igcd_lo ( A, B )
int A,B;
{
    /***    Initialisierung    ***/
	int C;
	bind( A, B );
	A = iabs(A),  B = iabs(B);
	if ( icomp(A,B)<0 )  C=A, A=B, B=C;
	if ( isatom(A) )  {
		return(sgcd(A,B));
	}
    /***    Folge der Reste    ***/
	{
	    int D;
	    single m,n;
	    init( C, D );
	    while ( B )  {
		    m = ilog2(A),  n = ilog2(B);
		    if ( m-n >= (BLOG2>>1) )  C=B, D=irem(A,B);
		    else {
			single  a,b,c, k,q, u1,u2,u3, v1,v2,v3;
			k = m-BLOG2;
			a = ip2quot( A,k ),  b = ip2quot( B,k );
			u1=v2=1,  u2=v1=0;
			for ( ; ; ) {
				q = a/b,  u3 = u1-q*u2;
				c = a%b,  v3 = v1-q*v2;
				if ( c < sabs(v3) || b-c < sabs(v2-v3) )  break;
				a = b,  b = c;
				u1 = u2,  u2 = u3;
				v1 = v2,  v2 = v3;
			}
			if ( v1==0 )  C=B, D=irem(A,B);
			else  {  C = ilcomb( A,B, u1,v1 );
				 D = ilcomb( A,B, u2,v2 );
			}
		    }
		    if ( isatom(C) )  A=sgcd(C,D), B=0;
		    else  A=C, B=D;
	    }
	    return( A );
	}
}
