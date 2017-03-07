/*M
.SH NAME
eciminfdisc - elliptic curve with integer coefficients, minimal model, factorization of discriminant
.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminfdisc(E1)
list E1;

.SH DESCRIPTION
eciminfdisc computes the complete ( prime-)factorization of |D|, where D is the discriminant of the minimal model representing the elliptic curve E/Q.
.P
|D| = p1^e1 * ...* pn^en
.P
eciminfdisc returns the list 
.P
 F = ( p1 e1 p2 e2 ... pn en )
 int p1, ..., pn;
 single e1, ..., en;
.P
If E1 does not contain the list F , F will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
The model representing E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1,
0, 1.).
 
.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE eciminfdisc   : 930531.931130
H*/	

#include <_ec1.h>

list eciminfdisc( E )
list E;
{
    if( ( lfourth( lsecond( E ) ) == _0 )
    ||  ( lsecond( lfourth( lsecond( E ) ) ) == _0 ) )
    {
	/*   Die Diskriminante ist noch nicht faktorisiert   */

        int D;
        list L, M, F;

        bind( E );
    
        init( L, F );
	init( D );

	D = ecimindisc( E );
	F = ifact( iabs( D ) );
	F = linv ( F );
	F = ifel ( F );
	if( lthird( lfourth( lsecond( E ) ) ) )
	{
	    M = list3( D, F, ecimindwhnth( E ) );
	}
	else
	{
	    M = list3( D, F, 0 );
	}

	L = lsecond( E );
	leset( L, 4, M );
	leset( E, 2, L );

	return( F );
    }

    return( lsecond( lfourth( lsecond( E ) ) ) );
}   
