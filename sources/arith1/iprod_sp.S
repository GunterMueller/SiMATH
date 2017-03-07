/*M
.SH NAME
iprod_sp - integer product, special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iprod_sp(A,B,l1,l2)
int A,B;
single l1,l2;

.SH DESCRIPTION
iprod_sp() returns A*B.
This program is only called internally by iprod()
to achieve fast calculations for l1<=20 or l2<=20.
.PP
.TP 4
.B l1, l2
>1, are the lengths of the list representations of A and B.
M*/

/*H
	Version  1      26.09.1990      U.Schneiders
					(leicht veraendertes altes iprod)
   DATE iprod_sp      : 901120
H*/


# include <_arith1.h>

int iprod_sp( A, B, l1, l2 )
int A, B;
single l1, l2;
{
    /***    A und B mehrfach-genau    ***/
	register l;
	single  a,b, c,d,u;
	list  A1, C, C1, C2, E;
	bind( A, B );

   /***    Vorbesetzungen    ***/
       if ( l1 < l2 )
       C = B,  B = A,  A = C;
       C = E = list2( 0,0 );
       for  ( l = l1+l2-2 ; l-- ; C = lcomp(0,C) );
   /***    A * Komponente von B aufsummieren    ***/
       for ( C1=C ; B!=_0 ; C1 = lred(C1) )  {
	       A1 = A;
	       b = lfirst( B ),  B = lred( B );
	       if ( b )  {
		       C2 = C1,  u = 0;
		       do {    a = lfirst( A1 ),  A1 = lred( A1 );
			       sprod( a,b, &d,&c );
			       c += u;
			       if      (c >= BASIS) c -= BASIS, u=  1;
			       else if (c <=-BASIS) c += BASIS, u= -1;
			       else  u = 0;
			       c += lfirst( C2 );
			       if      (c >= BASIS)  c -= BASIS, u++;
			       else if (c <=-BASIS)  c += BASIS, u--;
			       lsfirst( C2,c );
			       u += d;
			       C2 = lred( C2 );
		       }
		       while ( A1!=_0 );
		       lsfirst( C2,u );
	       }
       }
   /***    fuehrende Null    ***/
       if ( u==0 )  lsred( E,_0 );
       return( C );
}
