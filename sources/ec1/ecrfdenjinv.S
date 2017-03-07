/*M
.SH NAME   
ecrfdenjinv - elliptic curve over the rationals, factorization of the denominator of the j-invariant                                                                   
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list ecrfdenjinv(E1)  
list E1;
                                                                     
.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
ecrfdenjinv computes a complete ( prim -) factorization of the denominator of the j-invariant ( say d ) of the elliptic curve E.
.IP
d = p1^e1 * p2^e2 * ... * pn^en 
.PP
ecrfdenjinv returns the factorisation as a list F:
.IP
F = ( p1 e1 p2 e2 ...pn en )
    int p1, ..., pn;
    single e1, ..., en;
.PP
where p1 <= p2 <= ... <= pn.
.PP
If E1 does not contain the factorization of d, it will be added to E1.
                                                               
.SH SEE ALSO
ecrinit
                                                                  
M*/ 

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecrfdenjinv   : 930531.931130
H*/	

#include <_ec1.h>

list ecrfdenjinv( E )
list E;
{
    if( ( lfirst( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfirst( lfourth( E ) ) ) == _0 ) )
    {
	/*   Die j-Invariante ist noch nicht faktorisiert   */

        rat j;
        int den;
        list F, L;
    
        bind( E );

        init( F, L );
        init( den );
	init( j );

	j   = ecrjinv( E );
	den = rden( j );

	F = ifact( den );
	F = linv ( F );
	F = ifel ( F );

	L  = lfourth( E );
	leset ( L, 1, list2( j, F ) );
	leset ( E, 4, L );

	return( F );
    }

    return( lsecond( lfirst( lfourth( E ) ) ) );
}   
