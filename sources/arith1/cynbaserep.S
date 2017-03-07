/*M
.SH NAME
cynbaserep - cyclotomic number base representation 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cynbaserep(U)
cyc U;

.SH DESCRIPTION
cybaserep() computes the basis representation of a cyclotomic number U.
For details see "Basen von Moduln mit Anwendung auf Kreiseinheiten und 
Stickelbergerelemente", PhD thesis of Marc Conrad, Saarbruecken 1997.  
M*/
/*H
	Version 1 	01.01.2000 Marc Conrad.
H*/
#include<_arith1.h>
/* #define ANHANG_A1 */
#define METH_B 0
#define METH_S -1 
#define METH_H -2 
#define METH_E -3 

#define N_EQUAL2 1
#define N_EQUAL4 2
#define N_PRIME  3
#define N_EQUAL2MOD4 4 
#define N_SQUAREFREE 5 
#define N_4SQUAREFREE 6 
#define N_OTHER 7 

static int analyze_n(n, E) 
single n; 
list E; 
{       
        bind(E);

        if( n == 2 ) { return N_EQUAL2; }
        if( n == 4 ) { return N_EQUAL4; } 
        if( lred(E) == _0 ) { 
              if( lfirst(E) == 1 ) { return N_PRIME; } 
              else { return N_OTHER; } 
              }
        if( n % 4 == 2 ) { return N_EQUAL2MOD4; } 

        if( n % 4 == 0 ) { 
            if( lfirst(E) != 2 ) { return N_OTHER; } 
            E = lred(E); 
            while( E != _0 ) { 
                 if( lfirst(E) != 1 ) { return N_OTHER; } 
                 E = lred(E); 
                 } 
            return N_4SQUAREFREE; 
            } 
        while( E != _0 ) { 
            if( lfirst(E) != 1 ) { return N_OTHER; } 
            E = lred(E); 
            } 
        return N_SQUAREFREE; 
        } 

/* cyclotomic number generator developing method. (Algorithm A.1.2) */
cyc cyngdevmet( C )  
list C; 
{
   single s, n, a;  
   list E, P; 

   bind(C); 
   init(E,P); 
   n = lfirst(C); 
   a = lsecond(C); 
   P = iflel(n);
   E = lsecond(P); 
   P = lfirst(P); 

   s = analyze_n(n,E);
   if( s == N_EQUAL2 ) { return METH_H; } 
   else if( s == N_EQUAL4 ) {
       if( a == 1 ) { return METH_B; } 
       else { return METH_S; } 
       }
   else if( s == N_PRIME ) { 
        single p; 
        p = lfirst(P); 
        if( (2 * a) < p ) { return METH_B; } 
        else { return METH_S; } 
        } 
   else if( s == N_EQUAL2MOD4 ) { 
        return 2; 
        } 
   else if( s == N_SQUAREFREE || s == N_4SQUAREFREE ) { 
        single ai[16], qi[16];
        single p, i, r, k, l; 
        i = 1; 
        while( P != _0 ) {
          p = lfirst(P); P = lred(P); 
          qi[i] = ( p == 2 ? 4 : p);
          ai[i] = a % qi[i];
          i++; 
          } 
        r = i - 1; 
/* V,i)     */
        if( a == 1 ) {  
             if( r % 2 == 0 ) { return METH_B; } 
             else { return METH_E; } 
             } 
/* V,ii)   */
        l = 1; 
        while( ai[l] == 1 ) { l++; } 
#ifdef ANHANG_A1   /* Algorithm described in Appendix A.1 */
        if( (2 * ai[l]) < qi[l] ) { return METH_S; } 
#else             /* Algorithm used in Appendix A.2 */
        if( ai[l] == qi[l] - 1 ) { return (qi[l] == 4 ? 2 : qi[l]); }  
        if( (2 * ai[l]) > qi[l] ) { return METH_S; } 
#endif
/* V,iii) + V,iv)  */
        for( k=l; k <= r; k++ ) { 
             if( ai[k] == qi[k] - 1 ) { return (qi[k] == 4 ? 2 : qi[k]); }  
             } 
        return METH_B; 
        } 
/* VI)     */
   else { 
        single p[16], qp[16];
        single i, r, k, l, lambda, ai; 
        i = 1; 
        while( P != _0 ) {
          p[i] = lfirst(P); P = lred(P); 
          qp[i] = sexp(p[i], lfirst(E) - 1); 
          E = lred(E); 
          i++; 
          } 
        r = i-1; 
        l = 1; 
        while( qp[l] == 1 || qp[l] == 2 )  { l++; } 
        lambda = a % qp[l]; 
        if( 2 * lambda > qp[l] ) return METH_S; 
        for( i = 1; i <= r; i++ ) { 
             ai = ( (a % (qp[i] * p[i])) - (a % qp[i]) ) / qp[i]; 
             if( ai == p[i] - 1 ) return p[i]; 
             }
        return METH_B;   
        } 
   }

cyc cyngzeisum(C, p) /* Constructs a Zeilensumme */
list C; 
single p;
{ 
   cyc P, D;
   single a, n, d, b, i, c;
   bind(C); 
   init( P, D ); 

   P = _0; 
   n = lfirst(C); 
   a = lsecond(C); 
   d = n/p; 
   b = a % d; 

   for( i = 0; i <= p-1; i++ ) { 
      c = b + i * d; 
      if( sgcd(c,n) == 1 ) { 
           D = cyncons(n,c); 
           P = cynprod(P,D); 
           } 
      } 
   return P; 
   } 

cyc cyngnofzeisum(C, p) /* Construct n(Zeilensumme) */
list C; 
single p;
{ 
   cyc D, E;
   single a, n, d, b, i, c;
   bind(C); 
   init( D, E ); 

   n = lfirst(C); 
   a = lsecond(C); 
   d = n/p; 
   b = a % d; 

   D = cynexp(cyncons(d,b), -1); 
   if( d % p == 0 ) { return D; } 
   c = msinv(d,p); 
   E = cyncons(d,msprod(d,c,b)); 
   return cynprod(E,D); 
   } 

static cyc cyngSqop(C,p) /* S^q operator in Algorithm A.1.4 (p is a prime) */
list C; 
single p; 
{ 
   single a, d, n, q, b, c; 
   bind(C); 
   
   n = d = lfirst(C); 
   a = lsecond(C); 

   q = 1;
   while( d % p == 0 ) { d = d / p;  q = q * p; }

   c = a % q;
   b = a % d;
   b = micra(q,d,msinv(d,q), q-c, b);

   return list2(n,b); 
   }
  

cyc cynbaserep(cyc P);
   
cyc cyngdev(C, m)  /* develops the cyclotomic number generator C */ 
list C;           /* with method m */
single m; 
{ 
    cyc P; 
    bind(C); 
    init(P); 
    if( m == METH_S ) { 
        single n; 
        n = lfirst(C); 
        P = cyncons(n, n - lsecond(C)); 
        }
    else if( m > 1 ) { 
        list Q; 
        init(Q); 
        P = cyngzeisum(C,m); 
        Q = cyngnofzeisum(C,m); 
        P = cynprod(P,Q); 
        P = cynquot(list2(C,1),P); 
        } 
    else if( m == METH_H ) { 
        P = cyncons(4,1); 
        P = cynprod(cyncons(4,3),P); 
        } 
    else if( m == METH_E ) { 
        list H, D; 
        cyc Z, Zn;
        single z, p; 
        init(H,D, Zn, Z); 

        P = _0; 
        z = 1; 
        H = lfirst(iflel(lfirst(C))); 
        D = C; 
        while( H != _0 ) { 
            p = lfirst(H); 
            H = lred(H); 

            Z = cyngzeisum(D, p); 
            Zn = cyngnofzeisum(D, p); 
            Z = cynprod(Z, Zn); 

            if( z ) { P = cynprod(P,Z); } 
            else { P = cynquot(P,Z); } 
             
            z = !z; 
            D = cyngSqop(D,p); 
            } 

        Z = list2(D,1); 
        Z = cynprod(list2(C,1),Z); 
        P = cynquot(Z, P); 

        /* printf("Ennola recursion ..."); */
        P = cynbaserep(P); 

        P = cynroot(P,2); 
        } 
    return P; 
}

obj cyndev1(P)  /* return 0 if there is nothing to develop */
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
          m = cyngdevmet(C); 
          if( m != METH_B ) { 
               e = lsecond(Q); 
               R = cyngdev(C,m); 
               R = cynexp(R,e); 
               R = cynprod(R, list2(C,-e)); 
               R = cynprod( P, R);  
               return R; 
               } 
          Q = lred2(Q); 
          } 
    return 0; 
    }  

cyc cynbaserep(P) 
cyc P; 
{ 
    cyc Q; 
    init(Q); 
    bind(P); 

    while(P) {  
       Q = cyndev1(P); 
       if( !Q ) { return P; }
       P = Q; 
       } 
    printf("Error in cynbaserep: P = 0;\n!"); 
    return P;
}
 

