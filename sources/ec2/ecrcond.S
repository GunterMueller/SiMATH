/*M
.SH NAME
ecrcond - elliptic curve over rational numbers, conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecrcond(E)  
list E;
   
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.        
.PP
ecrcond returns the conductor of the elliptic curve E/Q.
If the list E does not already contain the conductor, ecrcond will compute it (together with its factorization, c_p values, Neron types and Kodaira types) and add them to E. E will be changed.
 
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       05.04.1990      Michael Pfeifer
	Version 2       04.12.1990	M.P.: fuer p auch int-Werte
					zugelassen
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
	Version 4 	02.04.1992	ECRCOND --> ECICOND.
					Dokumenation angepasst. MP
	Version 5       12.11.1992      fuer p > 3 ECIBRT statt 
					TATEALG. Berechnung der c_p-
					Werte eingebaut.  Josef Gebel
	Version 6	20.11.1992	TATEALG -> ECITATEALG.  PS
	Version 7	19.01.1993	Anpassung an neues Konzept. 
					ECICOND --> ECRCOND. JG
	Version 8	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
	Version 9	23.10.1995	ECIMINTATEALG --> ECIMINTATE  JG
   DATE ecrcond       : 901120.910715.910915.920331.921130.930115.930531.931130.951201
H*/	

#include <_ec2.h>

int ecrcond( E )
list E;
{
        bind( E );
    if( lsecond( lfourth( E ) ) == _0 )
    {
	/*   Der Fuehrer ist noch nicht berechnet   */

        single  n;
        int     N, c, c4, p, h;
        list    FDm, FN, Nrt, Lcp, L;
    
        /**bind( E ); **/

        init( FDm, FN, Nrt, Lcp, L );
        init( N, c, c4, p, h );

	/*   Vorbesetzungen   */
	FN  = _0;
	Nrt = _0;
	Lcp = _0;
        N   = 1;
        c   = 1;
    
	c4  = eciminc4( E );
	FDm = eciminfdisc( E );
    
        while( FDm != _0 )
        {
            p = lfirst ( FDm );
            n = lsecond( FDm );
            
            FDm = lred2( FDm );
        
            if( ( p == 2 )  ||  ( p == 3 ) )
            {
                L = ecimintate( E, p, n );
            }
            else
            {
                L = eciminbrtmp( E, p, n );
            }
    
            if( llength( L ) == 1 )
            {
		/*         Fehler im Programm         */
		/*   'ecimintate' oder 'eciminbrtmp'   */
                return( ERROR );
            }
            
            h   = lfirst( L );
	    FN  = lcomp2( h, p, FN );
            h   = iexp  ( p, h );
            N   = iprod ( N, h );
            n   = lsecond( L );
	    Nrt = lcomp2( n, p, Nrt );
            h   = lthird( L );
	    Lcp = lcomp ( h, Lcp );
            c   = iprod ( c, h );
        }

	FN  = linv(  FN );
	Nrt = linv( Nrt );
	Lcp = linv( Lcp );
	Lcp = lcomp( c, Lcp );

	FDm = list4( N, FN, Nrt, Lcp );

	L = lfourth( E );

	leset( L, 2, FDm );
	leset( E, 4, L );

	return( N );
    }

    return( lfirst( lsecond( lfourth( E ) ) ) );
}   
