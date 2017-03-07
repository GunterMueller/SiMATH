/*M
.SH NAME
qnfelcomp - quadratic number field element comparison 

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfelcomp( D, a, b )  
int D; 
nfel a, b;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a, b
are elements of K ( for representation of number field elements s. fputnfel ). 
.PP
qnfelcomp returns 
.IP
 
 0, for a = b, 
 1, else.

.SH SEE ALSO
fputnfel

M*/
                         
/*H
        Version 1	14.10.1993      Josef Gebel
   DATE qnfelcomp     : 931130
H*/

#include <_arith2.h>

qnfelcomp( D, a, b )
int  D; 
nfel a, b;
{
    if( !a )
    {
	if( !b )
	{
	    /***   a = b = 0   ***/
	    return( 0 );
	}

	/***   a = 0, b != 0   ***/
	return( 1 );
    }
    if( !b )
    {
	/***   b = 0, a != 0   ***/
	return( 1 );
    }

    /***   Ab hier: a * b != 0 ***/
    
    bind( D, a, b );

    if( lsecond( a ) )
    {
	if( lsecond( b ) )
	{
	    /***   a und b beide nicht rational   ***/

	    if( icomp( lfirst( a ), lfirst( b ) ) )
	    {
		return( 1 );
	    }
	    if( icomp( lthird( a ), lthird( b ) ) )
	    {
		return( 1 );
	    }
	    if( icomp( lfourth( a ), lfourth( b ) ) )
	    {
		return( 1 );
	    }
	    return( 0 );
	}
	/***   a ist nicht rational, b rational    ***/
	return( 1 );
    }
    if( lsecond( b ) )
    {
	/***   a ist rational, b nicht rational    ***/
	return( 1 );
    }

    /***   Ab hier: a und b beide rational   ***/
    if( icomp( lfirst( a ), lfirst( b ) ) )
    {
        return( 1 );
    }
    if( icomp( lthird( a ), lthird( b ) ) )
    {
        return( 1 );
    }
    return( 0 );
}
