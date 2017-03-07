/*M
.SH NAME
ecrclser - elliptic curve over the rationals, coefficients of L- series

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrclser(E, A, n)  
list E; 
single *A, n;
            
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.    
.TP 4
.B A
points on the table A (an array of type single) which is created by ecrclser, and contains the coefficients of the L-series of the elliptic curve E/Q.
A[0] contains the length of the current table A, i.e. the number of the coefficients already computed, A[i] (i > 0) contains the coefficient a_i.
.TP 4
.B n
is the number of the coefficients, which should be computed.
.PP
ecrclser returns the pointer A. In order to allocate memory space for A[0], ecrclser(0) had to be called before the first computation.

.SH SEE ALSO
ecrinit

M*/
                         
/*H
	Version 1	12.11.1992	Josef Gebel      
	Version 2	13.01.1993	Anpassung an neues Konzept.  JG
	Version 3	10.07.1993	Aenderung der Konstante SHANKS 
					und kleinere Aenderungen.  JG
	Version 4	21.10.1994	'ecmpsnfmsha1' statt 'ecmspsnfsha'
					(im 2. Fall Endlosschleife bei 
                                         supersingulaeren Kurven) JG
   DATE ecrclser      : 921130.930531.931130.941201
H*/

#include <_ec2.h>

#define SHANKS 540000
#define SoS    sizeof( single )

single *add;

/*****************************************************************************/
/***                                                                       ***/
/***   B e g i n n i n g   o f   t h e   s t a t i c   f u n c t i o n s   ***/
/***                                                                       ***/
/*****************************************************************************/
/*c 
	         shortfact( n, p, e, f, q ) 

        static shortfact( n ) single n;
        s = shortfact( n );
	Es muss gelten: n > 1.
	shortfact( n ) folgende Faktorisierung fuer n:
	     n = (*q) * (*f), *q = (*p)^(*e),
	wobei *p die kleinste Primahl ist, die n teilt, und (*p, *f) = 1.
	Rueckgabe: s = 0.
c*/
/*H     
	Version 1	12.11.1992	Josef Gebel.
H*/     


static shortfact( n, p, e, f, q )
single n, *p, *e, *f, *q;
{
    *e = 0;
    *f = n;
    *q = 1;
    *p = 2;
  
    while( !( (*f) & 01 ) )
    {
	(*f) >>= 1;
	(*q) <<= 1;
        (*e)++;
    }
    if( *e )
    {
        return( 0 );
    }
    else
    { 
        single r;

        *p = 3;

        while( 1 )
        {
            while( 1 )
            {
                iqrem( n, *p, f, &r );
                if( r )
                {
                    *f = n;
                    if( *e )
	            {
                        return( 0 );
                    }
                    break;
                }
                n = *f;
                *q *= *p;
                (*e)++;
            }
            if( *p == 3 )
            {
                *p = 5;
            }
            else
            {
                *p = 7;
                break;
            }
        }
        {
            single i, s;
            extern single *add;

            s = 1;
            while( *f )
            {
	        (*f) >>= 2;
	        s <<= 1;
            }
	    /*   s = 2^(log_2(n)/2) s ~ sqrt( n ),    */
        
            i = 0;
        
            while( 1 )
            {
                while( 1 )
                {
                    iqrem( n, *p, f, &r );
                    if( r )
                    {
                        *f = n;
                        if( *e )
	                {
                            return( 0 );
                        }
                        break;
                    }
                    n = *f;
                    *q *= *p;
                    (*e)++;
                }
            
                *p += add[i++];
	        i &= 0111;  /* i := i mod 8 */
        
                if( s < *p )
                {
		    /*   Keine Primteiler p von n gefunden    */
		    /*   mit p <= sqrt(n)  ==>  n prim        */
                    *p = *q = n;
                    *e = *f = 1;
                    return( 0 );
                }
            }
        }
    }
}

/**************   Ende von  s h o r t f a c t   ***************/

/*c 
	         p_exp_cond( p, N ) 

        static p_exp_cond( p, FN ) list FN; single p;
        n = p_exp_cond( p, FN );
	Es muss gelten: 
	 - p ist eine Primzahl und 
	 - FN ist die Primfaktorliste des Fuehrers N (s. 'ecrinit').
	p_exp_cond( p, N ) berechnet den Exponenenten von p in N
c*/
/*H     
	Version 1	13.01.1993	Josef Gebel.
H*/     

static p_exp_cond( p, FN )
list FN;
single p;
{
    bind( FN );

    while( FN != _0 )
    {
       if( p < lfirst ( FN ) )
       {
           return( 0 );
       }

       if( p == lfirst ( FN ) )
       {
           return( lsecond( FN ) );
       }

       FN = lred2( FN );
    }
    
    return( 0 );
}

/*************   Ende von  p _ e x p _ c o n d   **************/

/*****************************************************************************/
/***                                                                       ***/
/***         E n d   o f   t h e   s t a t i c   f u n c t i o n s         ***/
/***                                                                       ***/
/*****************************************************************************/
single *ecrclser( E, A, n )
list E;                                    
single *A, n;
{
    /*   Bereitstellen von Speicherplatz fuer die Koeffizienten	    */
   
    if( n == 0 )
    {
        if( ( A = ( single * ) calloc( 1, SoS ) ) == NULL )
	{
	    /*   Fehler beim Allokieren   */
	    return( NULL );
	}
        return( A );
    }

    if( n <= A[0] )
    {
        /*   Koeffizient A[n] ist bereits berechnet                  */
        return( A );
    }
    
    /*   Weiterer Speicherplatz fuer A[] muss allokiert werden      */
    /*   A[0], A[1], ..., A[n] ( = n+1 Speicherzellen )             */
  
    if( ( A = ( single * ) realloc( A, ( n + 1 ) * SoS ) ) == NULL )
    {
	/*   Fehler beim Allokieren   */
        return( NULL );
    }
    else
    {
        single p, e, f, m, i, eN, a4, a6;
        int    a4i, a6i;
        list   FN;
    
        extern single *add;
    	
        bind( E );
        init( FN );
        init( a4i, a6i );

        if( ( add = ( single * ) malloc( 8 * SoS ) ) == NULL )
        {
	    /*   Fehler beim Allokieren   */
            return( NULL );
        }
        add[0] = 4;
        add[1] = 2;
        add[2] = 4;
        add[3] = 2;
        add[4] = 4;
        add[5] = 6;
        add[6] = 2;
        add[7] = 6;
 
        FN = ecrfcond( E );
         
        i = A[0] + 1;
    
        while( ( i <= 3 )  &&  ( i <= n ) )
        {
            /*   Berechnung der ersten drei Koeffizienten der          */
            /*   L-Reihe der eingegebenen elliptischen Kurve.          */
        
            if( i == 1 )
            {
                A[1] = 1;
            }
            else
            {
	        /*   i = 2 oder 3  */
                
	        if( eN = p_exp_cond( i, FN ) )
                {
                    /*   Schlechte Reduktion bei i                     */
         
                    if( eN > 1 )
                    {
                        /*   Additive Reduktion bei i                  */
         
                        A[i] = 0;
                    }
                    else
                    {
                        /*   Multiplikative Reduktion bei i            */
                        A[i] = eciminmrtmp( E, i );
                    }
	    	
                }
                else
                {
                    /*   Gute Reduktion bei i                          */
	    	
		    e  = mshom( i, ecimina1( E ) );
		    f  = mshom( i, ecimina2( E ) );
		    m  = mshom( i, ecimina3( E ) );
		    a4 = mshom( i, ecimina4( E ) );
		    a6 = mshom( i, ecimina6( E ) );
                   
	            m = ecmspnp( i, e, f, m, a4, a6 );
                    A[i] = 1 + i - m;		
                }
            }
            i++;
        }
    
        a4i = ecisnfa4( E );
        a6i = ecisnfa6( E );
         
        while( i <= n )
        {
            shortfact( i, &p, &e, &f, &m );
        	
            if( f == 1 )
            {
                /*   Index des n-ten Koeffizienten ist eine reine      */
                /*   Primzahlpotenz: n = p^e                           */
        
	        if( eN = p_exp_cond( p, FN ) )
                {
                    /*   Schlechte Reduktion bei p                      */
                    if( eN > 1 )
                    {
                        /*   Additive Reduktion bei p                   */
    
                        A[i] = 0;
                    }
                    else  
                    {
                        /* Multiplikative Reduktion bei p               */
    
                        if( e == 1 )
                        {
                            A[i] = eciminmrtmp( E, p );
                        }
                        else
                        {
                            if( e & 01 ) 
                            {
                                /*   A[i] = A[p]^e = (+/- 1)^e = A[p]  */
                                /*   wegen e ungerade                  */
                                A[i] = A[p];
                            }
                            else 
                            {
                                /*   A[i] = A[p]^e = (+/- 1)^e = 1     */
                                /*   wegen e gerade                    */
                                A[i] = 1;
                            }
                        }
	    	
                        /* Multiplikative Reduktion bei p (Ende)       */
                    }
                    /* Schlechte Reduktion bei p (Ende)                */
	    	
                }
                else 
                {
                    /*   Gute Reduktion bei p                          */
        
                    if( e == 1 )
                    {
                        /*   Index des i-ten Koeffizienten             */
                        /*   ist eine reine Primzahl.                  */
         
                        /*   Berechne die Anzahl der Punkte der        */
                        /*   reduzierten Kurve ueber dem               */
                        /*   Restklassenkoerper                        */
         
		        a4 = mshom( p, a4i );
		        a6 = mshom( p, a6i );
	                
		        if( p < SHANKS )
		        {
		            m = ecmspsnfnp( p, a4, a6 );
		        }
		        else
		        {
                            list P;
        
                            init( P );

                            P = ecmpsnffp( p, a4, a6 );
                            P = ecmpsnfmsha1( p, a4, a6, P, 0, 1, 0, 0 );
                            if( ( lfirst( P ) < 0 ) 
                            ||  ( lthird( P ) <= 4 * sqrt( p ) ) )
                            {
		                m = ecmspsnfnp( p, a4, a6 );
                            }
                            else
                            {
                                m = lsecond( P );
                            }
		        }
                        A[i] = 1 + p - m;		
                
                    }
                    else   /* n = p^e, e > 1 */
                    {
                        /*   Index des n-ten Koeffizienten ist         */
                        /*   eine echte Primzahlpotenz	               */
            
                        e -= 2;
		        f = 1;
		        while( e )
		        {
			    f *= p;
			    e--;
		        }
    
		        if( A[p] || A[f] )
		        {
                            A[i] = A[p] * A[f * p] - p * A[f];
		        }
		        else
		        {
			    A[i] = 0;
		        }
                     
                    }
                }
            /*   Index des n-ten Koeffizienten ist eine reine          */
            /*   Primzahlpotenz: n = p^e (Ende)                        */
            }
            else 
            {
                /*   Index des n-ten Koeffizienten zusammengesetzt     */
                A[i] = A[m] * A[f];
            }
            i++;
        }  /**** while( i <= n) ENDE ****/
    
        A[0] = n;
        free( add );
    }  /**** if( ... == NULL ) ... else  (Ende) ****/

    return( A );
}

/***************   Ende von  e c r c l s e r   ****************/
