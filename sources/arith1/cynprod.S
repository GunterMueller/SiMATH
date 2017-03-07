/*M
.SH NAME
cynprod - cyclotomic number product

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cynprod(A, B)
cyc A, B;

.SH DESCRIPTION
cynprod() returns A * B.
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>

static int cyngencomp(A,B) 
list A, B; 
{ 
        bind(A, B); 
        if( A == B ) return 0; 

        if( lfirst(A) > lfirst(B) ) return 1; 
        else if( lfirst(A) < lfirst(B) ) return -1; 

        if( lsecond(A) > lsecond(B) ) return 1; 
        else if( lsecond(A) < lsecond(B) ) return -1; 

        return 0; 
        } 


cyc cynprod( U, V)  
cyc U, V; 
{ 
    cyc P; 
    list C, D; 
    single e, f, c, ok; 
    bind(U, V); 
    init(P, C, D); 

    if( U == _0 ) { return V; } 
    if( V == _0 ) { return U; } 
    C = lfirst(U); U = lred(U);
    e = lfirst(U); U = lred(U);
    D = lfirst(V); V = lred(V); 
    f = lfirst(V); V = lred(V); 

    P = _0; 
    ok = 1; 

    while( ok ) { 
       c = cyngencomp(D,C); 
       if( c < 0 ) { 
            P = lcomp2( e, C, P);
            if( U == _0 ) { 
                P = lcomp2(f, D, P); 
                ok = 0; 
                } 
            else {  
                C = lfirst(U); U = lred(U); 
                e = lfirst(U); U = lred(U); 
                }
            }
       else if( c > 0 ) { 
            P = lcomp2( f, D, P);
            if( V == _0 ) { 
                P = lcomp2(e,C,P); 
                ok = 0; 
                }  
            else { 
                D = lfirst(V); V = lred(V); 
                f = lfirst(V); V = lred(V); 
                }
            }
       else { 
            e = e + f; 
            if( e ) { P = lcomp2(e,D,P); } 
            if( V == _0 || U == _0 ) { ok = 0; } 
            else { 
                C = lfirst(U); U = lred(U); 
                e = lfirst(U); U = lred(U); 
                D = lfirst(V); V = lred(V); 
                f = lfirst(V); V = lred(V); 
                } 
           }
       } /* while(ok) */
   if( U == _0 ) { U = V; } 

   C = linv(P); 
   if( C == _0 ) { C = U; } 
   else { lsred(P,U); } 
   return(C); 
   }

