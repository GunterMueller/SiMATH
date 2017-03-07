/*M
.SH NAME
ecrjinv - elliptic curve over rational numbers, j-invariant

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecrjinv(E1)  
list E1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
ecrjinv returns the j-invariant of the elliptic curve E/Q.
.PP
If E1 does not contain the j-invariant, it will be added to E1.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2	29.08.1990	alter Name JINVECR. MP
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 4 	17.12.1992	Anpassung an neues Konzept.  JG
	Version 5	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecrjinv       : 900315.901120.9107__.910915.930531.931130
H*/	

#include <_ec1.h>

rat ecrjinv( E )
list E;
{
        bind( E );
    if( lfirst( lfourth( E ) ) == _0 )
    {
	/*   Die j-Invariante ist noch nicht berechnet   */

        rat j, D, c4;
        list L;
    
        /**bind( E );**/

        init( L );
	init( j, D, c4 );

	D  = ecracdisc( E );
	c4 = ecracc4( E );

	j  = rprod( c4, c4 );
	j  = rprod(  j, c4 );
	j  = rquot(  j,  D );
	
	L  = lfourth( E );
	leset ( L, 1, list2( j, _0 ) );
	leset ( E, 4, L );

	return( j );
    }

    return( lfirst( lfirst( lfourth( E ) ) ) );
}   
