/*M
.SH NAME
ecrranks - with integer coefficients, rank, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrranks(E, *A, *r);
list E;
single *A, *r;

.SH DESCRIPTION
ecrranks() computes the rank r of E/Q and returns
A on success or NULL if an error occurred.
If the rank r is not yet contained in the list E
it will be computed and stored in E, otherwise the value
will be taken from the list.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.TP 4
.B A
is a pointer to an array of singles.
A must contain the coefficients a_i of the L-series L(E, s) of E/Q
and must be of the form A[0]=length of A;  A[i]=a_i for i = 1, ..., A[0].

.TP 4
.B r
is a pointer to a single r, which will be assigned the rank of E/Q.

.SH SEE ALSO
ecrinit
M*/
/*H
	Version 1	12.06.1995	Josef Gebel
	Version 2	08.03.1996      Fehler beseitigt. JG
   DATE ecrranks      : 951201.960501
H*/

#include<_ec2.h>

#define LC_BOUND 1000000

single *ecrranks( E, A, r )
list E;
single *A, *r;
{
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == ERROR ) )
    {
	/*   Der Rang ist noch nicht berechnet   */

        single    *B, n, C, i, lc_flag;
        double    dh;
        list      L1, L2;
        int       N;
        floating  flh;
      
        bind( E ); 

        init( L1, L2 );
        init( flh );
        init( N );
    
        N = ecrcond( E );

	if( icomp( N, LC_BOUND ) > 0 )
	{
	    lc_flag = 1;
	}
	else
	{
	    lc_flag = 0;
	}

        /*  Berechnen des Vorzeichens der L-Reihe.  */

        if( lfourth( lfourth( E ) ) == _0 )
        {
	    /*   Das Vorzeichen ist noch nicht berechnet   */
    
            if( ( B = ecrsigns( E, A, &C ) ) == NULL )
            {
                free( A );
                return( NULL );
            }   
            if( ( lfourth( lfourth( E ) ) != _0 )
            && ( ( *r = lsecond( lfourth( lfourth( E ) ) ) ) != ERROR ) )
            {   
                return( B );
            }   
            A = B;
        }                               
        else
        {                               
            C = lfirst( lfourth( lfourth( E ) ) );
        }                               
   
        switch( C )
        {
            case -1: *r = 1;
	             break;
    
            case  1: *r = 0;
	             break;
    
            default: return( NULL );
        }

	while( 1 )
	{
	    dh = 0.0;
            switch( *r )
            {
                case  0: B = ecrlsers( E, A, &dh );
                         break;

                case  1: if( lc_flag)
                         {
                             B = ecrlserhdlc( E, A, *r, &dh );
                         }
                         else
			 {
			     B = ecrlserfds( E, A, &dh );
			 }
                         break;
   
                default: B = ecrlserhdlc( E, A, *r, &dh );
                         break;
            }

	    if( A == NULL )
            {
                free( A );

	        if( fabs( dh ) < 0.01 )
                {
                    (*r) += 2;
                }
                else
                {
                    return( NULL );
                }
            }

            A = B;

	    if( fabs( dh ) < 0.01 )
            {
                (*r) += 2;
            }
            else
            {
                break;
            }
        }

        flh = Cfltofl( dh );

	L2 = lfourth( E );
	L1 = lfourth( L2 );

	leset( L1, 1, C );
	leset( L1, 2, *r );
	leset( L1, 3, flh );

	leset( L2, 4, L1 );
	leset(  E, 4, L2 );

        return( A );
    }

    *r = lsecond( lfourth( lfourth( E ) ) );

    return( A );
}   
