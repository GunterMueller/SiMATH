/*M
.SH NAME                        
upmibofact - univariate polynomial over modular integers Ben-Or factorization
                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
list upmibofact(p, P)  
int p; 
pol P;                                                                                 
.SH DESCRIPTION 
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is an monic, univariate polynomial over Z/pZ.
P != 0.
.PP
upmibofact returns a list L = (P1, ..., Pr) consisting of all irreducible factors of P, with
.IP
P = P1 * ... * Pr.

.SH SEE ALSO                                                                    
M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci. , p.394-398, 1981.

M*/                                                                             

/*H
	Version 1 	16.02.93 	Joachim Stein
   DATE upmibofact    : 930531
H*/

#include <_pol2.h>

list upmibofact( ip, P )
int ip;
pol P;
{
	single d, i, e; 
	list L, L1, L2, L3;
	pol H;

        bind( ip, P );
	init( L, L1, L2, L3, H );
                              
/** quadratfreie Factorisierung **/
        L = _0;
        L1 = upmisfact( ip, P );
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
	  e = lfirst( L2 );
          H = lsecond( L2 );
          if ( pdegree( 1, H ) == 1 )    
          {
            do 
            {
              L = lcomp( H, L );
              e = e - 1;
            }  
            while ( e != 0 );
          }
          else
          {
            L3 = upmiddfact( ip, H ); 
            while ( L3 != _0 )
            {
              H = lfirst( L3 );
              d = lsecond( L3 );  
              L3 = lred2( L3 ); 
              L2 =  upmisfed( ip, H, d );
              while ( L2 != _0 )
              { 
                i = e;
                H = lfirst( L2 );
                while ( i != 0 )
                {
                  L = lcomp( H, L );    
                  i = i - 1;
                }
                L2 = lred( L2 ); 
              } 
            }                           
          }
        }       
        return( L );
}
