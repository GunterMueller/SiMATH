/*M
.SH NAME
ecrregmat - elliptic curve over the rational numbers, regulator-matrix

.SH SYNOPSIS
.nf
#include<_ec2.h>

matrix ecrregmat(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.    
.PP
ecrregmat computes the (r x r)-matrix A = ( a_ij ), 
 1 <= i,j <= r, of rank r = rank(E/Q), with 
.IP
a_ij = h(P_i, P_j), where
.TP 4
P_1, ..., P_r
form a basis of the Mordell-Weil group of the elliptic curve E/Q, and
.TP 4
h(P_i, P_j) 
is the Neron-Tate pairing.
.PP
ecrregmat returns
.IP
 (0), if rank(E/Q) = 0,
  A , if rank(E/Q) > 1 and A could be computed,
  0 , else.

.SH SEE ALSO
 ecrinit

M*/
               
/*H
	Version 1	21.02.1994	Josef Gebel
	Version 2	21.11.1994	ECIMINMWGBASE -> ECIMINBMWG. MP
   DATE ecrregmat     : 941201 
H*/

#include<_ec2.h>

matrix ecrregmat( E )
list E;
{
    single r;
   
    bind( E );

    if( ( r = ecrrank( E ) ) )
    {
        /***   Rank( E/Q ) > 0   ***/
        list B;

        init( B );

        B = eciminbmwg( E );

        if( lfirst( B ) )
        {
            /***   Basis could be computed successfully   ***/

            single   i, j;
            matrix   A;
            floating f;
            list     K, L, P, Q;
    
            init( A );
            init( K, L, P, Q );
            init( f );

            /***   A := (r x r)-null matrix   ***/
            A = maconszero( r, r );
            L = B;

            for( i = 1; i <= r; i++ )
            {
                K = B;
                P = lfirst ( L );
                f = lsecond( L );

                /***   a_i,i := h( P_i, P_i )   ***/
                masetel( A, i, i, f );

                for( j = 1; j < i; j++ )
                {
                    Q = lfirst( K );
                    f = eciminnetapa( E, P, Q );

                    /***   a_i,j := a_j,i := h( P_i, P_j )   ***/
                    masetel( A, i, j, f );
                    masetel( A, j, i, f );

                    K = lred2( K );
                }
                L = lred2( L );
            }
            return( A );
        }
       
        /***   Basis could not be computed   ***/
        return( 0 );
    }

    /***    Rank( E/Q ) = 0   ***/
    return( list1( 0 ) );
}
