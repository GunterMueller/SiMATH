/*M
.SH NAME
ecrsign - elliptic curve over rational numbers, sign of the functional equation

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrsign(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.       
.PP
ecrsign returns the sign of the functional equation of the L-series of the elliptic curve E/Q.
.PP
If the list E does not contain the sign, ecrsign will compute it and add it to E.
.PP
ecrsign returns
.IP
 +,-1 ,  if the sign could be computed,
    0 ,  if the sign could not be computed, but no 
         error occurs,
 ERROR,  if an error occurs.
 
.SH SEE ALSO
ecrinit

M*/
          
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2       20.01.1992	Anpassung an neues Konzept. JG
   DATE ecrsign       : 921130.930531
H*/

#include <_ec2.h>

single ecrsign( E )                    
list            E;
{
    if( lfourth( lfourth( E ) ) == _0 )
    {
	/*   Das Vorzeichen ist noch nicht berechnet   */

        single *A, C, n, r;
        single *ecrsigns( ), *ecrclser( );
        list    L1, L2;
    
        bind( E );

        init( L1, L2 );

	/* Initialisieren des Arrays A    */

        A = NULL;
        if( ( A = ecrclser( E, A, 0 ) ) == NULL )
        {
            return( ERROR );
        }
        
        /* Berechnung des Vorzeichens     */
        if( ( A = ecrsigns( E, A, &C ) ) == NULL )
        {
            return( ERROR );
        }
	
	free( A );
        
	return( C );
    }

    return( lfirst( lfourth( lfourth( E ) ) ) );
}   
