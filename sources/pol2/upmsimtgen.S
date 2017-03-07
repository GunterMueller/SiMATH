/*M
.SH NAME
upmsimtgen - univariate polynomial over modular singles, irreducible and monic trinomial, generator

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmsimtgen(p, n)  
single p, n;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B n
is an integer number, 0 < n < BASIS.
.PP
If an univariate, monic and irreducible trinomial over Z/pZ in the shape
.IP
x^n + x^k + 1       (1 <= k <= n/2)
.PP
exists, then upmsimtgen will return it, else upmsimtgen returns 0.

.SH NOTES
In the case p = 3, upmsimtgen searchs for a trinomial in the shape x^n + x^k + 2.
.PP
The algorithm, used by upmsimtgen is probabilistic. 
.PP
For p = 2, please use upm2imtgen.
 
.SH SEE ALSO
 upm2imtgen
 upm2imgen
 upmsimgen

M*/

/*H
	Version 1       27.04.1993	A.Stein 
   DATE upmsimtgen    : 930531.9311__
H*/

# include <_pol2.h>

pol upmsimtgen(p,n)
single p, n;
{
	single i, n1 = n/2;	
	pol P1, P;
	bind(P);
	
   /* n = 1 => P = x + 1	*/

	if( n == 1 ) return( list4(1,1,0,1) );

	if( seven(n) ) {
		if( (n%3) == 1 ) {
			P = (p==3)? (list6(n,1,1,1,0,2)) : (list6(n,1,1,1,0,1));
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+2 ) {
				if( (i%3) == 2 ) continue;
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}             
		else if( (n%3) == 2 ) {
			P = (p==3)? (list6(n,1,3,1,0,2)) : (list6(n,1,3,1,0,1));
			P1 = lred2(P);
			for( i=3; i<=n1; i=i+2 ) {
				if( (i%3) == 1 ) continue;
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}
		else {
			P = (p==3)? (list6(n,1,1,1,0,2)) : (list6(n,1,1,1,0,1));
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+2 ) {
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}
	} 
	else {
		if( (n%3) == 1 ) {
			P = (p==3)? (list6(n,1,1,1,0,2)) : (list6(n,1,1,1,0,1));
			P1 = lred2(P);
			for( i=1; i<=n ; i=i+1 ) {
				if( (i%3) == 2 ) continue;
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}             
		else if( (n%3) == 2 ) {
			P = (p==3)? (list6(n,1,2,1,0,2)) : (list6(n,1,2,1,0,1));
			P1 = lred2(P);
			for( i=2; i<=n1 ; i=i+1 ) {
				if( (i%3) == 1 ) continue;
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}
		else {
			P = (p==3)? (list6(n,1,1,1,0,2)) : (list6(n,1,1,1,0,1));
			P1 = lred2(P);
			for( i=1; i<=n1 ; i=i+1 ) {
				lsfirst(P1,i);
				if( isimupms(p,P) ) return(P);
			}
		}
	}

	/* Wird kein irreduzibles Trinom gefunden, so ist P = 0 */

	return( 0 ); 
}
