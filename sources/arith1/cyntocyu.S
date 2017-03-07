#define cyuprod cynprod
/*M
.SH NAME
cyntocyu - cyclotomic number to cyclotomic unit 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyntocyu(V)
cyc V;

.SH DESCRIPTION
cyntocyu() returns the cyclotomic number V as a cyclotomic number U
if possible and 0 otherwise.
M*/

/*H
	Version 1 	02.01.00	Marc Conrad.
H*/

#include<_arith1.h>

cyc cyntocyu(W)
cyc W; 
{ 
    list Q, P, C, L, LP, LE, D, Z, Y; 
    single e; 
    single a; 
    single n, p, m, q, alpha, beta; 
    bind(W); 
    init(Q, P, C, L, LP, LE, D, Z, Y); 
    
    P = Q = _0;  
    m = 1; 
    while( W != _0 ) { 
        C = lfirst(W); 
        e = lsecond(W); 
        W = lred2(W); 

        n = lfirst(C); 

        if( isspprime(n,&p) ) { 
             m = ilcm(m, n); 
             P = lcomp2(e,C,P); 
             } 
        else { 
             Q = lcomp2(e,C,Q); 
             } 
        } 
    Q = linv(Q); 
    P = linv(P); 

    L = iflel(m); 
    LP = lfirst(L); 
    LE = lsecond(L); 

    while( LP != _0 ) { 
        alpha = lfirst(LE); LE = lred(LE); 
        p = lfirst(LP); LP = lred(LP); 
        for( beta = 1; beta < alpha; beta++ ) { 
            Y = P; 
            q = sexp(p,beta); 
            while( Y != _0 ) { 
                C = lfirst(Y); 
                e = lsecond(Y); 
                Y = lred2(Y); 
                if( lfirst(C) == q ) { 
                     Q = cyuprod(Q, list2(C,e)); 
                     Z = cyngzeisum(list2(q * p,1),p);
                     D = list2(C,1); 
                     Z = cynquot(D,Z); 
                     Z = cynexp(Z,-e); 
                     P = cynprod(P,Z); 
                     } 
                } 
            } 
       Y = P; 
       q = sexp(p,alpha); 
       while( Y != _0 ) { 
           C = lfirst(Y); 
           e = lsecond(Y); 
           Y = lred2(Y); 
           if( lfirst(C) == q ) { 
               Q = cyuprod(Q, list2(C,e)); 
               Z = cyncons(q,1); 
               D = list2(C,1);
               Z = cynquot(D,Z); 
               Z = cynexp(Z,-e); 
               P = cynprod(P,Z); 
               } 
           } 
       } 
    return Q; 
} 
        


   

