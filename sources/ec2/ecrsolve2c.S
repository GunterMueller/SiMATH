/*M
.SH NAME
ecrsolve2c - curve over the rational numbers, solve 2-covering

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecrsolve2c(a, b, c, d, e, lx, ux, lz, uz)
single a, b, c, d, e; 
floating lx, ux, lz, uz;

.SH DESCRIPTION
ecrsolve2c() returns a list L = (x, y, z) representing
an integer solution (x, y, z) in Z^3 of the quartic equation 
.PP
  Q: y^2 = a*x^4 + b*x^3*z + c*x^2*z^2 + d*x*z^3 + e*z^4
.PP
within the range exp(lx) <= |x| <= exp(ux) and exp(lz) <= z <= exp(uz).
The quartic Q is an equation for a 2-covering of an elliptic curve E/Q.
In case of an error, ecrsolve2c() either returns an empty list or
a list L = (k) where k indicates the location of the error.

.PP
.TP 4
.B a, b, c, d, e
are the coefficients of the equation.

.TP 4
.B lx, ux, lz, uz
are the bounds of the search range.

.SH REFERENCES
J.E. Cremona, "Algorithms for modular elliptic curves", Cambridge University Press (1992).

.SH SEE ALSO
ecrinit
M*/
/*H
        Version 1       21.10.1995      Josef Gebel
        Version 2       25.01.1996      Fehler beseitigt. JG
        Version 3       06.12.1996      Beschleunigt. JG
   DATE ecrrank2d     : 951201.960201.970101
H*/

#include <_ec2.h>
#include <assert.h>

/**********************************************************************/
/***                                                                ***/
/***   Constants and global variables                   BEGINNING   ***/
/***                                                                ***/
/**********************************************************************/

#define MAXL   65535   /***   maximal length of the sieve array    ***/
#define MAXPRIM 1000   /***   maximal length of the sieve array    ***/
#define MAXPRIM1 100   /***   maximal length of the sieve array    ***/
                  
#define N1 3        /***   number of 'large' sieve modules       ***/

single  N2,         /***   number of 'small' sieve modules       ***/
        *M1,        /***   array containing the 'large' modules  ***/
        *M2,        /***   array containing the 'small' modules  ***/
                    /***     where M1[i] = M2[2*i] * M2[2*i+1]   ***/
        *adr,       /***   auxiliary variable to find the right  ***/
                    /***     address in the array Q2             ***/
        lb,         /***   length of the array B1                ***/
        zc;         /***   if zc != 0: B1 has to be computed     ***/
                    /***   if zc == 0: 'old' B1 is still valid   ***/
char   *B1,         /***   sieve array for the 'large' modules   ***/
       *S,          /***   sieve array                           ***/
       *Sz,         /***   sieve array                           ***/
       *Q2;         /***   array indicating wether a residue     ***/
                    /***     mod M2[i] is a square or not.       ***/

/**********************************************************************/
/***                                                  ***/
/***   Constants and global variables                   END   ***/
/***                                                  ***/
/**********************************************************************/

/**********************************************************************/
/***                                                  ***/
/***            B e g i n n i n g  o f   t h e                 ***/
/***                                                  ***/
/***               s t a t i c  -  b l o c k                  ***/
/***                                                  ***/
/**********************************************************************/

static sieve_gcd( z, m, s, t )
single z, m;
char *s, *t;
{
   switch( m )
   {
      case  11: if( !( z % 11 ) )
                {
                   if( ( z & 1 ) )
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 11;
                      }
                   }
                   else
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 22;
                      }
                   }
                }
                return;
      case  13: if( !( z % 13 ) )
                {
                   if( ( z & 1 ) )
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 13;
                      }
                   }
                   else
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 26;
                      }
                   }
                }
                return;
      case  17: if( !( z % 17 ) )
                {
                   if( ( z & 1 ) )
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 17;
                      }
                   }
                   else
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 34;
                      }
                   }
                }
                return;
      case  19: if( !( z % 19 ) )
                {
                   if( ( z & 1 ) )
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 19;
                      }
                   }
                   else
                   {
                      while( s < t )
                      {
                         *s = 1;
                         s += 38;
                      }
                   }
                }
                return;
      case  36: if( !( z & 1 ) )
                {
                   char *k;
                   for( k = s; k < t; k += 2 )
                   {
                      *k = 1;
                   }
                }
                if( !( z % 3 ) )
                {
                   char *k;
                   if( ( z & 1 ) )
                   {
                      for( k = s; k < t; k += 3 )
                      {
                         *k = 1;
                      }
                   }
                   else
                   {
                      for( k = s; k < t; k += 6 )
                      {
                         *k = 1;
                      }
                   }
                }
                return;
      case  49: if( !( z % 7 ) )
                {
                   char *k;
                   if( ( z & 1 ) )
                   {
                      for( k = s; k < t; k += 7 )
                      {
                         *k = 1;
                      }
                   }
                   else
                   {
                      for( k = s; k < t; k += 14 )
                      {
                         *k = 1;
                      }
                   }
                }
                if( !( z % 5 ) )
                {
                   char *k;
                   if( ( z & 1 ) )
                   {
                      for( k = s; k < t; k += 5 )
                      {
                         *k = 1;
                      }
                   }
                   else
                   {
                      for( k = s; k < t; k += 10 )
                      {
                         *k = 1;
                      }
                   }
                }
                return;
      default : return;
   }
}

static sieve_p( a, b, c, d, e, z, m, Q, T, T1 )
single a, b, c, d, e, z, m;
char *Q, *T, *T1;
{
   single a0, b0, c0, d0, e0;
   single X0, X1, X10, X2, X20, X21, X3, X30, X31, X32;
   char   *t1, *t2, *t;

   t1 = T;
   t2 = T + m;
   a0 = mshom( m, a );
   b0 = mshom( m, b );
   c0 = mshom( m, c );
   d0 = mshom( m, d );
   e0 = mshom( m, e );
   X0 = mshom( m, z );

   b0 = msprod( m, b0, X0 );
   X1 = msprod( m, X0, X0 );
   c0 = msprod( m, c0, X1 );
   X1 = msprod( m, X1, X0 );
   d0 = msprod( m, d0, X1 );
   X1 = msprod( m, X1, X0 );
   e0 = msprod( m, e0, X1 );

   X32 = 0;
   X31 = 0;
   X21 = 0;

   X3 = 0;
   X2 = 0;
   X1 = 0;
   X0 = a0 + b0 + c0 + d0;
   while( X0 >= m )
   {
      X0 -= m;
   }
   
   X30 = ( a0 << 2 );
   while( X30 >= m )
   {
      X30 -= m;
   }
 
   X20 = ( b0 << 1 ) + b0;
   X10 = X20 + X30 + ( c0 << 1 );
   while( X10 >= m )
   {
      X10 -= m;
   }
 
   X20 += ( a0 << 1 );
   X20 += X30;
   while( X20 >= m )
   {
      X20 -= m;
   }
 
   if( *( Q + e0 ) )
   {
      for( t = T; t < T1; t += m )
      {
         *t = 1;
      }
   }
 
   while( 1 )
   {
      e0 += X0;
      e0 += X1;
      e0 += X2;
      e0 += X3;
      while( e0 >= m )
      {
         e0 -= m;
      }
      
      t1++;
      if( *( Q + e0 ) )
      {
         for( t = t1; t < T1; t += m )
         {
            *t = 1;
         }
      }
 
      if( !( t1 - t2 ) )
      {
/***
         sieve_gcd( z, m, T, T1 );
***/
         return( 0 );
      }
 
      X1 += X10;
      if( X1 >= m )
      {
         X1 -= m;
      }
 
      X2  += X21;
      X21 += X20;
      if( X21 >= m )
      {
         X21 -= m;
      }
      X2 += X21;
      while( X2 >= m )
      {
         X2 -= m;
      }
 
      X3  += ( X32 << 1 );
      X3  += X32;

      X32 += X31;

      X3  += ( X31 << 1 );

      X31 += X30;
      if( X31 >= m )
      {
         X31 -= m;
      }
      X32 += X31;
      while( X32 >= m )
      {
         X32 -= m;
      }
      X3 += X31;
      while( X3 >= m )
      {
         X3 -= m;
      }
   }
   return( 0 );
}

static loc_sol_s( Q, a, b, c, d, e, x, z, p )
char *Q;
single a, b, c, d, e, x, z, p;
{
   /*** IMPORTANT: Modulus p must be smaller than 1024   ***/
   /***          such that ( x^2 + x ) * x + x < 2^30  ***/
   /***          still is a single precision integer   ***/
   single y, w;

   if( !z )
   {
      return( *( Q + a ) );
   }
   w = mshom( p, x );
   y = a * w + b;
   y *= w;
   y += c;
   y *= w;
   y += d;
   y *= w;
   y += e;
   y %= p;
   
   return( *( Q + y ) );
}

static loc_sol_m( Q, a, b, c, d, e, x, z, p )
char *Q;
single a, b, c, d, e, x, z, p;
{
   /*** IMPORTANT: Modulus p must be smaller than 1024   ***/
   /***          such that ( x^2 + x ) * x + x < 2^30  ***/
   /***          still is a single precision integer   ***/
   single y, w;

   if( !z )
   {
      return( *( Q + a ) );
   }
   w = mshom( p, x );
   y = a * w + b;
   if( y >> 15 )
   {
      y %= p;
   }
   y *= w;
   y += c;
   if( y >> 15 )
   {
      y %= p;
   }
   y *= w;
   y += d;
   if( y >> 15 )
   {
      y %= p;
   }
   y *= w;
   y += e;
   y %= p;
   
   return( *( Q + y ) );
}

static loc_sol_l( Q, a, b, c, d, e, x, z, p )
char *Q;
single a, b, c, d, e, x, z, p;
{
   /*** IMPORTANT: Modulus p must be smaller than 32768  ***/
   /***          such that x^2 + x < 2^30             ***/
   /***          still is a single precision integer   ***/
   single y, w;

   if( !z )
   {
      return( *( Q + a ) );
   }
   w = mshom( p, x );
   y = ( a * w + b ) % p;
   y *= w;
   y += c;
   y %= p;
   y *= w;
   y += d;
   y %= p;
   y *= w;
   y += e;
   y %= p;
   
   return( *( Q + y ) );
}

/*c
       get_squares) Q, p): computes all square mod p
               /  1 if i mod p is a square
         Q[i] = <
               \  0 if i mod p is no square
c*/

static get_squares( Q, p )
char *Q;
single p;
{
   single j, k, l;

   l = p >> 1;
   j = 1;
   k = 1;

   
   if( memset( Q, 0, p ) == NULL )
   { 
      /***  ERROR  # 6  ***/
      return( 6 );
   }
   *Q = *( Q + 1 ) = 1; 
   
   while( k < l )
   {
	j += k;
	k++;
	j += k;
	if( j >= p )
	{
         j -= p;
	}

	*( Q + j ) = 1;
   }
   return( 0 );
}

/* 
 * solmodp() is called with only six arguments. The last argument has been
 * removed. MP.
 * static solmodp( a, b, c, d, e, p, f )
 * single a, b, c, d, e, p, f;
 */

static solmodp(a, b, c, d, e, p)
single a, b, c, d, e, p;
{

  /*
   * Need to declare single f. MP.
   */
  
  single f;
  
  single q, x, y, z, A, B, bq;
  char   *Q, *Z;
  static get_squares();

   if( p > 100 )
   {
      return( 0 );
   }
   if( p > 10 )
   {
      f = 2;
   }
   else if( p > 3 )
   {
      f = 4;
   }
   else
   {
      f = 6;
   }

   q = sexp( p, f );
   Q = ( char * ) malloc( q * sizeof( char ) );
   get_squares( Q, q );

   x = q / p;
   Z = ( char * ) malloc( x * sizeof( char ) );
   memset( Z, 0, x );

   A  = mshom( q, a );
   bq = mshom( q, b );
   
   for( z = 0; z < q; z += p )
   {
      B = msprod( q, bq, z );

      if( f == 2 )
      {
         for( x = 1; x < q; x++ )
         {
            if( x % p )
            {
               y = msprod( q, A, x );
               y = mssum ( q, y, B );
               y = msprod( q, y, x );
               y = msprod( q, y, x );
               y = msprod( q, y, x );
      
               if( Q[y] )
               {
                  Z[ z / p ] = 1;
                  x = q;
               }
            }
         }
      }
      else
      {
         single cq, dq, eq, C, D, E;

         cq = mshom( q, c );
         dq = mshom( q, d );
         eq = mshom( q, e );
         y = msprod( q, z,  z );
         C = msprod( q, cq, y );
         y = msprod( q, y,  z );
         D = msprod( q, dq, y );
         y = msprod( q, y,  z );
         E = msprod( q, eq, y );

         for( x = 1; x < q; x++ )
         {
            if( x % p )
            {
               y = msprod( q, A, x );
               y = mssum ( q, y, B );
               y = msprod( q, y, x );
               y = msprod( q, y, x );
               y = mssum ( q, y, C );
               y = msprod( q, y, x );
               y = mssum ( q, y, D );
               y = msprod( q, y, x );
               y = mssum ( q, y, E );
      
               if( Q[y] )
               {
                  Z[ z / p ] = 1;
                  x = q;
               }
            }
         }
      }
   }

   free( Q );

   A = 0;
   y = 1;
   q /= p;
   for( x = 1; x <= f; x++ )
   {
      for( z = 0; z < q; z += y )
      {
         if( Z[z] )
         {
             z = q + 1;
         }
      }
      y *= p;
      if( z == q )
      {
         A = y;
         break;
      }
   }

   free( Z );
    
   return( A );
}


/**************   End of  g e t _ s q u a r e s   ********************/

/*c
      erg = loc_sol_sp( a, b, c, d, e, p, q, ZZ )
           / 0 if f( x, z ) soluble for z mod p (or if there was an ERROR)
      erg = <  1 if f( x, z ) not soluble for z = z0 mod p and z0 != 0
           \ 2 if f( x, z ) not soluble for z = 0  mod p
c*/

static loc_sol_sp( a, b, c, d, e, p, q, ZZ )
single a, b, c, d, e, p, q;
char *ZZ;
{
   single x, y, z, zp, m, a0, b0, c0, d0, e0, erg;
   char *Q;

   if( ( Q = ( char * ) malloc( q ) ) == NULL )
   {
      return( 0 );
   }
   get_squares( Q, q );
   erg = 0;

   /***   1st Test: f( x, z ) soluble mod p for even z   ***/
   /***   Since gcd( x, z ) = 1 and z even we only have   ***/
   /***   to look at odd values of x.                 ***/
   /***   Also since z even we know z^4 * e = 0 mod p    ***/

   a0 = mshom( q, a );
   b0 = mshom( q, b );
   c0 = mshom( q, c );
   d0 = mshom( q, d );
   e0 = mshom( q, e );

   for( z = 0; z < q; z++ )
   {
      x = 0;
      if( z % p )
      {
         zp = 0;
      }
      else
      {
         zp = 1;
      }

      while( x < q )
      {
         if( zp && !( x % p ) )
         {
            /***   p | gcd( x, z ) ***/
            x++;
         }

         m = ( a0 * x + b0 * z ) % q;
         m *= x;
         y = ( z * z ) % q;
         m += ( c0 * y );
         m %= q;
         m *= x;
         y = ( y * z ) % q;
         m += ( d0 * y );
         m %= q;
         m *= x;
         y = ( y * z ) % q;
         m += ( e0 * y );

         if( Q [ m % q ] )
         {
            /***   Solution found   ***/
            m = 0;
            x = q;
         }
         x++;
      }
      if( m )
      {
         /***   f( x, y ) not soluble for y = z mod q  ***/
         ZZ[ z ] = 1;
         if( !erg )
         {
            /***   f( x, y ) not soluble for y = z mod q     ***/
            erg = 2;
         }
         if( !zp )
         {
            /***   f( x, y ) not soluble for   ***/
            /***     y = z mod q  and  z != 0  ***/
            erg = 1;
         }
      }
      else
      {
         ZZ[ z ] = 0;
      }
   }
   
   if( erg && ( p == 2 ) )
   {
      x = erg & 1;
      while( x < q )
      {
         if( !ZZ[ x ] )
         {
            erg = 0;
            break;
         }
         x += 2;
      }
   }
   return( erg );
}

/**************   End of  n o n _ r e s 2   ***************************/

/*c
      L = non_res( a, b, c, d, e )
      L = ( L1  L2 ) 
      L1 = ( p1  p2  p3 ... pk )
      L2 = ( pp1, pp2, pp3, qq1 )
      pp1, pp2, pp3 are the products over the smallest primes p 
      such that y^2 = f( x, z ) is not p-adically soluble for p | z
      pp4 is the largest prime that divides pp1 * pp2 * pp3.
      qq1 is the product over the smallest primes p that do not
      divide pp1 * pp2 * pp3.
c*/

static list non_res( a, b, c, d, e )
single a, b, c, d, e;
{
   single p, j, s, t, a0, f;
   single qq;
   int    q;
   list L1, L2;
 
   static solmodp();
 
   init( L1, L2, q );
 
   q = 1;
   p = 3;
   L1 = _0;
   L2 = _0;
 
   while( p < MAXPRIM )
   {
      if( isiprime( p ) > 0 )
      {
         j = 0;
         if( a0 = mshom( p, a ) )
          {
             if( ijacsym( a0, p ) == -1 )
             {
                 j = p;
             }
         }
         else
         {
             j = solmodp( a, b, c, d, e, p );
         }
         
         if( j )
         {
            /***   f( x, z ) not soluble mod p if z = 0 mod p   ***/
            L1 = lcomp( j, L1 );
         }
         else if( p < MAXPRIM1 )
         {
            j = p;
            if( p < 30 )
            {
               if( p < 10 )
               {
                  if( p < 7 )
                  {
                     if( p < 5 )
                     {
                        j *= p;
                     }
                     j *= p;
                  }
                  j *= p;
               }
               j *= p;
            }
            q = isprod( q, j );
            if( issingle( q ) )
            {
               qq = q;
            }
            else
            {
               L2 = lcomp2( p, qq, L2 );
               q = j;
            }
         }
      }
      p += 2;
   }
   L2 = lcomp2( MAXPRIM1, qq, L2 );
   L1 = linv( L1 );
   L2 = linv( L2 );
   return( list2( L1, L2 ) );
}

/**************   End of  n o n _ r e s   ****************************/

/*c
      L = q_find_roots( a, b, c, d, e )
      L is the list of all real roots of the polynomial
      f( x ) = a x^4 + b x^3 + c x^2 +d x + e.
      L = _0, ( x_1  x_2 ) or ( x_1  x_2  x_3  x_4 ) 
      with x_i < x_(i+1)
c*/

static list q_find_roots( a, b, c, d, e )
int a, b, c, d, e;
{
   single n, f;
   floating u, v, TOL;
   list     M;

   pol    P;
   list   L;
   
   init( P, L );
   init( M, u, v, TOL );

   bind( a, b, c, d, e );

   f = flinit( 40 );
   P = list6( 4, a, b, c, d, e );
   n = udprf( 1, P, 1, &L );
   FL_EPS = f;
   M = lfirst( L );

   if( n == 3 )
   { 
      L = _0;
      TOL = Cfltofl( 0.00001 );
 
      while( M != _0 )
      {
         u = fltofl( lfirst( M ) );
 
         v = itofl( a );
         v = flprod( v, u );
         v = flsum ( v, itofl( b ) );
         v = flprod( v, u );
         v = flsum ( v, itofl( c ) );
         v = flprod( v, u );
         v = flsum ( v, itofl( d ) );
         v = flprod( v, u );
         v = flsum ( v, itofl( e ) );
         v = flabs ( v );
         if( flcomp( v, TOL ) > 0 )
         {
            break;
         }
         L = lcomp( u, L );
         M = lred( M );
      }
      if( M == _0 )
      {
         return( linv( L ) );
      }
   }
   /***  ERROR  ***/
   return( 0 );
}

/**************   End of  q _ f i n d _ r o o t s   *******************/

static single z_sieve( l, a, b, c, d, e, z, L, Z2 )
single l, z, a, b, c, d, e;
list L;
char *Z2;
{
   single i, j, p;
   char   *s1, *k, *s;

   extern char   *Sz;
  
   if( ( Sz = ( char * ) memset( Sz, 0, l ) ) == NULL )
   { 
      /***  ERROR  # 1 ***/
      return( 13 );
   }

   s = Sz + l;
   p = 16;
   j = z % p;

   for( i = 0; i < p; i++ )
   {
      if( Z2[i] )
      {
         /***   f( x, z ) not soluble for z = i mod 16   ***/
         k = Sz + i - j;
         if( k < Sz )
         {
            k += p;
         }
         while( k < s )
         {
            *k = 1;
            k += p;
         }
      }
   }

   bind( L );

   while( L != _0 )
   {
      p = lfirst( L );
      L = lred( L );

      k = Sz;

      if( j = ( z % p ) )
      {
         k += ( p - j );
      }

      while( k < s )
      {
         *k = 1;
         k += p;
      }
   }
   return( 0 );
}

/*c
    n = qp_sieve( l, x, a, b, c, d, e )
    qp_sieve is the routine that does the sieving of y^2 = f( x, z ).
    n < 0: There is a prime among the sieving moduli for which 
         y^2 = f( x, z ) is not pp-adically soluble
    n = 0: The procedure worked correctly
    n > 0: There was an ERROR in the procedure
c*/

static single qp_sieve( l, x, a, b, c, d, e, z )
single x, l, z, a, b, c, d, e;
{
   single i, j, j1, m1, m2, x0;
   char   *b1, *s1, *k, *s;

   extern single *M1, *M2, *adr, zc;
   extern char   *B1, *S;

   m1 = ( 1 << N1 );
   m1 >>= 1;
  
   if( memset( S, ( char ) m1, l ) == NULL )
   { 
      /***  ERROR  # 1 ***/
      return( 13 );
   }

   if( zc && ( memset( B1, 0, lb ) == NULL ) )
   { 
      /***  ERROR  # 10  ***/
      return( 14 );
   }

   s  = S + l;
   b1 = B1;

   for( j1 = 0; j1 < N1; j1++ )
   {
      m1 = M1[j1];

      if( zc )
      {
         single j2, v, v1;

         extern char *Q2;
         
         s1 = b1 + m1;
         
         for( j2 = 0; j2 < 2; j2++ )
         {
            zc--;

            v  = ( j1 << 1 ) + j2;
            m2 = M2[ v ];

            sieve_p( a, b, c, d, e, z, m2, Q2 + adr[v], b1, s1 );
         }
      }
 
      x0 = mshom( m1, x );
      s1 = b1 + x0;
      i  = m1 - x0;
      m2 = smin( m1, l );

      for( j = 0; j < m2; j++ )
      {
         if( !( i-- ) )
         {
            s1 = b1;
         }
         if( !( *( s1++ ) ) )
         {
            /***  y^2 = a x0^4 + bz x0^3 + cx x0^2 + dz x0 + ez ***/
            /***  not soluble modulo m1 ==> not soluble in Z    ***/

            for( k = S + j; k < s; k += m1 )
            {
               (*k) >>= 1;
            }
         }
      }
      b1 += m1;
   }
   return( 0 );
}

/*******************   End of  q p _ s i e v e   *********************/

/*c
               qp_sieve_init( )

	"qp_sieve initialization"
      static single qp_sieve_init( )
	n = qp_sieve_init( );
      qp_sieve_init allocates and initializes all extern arrays  
	Return: 0 if successful, 
            n > 0 if ther was an allocation ERROR 
c*/

static single qp_sieve_init( )
{
   char   *q2;
   single i, j, k, l, m, n, p;
 
   extern single N2, *M1, *M2, *adr, lb;
   extern char   *B1, *S, *Q2;

   N2 = ( N1 << 1 );

   k = sizeof( single );

   if( ( M1 = ( single * ) malloc( N1 * k ) ) == NULL )
   {
      /***  ERROR # 1  ***/
	return( 1 );
   }

   if( ( M2 = ( single * ) malloc( N2 * k ) ) == NULL )
   {
      /***  ERROR # 2  ***/
	return( 2 );
   }

   if( ( adr = ( single * ) malloc( N2 * k ) ) == NULL )
   {
      /***  ERROR # 3  ***/
	return( 3 );
   }

   m = 0;
 
   for( i = 0; i < N2; i++ )
   {
      /***  M2SET  36 35 11 13 17 19 ***/
      switch( i )
      {
         case  0: M2[ i ] =  36;
                break;
         case  1: M2[ i ] =  11;
                break;
         case  2: M2[ i ] =  35;
                break;
         case  3: M2[ i ] =  13;
                break;
         case  4: M2[ i ] =  17;
                break;
         case  5: M2[ i ] =  19;
                break;
         default: return( 4 );
      }
      adr[ i ] = m;
      m += M2[ i ];
   }

   k =  m * sizeof( char );
   if( ( Q2 = ( char * ) malloc( k ) ) == NULL )
   {
      /***  ERROR # 5   ***/
	return( 5 );
   }
   if( memset( Q2, 1, k ) == NULL )
   { 
      /***  ERROR  # 6  ***/
      return( 6 );
   }

   q2 = Q2;

   for( i = 0; i < N2; i++ )
   {
	m = M2[ i ];
	l = m >> 1;
	j = 1;
	k = 1;

      /***  Q2[i] = 0 <==> i ist quadratischer Rest      mod m   ***/
      /***  Q2[i] = 1 <==> i ist quadratischer Nichtrest mod m   ***/

	*q2 = *( q2 + 1 ) = 0; 
      /***   0 und 1 sind quadratische Reste mod m   ***/

	while( k < l )
	{
	   j += k;
	   k++;
	   j += k;
	   if( j >= m )
	   {
		j -= m;
	   }

	   *( q2 + j ) = 0;
      }
      q2 += m;
   }

   lb = 0;

   for( i = 0; i < N1; i++ )
   {
      M1[ i ] = M2[ 2 * i ] * M2[ 2 * i + 1 ];
      lb += M1[ i ];
   }

   k = lb * sizeof( char );
   
   if( ( B1 = ( char * ) malloc( k ) ) == NULL )
   {
      /***  ERROR # 7   ***/
	return( 7 );
   }

   return( 0 );
}

/**************   End of  q p _ s i e v e _ i n i t   *****************/

/*c
      static free_global1()
      free_global frees all extern arrays
      Return: 0.
c*/

static glob_free()
{
   extern single *M1, *M2, *adr, zc;
   extern char   *B1, *S;

   free( M1 );
   free( M2 );
   free( adr );
   free( B1 );
   free( Q2 );
   free( S );

   return( 0 );
}
/******************   End of  g l o b _ f r e e   *********************/

/**********************************************************************/
/***                                                  ***/
/***                 E n d  o f   t h e                      ***/
/***                                                  ***/
/***               s t a t i c  -  b l o c k                  ***/
/***                                                  ***/
/**********************************************************************/

list ecrsolve2c( a, b, c, d, e, lx, ux, lz, uz )
single   a, b, c, d, e;
floating lx, ux, lz, uz;
{
   if( a > 0 )
   {
      single y;

      y = isqrt( a );
      if( !( y * y - a ) )
      {
         /***   a is a square: trivial solution   ***/
         /***   ( x  y  z ) = ( 1  sqrt(a)  0 )   ***/

         return( list3( 1, y, 0 ) );
      }
   }
   if( e > 0 )
   {
      single y;

      y = isqrt( e );
      if( !( y * y - e ) )
      {
         /***   e is a square: trivial solution   ***/
         /***   ( x  y  z ) = ( 0  sqrt(e)  1 )   ***/

         return( list3( 0, y, 1 ) );
      }
   }
   {
   char     *Qp01;
   single   p01, bzp01, czp01, dzp01, ezp01;
   single   ap01, bp01, cp01, dp01, ep01, zp01;

   char     *Qp02;
   single   p02, bzp02, czp02, dzp02, ezp02;
   single   ap02, bp02, cp02, dp02, ep02, zp02;

   char     *Qp03;
   single   p03, bzp03, czp03, dzp03, ezp03;
   single   ap03, bp03, cp03, dp03, ep03, zp03;

   char     *Qp04;
   single   p04, bzp04, czp04, dzp04, ezp04;
   single   ap04, bp04, cp04, dp04, ep04, zp04;

   char     *Qp05;
   single   p05, bzp05, czp05, dzp05, ezp05;
   single   ap05, bp05, cp05, dp05, ep05, zp05;

   char     *Qp06;
   single   p06, bzp06, czp06, dzp06, ezp06;
   single   ap06, bp06, cp06, dp06, ep06, zp06;

   char     *Qp07;
   single   p07, bzp07, czp07, dzp07, ezp07;
   single   ap07, bp07, cp07, dp07, ep07, zp07;

   char     *Qp08;
   single   p08, bzp08, czp08, dzp08, ezp08;
   single   ap08, bp08, cp08, dp08, ep08, zp08;

   char     *Qp09;
   single   p09, bzp09, czp09, dzp09, ezp09;
   single   ap09, bp09, cp09, dp09, ep09, zp09;

   char     *s, *s1, *s0, *sz, Z2[16];
   single   pp1, pp2, pp3, pp4, qq1, s2;
   single   as, flag, flag1, sl, i, k, l, l1, n, nr, nr1;
   single   x, z, x1, x2, x3, x4, w1, w2, z1, z2, z3;
   single   v1, v2, v3, v4;
   int      w, y;
   list     F, L, M;
   floating u1, u2, u3, u4, fl;

   static glob_free(), get_squares(), qp_sieve_init(), qp_sieve();
   static list q_find_roots();
 
   extern single *MM, zc;
   extern char   *S, *Sz;

   if( n = qp_sieve_init( ) )
   {
      glob_free( );
      return( list1( n ) );
   }

   x1 = 0;
   x2 = 0;
   x3 = 0;
   w1 = 0;
   w2 = 0;
   z1 = 0;
   z2 = 0;
   bind( lx, ux, lz, uz );

   init( w, y );
   init( u1, u2, u3, u4, fl );
   init( F, L, M );

   M = non_res( a, b, c, d, e );
   L = lfirst ( M );
   F = lsecond( M );

   s2 = loc_sol_sp( a, b, c, d, e, 2, 16, Z2 );
   /***  SET P0   ***/

   p01 = 667;
   p02 = 1147;
   p03 = 1763;
   p04 = 2491;
   p05 = 3599;
   p06 = 4757;
   p07 = 5767;
   p08 = 7387;
   p09 = 9797;

   ap01 = mshom( p01, a );
   bp01 = mshom( p01, b );
   cp01 = mshom( p01, c );
   dp01 = mshom( p01, d );
   ep01 = mshom( p01, e );
   if( ( Qp01 = ( char * ) malloc( p01 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp01, p01 );

   ap02 = mshom( p02, a );
   bp02 = mshom( p02, b );
   cp02 = mshom( p02, c );
   dp02 = mshom( p02, d );
   ep02 = mshom( p02, e );
   if( ( Qp02 = ( char * ) malloc( p02 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp02, p02 );

   ap03 = mshom( p03, a );
   bp03 = mshom( p03, b );
   cp03 = mshom( p03, c );
   dp03 = mshom( p03, d );
   ep03 = mshom( p03, e );
   if( ( Qp03 = ( char * ) malloc( p03 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp03, p03 );

   ap04 = mshom( p04, a );
   bp04 = mshom( p04, b );
   cp04 = mshom( p04, c );
   dp04 = mshom( p04, d );
   ep04 = mshom( p04, e );
   if( ( Qp04 = ( char * ) malloc( p04 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp04, p04 );

   ap05 = mshom( p05, a );
   bp05 = mshom( p05, b );
   cp05 = mshom( p05, c );
   dp05 = mshom( p05, d );
   ep05 = mshom( p05, e );
   if( ( Qp05 = ( char * ) malloc( p05 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp05, p05 );

   ap06 = mshom( p06, a );
   bp06 = mshom( p06, b );
   cp06 = mshom( p06, c );
   dp06 = mshom( p06, d );
   ep06 = mshom( p06, e );
   if( ( Qp06 = ( char * ) malloc( p06 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp06, p06 );

   ap07 = mshom( p07, a );
   bp07 = mshom( p07, b );
   cp07 = mshom( p07, c );
   dp07 = mshom( p07, d );
   ep07 = mshom( p07, e );
   if( ( Qp07 = ( char * ) malloc( p07 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp07, p07 );

   ap08 = mshom( p08, a );
   bp08 = mshom( p08, b );
   cp08 = mshom( p08, c );
   dp08 = mshom( p08, d );
   ep08 = mshom( p08, e );
   if( ( Qp08 = ( char * ) malloc( p08 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp08, p08 );

   ap09 = mshom( p09, a );
   bp09 = mshom( p09, b );
   cp09 = mshom( p09, c );
   dp09 = mshom( p09, d );
   ep09 = mshom( p09, e );
   if( ( Qp09 = ( char * ) malloc( p09 ) ) == NULL )
   {
      return( list1( 8 ) );
   }
   get_squares( Qp09, p09 );

   n = 0;

   if( flsign( lx ) < 0 )
   {
      lx = 0;
   }
   if( flsign( lz ) < 0 )
   {
      lz = 0;
   }
   if( ( flcomp( lx, ux ) >= 0 ) || ( flcomp( lz, uz ) >= 0 ) )
   {
      glob_free();
      return( _0 );
   }

   fl = flexp( ux );
   x2 = flfloor( fl );
   w2 = x2 + 1;

   if( lx )
   {
      flag = 2;
      fl = flexp( lx );
      w1 = flfloor( fl );
      sl = idif( w2, w1 );
   }
   else
   {
      flag = 1;
      w1 = -w2;
      sl = w2 << 1;
      x1 = w1;
   }

   sl = smax( sl, MAXL );

   if( ( S = ( char * ) malloc( sl * sizeof( char ) ) ) == NULL )
   {
      /***  ERROR 12    ***/
      glob_free();
      return( list1( 12 ) );
   }
   /**   Allocation of the sieve array            ( E N D )   **/

   fl = flexp( lz );
   z1 = flfloor( fl );
   fl = flexp( uz );
   z2 = flfloor( fl );
   z2 = isum ( z2, 1 );

   sl = smin( z2 - z1, MAXL );

   if( ( Sz = ( char * ) malloc( sl * sizeof( char ) ) ) == NULL )
   {
      /***  ERROR 12    ***/
      glob_free();
      return( list1( 12 ) );
   }
      
   nr = 1;

   as = isign( a );
   M = q_find_roots( a, b, c, d, e );

   if( !M )
   {
      /***  ERROR 11   ***/
      glob_free();
      return( list1( 11 ) );
   }

   if( M != _0 )
   {
      u1 = lfirst ( M );
      u2 = lsecond( M );
      M  = lred2( M );
      nr += 2;
 
      if( M != _0 )
      {
         u3 = lfirst ( M );
         u4 = lsecond( M );
         nr += 2;
      }
   }
   else if( as < 0 )
   {
      /***   p( x ) has no roots and p( x ) < 0               ***/
      /***        ==> y^2 = p( x ) < 0 has no solution in Q      ***/
      glob_free();
      return( _0 );
   }
   
   if( as < 0 )
   {
      nr--;
      as = 0;
   }

   /**   Beginnng of the sieving                          **/
   z = z1;
   while( z2 > z )
   {
      l = smin( z2 - z, MAXL );
      z3 = z + l;

      if( z_sieve( l, a, b, c, d, e, z, L, Z2 ) )
      {
         /***  ERROR 12    ***/
         glob_free();
         return( list1( 12 ) );
      }

      sz = Sz;

      while( z3 > z )
      {
         /***   Test whether there is a prime p | z such that  ***/
         /***      y^2 = f( x, z ) is not soluble modulo p.    ***/
         while( 1 )
         {
            while( *( sz++ ) )
            {
               /***      f( x, z ) not soluble mod p, p > 2      ***/
               /***   or f( x, z ) not soluble for z = 1 mod 2   ***/
               /***   or f( x, z ) not soluble for z = 0 mod 2   ***/
               z++;
            }
            /***   Factor z and find out if there is a prime p mot   ***/
            /***   in L, for which f( x, z ) not soluble mod p  ***/
            w = z;
            while( !( w & 1 ) )
            {
               /***   Reduce z ( = w ) by powers of 2  ***/ 
               w >>= 1;
            }
            
            M = F;
            k = 1;
            while( ( M != _0 ) && ( w > 1 ) )
            {
               /***   Reduce z ( = w ) by all (small) primes p   ***/ 
               /***   for which f( x, z ) is soluble modulo p    ***/ 
               l = lfirst ( M );
               n = lsecond( M );
 
               while( ( y = sgcd( w, l ) ) > 1 )
               {
                  w /= y;
               }
               if( w < n )
               {
                  break;
               }
               M = lred2( M );
            }

            if( !( w - 1 ) )
            {
               l = 0;
               break;
            }

            M = ifel( sfact( w ) );

            while( M != _0 )
            {
               l = lfirst( M );
               if( ( l > MAXPRIM ) && ( ijacsym( a, l ) == -1 ) )
               {
                  break;
               }
               M = lred2( M );
               
               if( M == _0 )
               {
                  /***   There is no prime p | z such that     ***/
                  /***   y^2 = f( x, z ) is not soluble mod p. ***/
                  l = 0;
                  break;
               }
            }
            if( !l )
            {
               break;
            }
            /***  y^2 = f( x, z ) not soluble mod p ==>          ***/
            /***  y^2 = f( x, z ) not soluble in Z for this z    ***/
            /***  Increase z                               ***/
            z++;
         }

         zp01 = z % p01;
         bzp01 = ( bp01 * zp01 ) % p01;
         l     = ( zp01 * zp01 ) % p01;
         czp01 = ( cp01 * l    ) % p01;
         l     = ( zp01 * l    ) % p01;
         dzp01 = ( dp01 * l    ) % p01;
         l     = ( zp01 * l    ) % p01;
         ezp01 = ( ep01 * l    ) % p01;
   
         *Qp02 = 0;
         *Qp03 = 0;
         *Qp04 = 0;
         *Qp05 = 0;
         *Qp06 = 0;
         *Qp07 = 0;
         *Qp08 = 0;
         *Qp09 = 0;
   
         zc = N2;
         /***   New z: The sieve arrays have to be recomputed     ***/
   
         if( nr > 1 )
         {
            /***   The bounds for the sieving intervals must     ***/
            /***   be changed (since the roots of f( x, z )      ***/
            /***   have changed)                            ***/
            fl = itofl( z );
            v1 = flfloor( flprod( u1, fl ) );
            v2 = flfloor( flprod( u2, fl ) );
            if( as )
            {
               v2++;
            }
            else
            {
               v1++;
            }
   
            if( nr > 3 )
            {
               v3 = flfloor( flprod( u3, fl ) );
               v4 = flfloor( flprod( u4, fl ) );
               if( as )
               {
                  v4++;
               }
               else
               {
                  v3++;
               }
            }
            else
            {
               v3 = x2 + 1;
               v4 = v3;
            }
         }
         else
         {
            v1 = x2;
            v2 = x2;
            v3 = x2;
            v4 = x2;
         }
   
         flag1 = flag;
         while( flag1 )
         {
            switch( flag1 )
            {
               case 1:   /** Sieve in I1 = [w1, w2] X [z1, z2]  **/
   
                    x1 = w1;
                    x2 = w2;
                    break;
   
               case 2: /** Sieve in I2 = [-w2, -w1] X [z1, z2]   **/
   
                    x2 = -w1;
                    x1 = -w2;
                    break;
   
            }
            flag1--;
   
            nr1 = nr;
   
            while( nr1 )
            {
               /***   Different sieving intervals depending   ***/
               /***   on the number of real roots of          ***/
               /***       a x^4 + b x^3 + c x^2 + d x + e     ***/
               /***   and the sign of a.                     ***/
   
               switch( nr1 )
               {
                  case  1: nr1 = 0;
                         x3 = smin( v1, x1 );
                         x4 = smin( v1, x2 );
                         break;
                  case  2: nr1 = 0;
                         x3 = smax( v1, x1 );
                         x4 = smin( v2, x2 );
                         break;
                  case  3: nr1 = 1;
                         x3 = smax( v2, x1 );
                         x4 = smin( v3, x2 );
                         break;
                  case  4: nr1 = 2;
                         x3 = smax( v3, x1 );
                         x4 = smin( v4, x2 );
                         break;
                  case  5: nr1 = 3;
                         x3 = smax( v4, x1 );
                         x4 = smax( v3, x2 );
                         break;
                  default: break;
               }
   
               if( !b && !d )
               {
                  x3 = smax( x3, 0 );
               }

               if( ( x4 - x3 ) > 1 )
               {
                  x3--;
                  x4++;
               }

               while( x4 > x3 )
               {
                  /***   Initialize the sieve array with zeros   ***/
                  l = smin( sl, x4 - x3 ) + 1;
                  if( ( k = qp_sieve( l, x3, a, b, c, d, e, z ) ) > 0 )
                  {
                     /***   ERROR in the sieving routine      ***/
                     return( list1( k ) );
                  }
                  /***   Evaluation of the sieve array         ***/

                  s  = S;
                  l1 = l;
                                         
                  while( s1 = ( char * ) memchr( s, 0, l1 ) )
                  {
                     x  = x3 + s1 - S;
                     s0 = s1 + 1;
                     l1 -= ( ( single ) s0 );
                     l1 += ( ( single ) s );
                     s   = s0;

                     /***   f(x) is possibly a square in Z  ***/
                     if( loc_sol_m( Qp01, ap01, bzp01, czp01, dzp01, ezp01, x, zp01, p01 ))
                     {
                        if( !*Qp02 )
                        {
                           *Qp02 = 1;
                           zp02 = z % p02;
                           bzp02 = ( bp02 * zp02 ) % p02;
                           n     = ( zp02 * zp02 ) % p02;
                           czp02 = ( cp02 * n    ) % p02;
                           n     = ( zp02 * n    ) % p02;
                           dzp02 = ( dp02 * n    ) % p02;
                           n     = ( zp02 * n    ) % p02;
                           ezp02 = ( ep02 * n    ) % p02;
                        }
                        if( loc_sol_m( Qp02, ap02, bzp02, czp02, dzp02, ezp02, x, zp02, p02 ))
                        {
                           if( !*Qp03 )
                           {
                              *Qp03 = 1;
                              zp03 = z % p03;
                              bzp03 = ( bp03 * zp03 ) % p03;
                              n     = ( zp03 * zp03 ) % p03;
                              czp03 = ( cp03 * n    ) % p03;
                              n     = ( zp03 * n    ) % p03;
                              dzp03 = ( dp03 * n    ) % p03;
                              n     = ( zp03 * n    ) % p03;
                              ezp03 = ( ep03 * n    ) % p03;
                           }
                           if( loc_sol_m( Qp03, ap03, bzp03, czp03, dzp03, ezp03, x, zp03, p03 ))
                           {
                              if( !*Qp04 )
                              {
                                 *Qp04 = 1;
                                 zp04 = z % p04;
                                 bzp04 = ( bp04 * zp04 ) % p04;
                                 n     = ( zp04 * zp04 ) % p04;
                                 czp04 = ( cp04 * n    ) % p04;
                                 n     = ( zp04 * n    ) % p04;
                                 dzp04 = ( dp04 * n    ) % p04;
                                 n     = ( zp04 * n    ) % p04;
                                 ezp04 = ( ep04 * n    ) % p04;
                              }
                              if( loc_sol_m( Qp04, ap04, bzp04, czp04, dzp04, ezp04, x, zp04, p04 ))
                              {
                                 if( !*Qp05 )
                                 {
                                    *Qp05 = 1;
                                    zp05 = z % p05;
                                    bzp05 = ( bp05 * zp05 ) % p05;
                                    n     = ( zp05 * zp05 ) % p05;
                                    czp05 = ( cp05 * n    ) % p05;
                                    n     = ( zp05 * n    ) % p05;
                                    dzp05 = ( dp05 * n    ) % p05;
                                    n     = ( zp05 * n    ) % p05;
                                    ezp05 = ( ep05 * n    ) % p05;
                                 }
                                 if( loc_sol_m( Qp05, ap05, bzp05, czp05, dzp05, ezp05, x, zp05, p05 ))
                                 {
                                    if( !*Qp06 )
                                    {
                                       *Qp06 = 1;
                                       zp06 = z % p06;
                                       bzp06 = ( bp06 * zp06 ) % p06;
                                       n     = ( zp06 * zp06 ) % p06;
                                       czp06 = ( cp06 * n    ) % p06;
                                       n     = ( zp06 * n    ) % p06;
                                       dzp06 = ( dp06 * n    ) % p06;
                                       n     = ( zp06 * n    ) % p06;
                                       ezp06 = ( ep06 * n    ) % p06;
                                    }
                                    if( loc_sol_m( Qp06, ap06, bzp06, czp06, dzp06, ezp06, x, zp06, p06 ))
                                    {
                                       if( !*Qp07 )
                                       {
                                          *Qp07 = 1;
                                          zp07 = z % p07;
                                          bzp07 = ( bp07 * zp07 ) % p07;
                                          n     = ( zp07 * zp07 ) % p07;
                                          czp07 = ( cp07 * n    ) % p07;
                                          n     = ( zp07 * n    ) % p07;
                                          dzp07 = ( dp07 * n    ) % p07;
                                          n     = ( zp07 * n    ) % p07;
                                          ezp07 = ( ep07 * n    ) % p07;
                                       }
                      
                                       if( loc_sol_m( Qp07, ap07, bzp07, czp07, dzp07, ezp07, x, zp07, p07 ))
                                       {
                                          if( !*Qp08 )
                                          {
                                             *Qp08 = 1;
                                             zp08 = z % p08;
                                                bzp08 = ( bp08 * zp08 ) % p08;
                                             n     = ( zp08 * zp08 ) % p08;
                                             czp08 = ( cp08 * n    ) % p08;
                                             n     = ( zp08 * n    ) % p08;
                                             dzp08 = ( dp08 * n    ) % p08;
                                             n     = ( zp08 * n    ) % p08;
                                             ezp08 = ( ep08 * n    ) % p08;
                                          }
                                          if( loc_sol_m( Qp08, ap08, bzp08, czp08, dzp08, ezp08, x, zp08, p08 ))
                                          {
                                             if( !*Qp09 )
                                             {
                                                *Qp09 = 1;
                                                zp09 = z % p09;
                                                bzp09 = ( bp09 * zp09 ) % p09;
                                                n     = ( zp09 * zp09 ) % p09;
                                                czp09 = ( cp09 * n    ) % p09;
                                                n     = ( zp09 * n    ) % p09;
                                                dzp09 = ( dp09 * n    ) % p09;
                                                n     = ( zp09 * n    ) % p09;
                                                ezp09 = ( ep09 * n    ) % p09;
                                             }
                                             if( loc_sol_m( Qp09, ap09, bzp09, czp09, dzp09, ezp09, x, zp09, p09 ) )
                                             {
                                                int u;
                                                init( u );
                                                      
                                                w = isprod( a, x );
                                                u = isprod( z, b );
                                                w = isum  ( w, u );
                                                y = isprod( z, z );
                                                w = isprod( w, x );
                                                u = isprod( y, c );
                                                w = isum  ( w, u );
                                                y = isprod( y, z );
                                                w = isprod( w, x );
                                                u = isprod( y, d );
                                                w = isum  ( w, u );
                                                w = isprod( w, x );
                                                y = isprod( y, z );
                                                u = isprod( y, e );
                                                w = isum  ( w, u );
                
                                                /***   w = f( x, z )  ***/
                                             
                                                if( isign( w ) >= 0 )
                                                {
                                                   y = isqrt( w );
                                                    
                                                   if( !idif( iprod( y, y ), w ) )
                                                   {
                                                      /***   y^2 = f( x, z )    ***/
                                                      /***   solution           ***/
                                                      /***   ( x, y, z )        ***/
                                                      w = sgcd( x, z );
                                                      x = iquot( x, w );
                                                      y = iquot( y, w );
                                                      y = iquot( y, w );
                                                      z = iquot( z, w );
                                                      glob_free();
                                                      M = list3( x, y, z );
                                                      return( M );
                                                   } /**  if( !u )  **/
                                                } /**  if( isign( w ) >= 0 ) **/
                                             } /**  if( loc_sol_m( p09 ) )  **/
                                          } /**  if( loc_sol_m( p08 ) )  **/
                                       } /**  if( loc_sol_m( p07 ) ) **/
                                    } /**  if( loc_sol_m( p06 ) )  **/
                                 } /**  if( loc_sol_m( p05 ) )  **/
                              } /**  if( loc_sol_m( p04 ) )  **/
                           } /**  if( loc_sol_m( p03 ) )  **/
                        } /**  if( loc_sol_m( p02 ) )  **/
                     } /**  if( loc_sol_m( p01 ) )  **/
                  } /**  while( s1 = ( char * ) memchr( s, 0, l1 ) )  **/
                  x3 += l;
               } /**  while( x4 > x3 )  **/
            } /**  while( nr1 )  **/
         } /**  while( flag1 )  **/
         z++;
      } /**  while( z3 > z )  **/
   } /**  while( z2 > z )  **/
   glob_free( );
   return( _0 );
   }
}
