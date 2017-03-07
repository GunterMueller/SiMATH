/*M
.SH NAME
iprod_lo - integer product, lists only

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iprod_lo(A,B)
int A,B;

.SH DESCRIPTION
iprod_lo() returns A * B.
The computation is performed within the SIMATH memory
management only, i.e. with lists only.
M*/
/*H
	Version  1      14.02.1992	Marc Conrad (altes iprod)
   DATE iprod_lo      : 920331
H*/


# include <_arith1.h>

static int _iprod_lo(int, int);

int iprod_lo( A, B )             /* unsafe A,B */
int A, B;
{
    /***    Sonderfaelle    ***/
	if ( A==0 || B==0 )  return( 0 );
	if ( isatom(A) )  return(isprod(B,A));
	if ( isatom(B) )  return(isprod(A,B));
    /***    A und B mehrfach-genau    ***/
	return(_iprod_lo(A,B));
}

static int _iprod_lo(int A, int B) {
    single  l1, l2;

    bind( A, B );

    l1 = llength( A );  l2 = llength( B );
    if( l1>20 && l2>20 )   /* Konst. 20 heuristisch erhalten */
	return(iprodk_sp( A, B, l1, l2 ));
    else
	return(iprod_sp( A, B, l1, l2 ));
}

