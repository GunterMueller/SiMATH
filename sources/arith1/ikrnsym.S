/*M
.SH NAME
ikrnsym - integer kronecker-symbol of n for d.

.SH SYNOPSIS
.nf
#include<_simath.h>
	
single ikrnsym(d,n)
	int d,n	;

.SH DESCRIPTION
ikrnsym() returns the value of kronecker-symbol of n for d.

.SH SEE ALSO
ijacsym
	
M*/

/*H	
	Version 1	11.04.2002	Abe Mizuho 
	
H*/
	
#include<_simath.h>

single ikrnsym( d, n )
     int d, n ; 
{
  int m, a, b, c, k, l, j, ab, md ;
  
  bind( d, n ) ;
  init( m, a, b, c, k, l, j, ab, md ) ; 
  
  if ( ieven( d ) == 1 ){ /* if d is even */
    if ( ieven( n ) == 0 ) /* if n is odd */ 
      {
	k = iqrem( d, 16, &b, &a ) ; /* d = 16 * b + a, a = d ( mod 16 ) */
	m = idif( 16, a ) ; /* m = 16 - (d mod16)*/

	c = isum( m, m ) ;
	/* c = 2 * m */
 
	k = iprod( 4, n ) ; 
	l = idif( isum( isum( k, d ), 4 ), m ) ;
	/* l = k + d + 4 - m = 4*n + d + 4 - m */
 
	a = irem( isum( iquot( iprod( idif( n, 1 ), l ), c ), 1 ), 4 ) ;
	/* a = ( n - 1 ) * l / c + 1 (mod 4) */

	md = idif( 2, a ) ;
	/* md = 2 - { (n-1)*l/c +1 (mod 4) } */

	ab = iabs( iquot( d, m ) ) ;
	j = ijacsym( n, ab );

	return iprod( md, j ); 
	/* {2 - ( {(n-1)*(4n+d+4-m)/2m + 1} mod 4)}*{jacsym(n,abs(d/m))} 
	   jacsym(a,b) :	jacobian of a for b */
      }
    else return 0 ; 
  }
  else {
  ab = iabs( d ) ;
  return ijacsym( n, ab ) ;
  }
}

/* main(){

  int d,n;
  init(d,n);

  printf("\nEnter the numders:  \nd = ");
  while ((d = geti()) == ERROR)
    printf("Reading error \nd = ");
   printf("\nn = ");
  while ((n = geti()) == ERROR)
    printf("Reading error \nn = ");

  printf("\n ikrnsym(%i,%i) = %d",d,n,ikrnsym(d,n));
 
}
*/
