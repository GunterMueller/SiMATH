/*M
.SH NAME
upgf2sfact - univariate polynomial over Galois-field with characteristic 2 squarefree factorization
(rekursiv)  

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2sfact(G, P)  
obj G; 
pol P;
         
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P
is a monic and univariate polynomial over GF(2^n) of positive degree with coefficients in special bit-representation. 
.PP
upgf2sfact returns a list, say L, containing the squarefree factorization of P, i.e.
L = ((e_1, P_1),...,(e_n, P_n)), such that, for 1 <= i <= n
.nf
.IP
0 < e_1 < e_2 < ... < e_n;
P_i is a monic and squarefree factor of P;
the P_i's are coprime;
(P_1)^(e_1) * ... * (P_n)^(e_n) = P.
                    
.SH SEE ALSO
udpm2tosb

M*/
   
/*H
	Version 1       04.05.1993      Joachim Stein
   DATE upgf2sfact    : 931130
H*/


#include <_pol3.h>

list upgf2sfact( G, P )
obj G;
pol P;
{
	single e2, j, i;
	gf2el k2, b;
	int Z, K, T;
	list L, LS, L1, M, MS, M1;
	pol PS, P1, P2, P3, P4, P2S;
	bind( G, P );
	init(k2,b,Z,K,T,L,LS,L1,M,MS,M1,PS,P1,P2,P3,P4,P2S);

	LS = _0;
	PS = pgf2deriv( 1, G, P );

/* Berechnung der Pi, fuer die ei nicht durch 2 teilbar ist */

	if (PS)
        {                
	  P2 = upgf2gcd( G, P, PS );
	  P3 = pgf2quot( 1, G, P, P2 );
	  j = 1;
	  do
          {
	    P4 = upgf2gcd( G, P2, P3 );
	    P1 = pgf2quot( 1, G, P3, P4 );
	    if (lfirst( P1 ))
            {
	      P1 = list2( j, P1 );
     	      LS = lcomp( P1, LS );
	    }
	    if (lfirst( P4 ))
            {
	      P3 = P4;
	      P2 = pgf2quot( 1, G, P2, P3 );
	      j++;
	    }
	  } while (lfirst( P4 ));
	}
	else P2 = P;

/* Berechnung der Pi, fuer die ei durch 2 teilbar ist */

	if (lfirst( P2 ) == 0) L = linv( LS );
	else 
        {
	  P2S = _0;
	  Z = lfirst(G)-1;
	  Z = iexp( 2, Z );
	  do
          {
	    e2 = lfirst( P2 );
	    P2 = lred( P2 );
	    k2 = lfirst( P2 );
	    P2 = lred( P2 );

	    if ( !oequal( k2, udpm2togf2el(G, list2(0,1)) ) )
            {
	      K = 2;
	      while ( icomp(K,Z)!=1 ) K = isum( K, K );
	      K = iquot( K, 2 );
	      b = k2;
	      T = idif( Z, K );
	      while ( icomp(K,1) != 0 )
              {
		k2 = gf2prod( G, k2, k2 );
		K  = iquot( K, 2 );
		if ( icomp(K,T)!=1 )
                {
	 	  k2 = gf2prod( G, b, k2 );
		  T  = idif( T, K );
		}
	      }
	    }
	    e2 /= 2;
	    P2S = lcomp2( k2, e2, P2S );
	  }
          while ( P2 != _0 );
	  P2 = linv( P2S );
	  M = upgf2sfact( G, P2 );
	  MS = M;
	  do
          {
	    M1 = lfirst( MS );
	    MS = lred( MS );
	    e2 = 2 * lfirst( M1 );
	    lsfirst( M1, e2 );
	  }
          while ( MS != _0 );
  	  M = linv( M );
	  L = _0;

	/* Mischen von LS und M */

	  while (LS != _0  &&  M != _0) 
          {
	    if (lfirst( lfirst(LS) ) > lfirst( lfirst(M) )) 
            {
	      L1 = lfirst( LS );
	      LS = lred( LS );
	    }
	    else
            {
	      L1 = lfirst( M );
	      M = lred( M );
	    }
	    L = lcomp( L1, L );
	  }
	  if (M == _0) LS = linv( LS );
	  else LS = linv( M );
	  L = lconc( LS, L );
	}

	return(L);
}
