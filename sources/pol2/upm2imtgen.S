/*M
.SH NAME
upm2imtgen - univariate polynomial over modular 2, irreducible and monic trinomial, generator

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upm2imtgen(n)  
single n;
  
.SH DESCRIPTION
.TP 4
.B n
is an integer number, 0 < n < BASIS.
.PP                                                                             
If an univariate, monic and irreducible trinomial over Z/2Z in the shape        
.IP                                                                             
x^n + x^k + 1       (1 <= k <= n/2)                                             
.PP                                                                             
exists, then upm2imtgen will return it, else upm2imtgen returns 0.              
                                                                            
.SH SEE ALSO
upm2imgen
.PP
Literature:Zierler/Brillhart, "On Primitive Trinomials 
           (Mod 2)", Information And Control 13, 1968, 
           p. 541-554.   
           J.H. v.Lint, "Introduction to Coding Theory", 
           NY, Springer 1982.
M*/

/*H
	Version 1       21.04.1993	A.Stein 
   DATE upm2imtgen    : 930531
H*/

# include <_pol2.h>

pol upm2imtgen(n)
single n;
{
	single i, n1 = n/2;	
	pol P1, P;
	bind(P);
	
   /* n = 1 => P = x + 1	*/

	if( n == 1 ) return( list4(1,1,0,1) );

	if( seven(n) ) {
		for( i=n1; !(i%3); ) i /= 3; 
                if( i == 1 ) return( list6(n,1,n1,1,0,1) );
		if( (n%3) == 1 ) {
			P = list6(n,1,1,1,0,1);
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+2 ) {
				if( (i%3) == 2 ) continue;
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}             
		else if( (n%3) == 2 ) {
			P = list6(n,1,3,1,0,1);
			P1 = lred2(P);
			for( i=3; i<=n1; i=i+2 ) {
				if( (i%3) == 1 ) continue;
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}
		else {
			P = list6(n,1,1,1,0,1);
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+2 ) {
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}
	} 
	else {
		if( (n%3) == 1 ) {
			P = list6(n,1,1,1,0,1);
			P1 = lred2(P);
			for( i=1; i<=n ; i=i+1 ) {
				if( (i%3) == 2 ) continue;
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}             
		else if( (n%3) == 2 ) {
			P = list6(n,1,2,1,0,1);
			P1 = lred2(P);
			for( i=2; i<=n1 ; i=i+1 ) {
				if( (i%3) == 1 ) continue;
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}
		else {
			P = list6(n,1,1,1,0,1);
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+1 ) {
				lsfirst(P1,i);
				if( isimupms(2,P) ) return(P);
			}
		}
	}

	/* Wird kein irreduzibles Trinom gefunden, so ist P = 0 */

	return( 0 ); 
}
