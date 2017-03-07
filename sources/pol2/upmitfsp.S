/*M
.SH NAME
upmitfsp - univariate polynomial over modular integers, trace function, special

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmitfsp(p, P, d, M)  
int p; 
single d; 
pol P, M;
  
.SH DESCRIPTION
.TP 4
.B p
is an odd prime number.
.TP 4
.B P, M 
are univariate polynomials over Z/pZ, deg(P) < deg(M).
.PP
upmitfsp returns the polynomial 
.IP
P1 = Tr(P) = P + P^p + P^p^2 + ... + P^p^d.
.PP
All products, made for the computation of P1, are reduced modulo M.

M*/

/*H
	Version 1       17.02.1993      Joachim Stein
   DATE upmitfsp      : 930531
H*/

#include <_pol2.h>

pol upmitfsp( ip, G, d, M )
int ip; 
single d; 
pol G, M;
{
	single i;
	pol P, H;               

        bind( ip, G, M );
	init( P, H );

        P = G;
        H = G;      
        for ( i = 1; i <= d; i++ )
        {
          H = upmimpexp( ip, H, ip, M );
          P = pmisum( 1, ip, P, H ); 
          P = pmirem( 1, ip, P, M ); 
        }
        return( P );
}
