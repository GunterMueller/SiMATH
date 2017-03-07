/*M
.SH NAME
fputecrac - file put elliptic curve over rational numbers, actual curve

.SH SYNOPSIS
.nf
#include<_ec1.h>

single fputecrac(E, pf)
list E;
FILE *pf;

.SH DESCRIPTION
fputecrac writes the data of the actual model representing 
the elliptic curve E/Q, beeing found in the list E, 
to the output file *pf, 
and returns 0 or ERROR in case of an error has occured.
A description of the list E can be found in the documentation of 'ecrinit'.
 
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	22.07.1993	Unnoetige Ausgabe im Fall
					'L7 != 0' entfernt.  JG
   DATE fputecrac     : 930531.931130
H*/	

#include <_ec1.h>

fputecrac( E, pf )
list E;
FILE *pf;
{
    single i;
    list L, L1, L2, L3, L4, L5, L6, L7, LH;

    bind( E );

    init( L, L1, L2, L3, L4, L5, L6, L7, LH );
	
    L  = lfirst ( E );
    L1 = lfirst ( L );
    L2 = lsecond( L );
    L3 = lthird ( L );
    L4 = lfourth( L );
    L5 = lfifth ( L );
    L6 = lsixth ( L );
    L  = lred   ( L );
    L7 = lsixth ( L );

    if( fprintf( pf, "  actual model: \n" ) < 0 )
    {
	return( ERROR );
    }
    if( L1 != _0 )
    {
        if( ( fprintf( pf,  "    ( a1, a2, a3, a4, a6 ) = " ) < 0 )
        ||  ( fprintf( pf,  "( %r,",   lfirst ( L1 ) ) < 0 )
        ||  ( fprintf( pf,  " %r,",    lsecond( L1 ) ) < 0 )
        ||  ( fprintf( pf,  " %r,",    lthird ( L1 ) ) < 0 )
        ||  ( fprintf( pf,  " %r,",    lfourth( L1 ) ) < 0 )
        ||  ( fprintf( pf,  " %r )\n", lfifth ( L1 ) ) < 0 ) )
	{
	    return( ERROR );
	}
    }
    if( L2 != _0 )
    {
        if( ( fprintf( pf,  "    ( b2, b4, b6, b8 ) = " ) < 0 )
        ||  ( fprintf( pf,  "( %r,",   lfirst ( L2 ) ) < 0 )
        ||  ( fprintf( pf,  " %r,",    lsecond( L2 ) ) < 0 )
        ||  ( fprintf( pf,  " %r,",    lthird ( L2 ) ) < 0 )
        ||  ( fprintf( pf,  " %r )\n", lfourth( L2 ) ) < 0 ) )
	{
	    return( ERROR );
	}
    }
    if( L3 != _0 )
    {
        if( ( fprintf( pf,  "    ( c4, c6 ) = " ) < 0 )
        ||  ( fprintf( pf,  "( %r,",   lfirst ( L3 ) ) < 0 )
        ||  ( fprintf( pf,  " %r )\n", lsecond( L3 ) ) < 0 ) )
	{
	    return( ERROR );
	}
    }
    if( L4 != _0 )
    {
        if( fprintf( pf,  "    discriminant: %r", lfirst( L4 ) ) < 0 )
	{
	    return( ERROR );
	}
        LH = lsecond( L4 );
	if( LH != _0 )
	{
	    if( ( llength( LH ) == 2 ) && ( lsecond( LH ) == 1 ) )
	    {
	        if( fprintf( pf,  " (prime) " ) < 0 )
		{
		    return( ERROR );
		}
	    }
	    else
	    {
	        if( ( fprintf( pf,  " = " ) < 0 )
	        ||  ( fputfactl( LH, pf ) == ERROR ) )
		{
		    return( ERROR );
		}
	    }
	}
        if( fprintf( pf,  "\n" ) < 0 )
        {
	    return( ERROR );
        }
	
    }
    if( L5 != _0 )
    {
	LH = lfirst( L5 );
	i = 0;
        if( fprintf( pf,  "    torsion group: " ) < 0 )
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
	        if( fprintf( pf,  ", " ) < 0 )
		{
		    return( ERROR );
		}
	        if( i % 3 == 0 )
	        {
		    if( fprintf( pf,  "\n                    " ) < 0 )
		    {
			return( ERROR );
		    }
	        }
	    }
	}
	LH = lsecond( L5 );
        if( ( fprintf( pf,  "\n    generator: " ) < 0 )
	||  ( fputecrp( lfirst( LH ), pf ) == ERROR ) )
	{
	    return( ERROR );
	}
	LH = lred( LH );
	if( LH != _0 )
	{
	    if( ( fprintf( pf,  " , " ) < 0 )
	    ||  ( fputecrp( lfirst( LH ), pf ) == ERROR ) )
	    {
		return( ERROR );
	    }
	}
	if( fprintf( pf,  "\n" ) < 0 )
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
            if( ( fprintf( pf,  "    transformation actual " ) < 0 )
            ||  ( fprintf( pf,  "model --> minimal model:" ) < 0 )
	    ||  ( fprintf( pf,  " ( %r,",  lfirst ( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r,",    lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r,",    lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r )\n", lfourth( LH ) ) < 0 ) )
	    {
		return( ERROR );
	    }
	}
	
	LH = lsecond( L6 );
	if( LH != _0 )
	{
            if( ( fprintf( pf,  "    transformation actual " ) < 0 )
            ||  ( fprintf( pf,  "model --> sWNF:" ) < 0 )
	    ||  ( fprintf( pf,  " ( %r,",  lfirst ( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r,",    lsecond( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r,",    lthird ( LH ) ) < 0 )
	    ||  ( fprintf( pf,  " %r )\n", lfourth( LH ) ) < 0 ) )
	    {
		return( ERROR );
	    }
	}
    }
    if( fprintf( pf,  "\n" ) < 0 )
    {
	return( ERROR );
    }
    return( 0 );
}   
