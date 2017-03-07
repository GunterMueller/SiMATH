/*M
.SH NAME
iscynfHS - is cyclotomic number field Hilbert-Speiser for a given prime ?

.SH SYNOPSIS
.nf 
#include <_arith2.h>

single iscynfHS(n,l, msg, bound)
single n, l, msg, bound; 

.SH DESCRIPTION
.TP 4
.B n 
is a single number, n > 2, and  n % 4 != 2. 
.TP 4
.B l 
is an odd prime; 
.TP 4
.B msg 
is 0 or 1; 
.TP 4
.B bound 
is a positive single or 0; 
.PP 
If the class number of the n-th cyclotomic field is one, and iscynfHS() 
returns 0, then the field is not Hilbert-Speiser for the prime l. A detailed
description of the algorithm can be found in: Marc Conrad, Daniel R. Replogle:
"Nontrivial Galois Module Structure of Cyclotomic Fields".
.PP
If msg = 1 messages will be printed during the computation.
.PP 
bound is an upper bound on the values n, l. The performance of the algorithm
depends on the number l^f where f is minimal such that l^f = 1 mod n. 
iscynfHS() returns -1 if l^f is greater then bound. bound=0 implies that 
l^f must be a single.  
.PP 
A negative return value implies that the parameters n and l are not 
suitable for this algorithm.
M*/


#include <_simath.h>
#define G_GRENZE 256 


/* Converts an integer to polynomial lexicographically */
static pol i2pmi(single p, single i) { 
    list P; 
    single z, t; 
    init(P); 
    if( !i ) return 0; 
    P = _0; z = 0; 
    while( i ) { 
        t = i % p; 
        i = i / p; 
        if( t ) { P = lcomp2(z,t,P); }
        z++; 
        } 
    return P; 
    } 

/* Computes the order of the element a in Z/lZ[x] / P(x)  */ 
static single EltOrder(pol a, single l, pol P) { 
     single i; 
     list b, c, eins, m; 
     bind(a, P); 
     init(b, c, eins); 

     b = eins = list2(0,1); 
     m = sexp(l, lfirst(P) ); 
     for( i = 1; i < m + 100; i++ ) { 
         b = pmiprod(1, l, a, b); 
         b = upmirem(l, b, P );  
        
         if( oequal(b, eins ) ) { return i; }  
         } 
     } 
/* Finds a Generator of  Z/lZ[x] / P(x), 0 if not found  */ 

static list FindGenerator(single l, pol P) { 
     list L, W; 
     single d, z, j; 
     init(L, W);  
     bind(P); 

     z = sexp(l, lfirst(P) ) - 1; 
     j = 0; 
     while(j++ <= z ) { 
        W = i2pmi(l, j); 
        d = EltOrder(W, l, P); 
        if(  d == z  ) { return W; } 
        } 
     return 0; 
     } 

/* Computes k, such that a^k = u in Z/lZ[x] / P(x)*/
static single DiscLog(pol a, pol u, single l, pol P) {  
     single i, w; 
     list b, c; 
     bind(a, u, P); 
     init(b, c); 

     b = list2(0,1); 
     u = pitopmi(1,u,l); 
     u = upmirem(l, u, P );  
     w = sexp(l, lfirst(P)); 
     for( i = 1; i < w; i++ ) { 
         b = pmiprod(1, l, a, b); 
         b = upmirem(l, b, P );  
        
         if( oequal(b, u ) ) { 
                return i; }  
         } 
     printf("Fataler FEHLER:::: Exit Disclog: i = -1\n"); 
     exit(1); 
     } 
/* Computes a basis of cyclotomic units as number field elements */
static list GetBase(single n) { 
     list L, a, F, M; 
     init(L, a, F, M);
     M = _0; 
     L = lcyubas(n); 
     F = udpicycgen(n); 
     while( L != _0 ) { 
        a = cyutonfel(n, F, lfirst(L) ); 
        L = lred(L); 
        if( lfirst(a) != 1 ) { printf("Error! a = %obj\n", a); } 
        else { a = lred(a); } 
        a = dptop(1,a); 
        M = lcomp(a, M);  
        } 
     a = list2(1,1); /* add zeta to the list */
     M = lcomp(a, M); 
     a = list2(0, -1); /* add -1 to the list */
     M = lcomp(a, M); 
     M = linv(M); 
     return M; 
     } 

/* A simple triangularization algorithm */
single V[G_GRENZE][G_GRENZE];
static void TrianguliereV(single m, single start, 
                   single maxj, single maxi) { 
     single i, j, aktmin; 
     single zaehl = 0, t, mzaehl; 
     single aminidx = 0; 
/* Pivot finden */
     while(1) { 
       zaehl = 0; 
       aktmin =  m + 1; 
       for (i = start; i < maxi; i++ ) { 
         if( V[start][i] != 0) { 
             zaehl++; mzaehl = i;   
             if( V[start][i] <= aktmin ) { 
                aktmin = V[start][i]; 
                aminidx = i;} 
             } 
         } 
       if( zaehl == 0 ) { return; } 
       if( zaehl == 1 ) { 
           for( j = 0; j < maxj; j++ ) { 
               t = V[j][start]; 
               V[j][start] = V[j][mzaehl]; 
               V[j][mzaehl] = t; 
               } 
           return; 
           } 
       for (i = start; i < maxi; i++ ) if( i != aminidx && V[start][i] ) {  
         for( j = 0; j < maxj; j++ ) { 
            V[j][i] -= V[j][aminidx]; 
            if( V[j][i] < 0 ) { V[j][i] += m; } 
            } 
         } 
         } 
                    
     } 
/* Compute the minimal f such that p^f = 1 mod n. Return 0 if f > 20 */
static single FindF(single n, single l) { 
    single i, ll = 1; 
    i = 1; 
    while( i < 20 ) { 
       ll = msprod(n, l, ll); 
       if( ll == 1 )  return i; 
       i++; 
       } 
    return 0;   
    } 

static int IsPairOk(single n, single l, single msg, single bound) {
    single ph, f, g;
    int A;
    init(A);
    if( l == 2 ) return -2; 
    if( n % 4 == 2 ) return -3;
    if( !isiprime(l) ) return -4;
    if( sgcd(l, n) != 1 ) return -5;
    if( !(f = FindF(n,l)) ) return -6;
    if( f == 1 ) return -7; 
    ph = iphi(n); /* Number of cyclotomic units in the base + 2 must
                     not exceed G_GRENZE */   
    if(  ph / 2 + 1 > G_GRENZE ) return -8;  
    g = ph / f;
    if( g > G_GRENZE ) return -9;
    A = iexp(l,f);
    if( !issingle(A) ) return -1;
    if( bound && A > bound ) return -1;  
    if( msg ) { printf("iscynfHS: n=%d l=%d f=%d g=%d k=%d\n", n,l,f,g,A);  }
    return 1;
    }

single iscynfHS(single n, single l, single msg, single  bound) { 
    list C, L, P, G, B, H; 

    list D; 
    single s, t, i, j, im, jm, f, k, c, detV; 

    init(D, C,  L, P, G, B, H); 

/*   check the input parameters */
    if( (s = IsPairOk( n, l, msg, bound )) < 0  ) { return s; } 

/*  generate cyclotomic polynomial mod l*/ 
    C = udpicycgen(n); 
    C = dptop(1,C); 
    C = pitopmi(1, C, l); 

/*  faktor cyclotomic polynomial mod l: */ 
    L = upmicfact(l, C); 

/*  Compute a basis of cyclotomic units as number field elements: */
    B = GetBase(n); 
    i = 0;  
/*  Make matrix V */
    while( L != _0 ) {  
        P = lfirst(L); 
        L = lred(L); 

        G = FindGenerator(l, P); 
         
        H = B; 
        j = 0; 
        while( H != _0 ) { 
            D = lfirst(H); H = lred(H); 
            V[i][j++] = DiscLog(G, D, l, P); 
            } 
        jm = j; 
        i++; 
        } 
    im = i; 
    f = lfirst(P); 
    k = sexp(l, f) - 1;  

/* Compute the determinant of V */
    if( jm < im ) { detV = 0; } 
    else { 
       detV = 1; 
       for( i = 0; i < im; i++ ) { 
        TrianguliereV(k, i, im, jm); 
        detV = msprod(k, detV, V[i][i]); 
        } 
       }
/* Compute c, i.e. find a prime which divides det(V) and k; but not s */
    s = (l - 1) * ( l - 1) / 2;
    c = sgcd(detV, k); 
    do { 
     t = c; 
     c = c / sgcd(s,c); 
     }
    while( c != t ); 
    if(msg) printf("iscynfHS: detV=%d, s=%d, k=%d, c=%d\n",  detV, s, k, c);        
    
    if( c != 1 ) return 0; 
    else return 1; 
   } 



