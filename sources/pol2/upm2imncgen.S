/*M
.SH NAME
upm2imncgen - univariate polynomial over modular 2, irreducible and monic with given number of nonzero coefficients, generator

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upm2imncgen(n, k, nr)  
single n, k, nr;
 
.SH DESCRIPTION
upm2imncgen makes nr-times the attempt to find an univariate, monic and irreducible polynomial over Z/2Z of degree n with k nonzero coefficients.
By success, upm2imncgen returns the polynomial, else upm2imncgen returns 0.

.SH NOTES
For k even, or k < 3 never exists such a polynomial.
.PP
For k = 3, n or n+1, upm2imncgen tests all possibilities. ( independent of the value of nr. )

M*/

/*H
	Version 1       08.09.1994	A.Stein
	Version 2       07.10.1994 	marginale Aenderungen, Marc Conrad
   DATE upm2imncgen   : 941201
H*/ 

# include <_pol2.h>

pol upm2imncgen(n,k,nr)
single n, k, nr;
{ 	
	single i, j , l, n1 = n/30 + 1, z, zd, lfa;
	obj a, a1;	
	pol  P;
	init( a, a1, P);
      
	if( k > n+1 || k < 3 || seven( k ) ) return( 0 ); 
	if( k == 3 ) return( upm2imtgen(n) );
	if ( k == n ) return( upm2imncgen_sp0( n ) ); 
	if ( k == n + 1 ) return( upm2imncgen_sp1( n ) ); 
    
	a = list1(1);
	for( i=n1-1; i; i--) a = lcomp(0,a);	
	for( ; nr-- ; ) {
		for( j=k-2; j;  ) {
			z = irand(n);
			if( !z ) continue;
			zd = z/30 + 1; i = z % 30;
			z = (1<<i);
			for( a1=a, i=n1-zd; i--; ) a1=lred(a1);
			lfa = lfirst(a1);
			if( lfa & z ) continue;
			else {
				lfa = lfa ^ z;
				lsfirst(a1,lfa);
				j--;
			}
		} 
		a1 = linv(a); 
		P = _0; a = a1;
		for( z=0, l=n1-1; l--;  ) {
			lfa = lfirst(a1); a1 = lred(a1);
			if ( lfa&1 ) P = lcomp2(z,1,P);
                	for( z++, i=29; i--; z++ ) {
				lfa >>= 1;
				if ( lfa&1 ) P = lcomp2(z,1,P);
			}
		}
		lfa = lfirst(a1); a1 = lred(a1);
		for( ; lfa; lfa>>=1, z++ ) if ( lfa&1 ) P = lcomp2(z,1,P);
		P = lcomp2(n,1,P);
		if( isimupms(2,P) ) return( P );
		for( i=n1-1, a1=a; i; i--) {
			lsfirst(a1,0);
			a1 = lred(a1);
		}
		lsfirst(a1,1);		
	}
	return( 0 );
}
                         

               
/* Spezialroutine fuer den Fall k = n, das heisst genau ein Koeffizient = 0 */
pol upm2imncgen_sp0(n)  
	single n;          
	{
	pol P; 
	single k, i; 
	
	init( P );         
		               
	for( k = n - 1; k > 0; k-- ) { 
		P = _0; 
		for( i = 0; i<= n; i++ ) { 
			if( i != k ) P = lcomp2(i,1,P);
			}
		if( isimupms(2,P) ) return( P );
		
		}
	return( 0 );
}

/* Spezialroutine fuer den Fall k = n + 1, das heisst alle Koeffizienten == 1*/

pol upm2imncgen_sp1(n)  
	single n;          
	{
	pol P; 
	single k, i; 
	
	init( P );         
		               
	P = _0; 
	for( i = 0; i<= n; i++ ) P = lcomp2(i,1,P);     		
	if( isimupms(2,P) ) return( P );
	else return( 0 );
	}    



