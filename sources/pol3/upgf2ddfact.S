/*M
.SH NAME
upgf2ddfact - univariate polynomial over Galois-field with characteristic 2 distinct degree factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2ddfact(G, P)  
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
is a monic, squarefree and univariate polynomial over GF(2^n) in special bit-representation, deg(P) >= 2.
.PP
upgf2ddfact returns a list (G1, m1, G2, m2, ..., Gk, mk), whereat
.PP
m_i is a positive integer number,
.PP
m_i < m_j  for i < j, and
.PP
G_i is the product of all irreducible and monic factors of P with degree m_i. G_i is given in special bit-representation.

.SH SEE ALSO
udpm2tosb

M*/
                                
/*H
	Version 1       21.05.1993      Joachim Stein
   DATE upgf2ddfact   : 931130
H*/


#include <_pol3.h>

list upgf2ddfact( G, P )
obj G;
pol P;
{
	single d, e, i, m, n;
	list   L, PV, Q, QV, QM;
	pol    H, P1, X;
	bind( G, P );
	init( H, P1, X, L, PV, Q, QV, QM );

	QM = upgf2bqp( G, P );
	P1 = lsecond( QM );
	m = 1;
	n = lfirst( P );
	L = _0;
	X = list2( 1, list2(0,1) );

	for ( ; ; )
        {
	  H = upgf2gcd( G, P, pgf2dif( 1, G, P1, X ) );
	  if ( lfirst(H) > 0 ) 
          {
	    L = lcomp2( m, H, L );
	    P = pgf2quot( 1, G, P, H );
	  }
	  m++;
	  d = lfirst(P);
	  if ( d >= 2*m )
          {
	    if ( m==2 )  QM = matransp( macup(n,QM) );
	    P1 = ptodp( 1, P1 );
	    e = lfirst( P1 );
	    P1 = lred( P1 );
	    for ( i=1; i++<n-e; P1=lcomp(0,P1) );
	    PV = linv(P1);

	    P1 = _0,  Q = QM;
	    do
            {
	      QV = lfirst( Q ),  Q = lred( Q );
	      P1 = lcomp(vecgf2sprod( G, PV, QV ), P1 );
	    }
	    while ( Q != _0 );

	    for ( e=n-1; lfirst(P)==0; e--, P1=lred(P1) );
	    P1 = lcomp( e, P1 ),  P1= dptop( 1, P1 );
	  }
	  else 
          {
	    /*      alle Faktoren gefunden      */
	    if ( d > 0 )  L = lcomp2( d, P, L );
	    return( linv(L) );
	  }
	}
}
