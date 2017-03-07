/*M
.SH NAME
upmibofactsr - univariate polynomial over modular integers, Ben-Or factorization, single root

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmibofactsr(p, P)  
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
upmibofactsr returns a list consisting of one root of P.

M*/

/*H
	Version 1	01.06.94	Georg Rock
   					Programm sucht genau eine Nullstelle 
					des eingegebenen Polynoms.
   DATE upmibofactsr  :	941201
H*/

#include <_pol2.h>

int upmibofactsr( ip, P )
int ip;
pol P;
{
	single d, i, e; 
	list L, L1, L2, L3;
	int j;
	pol H;

        bind( ip, P );
	init( j,L, L1, L2, L3, H );
                              
        L = _0;
        L1 = upmisfact( ip, P );
        while ( L1 != _0 )
        {
          L2 = lfirst( L1 );
          L1 = lred( L1 );
	  H = lsecond( L2 );
	 
	 if ( pdegree( 1, H ) == 1 )    
          {
	    L3 = upmirfspec(ip, H);
	    j = lfirst(L3);
	    return(list1(j));
          }  

          else
	  {
	    L3 = upmiddfact( ip, H );
	    d = lsecond(L3);
            
	    if (d == 1)
            {
             H = lfirst(L3);
	     L3 = upmirfspec(ip, H);
	     j = lfirst(L3);
             return(list1(j));
	    }
	   
	  }
        }
       return(list1(j));
}








