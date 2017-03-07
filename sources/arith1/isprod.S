/*M
.SH NAME
isprod - integer single-precision product

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isprod(A,b)
int A;
single b;

.SH DESCRIPTION
isprod() returns A * b.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      04.07.1991      ueberfl. Zuweisung c=0 beseitigt.  PS
	Version  3	06.06.1992	lcomp, linv -> lpmoc.  MC
   DATE isprod        : 890501.910715.921130
H*/

# include <_arith1.h>            

#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }     
#define lpmoc_start( AA ) { if ( AVAIL == _0 ) gc(); AA = AVAIL; }
/* Arbeitsweise dieser Macros: siehe Doku. von isum */

int isprod ( A , b )           /* unsafe A */
int A;
single b;
{
	single m,n;
    /***    A oder b Null    ***/
	if ( A==0 || b==0 )  return( 0 );
    /***    A einfach-genau    ***/
	if ( isatom(A) )  {
		sprod( A,b, &m,&n );
		if ( m==0 )  return( n );
		return(list2(n,m));
	}
    /***    A mehrfach-genau    ***/
	{
		single  a, c, u=0;
		list  CC, C;           

		init( CC );
		bind( A );   

		lpmoc_start( CC );

		do {
			a = lfirst( A ),  A = lred( A );
			sprod( a,b, &m,&n );
			c = n+u,  u = m;
			if  (c >= BASIS)      c -= BASIS, u++;
			else if (c <= -BASIS) c += BASIS, u--;
			lpmoc( C, c )
		}
		while ( A!=_0 );
		if ( u!=0 )  { lpmoc( C, u ) }     
		lsred( C, _0 );  

		return(CC);
	}
}
