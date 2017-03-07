/*M
.SH NAME
ecrrankbsd - elliptic curve over the rationals, rank via Birch and Swinnerton-Dyer conjecture

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrrank(E)  
list E;
   
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.          
.PP
ecrrankbsd returns the rank of the elliptic curve E/Q.
.PP
If the list E does not contain the rank, ecrrankbsd will compute it (via the conjecture of Birch and Swinnerton-Dyer) and add it to E. E will be changed.

.SH SEE ALSO
ecrinit

M*/
                    
/*H
	Version 1	12.03.1996	Josef Gebel (frueheres 'ecrrank')
   DATE ecrrankbsd    : 960501
H*/

#include<_ec2.h>

ecrrankbsd( E )
list E;
{
    bind( E );
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == ERROR ) )
    {
	/*   Der Rang ist noch nicht berechnet   */
        single r, *A;

        /**bind( E ); **/

        /*  Initialisieren des Arrays A             */
        A = NULL;

        if( ( A = ( single * ) ecrclser( E, A, 0 ) ) == NULL )
        {
            return( ERROR );
        }

        if( ( A = ( single * ) ecrranks( E, A, &r ) ) == NULL )
        {
            return( ERROR );
        }

        free( A );

	return( r );
    }

    return( lsecond( lfourth( lfourth( E ) ) ) );
}   
