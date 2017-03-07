/*M
.SH NAME
upgf2gen - univariate polynomial over Galois-field with characteristic 2, random generator

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol upgf2gen(G, m)  
obj G; 
single m;
  
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ). 
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.PP
upgf2gen returns a randomly generated univariate polynomial over Z/2Z of degree <= m in special bit-representation. upgf2gen does not return the zero polynomial.
 
.SH SEE ALSO
udpm2tosb

M*/
                                              
/*H
	Version 1       26.05.1993      Joachim Stein
   DATE upgf2gen      : 931130
H*/


#include <_arith2.h>

pol upgf2gen( G, m )
obj G;
single m; 
{
	single i, n;
	pol P;               
        gf2el a;

        bind( G );
	init( P, a );

/** Polynom ueber GF(2^n) zusammenbauen **/
        do
        {
          P = _0;
          for ( i = 0; i <= m; i++ )
          { 
            a = gf2elrand( G );
            if ( a )  P = lcomp2( i, a, P ); 
          } 
        }
        while ( P == _0 ); 
        return( P );
}
