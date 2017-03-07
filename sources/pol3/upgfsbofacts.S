/*M
.SH NAME
upgfsbofacts - univariate polynomial over Galois-field with single characteristic, Ben-Or factorization, special

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfsbofacts(p, AL, P)  
single p; 
list AL; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 2 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a monic and univariate polynomial over GF(p^n), P != 0.
.PP
upgfsbofacts returns a list, containing all irreducible factors of P and their exponents, i.e. L = (P_1, e_1, ...,P_k, e_k) such that
.IP
P = P_1^e_1 * ... * P_k^e_k holds.  

.SH SEE ALSO
 upgfsbofact
 gfsalgen
 Literature: M. Ben-Or: Proc.22, IEEE Symp. Foundations
                        Comp. Sci., p.394-398, 1981.  
M*/
                              
/*H
	Version 1       06.11.92        Joachim Stein
   DATE upgfsbofacts  : 921130.9305__
H*/

#include <_pol3.h>

list upgfsbofacts( p, AL, P )
single p;
list AL;
pol P;

{
	single n, d, e; 
	list L, L1, L2, L3;
	pol F;

        bind( AL, P );
	init( L, L1, L2, L3, F );
                              
/** quadratfreie Factorisierung **/
        L1 = upgfssfact( p, AL, P );
        L = _0;        
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
          e = lfirst( L2 );
          F = lsecond( L2 );
          L3 = upgfsddfact( p, AL, F ); 
          while ( L3 != _0 )
          {
            F = lfirst( L3 );
            d = lsecond( L3 );  
            L3 = lred2( L3 ); 
            L2 =  upgfssfed( p, AL, F, d );
            while( L2 != _0 )
            {
              F = lfirst( L2 );
              L = lcomp2( F, e, L );
              L2 = lred( L2 );
            } 
          }
        }       
        return( L );
}
