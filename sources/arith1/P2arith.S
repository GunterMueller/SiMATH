/*M
.SH NAME
P2arith - arithmetic package for polynomials over Z/2Z
.SH SYNOPSIS
.nf
#include<_P2arith.h>

.\ P2arith ()
Unless not stated otherwise all parameters are of type unsigned long*.
See also the compatibility notice below. 

int  P2maxdeg()             the maximal possible degree which can be 
                            stored 
int  P2deg(p)               the degree of p; -1 for p == 0 
void P2addeq(a,b)           a += b
void P2add(a,b,e)           e = a + b

void P2multeq(a,b)          a *= b
void P2mult(a,b,e)          e = a * b
void P2squareeq(a)          a = a * a
void P2square(a,e)          e = a * a

The return value of the next 6 functions is 1 if b == 0 and 0 otherwise.

int P2modeq(a,b)            a %= b                         
int P2mod(a,b,e)            e = a % b  
int P2diveq(a,b)            a /= b  
int P2div(a,b,e)            e = a / b  
int P2divmodeq(a,b,e)       e = a / b and a %= b    (a /= b  if a == e) 
int P2divmod(a,b,q,r)       q = a / b and r = a % b (r = a/b if r == q)

void P2pow(a,d,e)           e = a^d, d is of type unsigned long

The return value of the next 3 functions is 1 if a == 0 and b == 0 
    and 0 otherwise.

int P2gcdeq(a,b)            a = gcd(a,b)  
int P2gcd(a,b,e)            e = gcd(a,b)   
int P2hegcd(a,b,s,e)        e = gcd(a,b) and s such that 
                            b * s = e mod a. 

In the following, x means the variable of the polynomial.

void P2consone(e)            e = 1
void P2conszero(e)           e = 0
void P2consx(e)              e = x
void P2consxpow(e,d)         e = x^d, d is of type unsigned long
int  P2isone(a)              returns 1 if a == 1 otherwise 0
int  P2iszero(a)             returns 1 if a == 0 otherwise 0
int  P2isx(a)                returns 1 if a == x otherwise 0

void P2trans(a,b)            copy a into b

.SH DESCRIPTION
.PP
This file contains the above mentioned functions of a special arithmetic 
for polynomials over Z/2Z. 
Please mind the compatibility notice below!

.SH COMPATIBILITY
.PP
The data types being used do not conform with the SIMATH conventions. 
The declaration of a polynomial has to be of the form 
unsigned long p[P2LAENGE]; where P2LAENGE is defined in _P2arith.h

.SH SEE ALSO 
G2arith() and Earith(). 
M*/
/*H
        Version  1      10.10.1999      Marc Conrad 
H*/                                                             

#include<_P2arith.h>

int P2maxdeg() {
    return( (P2LAENGE - 1) * 32 - 1 );
}

int P2deg(unsigned long *pp) {
     unsigned long a;
     int  b;
     a = *(pp + (*pp));
     if( !a )   /* Nullpolynom */ 
         return -1;
     b = (32 * (*pp)) - 1;
     while(! (a & (1UL << 31)) ) {
         b--;
	 a <<= 1;
     }
     return b;
}

void P2consone(unsigned long *e)  {
     *e = 1; *(e+1) = 1;
}

void P2conszero(unsigned long *e) {
     *e = 0;
}

void P2consx(unsigned long *e) {
     *e = 1; *(e+1) = 2;
}

void P2consxpow(unsigned long *e, unsigned long d) {
     int q;
     int i;
     q = 1 + (d / 32);
     e[0] = q;
     for( i = 1; i < q; i++ ) { e[i] = 0; }
     e[q] = (1 << (d % 32) );
}

int  P2isone(unsigned long *a) {
     if( *a == 1 && *(a+1) == 1 ) return 1;
     return 0;
}

int  P2iszero(unsigned long *a) {
     if( *a == 0 ) return 1;
     return 0;
}

int  P2isx(unsigned long *a) {
     if( *a == 1 && *(a+1) == 2 ) return 1;
     return 0;
}

void P2addeq(unsigned long *p, unsigned long *q)  /* p += q; */ 
{
     unsigned long i;
     if( *p >= *q ) {
         for(i = *q; i;  i-- ) {
            p[i] ^= q[i];
	 }
         for(i = *p; i;  i-- ) {
            if( p[i] == 0 ) (*p)--;
            else return;
	 }
     } else {
         for( i = *q ; i != *p;  i-- ) {
            p[i] = q[i];
         }
         for( ; i;  i--) {
            p[i] ^= q[i];
	 }
         *p = *q;
     }
}

void P2add(unsigned long *p, unsigned long *q, unsigned long *e) {
     if( q == e ) {
         P2addeq(q,p);
         return;
     }
     P2trans(p,e);
     P2addeq(e,q);
}


#define LOWMULT                     \
        x = A; y = *pb;             \
        while(x) {                  \
           if( x & 1 ) { pl ^= y; } \
           x >>= 1;  y <<= 1; }  

#define HIGHMULT                           \
        x = A; y = *pb;  pl = 0;           \
        while(x) {                         \
           y >>= 1;                        \
           if( x & (1 << 31)) { pl ^= y; } \
           x <<= 1;  }


void P2mult(unsigned long *a, unsigned long *b, unsigned long *e)
{
        unsigned long  A, x, y;
        unsigned long lb,  lbb, la, pl = 0;
        unsigned long *pee, *pe, *pb;

        if( a == b ) {
               P2square(a,e);
               return;
	}
        if( a == e ) {
               P2multeq(a,b);
               return;
	}
        if( b == e ) {
               P2multeq(b,a);
               return;
	}

        if( !(lb = lbb = *b++)) { *e = 0; return; }
        if( (la = *a) ) {
            A = *(++a); pb = b;
            LOWMULT
            *(pe = pee = (e + 1)) = pl;
            HIGHMULT
            while (--lb) {
                pb++;
                LOWMULT
                *++pe = pl;
                HIGHMULT
	    }
        } else { *e = 0; return; }
        while (--la) {
                *++pe = pl;
                pe = ++pee;
                pb = b; A = *++a;
                pl = 0;
                LOWMULT
                *pe ^= pl;
                HIGHMULT
                lb = lbb;
                while (--lb) {
                    ++pe; ++pb;
                    LOWMULT
                    *pe ^= pl;
                    HIGHMULT
                }
        }
        if (pl) { *++pe = pl; }
        *e = pe - e;
}

void P2multeq(unsigned long *a, unsigned long *b) {
     unsigned long h[P2LAENGE];
     P2mult(a,b,h);
     P2trans(h,a);
}

void P2square(unsigned long *a, unsigned long *e)
{

        unsigned long *pe;
        unsigned long la, i, A, E, M;

        if( a == e ) { P2squareeq(a); return; }

        if( !(la = *a++) ) { *e = 0; return; } 
        pe = e + 1;
        if( la ) {
          while (--la) {
            A = *a++;
            E = 0; M = 1;
            for(i = 16; A && i--; ) {
                  if( A & 1 ) { E |= M; }
                  A >>= 1; M <<= 2;
	    }
            *pe++ = E;
            E = 0; M = 1;
            for(i = 16; A && i--; ) {
                  if( A & 1 ) { E |= M; }
                  A >>= 1; M <<= 2;
	    }
            *pe++ = E;
	  }
          A = *a;
          E = 0; M = 1;
          for(i = 16; A && i--; ) {
            if( A & 1 ) { E |= M; }
            A >>= 1;  M <<= 2;
	  }
          *pe = E;
          E = 0; M = 1;
          for(i = 16; A && i--; ) {
            if( A & 1 ) { E |= M; }
            A >>= 1;  M <<= 2;
	  }
          if( E ) *++pe = E;
	}
        *e = pe - e;
}

void P2squareeq(unsigned long *a) {
     unsigned long h[P2LAENGE];
     P2trans(a,h);
     P2square(h,a);
}

static void P2powmultaddeq(unsigned long *e, unsigned long *b, int d)
     /* e = e + b * x^d;  e == b is not allowed!!!! */ 
{
     int q, n;
     unsigned long *pe;
     unsigned long *pb;
     int i;

     q = d / 32;
     n = d % 32;

     pe = e + (q + 1);
     pb = b + 1;
     for( i = *b; i; i--) {
         *pe++ ^= (*pb++ << n);
     }
     if( n ) {
         pe = e + (q + 2);
         pb = b + 1;
         for( i = *b; i; i--) {
             *pe++ ^= (*pb++ >> (32 - n) );
	 }
     }
     pe = e + (*e);
     while(*pe == 0) {
            pe--;
            if( pe == e ) { *e = 0; return; }
            (*e)--;
     }
} 

int P2modeq(unsigned long *a, unsigned long *m)  /* a = a % m; */ 
{
     int degm, dega;

     degm = P2deg(m);
     if( degm == -1 ) { return 1; }
     if( a == m ) { *a = 0; return 0; }

     while( (dega = P2deg(a)) >= degm ) {
            P2powmultaddeq(a,m, dega - degm);
     }
     return 0;
}

int P2mod(unsigned long *a, unsigned long *m, unsigned long *e) {
     if( e == m ) {
         unsigned long h[P2LAENGE];
         P2trans(e,h);
         return( P2mod(a,h,e) );
     }
     P2trans(a,e);
     return( P2modeq(e,m) );
}

int P2divmodeq(unsigned long *a,unsigned long *m,unsigned long *e)
             /* e = a / m; und a = a mod m; */ 
{
     int degm, dega, d, q, i;

     degm = P2deg(m);
     if( degm == -1 ) { return( 1 ); }
     if( a == m ) { *a = 0; *e = 1; *(e+1) = 1; return; }

     if( m == e || a == e ) {
           unsigned long h[P2LAENGE];
           i = P2divmodeq(a,m,h);
           P2trans(h,e);
           return i;
     }

     dega = P2deg(a);
     d = dega - degm;
     if( d < 0 ) { *e = 0; return 0; }
     q = d / 32;
     for(i= q; i; i--) { e[i] = 0; }
     e[q+1] = (1 << (d % 32) );
     e[0] = q + 1;
     P2powmultaddeq(a,m,d);

     while( (dega = P2deg(a)) >= degm ) {
            d = dega - degm;
            P2powmultaddeq(a,m,d);
            e[(d/32)+1] |= (1 << (d % 32));
     }
     return 0;
}

int P2divmod(unsigned long *a, unsigned long *b,
             unsigned long *q, unsigned long *r ){
    if( b == r ) {
         unsigned long h[P2LAENGE];
         P2trans(b,h);
         return ( P2divmod(a,h,q,r) );
    }
    P2trans(a,r);
    return( P2divmodeq(r,b,q) );
}

int P2diveq(unsigned long *a, unsigned long *b)  { /* a = a / b; */
    unsigned long h[P2LAENGE];
    P2trans(a,h);
    return P2divmodeq(h,b,a);
}

int P2div(unsigned long *a, unsigned long *b, unsigned long *e)  {
    unsigned long h[P2LAENGE];
    P2trans(a,h);
    return P2divmodeq(h,b,e);
}

void P2pow(unsigned long *b, unsigned long d, unsigned long *e) {

    unsigned long h[P2LAENGE];
    if( d == 0 ) { P2consone(e); return; }
    if( d == 1 || P2iszero(b) ) { P2trans(b,e); return; }

    P2trans(b,h);
    P2consone(e);

    while( d ) {
        if( d & 1 ) { P2multeq(e,h); }
        d >>= 1;
        if( d ) { P2squareeq(h); }
    }
}

int P2gcdeq(unsigned long *a, unsigned long *b)
{
      unsigned long h[P2LAENGE];
      if( !(*a) && !(*b) ) { return 1; }
      if( a == b ) { return 0; }
      P2trans(b,h);

      while( *h ) {
         P2modeq(a,h);
         if( *a ) { P2modeq(h,a); }
         else { P2trans(h,a); return 0; }
      }
      return 0;
}

int P2gcd(unsigned long *a, unsigned long *b, unsigned long *e)
{
      if( b == e ) { return P2gcdeq(e,a); }
      P2trans(a, e);
      return P2gcdeq(e, b);
}

/* Diese Funktion kann wohl noch optimiert werden! */ 
int P2hegcd(unsigned long *a,  unsigned long *b,
            unsigned long *s, unsigned long *d) 
{
      unsigned long d1[P2LAENGE];
      unsigned long d2[P2LAENGE];
      unsigned long s1[P2LAENGE];
      unsigned long s2[P2LAENGE];
      unsigned long s3[P2LAENGE];
      if( !(*a) && !(*b) ) { return 1; }
      P2trans(a,d1);
      P2trans(b,d2);

      P2conszero(s1);
      P2consone(s2);

      while(! P2iszero(d2) ) {
          P2divmod(d1,d2,s3,d);

          P2trans(d2,d1);
          P2trans(d,d2);

          P2multeq(s3,s2);
          P2modeq(s3,a); /* Reduktion... */
          P2addeq(s3,s1);
          P2trans(s2,s1);
          P2trans(s3,s2);
      }

      P2trans(d1,d);
      P2trans(s1,s); 
      return 0;
}

void P2trans(unsigned long* src, unsigned long* dest) {
  memcpy((void*)dest, (void*)src, ((*src)+1) * sizeof(unsigned long));
}
