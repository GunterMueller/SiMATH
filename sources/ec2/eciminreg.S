/*M
.SH NAME
eciminreg - elliptic curve with integer coefficients, minimal model, regulator

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating eciminreg(E, LP, n, modus)  
list E, LP;  
single n, modus; 

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.       
.TP 4
.B n
is a natural number, 0 < n < BASIS.
.PP
For modus != 0, 
.TP 4
.B PL
is a list in the shape
.IP
PL = ( P1 h1 P2 h2 ... Pn hn ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a point on the minimal model of E/Q,
.IP
hi
is the Neron-Tate height of Pi.
.PP
For modus = 0 
.TP 4
.B PL
is a list in the shape
.IP
PL = ( P1  ... Pn ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a point on the minimal model of E/Q.
.PP
Let h(P, Q) be the Neron-Tate pairing of the points P and Q (s. eciminnetapa), then
.PP
eciminreg computes the regulator, say H, where
.IP
H = |det( { h(Pi,Pj) }i,j = 1, ...,n)|
.PP
with an error smaller than 10^-NTH_EPS (s. _ec1.h or eciminntheps).
.PP
eciminreg returns H or -1 in case of an ERROR occurs.
 
.SH SEE ALSO
 ecrinit
 _ec1.h
 eciminntheps 
 eciminnetapa

M*/
                         
/*H
	Version 1	06.04.1992	Josef Gebel
	Version 2	18.12.1993	ECIREG --> ECIMINREG.
					Anpassung an neues Konzept.  JG
	Version 3	09.07.1993	Parameter modus eingefuehrt.  JG
   DATE eciminreg     : 921130.930531.931130
H*/

#include<_ec2.h>

floating eciminreg( E, LP, n, modus )
list E, LP;
single n, modus;
{
  floating        erg, flh;
  list            L1, L2, LZ, P, Q;
  single          i, j, h;
  matrix          M, N;

  bind( E, LP );

  if( modus )
  { 
      i = n << 1;
  }
  else
  {
      i = n;
  }
  
  if( llength( LP ) < i )
  {
      return( itofl( -1 ) );
  }

  init( erg, flh );
  init( L1, L2, LZ );
  init( P, Q );
  init( M, N );

   M = _0;

   for( i = 0; i < n; i++ )
   {
       /*   Aufbau und Initialisierung der Matrix    */
       LZ = _0;

       for( j = 0; j < n; j++ )
       {
	   LZ = lcomp( 0, LZ );
       }

       M = lcomp( LZ, M );
   }
	  
   L1 = LP;
   i  = 1;

   while( L1 != _0 )
   {
       /*   Eintragen der Werte in die Matrix M     */
       L2 = L1;
       P  = lfirst( L1 );
       j  = i;

       while( L2 != _0 )
       {
           Q   = lfirst( L2 );
	   flh = eciminnetapa( E, P, Q );

	   /*   Es gilt wegen der Symmetrie von M:   */
	   /*       M[i, j] = M[ j, i] = flh         */

	   /*   Setzen von M[ i, j ] = flh           */
	   /*   ( nur fuer i <= j )                  */

	   N = M;

	   for( h = 1; h < i; h++ )
	   {
	      N = lred( N );
           }

           LZ = lfirst( N );

	   leset( LZ, j, flh );
	   leset(  M, i, LZ );

	   if( i < j )
	   {
	      /*   Setzen von M[ j, i ] = flh   */
	      /*   ( nur fuer i < j )           */
	      for( h = i; h < j; h++ )
	      {
	         N = lred( N );
	      }

              LZ = lfirst( N );
	      leset( LZ, i, flh );
	      leset(  M, j, LZ );
	   
	   }
	   
	   j++;
           
	   if( modus )
           {
               L2 = lred2( L2 );
           }
           else
           {
               L2 = lred( L2 );
           }
       }
       
       i++;
       
       if( modus )
       {
           L1 = lred2( L1 );
       }
       else
       {
           L1 = lred( L1 );
       }
   }

   erg = mafldet( M );

   /*   flabs( erg ), weil Werte, die 'nahe bei' 0 liegen,  */
   /*   negativ sein koennen                                */

   return( flabs( erg ) );
}
