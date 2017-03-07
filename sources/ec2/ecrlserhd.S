/*M
.SH NAME
ecrlserhd - elliptic curve over rational numbers, L-series, higher derivative

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecrlserhd(E, r)  
list E;
single r;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.PP
ecrlserhd returns the value of the n-th derivative of the L-series L(E,s) of the elliptic curve E/Q at s = 1, or ERROR in case of an error occurs.

.SH SEE ALSO
 ecrinit
 ecrlserfd

M*/

/*H
	Version 1 	12.11.1992  	Josef Gebel
	Version 2 	12.01.1993  	Unterscheidung zwischen 'grossem' 
					und 'kleinem' Fuehrer.
					Anpassung an neues Konzept. JG
        Version 3       05.11.1994      Rueckgabetyp jetzt floating. JG.
	Version 3.1     08.11.1994	Cfltofl in return. US.
   DATE ecrlserhd     : 921130.930531.941201
H*/

#include <_ec2.h>

floating ecrlserhd( E, r )                    
list            E;
single          r;
{
    single      *A, C;
    double      result;
    single      *ecrclser(), *ecrlserhdsc(), *ecrlserhdlc(), *ecrsigns();

    bind( E );

    /* Initialisieren des Arrays A                                */
    A = NULL;
    if( ( A = ecrclser( E, A, 0 ) ) == NULL )
    {
	return( ERROR );
    }

    /* Berechnung des Vorzeichens von E/Q                         */
    if( ( A = ecrsigns( E, A, &C ) ) == NULL )
    {
	return( ERROR );
    }
    else
    {
	int    N;
	init( N );

        N = ecrcond( E );

        if( ( ( C == -1 ) && !( r % 2 ) ) 
	||  ( ( C ==  1 ) &&  ( r % 2 ) )
	||  ( icomp( N, 1000000 ) < 0 ) )
        {
            /*   Bedingung (-1)^r = C verletzt                    */
	    /*   (dann ist 'ecrlserhdlc' nicht anwendbar) oder    */
	    /*   N ist 'klein': ecrlserhdsc ('small conductor')   */
	    /*   ist schneller als 'ecrlserhdlc'                  */
            if( ( A = ecrlserhdsc( E, A, r, &result ) ) == NULL )
            {
	        return( ERROR );
            }
        }
        else
	{
	    /*   N ist 'gross': ecrlserhdlc ('large conductor')   */
	    /*   und (-1)^r = C.                                  */
            if( ( A = ecrlserhdlc( E, A, r, &result ) ) == NULL )
            {
	        return( ERROR );
            }
        }
    }
    free( A );

    return( Cfltofl( result ) );
}
