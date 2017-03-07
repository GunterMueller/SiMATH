/*M
.SH NAME
upm2imgen - univariate polynomial over modular 2, irreducible and monic, generator

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upm2imgen(n)  
single n;

.SH DESCRIPTION
.TP 4
.B n
is an integer number, 0 < n < BASIS.
.PP
upm2imgen randomly generates an irreducible, monic and univariate polynomial of degree n over Z/pZ and returns it.

.SH NOTES
First, upm2imgen looks for an irreducible and univariate polynomial in the shape x^n + x^k + 1 (1 <= k <= n/2 ).
If such a polynomial can not be found, upm2imgen calls upmsimgen.

.SH SEE ALSO
upm2imtgen

M*/

/*H
	Version 1       18.01.1992	A.Stein 
	Version 2       20.04.1993	Ueberarbeitete Version. AS 
   DATE upm2imgen     : 920331.930531
H*/

# include <_pol2.h>

pol upm2imgen(n)
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

	/* Wird kein irreduzibles Trinom gefunden, so benutze upmsimgen */

	return( upmsimgen(2,n) ); 
}
