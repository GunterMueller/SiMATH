/*M
.SH NAME
rcons - rational number construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rcons(A,B)
int A,B;

.SH DESCRIPTION
rcons() returns the (reduced) rational number A/B for B!=0.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rcons         : 890501
H*/


# include <_arith1.h>

rat rcons ( A, B )             /* unsafe A,B */
int A,B;
{
	list R;
	if ( A==0 )  return( 0 );
	bind( A );
	igcdcf( A,B, &A,&B );
	if ( isign(B) < 0 )  {
		bind( B );
		A = ineg(A);
		B = ineg(B);
	}
	R = list2( A,B );
	return( R );
}
