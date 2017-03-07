/*M
.SH NAME
upgf2bofacts - univariate polynomial over Galois-field with characteristic 2 Ben-Or factorization, special

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2bofacts(G, P)  
obj G;
pol P;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a monic and univariate polynomial over GF(2^n) in special bit-representation, P != 0.
.PP 
upgf2bofacts returns a list, containing all irreducible factors of P and their exponents, i.e. L = (P_1, e_1, ...,P_k, e_k) such that
.IP
P = P_1^e_1 * ... * P_k^e_k holds.
                                        
.SH SEE ALSO
.nf
udpm2tosb
Literature: M. Ben-Or: Proc.22, IEEE Symp. Foundations 
                       Comp. Sci., p.394-398, 1981.    
M*/
                                                           
/*H
	Version 1       05.05.1993      Joachim Stein
   DATE upgfsbofacts  : 931130
H*/

#include <_pol3.h>

list upgf2bofacts( G, P )
obj G;
pol P;

{
	single n, d, e; 
	list L, L1, L2, L3;
	pol F;

        bind( G, P );
	init( L, L1, L2, L3, F );
                              
/** quadratfreie Factorisierung **/
        L1 = upgf2sfact( G, P );
        L = _0;        
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
          e = lfirst( L2 );
          F = lsecond( L2 );
          L3 = upgf2ddfact( G, F ); 
          while ( L3 != _0 )
          {
            F = lfirst( L3 );
            d = lsecond( L3 );  
            L3 = lred2( L3 ); 
            L2 =  upgf2sfed( G, F, d );
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
