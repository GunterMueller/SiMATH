/*M
.SH NAME
ilcomb - integer linear combination

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ilcomb(A,B,m,n)
int A,B;
single m,n;

.SH DESCRIPTION
For A,B,m,n with  A*m + B*n >=0
ilcomb() returns A*m + B*n.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE ilcomb        : 890501
H*/


# include <_arith1.h>

int ilcomb ( A, B, m, n )              /* unsafe A,B */
int  A,B;
single  m,n;
{
	single  a,a0,a1, b,b0,b1, c;
	list  C=_0;
	double  d0, d1=0;
    /***    Initialisierung    ***/
	bind( A ); bind( B );
	if ( isatom(A) )  A = list1( A );
	if ( isatom(B) )  B = list1( B );
    /***    Arithmetik    ***/
	do {    if ( A==_0 )  a = 0;
		else  a = lfirst( A ), A = lred( A );
		if ( B==_0 )  b = 0;
		else  b = lfirst( B ), B = lred( B );
		sprod( a,m, &a1,&a0 );
		sprod( b,n, &b1,&b0 );
		d0 = a0 + b0 + d1;
		d1 = a1 + b1;
		while (d0 < 0)  d0 += BASIS, d1--;
		if (d0>=BASIS)  d0 -= BASIS, d1++;
		c = d0,  C = lcomp( c,C );
	}
	while ( A!=_0 || B!=_0 );
	if ( d1!=0 )  if ( (c=d1)<BASIS )  C = lcomp( c,C );
		      else  C = lcomp2( 1, c-BASIS, C );
    /***    Normalisieren    ***/
	while ( C!=_0 && lfirst(C)==0 )  C = lred( C );
	if ( C==_0 )  return( 0 );
	if ( lred(C)==_0 )  return(lfirst(C));
	return(linv(C));
}
