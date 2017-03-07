/*M
.SH NAME
fputecimin - file put elliptic curve with integer coefficients, minimal model

.SH SYNOPSIS
.nf
#include<_ec1.h>

single fputecimin(E,pf)
list E;
FILE *pf;

.SH DESCRIPTION
fputecimin writes the data of the minimal model representing 
the elliptic curve E/Q, beeing found in the list E, to the
output File *pf, 
and returns 0 or ERROR in case of an error has occured.
A description of the list E can be found in the documentation of 'ecrinit'. 

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	13.10.1993	englische Ausgaben.  JG
   DATE fputecimin    : 930531.931130
H*/	

#include <_ec1.h>

fputecimin( E, pf )
list E;
FILE *pf;
{
    list L, L1, L2, L3, L4, L5, L6, L7, LH;
    single i;

    bind( E );

    init( L, L1, L2, L3, L4, L5, L6, L7, LH );
	
    L  = lsecond( E );
    L1 = lfirst ( L );
    L2 = lsecond( L );
    L3 = lthird ( L );
    L4 = lfourth( L );
    L5 = lfifth ( L );
    L6 = lsixth ( L );
    L7 = lsixth ( lred( L ) );

    if( L1 == _0 ) 
    {
	/*   Die Koeffizienten a1, ..., a6 sind noch   */
	/*   nicht eingetragen ==> L = ( _0, ..., _0 )  */
	return( 0 );
    }

    if( fprintf( pf, "  minimal model: \n" ) < 0 )
    {
	return( ERROR );
    }
    if( L1 != _0 )
    {
        if( ( fprintf( pf, "    ( a1, a2, a3, a4, a6 ) ") < 0 )
        ||  ( fprintf( pf, "= ( %i",     lfirst ( L1 ) ) < 0 )
        ||  ( fprintf( pf, ", %i",     lsecond( L1 ) ) < 0 )
        ||  ( fprintf( pf, ", %i",     lthird ( L1 ) ) < 0 )
        ||  ( fprintf( pf, ", %i",     lfourth( L1 ) ) < 0 )
        ||  ( fprintf( pf, ", %i )\n", lfifth( L1 ) ) < 0 ) )
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
	if( llength( L4 ) >= 2 )
	{
	    LH = lsecond( L4 );
	    i  = llength( LH );

	    if( ( i == 2 ) && ( lsecond( LH ) == 1 ) )
	    {
	        if( fprintf( pf, " (prime) " ) < 0 )
                {
	            return( ERROR );
	        }
	    }
	    else if( i )
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
	if( fprintf( pf, "\n" ) < 0 )
        {
	    return( ERROR );
	}
    }
    if( L7 != _0 )
    {
        if( ( fprintf( pf, "    basis: " ) < 0 )
        ||  ( fputecrlistp( L7, 1, pf ) == ERROR ) )
        { 
            return( ERROR ); 
        } 
    }
    if( L6 != _0 )
    {
	LH = lfirst( L6 );
        if( LH != _0 )
	{
	    if( ( fprintf( pf, "    transformation minimal ") < 0 )
	    ||  ( fprintf( pf, "model --> actual model:" ) < 0 ) 
	    ||  ( fprintf( pf, " ( %r,",  lfirst ( LH ) ) < 0 )
	    ||  ( fprintf( pf, " %r,",    lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf, " %r,",    lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf, " %r )\n", lfourth( LH ) ) < 0 ) )
            {
	        return( ERROR );
	    }
	}
	LH = lsecond( L6 );
        if( LH != _0 )
	{
            if( ( fprintf( pf, "    transformation minimal " ) < 0 )
            ||  ( fprintf( pf, "model --> sWNF:" ) < 0 )
	    ||  ( fprintf( pf, " ( %r,",  lfirst ( LH ) ) < 0 ) 
	    ||  ( fprintf( pf, " %r,",    lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf, " %r,",    lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf, " %r )\n", lfourth( LH ) ) < 0 ) )
            {
	        return( ERROR );
	    }
	}
    }
    if( fprintf( pf, "\n" ) < 0 )
    {
	return( ERROR );
    }
    return( 0 );
}
