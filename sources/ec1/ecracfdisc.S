/*M
.SH NAME
ecracfdisc - elliptic curve over rational numbers, actual curve, factorization of discriminant

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracfdisc(E1)  
list E1;

.SH DESCRIPTION
ecracfdisc computes the complete ( prime-)factorization of |D|, where D is the
discriminant of the actual model representing the elliptic curve E/Q.
.P
|D| = p1^e1 * ...* pn^en
.P
eciminfdisc returns the list
.P
 F = ( p1 e1 p2 e2 ... pn en )
 int p1, ..., pn;
 single e1, ..., en;
.P
If E1 does not contain the list F, F will be added to E1.                      
.TP 4                                                                           
.B E1 
is a list containing the data of the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecracfdisc    : 930531.931130
H*/	

#include <_ec1.h>

list ecracfdisc( E )
list E;
{
    if( ( lfourth( lfirst( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfirst( E ) ) ) == _0 ) )
    {
	/*   Die Diskriminante ist noch nicht faktorisiert   */

        rat D;
        int num, den;
        list L, H, FD;
    
        bind( E );

        init( L, FD );
        init( num, den );
	init( D );

	D   = ecracdisc( E );
	num = iabs( rnum( D ) );
	den = rden( D );

	if( den != 1 )
	{
	    L = ifact( den );
	    L = ifel (  L  );
	    H = ifact( num );
	    H = ifel (  H  );
	    
	    FD = _0;

	    while( L != _0 )
	    {
	        FD = lcomp( (-1) * lsecond( L ), FD );
	        FD = lcomp( lfirst( L ), FD );
	        L  = lred2( L );
	    }
	    
	    while( H != _0 )
	    {
	        FD = lcomp( lsecond( H ), FD );
	        FD = lcomp( lfirst( H ), FD );
	        H  = lred2( H );
	    }
	}
	else
	{
	    FD = ifact( iabs( num ) );
	    FD = linv ( FD );
	    FD = ifel ( FD );
	}

	L  = lfirst( E );
	leset ( L, 4, list2( D, FD ) );
	leset ( E, 1, L );

	return( FD );
    }

    return( lsecond( lfourth( lfirst( E ) ) ) );
}   
