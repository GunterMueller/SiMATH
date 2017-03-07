/*M
.SH NAME
qnfidcomp - quadratic number field ideal comparison

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfidcomp( D, A, B )  
int D; 
list A, B;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B A, B
are ideals in the ring of integers O_K of the field K (for representation of ideals s. qnfidprod).
.PP
qnfidcomp returns 
.PP
 0, if A and B are equal in O_K,
 1, else.

.SH SEE ALSO
qnfidprod

M*/

/*H
        Version 1	14.10.1993      Josef Gebel
   DATE qnfidcomp     : 931130
H*/

#include <_arith2.h>

qnfidcomp( D, A1, A2 )
int  D; 
list A1, A2;
{
    bind( D, A1, A2 );

    if( ( icomp( lfirst( A1 ), lfirst( A2 ) ) )
     || ( lfourth( A1 ) != lfourth( A2 ) ) )
    {
	/***   A1 und A2 verschieden   ***/
	return( 1 );
    }
    else
    {
	int Q1, Q2;

	init( Q1, Q2 );

	Q1 = lsecond( A1 );
	Q2 = lsecond( A2 );

	if( icomp( Q1, Q2 ) )
	{
	    /***   A1 und A2 verschieden   ***/
	    return( 1 );
	}
	else
	{
	    int P1, P2;

	    init( P1, P2 );
    
	    P1 = lthird( A1 );
	    P2 = lthird( A2 );

	    P1 = idif( P1, P2 );
	    P2 = mihom( Q1, P1 );

	    if( P1 )
	    {
		return( 1 );
	    }
	    return( 0 );
        }
    }
}
