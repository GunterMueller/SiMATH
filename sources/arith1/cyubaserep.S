/*M
.SH NAME
cyubaserep - cyclotomic unit base representation 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyubaserep(U)
cyc U;

.SH DESCRIPTION
cyubaserep() computes the basis representation of a cyclotomic unit U.
For details see "Basen von Moduln mit Anwendung auf Kreiseinheiten und 
Stickelbergerelemente", PhD thesis of Marc Conrad, Saarbruecken 1997.  
M*/
/*H
	Version 1 	01.01.2000 Marc Conrad.
H*/
#include<_arith1.h>
#define METH_B 0
#define METH_S -1 
#define METH_H -2 
#define METH_E -3 

#define METH_T -10 
#define METH_Z -11 

/* cyclotomic unit generator developing method. (Algorithm A.2.2) */
cyc cyugdevmet( C )  
list C; 
{
   single s, n, a, p, lam, b;  

   bind(C); 
   n = lfirst(C); 
   a = lsecond(C); 

   if( !isspprime(n, &p) ) { 
        return cyngdevmet(C); 
        } 
   if( n == 2 || n == 4 ) { 
        return METH_T; 
        } 
   if( n == p ) { 
        if( a == 1 ) { return METH_T;  } 
        if( 2 * a < p ) { return METH_B; } 
        return METH_S; 
        } 
   n = n/p; 
   lam = a % n; 
   if( 2 * lam > n ) { return METH_S; } 
   b = (a - lam) / n; 
   if( b != 0 ) { return METH_B; } 
   if( lam == 1 ) { return METH_T; } 
   return METH_Z; 
   } 

cyc cyugdev(C, m)  /* develops the cyclotomic unit generator C */ 
list C;           /* with method m */
single m; 
{ 
    cyc Q; 
    bind(C); 
    init(Q); 
    if( m == METH_T ) { 
        Q = _0; 
        } 
    else if( m == METH_S ) { 
        single n; 
        n = lfirst(C); 
        Q = cyucons(n, n - lsecond(C)); 
        }
    else if( m > 1 || m == METH_E) { 
        Q = cyngdev(C,m); 
        Q = cyntocyu(Q); 
        } 
    else if (m == METH_Z ) { 
        single p, b, d, i, n, a; 
        n = lfirst(C); 
        a = lsecond(C); 
        isspprime(n,&p); 
        d = n / p; 
        b = a % d; 
        Q = cyucons(n,a); 
        for(i =0; i <= p-1; i++ ) { 
           C = cyucons(n,b + i * d);
           Q = cyuquot(Q,C);  
           C = cyucons(n,1 + i * d);
           Q = cyuprod(Q,C);  
           } 
        C = cyucons(d,b); 
        Q = cyuprod(Q,C);  
        } 
    return Q; 
}

obj cyudev1(P)  /* return 0 if there is nothing to develop */
cyc P; 
{ 
    cyc Q, R;  
    list C; 
    single m, e; 
    init(Q, R); 
    bind(P); 
    
    Q = P; 
    while (Q != _0 ) { 
          C = lfirst( Q ); 
          m = cyugdevmet(C); 
          if( m != METH_B ) { 
               e = lsecond(Q); 
               R = cyugdev(C,m); 
               R = cyuexp(R,e); 
               R = cyuprod(R, list2(C,-e)); 
               R = cyuprod( P, R);  
               return R; 
               } 
          Q = lred2(Q); 
          } 
    return 0; 
    }  

cyc cyubaserep(P) 
cyc P; 
{ 
    cyc Q; 
    init(Q); 
    bind(P); 

    while(P) {  
       Q = cyudev1(P); 
       if( !Q ) { return P; }
       P = Q; 
       } 
    printf("Error in cyubaserep: P = 0;\n!"); 
    return P;
}
 

