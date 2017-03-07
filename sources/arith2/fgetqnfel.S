/*M
.SH NAME
fgetqnfel - file get quadratic number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel fgetqnfel(D, pf)  
int D; 
FILE *pf;
   
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.TP 4
.B pf
points on the input file *pf.
.PP
fgetqnfel reads an element of K from the file *pf and returns it as an element of type nfel, or ERROR in case of an error occurs (for representation of number field elements s. fputnfel).
.PP
Following inputs are allowed:
  a1, a1/aN, (a1 a2), (a1/aN a2), (a1 a2/aN),
  (a1/aN a2/aN), (aN 0 a1), (aN 1 a2 a1)
  with integer numbers a1, a2 aN.

.SH SEE ALSO
 fputnfel
 getnfel
             
M*/
                       
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE fgetqnfel     : 931130
H*/

#include <_arith2.h>

nfel fgetqnfel( D, pf ) 
int D;
FILE *pf;
{
    single c;
    bind( D );

    if( ( c = fgetcs( pf ) ) == '0' )
    {
	return( 0 );
    }
    else
    {
        int a1, b3;
        rat X;
	nfel a;
        
        init( a1, b3 );
        init( X );
        init( a );

        bind( D );

        ungetc( c, pf );

        if( ( c = fgetcs( pf ) ) == '(' )
        {
            /*   Eingabe startet mit oeffnender Klammer:  */
            /*   Eingabe ist von der Form                 */
            /*   1.  ( a1  a2 )        rat a1, a2;        */
            /*   2.  ( aN  0  a1 )     int aN, a1;        */
            /*   3.  ( aN  1  a2  a1 ) int aN, a1, a2;    */
	    /*   und stellt das Zahlkoerperelement        */
            /*     a1 + a2 * D^(1/2)   bzw.               */
            /*     a1/aN               bzw.               */
            /*     a1/aN + a2/aN * D^(1/2)                */
            /*   dar.                                     */
        
	    int a2, b1, b2;
        
	    init( a2, b1, b2 );
        
            if( ( X = fgetr( pf ) ) == ERROR )
            {
                return( ERROR );
            }
	    a1 = rnum( X );
	    b1 = rden( X );

	    if( ( c = fgetcs( pf ) ) != ',' )
            {
                ungetc( c, pf );
            }
            
	    if( ( X = fgetr( pf ) ) == ERROR )
            {
                return( ERROR );
            }
	    a2 = rnum( X );
	    b2 = rden( X );

	    if( ( c = fgetcs( pf ) ) == ')' )
            {
                /*   Eingabe ist von der Form ( a1  a2 ) rat a1, a2;  */

		int a3;

		init( a3 );

		b3 = ilcm( b1, b2 );
		a3 = igcd( b1, b2 );
		a1 = iprod( a1, b2 );
		a1 = iquot( a1, a3 );
		a2 = iprod( a2, b1 );
		a2 = iquot( a2, a3 );

		a = list4( b3, 1, a2, a1 );
            }
	    else
	    {
                /*   Eingabe ist von der Form                 */
                /*       ( aN  0  a1 )     int aN, a1;        */
                /*   oder                                     */
                /*       ( aN  1  a2  a1 ) int aN, a1, a2;    */
		/*   d.h. die 1. Eingabe muss vom Typ int     */
		/*        und ungleich 0 sein und             */
		/*        die 2. Eingabe muss 0 oder 1 sein.  */

		if( ( b1 != 1 ) ||  !a1  || ( b2 != 1 )
		||  ( a2 && ( a2 != 1 ) ) )
		{
		    return( ERROR );
		}
		
		if( c != ',' )
                {
                    ungetc( c, pf );
                }

		b3 = a1;
            
		if( a2 )
		{
                    /*   Eingabe ist von der Form             */
                    /*    ( aN  1  a2  a1 ) int aN, a1, a2;   */

	            if( ( a2 = fgeti( pf ) ) == ERROR )
                    {
                        return( ERROR );
                    }
		
		    if( ( c = fgetcs( pf ) ) != ',' )
                    {
                        ungetc( c, pf );
                    }
            
	            if( ( a1 = fgeti( pf ) ) == ERROR )
                    {
                        return( ERROR );
                    }

		    a = list4( b3, 1, a2, a1 );
		}
		else
		{
                    /*   Eingabe ist von der Form             */
                    /*       ( aN  0  a1 ) int aN, a1;        */
	            
		    if( ( a1 = fgeti( pf ) ) == ERROR )
                    {
                        return( ERROR );
                    }
		    
		    a = list3( b3, 0, a1 );
		}
		
		if( ( c = fgetcs( pf ) ) != ')' )
                {
                    return( ERROR );
                }
	    }
	}
	else
	{
            /*   Eingabe ist eine rationale (oder ganze) Zahl  */
	    ungetc( c, pf );
            if( ( X = fgetr( pf ) ) == ERROR )
            {
                return( ERROR );
            }

	    a1 = rnum( X );
	    b3 = rden( X );

	    a = list3( b3, 0, a1 );
	}
	return( qnfminrep( D, a ) );
    }
}
