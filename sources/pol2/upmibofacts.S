/*M
.SH NAME
upmibopfacts - univariate polynomial over modular integers Ben-Or factorization, special

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmibofacts(p, P)  
int p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a monic, univariate and nonzero polynomial over Z/pZ.
.PP
umpibofacts returns a list L = (P1, e1,  ..., Pr, er) consisting of all irreducible factors and powers of P, with
.IP
P = P1^e1 * ... Pr^er.

.SH SEE ALSO
M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci. , p.394-398, 1981.   

M*/

/*H
	Version 1	20.02.93	Joachim Stein
   DATE upmibofacts   : 930531
H*/

#include <_pol2.h>

list upmibofacts( ip, P )
int ip;
pol P;

{
	single d, e; 
	list L, L1, L2, L3;
	pol F;

        bind( ip, P );
	init( L, L1, L2, L3, F );
                              
/** quadratfreie Factorisierung **/
        L1 = upmisfact( ip, P );
        L = _0;        
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
          e = lfirst( L2 );
          F = lsecond( L2 );
          if ( pdegree( 1, F ) == 1 )
          {
            L = lcomp2( F, e, L );
          }
          else
          {
            L3 = upmiddfact( ip, F ); 
            while ( L3 != _0 )
            {
              F = lfirst( L3 );
              d = lsecond( L3 );  
              L3 = lred2( L3 ); 
              L2 =  upmisfed( ip, F, d );
              while( L2 != _0 )
              {
                F = lfirst( L2 );
                L = lcomp2( F, e, L );
                L2 = lred( L2 );
              } 
            }
          }
        }       
        return( L );
}
