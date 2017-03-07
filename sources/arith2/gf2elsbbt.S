/*M
.SH NAME
gf2elsbbt - Galois field of characteristic 2, element in special bit notation, basis transformation

.SH SYNOPSIS
.nf
#include<_arith2.h>

single gf2elsbbt(G, T, a)  
obj G; 
gf2el a; 
list T;
  
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a
is an elements of GF(2^n), given in special bit-representation with regard to a basis B. a is interpreted as a vector over GF(2).
.TP 4
.B T
is an (n x n)- matrix over GF(2) of degree n in special bit notation (s. mamstom2).
.PP
gf2sbbt returns an element of GF(2^n), say c, given in special bit notation, where
.IP
c = T * a.
     
.SH SEE ALSO
 udpm2tosb
 mamstom2

M*/
                   
/*H
	Version 1       09.09.1994      Josef Gebel
	Version 2       25.10.1995      New arithmetic for matrices
                                        over GF(2). JG.
   DATE gf2elsbbt     : 941201.951201
H*/

#include <_arith2.h>

gf2el gf2elsbbt( G, T, d )
obj   G;
list  T;
gf2el d;
{
    if( d )
    {
        single e,  /***   current word in the result 'vector' b     ***/
               f,  /***   counter for the position in the current   ***/
                   /***   word of the result 'vector'               ***/
               i,  /***   auxiliary variable                        ***/
               l,  /***   number of 'single' words of d             ***/
               m,  /***   auxiliary variable                        ***/
               n,  /***   field degree                              ***/
               p;  /***   result of a multiplication of a row of    ***/
                   /***   T with d.                                 ***/
        int    a,  /***   current 'row' of T                        ***/
               b,  /***   result 'vector'                           ***/
               c;  /***   auxiliary variable to run through d       ***/
        list   M;  /***   auxiliary variable to run through T       ***/
    
        init( a, b, c );
        init( M );
        bind( G, T, d );

        M = lred( T );
        d = lred( d );
        l = llength( d );
        /***   l = number of singles that d is built of  ***/
    
        e = 0;
        n = lfirst( G );
        f = ( n - 1 ) % 30;
        b = _0;
    
        while( M != _0 )
        {
            /***  a is the current line in the matrix M   ***/
            while( !( a = lfirst( M ) ) ) 
            {
                a = lred( a );
            }
            m = llength( a );
            /***   m = number of singles that a is built of  ***/
    
            c = d;
    
            i = l - m;
    
            /***   cut the 'vectors' a and c down on the  ***/
            /***   length of the shortest of them         ***/
            if( i > 0 )
            {
                while( i )
                {
                    c = lred( c );
                    i--;
                }
            }
            else
            {
                while( i )
                {
                    a = lred( a );
                    i++;
                }
            }
    
            /***   carry out the multiplication row by row   ***/
            p = 0;
    
            while( a != _0 )
            {
                m = lfirst( a );
                i = lfirst( c );
                p ^= ( m & i );
                a = lred( a );
                c = lred( c );
            }
    
            /***   add the result of the multiplication of a and c  ***/
            while( p )
            {
                if( p & 1 )
                {
                    e ^= 1;
                }
                p >>= 1;
            }
            
            /***   enter the result in the 'vector' b and move      ***/
            /***   to the next position in the 'vector' b           ***/
            if( f )
            {
                /***  left shift <==> next position in the vector   ***/
                e <<= 1;
                f--;
            }
            else
            {
                /***  The current 'single' word of b is filled up   ***/
                /***  (i.e. no more left shift possible):           ***/
                /***  take another 'single' word an add it to the   ***/
                /***  'vector' b <==> next position in the vector   ***/
                b = lcomp( e, b );
                e = 0; 
                f = 29;
            }
            
            M = lred( M );
        }
    
        b = linv( b );
    
        /***   cancel (if exist) leading zero words in b   ***/
        while( ( b != _0 ) && !lfirst( b ) )
        {
            b = lred( b );
        }
        if( b == _0 )
        {
            return( 0 );
        }
    
        /***   determination of the degree of b    ***/
        i = 30 * ( llength( b ) - 1 ) - 1;
        m = lfirst( b );
        while( m )
        {
            i++;
            m >>= 1;
        }
        b = lcomp( i, b );

        return( b );
    }
    return( 0 );
}
