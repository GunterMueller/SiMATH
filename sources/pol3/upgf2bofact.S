/*M
.SH NAME
upgf2bofact - univariate polynomial over Galois-field with characteristic 2, Ben-Or factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2bofact(G, P)  
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
upgf2bofact returns a list, containing all irreducible factors of P. The factors are given in special bit-representation.

.SH SEE ALSO
.nf
udpm2tosb
Literature: M. Ben-Or: Proc.22, IEEE Symp. Foundations 
                       Comp. Sci., p.394-398, 1981.  
M*/

/*H
	Version 1       03.05.1993      Joachim Stein
	Version 1.1	20.07.1994	U.Schneiders (Aufruf von upgf2ddfact)
   DATE upgf2bofact   : 931130.941201
H*/

#include <_pol3.h>

list upgf2bofact( G, P )
obj G;
pol P;
{
	single n, d, i, e; 
	list L, L1, L2, L3;
	pol F;

        bind( G, P );
	init( L, L1, L2, L3, F );
                              
/** quadratfreie Factorisierung **/
        L = _0;
        L1 = upgf2sfact( G, P );
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
	  e = lfirst( L2 );
          F = lsecond( L2 );

	  /**** Zeile in Version vom 3.5.93 J.St.
          L3 = upgf2ddfact( G, F ); 
	
	  ersetzt am 20.7.94 U.Sch. durch: ***/
	
          if( lfirst(F)!= 1 ) L3 = upgf2ddfact( G, F ); 
	  else 
	  {	L3=_0;	
		i=e;
		while( i!= 0)
		{	L = lcomp( F, L);
			i--;
		}
	  }

	  /*** Ende des Ersetzens ***/
	  
          while ( L3 != _0 )
          {
            F = lfirst( L3 );
            d = lsecond( L3 );  
            L3 = lred2( L3 ); 
            L2 =  upgf2sfed( G, F, d );
            while ( L2 != _0 )
            { 
              i = e;
              F = lfirst( L2 );
              while ( i != 0 )
              {
                L = lcomp( F, L );    
                i = i - 1;
              }
              L2 = lred( L2 ); 
            } 
          }                           
        }       
        return( L );
}
