/*M
.SH NAME
iprodk_sp - integer product Karatsuba, special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iprodk_sp(A,B,l1,l2)
int A,B;
single l1,l2;

.SH DESCRIPTION
iprodk_sp() returns A*B.
This program is only called internally by iprod()
to achieve fast calculations for l1>20 and l2>20.
.PP
.TP 4
.B l1, l2
>1, are the lengths of the list representations of A and B.
M*/

/*H
	Version  1      26.09.1990      U.Schneiders
	Version  2      17.12.1990      U.Schneiders ( Fehler verbessert )
   DATE iprodk_sp     : 901120.901220
H*/


# include <_arith1.h>

int iprodk_sp( A, B, l1, l2 )
int A, B;
single l1, l2;
{
       single a, b, i, k, k1, k2, n1, n2;
       list  A0, B0, Z, Z0, Z1;
       bind( A, B );
       init( A0, B0, Z, Z0, Z1 );

       /*** Aufteilung von A in ( A0, A ) und von B in ( B0, B ) ***/

       k = smax( l1, l2 ) / 2;
       n1 = 0; n2 = 0;
       if( k == 1 )
       {       A0 = lfirst( A );
	       A = lred( A );
	       B0 = lfirst( B );
	       B = lred( B );
       }
       else
       {       A0 = _0;  B0 = _0;
	       if( k >= l1 )
	       {        A0 = A;
			for( i = 0; i < k; i++ )
			{       b = lfirst( B );
				B = lred( B );
				B0 = lcomp( b, B0 );
			}
			while( !( b = lfirst( B0 ) ) )
			{       n2++;
				B0 = lred( B0 );
				if( B0 == _0 ) break;
			}
			B0 = linv( B0 );
			A = 0;
	       }
	       else if( k >= l2 )
	       {        B0 = B;
			for( i = 0; i < k; i++ )
			{       a = lfirst( A );
				A = lred( A );
				A0 = lcomp( a, A0 );
			}
			while( !( a = lfirst( A0 ) ) )
			{       n1++;
				A0 = lred( A0 );
				if( A0 == _0 ) break;
			}
			A0 = linv( A0 );
			B = 0;
	       }
	       else
	       {        for( i = 0; i < k; i++ )
			{       a = lfirst( A );
				A = lred( A );
				A0 = lcomp( a, A0 );
				b = lfirst( B );
				B = lred( B );
				B0 = lcomp( b, B0 );
			}
			while( !( a = lfirst( A0 ) ) )
			{       n1++;
				A0 = lred( A0 );
				if( A0 == _0 ) break;
			}
			while( !( b = lfirst( B0 ) ) )
			{       n2++;
				B0 = lred( B0 );
				if( B0 == _0 ) break;
			}
			A0 = linv( A0 );  B0 = linv( B0 );
	       }
       }

       if( A0 == _0 )
       {        A0 = 0;
		k1 = 1;
       }
       else if( ( k1 = smin( k, l1 ) - n1 ) == 1 )
		A0 = lfirst( A0 );

       if( B0 == _0 )
       {        B0 = 0;
		k2 = 1;
       }
       else if( ( k2 = smin( k, l2 ) - n2 ) == 1 )
		B0 = lfirst( B0 );

       if( l1 > k ) l1 = l1 - k;
       else         l1 = 0;
       if( l2 > k ) l2 = l2 - k;
       else         l2 = 0;

       /*** A*B ***/

       if( !l1 || !l2 ) Z1 = 0;
       else if( l1 == 1 && l2 == 1 )
       {        A = lfirst( A );
		B = lfirst( B );
		sprod( A, B, &a, &b );
		if( a ) Z1 = list2( b, a );
		else Z1 = b;
       }
       else if( l1 == 1 )
       {        A = lfirst( A );
		Z1 = isprod( B, A );
       }
       else if( l2 == 1 )
       {        B = lfirst( B );
		Z1 = isprod( A, B );
       }
       else if( l1 <= 20 || l2 <= 20 ) Z1 = iprod_sp( A, B, l1, l2 );
       else Z1 = iprodk_sp( A, B, l1, l2 );

       /*** A0 * B0 ***/

       if( !A0 || !B0 )  Z0 = 0;
       else if( k1 == 1 && k2 == 1 )
       {        sprod( A0, B0, &a, &b );
		if( a ) Z0 = list2( b, a );
		else Z0 = b;
       }
       else if( k1 == 1 )
		Z0 = isprod( B0, A0 );
       else if( k2 == 1 )
		Z0 = isprod( A0, B0 );
       else if( k1 <= 20 || k2 <= 20 ) Z0 = iprod_sp( A0, B0, k1, k2 );
       else Z0 = iprodk_sp( A0, B0, k1, k2 );

       /*** (A-A0) * (B-B0) ***/

       A0 = idif( A, A0 );
       B0 = idif( B, B0 );
       if( isatom( A0 ) ) k1 = 1;
       else               k1 = llength( A0 );
       if( isatom( B0 ) ) k2 = 1;
       else               k2 = llength( B0 );
       if( k1 == 1 && k2 == 1 )
       {        sprod( A0, B0, &a, &b );
		if( a ) A0 = list2( b, a );
		else A0 = b;
       }
       else if( k1 == 1 )
		A0 = isprod( B0, A0 );
       else if( k2 == 1 )
		A0 = isprod( A0, B0 );
       else if( k1 <= 20 || k2 <= 20 ) A0 = iprod_sp( A0, B0, k1, k2 );
       else A0 = iprodk_sp( A0, B0, k1, k2 );

       /*** Z = A*B0 + A0*B ***/

       Z = idif( Z0, A0 );
       Z = isum( Z1, Z );
                           
       /*** shiften ***/

       if( Z && isatom( Z ) ) Z = list1( Z );
       if( Z1 && isatom( Z1 ) ) Z1 = list1( Z1 );
       for( i = 0; i < k; i++ )
       {      if( Z )   Z = lcomp( 0, Z );
	      if( Z1 )
	      {     Z1 = lcomp( 0, Z1 );
		    Z1 = lcomp( 0, Z1 );
	      }
       }
       Z = isum( Z, Z1 );
       Z = isum( Z, Z0 );
       return( Z );
}
