/*M
.SH NAME
fputecisnf - put elliptic curve with integer coefficients, short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

int fputecisnf(E, pf)
list E;
FILE *pf;

.SH DESCRIPTION
fputecisnf() writes the data of the model representing
the elliptic curve E/Q over the rational numbers in short
normal form to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.SH SEE ALSO
ecrinit
M*/

/*H 
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	13.10.1993	englische Ausgaben.  JG
	Version 3	20.10.1994	Dokumentation korrigiert. MP
	Version 4	06.12.1996	Output of the real roots of the 
	                                polynonial x^3 + a4 x + a6 added. JG.
   DATE fputecisnf    : 930531.931130.941201.970101
H*/	

#include <_ec1.h>

fputecisnf( E, pf )
list E;
FILE *pf;
{
    list L, L1, L2, L3, L4, L5, L6, L7, LH;
    single i;

    bind( E );

    init( L, L1, L2, L3, L4, L5, L6, L7, LH );
	
    L  = lthird ( E );
    L1 = lfirst ( L );
    L2 = lsecond( L );
    L3 = lthird ( L );
    L4 = lfourth( L );
    L5 = lfifth ( L );
    L6 = lsixth ( L );
    L7 = lsixth ( lred( L ) );

    if( L1 == _0 )
    {
        return( 1 ); 
    }

    if( fprintf( pf, "  short WNF:\n") < 0 )
    {
        return( ERROR );
    }
    if( L1 != _0 )
    {
        if( ( fprintf( pf, "    ( A4, A6 ) = " ) < 0 )
        ||  ( fprintf( pf, "( %i,", lfirst( L1 ) ) < 0 )
        ||  ( fprintf( pf, " %i )\n", lsecond( L1 ) ) < 0 ) )
        {
            return( ERROR );
        }
    }
    if( L2 != _0 )
    {
        if( ( fprintf( pf, "    ( b2, b4, b6, b8 ) = " ) < 0 )
        ||  ( fprintf( pf, "( %i",     lfirst ( L2 ) ) < 0 )
        ||  ( fprintf( pf, ", %i",     lsecond( L2 ) ) < 0 )
        ||  ( fprintf( pf, ", %i",     lthird ( L2 ) ) < 0 )
        ||  ( fprintf( pf, ", %i )\n", lfourth( L2 ) ) < 0 ) )
        {
	    return( ERROR );
	}
         
    }
    if( L3 != _0 )
    {
        if( fprintf( pf, "    ( c4, c6 ) = ( %i, %i )\n", 
	    lfirst( L3 ), lsecond( L3 ) ) < 0 )
        {
	    return( ERROR );
	}
    }
    if( L4 != _0 )
    {
        if( fprintf( pf, "    discriminant: %i", lfirst( L4 ) ) < 0 )
        {
            return( ERROR );
        }
	LH = lsecond( L4 );
	if( LH != _0 )
	{
	    if( ( llength( LH ) == 2 ) && ( lsecond( LH ) == 1 ) )
	    {
	        if( fprintf( pf, " (prime) " ) < 0 )
                {
                    return( ERROR );
                }
	    }
	    else
	    {
	        if( ( fprintf( pf, " = " ) < 0 )
	        ||  ( fputfactl( LH, pf ) == ERROR ) )
                {
                    return( ERROR );
                }
	    }
	} 
        if( fprintf( pf, "\n" ) < 0 )
        {
            return( ERROR );
        }
    }
    if( L5 != _0 )
    {
	LH = lfirst( L5 );
	i = 0;
        if( fprintf( pf, "    torsion group: " ) < 0 )
        {
            return( ERROR );
        }
	while( LH != _0 )
	{
	    if( fputecrp( lfirst( LH ), pf ) == ERROR )
            {
                return( ERROR );
            }
	    i++;
	    LH = lred( LH );
	    if( LH != _0 )
	    {
	        if( fprintf( pf, " , " ) < 0 )
                {
                    return( ERROR );
                }
	        if( i % 3 == 0 )
	        {
		    if( fprintf( pf, "\n                    " ) < 0 )
                    {
                        return( ERROR );
                    }
	        }
	    }
	}
	LH = lsecond( L5 );
	if( LH != _0 )
	{
            if( ( fprintf( pf, "\n    generator: " ) < 0 )
	    ||  ( fputecrp( lfirst( LH ), pf ) == ERROR ) )
            {
                return( ERROR );
            }
	    LH = lred( LH );
	    if( LH != _0 )
	    {
	        if( ( fprintf( pf, " , " ) < 0 )
	        ||  ( fputecrp( lfirst( LH ), pf ) == ERROR ) )
                {
                    return( ERROR );
                }
	    }
	}
	if( fprintf( pf, "\n" ) < 0 )
        {
            return( ERROR );
        }
    }
    if( L7 != _0 )
    {
        if( ( fprintf( pf, "    basis: " ) < 0 )
        ||  ( fputecrlistp( L7, 0, pf ) == ERROR ) )
        { 
            return( ERROR ); 
        } 
        if( fprintf( pf, "\n" ) < 0 )
        {
            return( ERROR );
        }
    }
    if( L6 != _0 )
    {
	if( lfirst( L6 ) != _0 )
	{
	    LH = lfirst( L6 );
            if( ( fprintf( pf, "    transformation sWNF" ) < 0 )
            ||  ( fprintf( pf, " --> actual model:" ) < 0 )
	    ||  ( fprintf( pf, " ( %r",    lfirst ( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r",     lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r",   lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r )\n", lfourth( LH ) ) < 0 ) )
            {
                return( ERROR );
            }
	}
	if( lsecond( L6 ) != _0 )
	{
	    LH = lsecond( L6 );
            if( ( fprintf( pf, "    transformation sWNF" ) < 0 )
            ||  ( fprintf( pf, " --> minimal model:" ) < 0 )
	    ||  ( fprintf( pf, " ( %r",    lfirst ( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r",     lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r",   lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf, ", %r )\n", lfourth( LH ) ) < 0 ) )
            {
                return( ERROR );
            }
	}
    }
    if( ( LH = lsixth ( lred2( L ) ) ) != _0 )
    {
        single p;
        p  = lfirst ( LH );
        LH = lsecond( LH );
        if( fprintf( pf, "    x^3" ) < 0 )
        {
            return( ERROR );
        }
        if( isign( lfirst( L1 ) ) > 0 )
        {
            if( fprintf( pf, " + %i x", lfirst( L1 ) ) < 0 )
            {
                return( ERROR );
            }
        }
        else if( isign( lfirst( L1 ) ) < 0 )
        {
            if( fprintf( pf, " - %i x", iabs( lfirst( L1 ) ) ) < 0 )
            {
                return( ERROR );
            }
        }
        if( isign( lsecond( L1 ) ) > 0 )
        {
            if( fprintf( pf, " + %i", lsecond( L1 ) ) < 0 )
            {
                return( ERROR );
            }
        }
        else if( isign( lsecond( L1 ) ) < 0 )
        {
            if( fprintf( pf, " - %i", iabs( lsecond( L1 ) ) ) < 0 )
            {
                return( ERROR );
            }
        }
        if( fprintf( pf, " has %d real root", llength( LH ) ) < 0 )
        {
            return( ERROR );
        }
        if( ( llength( LH ) > 1 )  && ( fprintf( pf, "s" ) < 0 ) )
        {
            return( ERROR );
        }
        i = 1;
        while( LH != _0 )
        {
            if( fprintf( pf, "\n        x_%d = %.10p", i, lfirst( LH ) ) < 0 )
            {
                return( ERROR );
            }
            LH = lred( LH );
            i++;
        }
        if( ( fprintf( pf, "\n    (computed with precision" ) < 0 )
        ||  ( fprintf( pf, " FL_EPS = %d)\n", p ) < 0 ) )
        {
            return( ERROR );
        }
    }
    if( fprintf( pf, "\n" ) < 0 )
    {
        return( ERROR );
    }
    return( 0 );
}   
