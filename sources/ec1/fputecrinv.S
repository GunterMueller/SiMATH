/*M
.SH NAME
fputecrinv - put elliptic curve over the rationals, invariants

.SH SYNOPSIS
.nf
#include<_ec1.h>

int fputecrinv(E, pf)
list E;
FILE *pf;

.SH DESCRIPTION
fputecrinv() writes the invariants of the elliptic
curve E/Q over the rational numbers to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.SH SEE ALSO
ecrinit
M*/

/*H
        Version 1       17.12.1992      Josef Gebel (neues Konzept)
        Version 2       19.09.1993      Komplexe Periode eingefuegt.  JG
        Version 3       13.03.1995      Charakteristisches Polynom der
                                        Regulatormatrix und kleinster Eigen-
                                        wert dieser Matrix eingefuegt. JG.
        Version 4       19.12.1994      Output of periods modified. JG
        Version 5       15.02.1998      bug fix (periods). JG
        Version 6       26.02.1998      return value now 0 instead of 1.
					Empty line in output removed. PS
   DATE fputecrinv    : 930531.931130.951201.970101
H*/

#include <_ec1.h>

fputecrinv( E, pf )
list E;
FILE *pf;
{
    single i;
    list L, L1, L2, L3, L4, L5, LH;

    bind( E );

    init( L, L1, L2, L3, L4, L5, LH );
	
    L  = lfourth( E );
    L1 = lfirst ( L );
    L2 = lsecond( L );
    L3 = lthird ( L );
    L4 = lfourth( L );
    L5 = lfifth ( L );

    if( ( L1 == _0 ) && ( L2 == _0 ) && ( L3 == _0 ) 
     && ( L4 == _0 ) && ( L5 == _0 ) )
    {
	return( 0 );
    }

    if( fprintf( pf, "  invariants of E/Q: " ) < 0 )
    {
	return( ERROR );
    }
    if( L1 != _0 )
    {
        if( fprintf( pf, "\n    j-invariant: %r", lfirst( L1 ) ) < 0 )
        {
	    return( ERROR );
        }
    }

    if( L2 != _0 )
    {
        if( fprintf( pf, "\n    conductor: %i", lfirst( L2 ) ) < 0 )
        {
	    return( ERROR );
        }
        LH = lsecond( L2 );
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
        if( fprintf( pf, "\n    Kodaira reduction type" ) < 0 )
        {
	    return( ERROR );
        }
	LH = lthird( L2 );
        if( llength( LH ) > 2 )
	{
	    if( fprintf( pf, "s" ) < 0 )
            {
	        return( ERROR );
            }
	}
	if( fprintf( pf, ": " ) < 0 )
        {
	    return( ERROR );
        }
	while( LH != _0 )
	{
	    if( fprintf( pf, "( %i: ", lfirst( LH ) ) < 0 )
            {
	        return( ERROR );
            }
	    i = lsecond( LH );

	    switch( i )
	    {
		case  1: if( fprintf( pf, "II ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  2: if( fprintf( pf, "III ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  3: if( fprintf( pf, "IV ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  5: if( fprintf( pf, "I0* ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  6: if( fprintf( pf, "IV* ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  7: if( fprintf( pf, "III* ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		case  8: if( fprintf( pf, "II* ) " ) < 0 )
                         {
	                     return( ERROR );
                         }
			 break;
		default: if( i < 0 )
			 {
			     if( fprintf( pf, "I%d ) ", -i ) < 0 )
                             {
	                         return( ERROR );
                             }
			 }
			 else
			 {
			     if( fprintf( pf, "I%d* ) ", i - 10 ) < 0 )
                             {
	                         return( ERROR );
                             }
			 }
			 break;
	    }
	    LH = lred2( LH );
	}

	LH = lfourth( L2 );
        if( ( fprintf( pf, "\n    product over all c_p-" ) < 0 )
        ||  ( fprintf( pf, "values: %i", lfirst( LH ) ) < 0 ) )
        {
	    return( ERROR );
        }
        if( llength( LH ) > 2 )
	{
	    LH = lred( LH );
	    if( fprintf( pf, " = %i", lfirst( LH ) ) < 0 )
	    {
	        return( ERROR );
	    }
    
	    while( 1 )
	    {
	        LH = lred( LH );
	        if( LH == _0 )
	        {
		    break;
	        }
                if( fprintf( pf, " * %i", lfirst( LH ) ) < 0 )
	        {
	            return( ERROR );
	        }

	    }
	}
    }

    if( L3 != _0 )
    {
        if( ( fprintf( pf, "\n    order of the torsion group:" ) < 0 )
        ||  ( fprintf( pf, " %d",  lfirst( L3 ) ) < 0 ) )
        {
	    return( ERROR );
        }
	if( llength( L3 ) > 1 )
	{
            if( ( fprintf( pf, "\n    structure of the torsion" ) < 0 )
            ||  ( fprintf( pf, " group: %l", lsecond( L3 ) ) < 0 ) )
            {
	        return( ERROR );
            }
	}
    }
    if( L4 != _0 )
    {
        if( ( fprintf( pf, "\n    sign of the " ) < 0 )
        ||  ( fprintf( pf, "functional equation: " ) < 0 ) )
        {
	    return( ERROR );
        }
	
	if( lfirst( L4 ) < 0 )
	{
            if( fprintf( pf, "-" ) < 0 )
            {
	        return( ERROR );
            }
	}
	else
	{
            if( fprintf( pf, "+" ) < 0 )
            {
	        return( ERROR );
            }
	}
	

	if( lsecond( L4 ) != ERROR ) 
	{
            if( fprintf( pf, "\n    rank: %d",  lsecond( L4 ) ) < 0 )
            {
	        return( ERROR );
            }
	}

	if( lfourth( L4 ) != 0 )
	{
            if( ( fprintf( pf, "\n    regulator = " ) < 0 )
            ||  ( fprintf( pf, "%1.10p", lfourth( L4 ) ) < 0 ) )
            {
	        return( ERROR );
            }
	}

	if( lfifth( L4 ) )
	{
            if( ( fprintf( pf, "\n    order of the " ) < 0 )
            ||  ( fprintf( pf, "Tate-Shafarevic group" ) < 0 )
            ||  ( fprintf( pf, ": %d", lfifth( L4 ) ) < 0 ) )
            {
	        return( ERROR );
            }
	}

	LH = lred5( L4 );
        if( LH != _0 )
        {
            list     chi;
            floating f;

            init( chi );
            init( f );

            if( chi = lfirst( LH ) )
            {
                single   d;
           
                fprintf( pf, "\n    characteristic polynomial of the ");
                fprintf( pf, "regulator matrix: \n");
            
                d = lfirst( chi );
                chi = lred2( chi );
		if(d==1) fprintf( pf, "        x");
                else     fprintf( pf, "        x^%d", d );
                d--;
                while( chi != _0 )
                {
                    f = lfirst( chi );
                    switch( d )
                    {
                        case  0: if( flsign( f ) > 0 ) 
                                 {
                                     fprintf( pf, " +%.10p", f );
                                 }
                                 else if( flsign( f ) < 0 ) 
                                 {
                                     fprintf( pf, " -%.10p", flabs( f ) );
                                 }
                                 break;
                        case  1: if( flsign( f ) > 0 ) 
                                 {
                                     fprintf( pf, " +%.10p * x", f );
                                 }
                                 else if( flsign( f ) < 0 ) 
                                 {
                                     fprintf( pf, " -%.10p * x", flabs( f ) );
                                 }
                                 break;
                        default: if( flsign( f ) > 0 ) 
                                 {
                                     fprintf( pf, " +%.10p * x^%d", f, d );
                                 }
                                 else if( flsign( f ) < 0 ) 
                                 {
                                     fprintf( pf, " -%.10p * x^%d", flabs( f ), d );
                                 }
                                 break;
                        }
                    d--;
                    chi = lred( chi );
                }
            }
            LH = lred( LH );
            if( LH != _0 )
            {
                f = lfirst( LH );
                fprintf( pf, "\n    smallest eigenvalue of the" );
                fprintf( pf, " regulator matrix: %.10p", f );
            }
        }
    }
    if( L5 != _0 )
    {
        if( fprintf( pf, "\n    real " ) < 0 )
        {
	    return( ERROR );
	}
	if( lsecond( L5 ) )
	{
            if( fprintf( pf, "   " ) < 0 )
	    {
	        return( ERROR );
	    }
        }
        if( fprintf( pf, "period w1 =%1.10p", lsecond( L5 ) ) < 0 )
        {
	    return( ERROR );
	}
        if( fprintf( pf, "   (precision: FL_EPS = %d)", lfirst( L5 ) ) < 0 )
        {
	    return( ERROR );
	}
	if( lthird( L5 )  )
        {
	    if( ( fprintf( pf, "\n    complex period w2 =" ) < 0 )
            ||  ( fputcn( lfourth( L5 ), 1, 10, pf ) == ERROR ) )
            {
	        return( ERROR );
	    }
            if( fprintf( pf, " (precision: FL_EPS = %d)", lthird( L5 ) ) < 0 )
            {
	        return( ERROR );
	    }
	    if( lfifth( L5 )  )
            {
	        if( ( fprintf( pf, "\n        tau = w2 / w1 =" ) < 0 )
                ||  ( fputcn( lsixth( L5 ), 1, 10, pf ) == ERROR ) )
                {
	            return( ERROR );
	        }
                if( fprintf( pf, " (precision: FL_EPS = %d)", lfifth (L5 ) ) < 0 )
                {
	            return( ERROR );
	        }
	    }
    	}
    }
    if( fprintf( pf, "\n" ) < 0 )
    {
	return( ERROR );
    }

    return( 0 );
}   
