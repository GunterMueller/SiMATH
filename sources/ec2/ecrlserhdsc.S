/*M
.SH NAME
ecrlserhdsc - elliptic curve over rational numbers, L-series, higher derivative,small conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrlserhdsc(E, A, r, result) 
list E;  
single *A, r;  
double *result;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.  
.PP
Let N be the conductor of the elliptic curve E/Q, let M = (sqrt(N))^-1, then ecrlserhdsc computes (approximates) the sum over the terms
.IP
 2 * Pi * a_n * I_n,  where I_n =
.PP
  oo                                                                
 (        r              r     r       -2*Pi*n*y         
  \   (log (y) + C * (-1) * log (N*y))*e          dy  
   )                                                        
  M
.PP
for n = 1 ... infinity.
.PP
ecrlserhdsc writes the result to result and returns a pointer to an array, containig the coefficients a_i of the L-series (s. ecrclser). In case of an error occurs, ecrlserhdsc returns NULL.

.SH NOTES
The conductor should be smaller than 10^6, because otherwise eclserhdlc is faster.
 
.SH SEE ALSO
 ecrinit
 ecrclser
 ecrlserhdlc

M*/
                           
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	19.01.1993	ECRLSERHDS --> ECRLSERHDSC
					Anpassung an neues Konzept. JG
   DATE ecrlserhdsc    : 921130.930531
H*/

#include <_ec2.h> 

#define EL       12                     /*  EL viele Integrale  */
                                        /*   werden gleich-     */
                                        /*   zeitig berechnet.  */

#define PI2      6.283185307179586      /*   2 * PI */
#define _PI2    -6.283185307179586      /* - 2 * PI */

static single romberg(single,single,double,double,double,double*,single[]);

single *ecrlserhdsc( E, A, r, res )
list E;
single *A, r;
double *res;
{
    single i, k, n, vz, j = 0, flag = 5, ixv[ EL ], C;
    double lgN, sqrtiN, dh, summand, isqrtN, ev[ EL ], T0;
    floating flh;
    int N;

    single *ecrclser(  );
    double fltoCfl( );

    *res = 0.0;
  
    bind( E );

    init( N );
    init( flh );
    
    N = ecrcond( E );
    C = ecrsign( E );

    flh = itofl( N );
    flh = fllog( flh );
    lgN = fltoCfl( flh );

    flh = itofl( N );
    flh = flsqrt( flh );
    sqrtiN = 1.0 / fltoCfl( flh );

    k = r + 1;
    N = ifactl( k );
    dh = fltoCfl( itofl( N ) );
  
    T0 = ( double ) r * lgN + log( 2.0 * dh ) / 3.0;
    k = n = 0;
  
    if( ( ( C == 1 ) && ( r % 2 == 0 ) ) || ( ( C == -1 ) && ( r % 2 ) ) )
    {
	vz = 1;
    }
    else
    {
	vz = -1;
    }
  
    while( flag )
    {
        i = 0;
        while( i < EL )
        {
            k++;
            if( k > n )
            {  
                n += LS_STEP;
                A = ecrclser( E, A, n );
		if ( A == NULL )
		{
		    return( NULL );
		}
            }
            if( *( A + k ) )      
            {
	        *( ixv + i ) = k;
                i++;
            }
        }

	if( romberg( r, vz, T0, lgN, sqrtiN, ev, ixv ) == ERROR )
	{
	   return( NULL );
	}

        for( i = 0; i < EL; i++ )
        {
            *( ev + i ) *= *( A + *( ixv + i ) );
            *res        += *( ev + i );

            if( fabs( *( ev + i ) ) < LS_TOL1 ) 
            {
                j++;
                if( j == 50 )
                {
                    dh = fabs( *( ev + i ) / *res );
		    if( ( dh < LS_TOL2 )
                    ||  ( fabs( *res ) < LS_TOL1 ) )
                    {
                        /* Approximation ist gut genug        */
			flag--;
			if( flag < 0 )
			{
                           flag = 0;
			}
                    }
		    else
		    {
			flag = 5;
		    }
                    j = 0;
                }
            }
        }
    }
    *res *= PI2;
    return( A );
}

/*c
         	romberg( r, vz, T0, lgN, sqrtiN, ev, ixv )
	
	"romberg"
        static single romberg( r, vz, T0, lgN, sqrtiN, ev, ixv )
            single r, vz, ixv[ EL ]; double T0, lgN, sqrtiN, ev[ EL ];
	static Modul zu ecrlserhdsc.
        t = romberg( r, vz, T0, lgN, sqrtiN, ev, ixv );
	romberg berechnet ( approximiert ) mit dem Romberg'schen
	Integrationsverfahren die Integrale
             T0
	    (     /   r                 r      \     -2 * Pi * y
             \   | log ( y )  + vz * log ( Ny ) | * e              dy
          1/  )   \                            /
          /\/N
        fuer y = ixv[ k ], 0 <= k < EL.
	Rueckgabe: 0 bei Erfolg, ERROR sonst.
c*/
/*H
	Version 1	12.11.1992	Josef Gebel
H*/

static single romberg( r, vz, T0, lgN, sqrtiN, ergv, indexv )
single r, vz, indexv[EL];
double T0, lgN, sqrtiN, *ergv;
{
    double erg1v[EL], erg2v[EL], integv[EL], *feld, integ, mul, pi2_n, 
	   lg1, lg2, dh1, dh2, og, arg, mg, h1, h2, h3, h4, tol;
    single i , j, k, l, n, a1, a2, a3, K, M, diffv[EL];
  
    K = 105;         /*****  105 = 10 * 11 / 2   *****/
    tol = LS_TOL1 / 50.0;
    
    if( ( feld = ( double * ) calloc( EL * K, sizeof( double ) ) ) == NULL )
    {
        return( ERROR );
    }
        
    diffv[0] = 0;
    for( i = 1; i < EL; i++ )
    {
        diffv[i] = indexv[i] - indexv[i - 1];
    }

    feld = ( double * ) calloc( EL * K, sizeof( double ) );
    pi2_n = _PI2 * indexv[0];
    
    M = 4;

    h3  = T0 / ( ( double ) indexv[0] );
    og  = sqrtiN + h3;
    arg = 0.2 / ( double ) r;
    h3 *= arg;
    mg  = sqrtiN + h3;
    h1  = h3 / ( double ) M;
    h2  = h1 * ( 1 / arg - 1.0 );

    arg  = sqrtiN;
    lg1 = log( arg );
    lg2 = lg1 + lgN;
    dh1  = 1.0;
    dh2  = ( double ) vz;
    
    for( k = 0; k < r; k++ )
    {
        dh1 *= lg1;
        dh2 *= lg2;
    }

    integ = ( dh1 + dh2 ) * exp( pi2_n * arg );
    mul = exp( _PI2 * arg );

    for( l = 0; l < EL; l++ )
    {
        for( n = 0; n < diffv[l]; n++ )
	{
            integ *= mul;
	}
        integv[l] = integ;
    }

    lg1 = log( mg );
    dh1  = 1.0;
    dh2  = ( double ) vz;
    lg2 = lg1 + lgN;
    
    for( k = 0; k < r; k++ )
    {
        dh1 *= lg1;
        dh2 *= lg2;
    }
    
    integ = ( dh1 + dh2 ) * exp( pi2_n * mg );
    mul = exp( _PI2 * mg );
    
    for( l = 0; l < EL; l++ )
    {
        for( n = 0; n < diffv[l]; n++ )
	{
            integ *= mul;
	}
    
        integv[l] += integ;
        integv[l] *= ( 0.5 * h1 );
    }

    for( j = 1L; j < M; j++ )
    {
        arg += h1;
        lg1 = log( arg );
        dh1  = 1.0;
        dh2  = ( double ) vz;
        lg2 = lg1 + lgN;
    
        for( k = 0; k < r; k++ )
        {
            dh1 *= lg1;
            dh2 *= lg2;
        }
    
        integ = ( dh1 + dh2 ) * h1 * exp( pi2_n * arg );
        mul = exp( _PI2 * arg );
    
        for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
            integv[l] += integ;
        }
    }
    
    for( l = 0; l < EL; l++ )
    {
        feld[l] = integv[l];
    }

    i = 0;
    while( 1 )
    {
        i++;
        for( l = 0; l < EL; l++ )
	{
            erg1v[l] = 0.0;
	}
        arg = sqrtiN - h1 * 0.5;

        for( j = 1L; j <= M; j++ )
        {
            arg += h1;
            lg1 = log( arg );
            dh1  = 1.0;
            dh2  = ( double ) vz;
            lg2 = lg1 + lgN;
    
            for( k = 0; k < r; k++ )
            {
                dh1 *= lg1;
                dh2 *= lg2;  
	    }
    
            integ = ( dh1 + dh2 ) * h1 * exp( pi2_n * arg );
            mul = exp( _PI2 * arg );

            for( l = 0; l < EL; l++ )
            {
                for( n = 0; n < diffv[l]; n++ )
	        {
                    integ *= mul;
	        }
                erg1v[l] += integ;
            }
        }
        
	a1 = EL * ( ( i * ( i + 1 ) ) >> 1 );
        
	if( a1 >= K )
        {
            K += i;
            feld = ( double * ) realloc( feld, K * EL * sizeof( double ) );
        }
        
	for( l = 0; l < EL; l++ )
        {
            integv[l] = ( integv[l] + erg1v[l] ) * 0.5;
            feld[a1] = integv[l];
	    a1++;
        }
  
        M <<= 1;
        h1 *= 0.5;
        h3 = 1.0;
    
        for( k = 0; k < i; k++ )
        {
            h3 *= 4.0;
	    h4 = 1.0 / ( h3 - 1.0 );
            a1 = EL * ( ( ( i * ( i - 1 ) ) >> 1 ) + k );
            a2 = a1 + EL * i;
            a3 = a2 + EL;
            
	    for( l = 0; l < EL; l++ )
            {
                ergv[l] = feld[a2] + ( feld[a2] - feld[a1] ) * h4;
                feld[a3] = ergv[l];
		a1++;
		a2++;
		a3++;
            }
            
	    a1 = EL * ( ( ( i - 1 ) * ( i + 2 ) ) >> 1 );
        }
        
	if( ( fabs( ergv[0] - feld[a1] ) < tol ) || ( i == 20 ) )
        {
            break;
	}
    }
  
    if( i > 1 )               /* Falls i > 1 ist, muss auch das   */
    {                         /* 2. Teilintegral berechnet werden */
        i = 0;
        M = 4;
        arg = mg;

        lg1 = log( arg );
        dh1  = 1.0;
        dh2  = ( double ) vz;
        lg2 = lg1 + lgN;
        
	for( k = 0; k < r; k++ )
        {
            dh1 *= lg1;
            dh2 *= lg2;
        }
        
	integ = ( dh1 + dh2 ) * exp( pi2_n * arg );
        mul = exp( _PI2 * arg );
        
	for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
            integv[l] = integ;
        }
        
	lg1 = log( og );
        dh1  = 1.0;
        dh2  = ( double ) vz;
        lg2 = lg1 + lgN;
        
	for( k = 0; k < r; k++ )
        {
            dh1 *= lg1;
            dh2 *= lg2;
        }
        
	integ = ( dh1 + dh2 ) * exp( pi2_n * og );
        mul = exp( _PI2 * og );
        
	for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
            
	    integv[l] += integ;
            integv[l] *= ( 0.5 * h2 );
        }
        for( j = 1L; j < M; j++ )
        {
            arg += h2;
            lg1 = log( arg );
            dh1  = 1.0;
            dh2  = ( double ) vz;
            lg2 = lg1 + lgN;
            
	    for( k = 0; k < r; k++ )
            {
                dh1 *= lg1;
                dh2 *= lg2;
            }
            
	    integ = ( dh1 + dh2 ) * h1 * exp( pi2_n * arg );
            mul = exp( _PI2 * arg );
          
            for( l = 0; l < EL; l++ )
            {
                for( n = 0; n < diffv[l]; n++ )
	        {
                    integ *= mul;
	        }
                integv[l] += integ;
            }
        }
        for( l = 0; l < EL; l++ )
        {
            feld[l] = integv[l];
        }
  
        while( 1 )
        {
            i++;
            for( l = 0; l < EL; l++ )
	    {
                erg1v[l] = 0;
	    }
            arg = mg - h2 * 0.5;
  
            for( j = 1L; j <= M; j++ )
            {
                arg += h2;
                lg1 = log( arg );
                dh1  = 1.0;
                dh2  = ( double ) vz;
                lg2 = lg1 + lgN;
                
		for( k = 0; k < r; k++ )
                {
                    dh1 *= lg1;
                    dh2 *= lg2;
                }
                
		integ = ( dh1 + dh2 ) * h2 * exp( pi2_n * arg );
                mul = exp( _PI2 * arg );
            
                for( l = 0; l < EL; l++ )
                {
                    for( n = 0; n < diffv[l]; n++ )
	            {
                        integ *= mul;
	            }
	            erg1v[l] += integ;
                }
            }
            
	    a1 = EL * ( ( i * ( i + 1 ) ) >> 1 );
            
	    for( l = 0; l < EL; l++ )
            {
	        integv[l] = ( integv[l] + erg1v[l] ) * 0.5;
	        feld[a1]  = integv[l];
		a1++;
            }
  
            M <<= 1;
            h2 *= 0.5;
            h3 = 1.0;
  
            for( k = 0; k < i; k++ )
            {
                h3 *= 4.0;
	        h4 = 1.0 / ( h3 - 1.0 );
                a1 = EL * ( ( ( i * ( i - 1 ) ) >> 1 ) + k );
                a2 = a1 + EL * i;
                a3 = a2 + EL;

                for( l = 0; l < EL; l++ )
                {
	            erg2v[l] = feld[a2] + ( feld[a2] - feld[a1] ) * h4;
	            feld[a3] = erg2v[l];
		    a1++;
		    a2++;
		    a3++;
                }
                a1 = EL * ( ( i - 1 ) * ( i + 2 ) >> 1 );
            }
	    if( ( fabs( erg2v[0] - feld[a1] ) < tol ) || ( i == 20 ) )
	    {
                break;
	    }
        }
        for( l = 0; l < EL; l++ )
        {
            ergv[l] += erg2v[l];
	}
    }

    free( feld );
    return( 0 );
}
