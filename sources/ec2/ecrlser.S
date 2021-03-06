/*M
.SH NAME
ecrlser - elliptic curve over rational numbers, L-series

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecrlser(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.               
.PP
ecrlser returns the value of the L-series L(E,s) of the elliptic curve E/Q at s = 1, or ERROR in case of an error occurs. 

.SH SEE ALSO
ecrinit

M*/
  
/*H
	Version 1 	12.11.1992  	Josef Gebel
	Version 2 	20.01.1993  	Anpassung an neues Konzept. JG
	Version 3 	05.11.1994  	Rueckgabetyp jetzt floating. JG.
   DATE ecrlser       : 921130.930531.941201
H*/

#include <_ec2.h>

floating ecrlser( E )                    
    list            E;
{
    single          *A, C;
    double          result;
    
    bind( E );

    /* Initialisieren des Arrays A                                    */
    A = NULL;
    if( ( A = ecrclser( E, A, 0 ) ) == NULL )
    {
	return( ERROR );
    }

    /* Berechnung des Vorzeichens                                     */
    if( ( A = ecrsigns( E, A, &C ) ) == NULL )
    {
	return( ERROR );
    }

    /* Berechnung der L-Reihe                                         */
    if( ( A = ecrlsers( E, A, &result ) ) == NULL )
    {
	return( ERROR );
    }
    
    free( A );

    return( Cfltofl( result ) );

}
