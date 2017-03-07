/*M
.SH NAME
G2arith - arithmetic package for Galois fields with characteristic 2
.SH SYNOPSIS
.nf
#include<_G2arith.h>

.\ G2arith ()
Unless not stated otherwise all parameters are of type unsigned long*
all calculations are done modulo the polynomial g. g must be not zero. 
g must point to a different part of the memory than all other 
parameters, that means esp. g != a, g != e, etc. The degree of g must 
be <= G2maxdeg(). The polynomials a and b are assumed to be reduced, 
i.e. P2deg(a) < P2deg(g) and P2deg(b) < P2deg(g). 

int G2maxdeg(g)               the maximal degreed allowed for g.

void G2add(g,a,b,e)           e = a + b
void G2addeq(g,a,b)           a += b

void G2mult(g,a,b,e)          e = a * b
void G2multeq(g,a,b)          a *= b
void G2quare(g,a,e)           e = a * a
void G2squareeq(g,a)          a = a * a

The return value of the next 4 functions is 1 if gcd(a,g) != 1 
otherwise 0. 
int G2inv(g,a,e)              e = a^-1 
int G2inveq(g,a)              a = a^-1  
int G2div( g,a,b,e)           e = a / b
int G2diveq( g,a,b,e)         a = a / b

void G2pow(g,a,d,e)           e = a^d. d is of type unsigned long. 

void G2consone(g,e)           e = 1
void G2conszero(g,e)          e = 0
void G2consx(g,e)             e = x
void G2consxpow(g,e,d)        e = x^d, d is of type unsigned long

int  G2isone(g,a)             returns 1 if a == 1 otherwise 0
int  G2iszero(g,a)            returns 1 if a == 0 otherwise 0
int  G2isx(g,a)               returns 1 if a == x otherwise 0

.SH DESCRIPTION
.PP
This file contains the above mentioned functions of a special arithmetic 
for polynomials over Z/2Z. 
Please mind the compatibility notice below!

.SH COMPATIBILITY
.PP
The data types being used do not conform with the SIMATH conventions. 
The declaration of an element of GF(2^n) has to be of the form 
unsigned long p[G2LAENGE]; where G2LAENGE is defined in _G2arith.h
These data types cannot be used as members of SIMATH lists etc.

.SH SEE ALSO 
P2arith(), gf2toG2() and G2togf2(). 
M*/
/*H
	Version  1      10.10.1999      Marc Conrad 
H*/                                                             

#include<_G2arith.h>

// Nur fuer Debugging Zwecke. Man kann damit den maxmimal erlaubten 
// Grad kuenstlich heruntersetzen. 

static int G2maxdegvar = 1000000;
int set_G2maxdeg(int i) { G2maxdegvar = i; }

int G2maxdeg() {
        if( G2maxdegvar > (P2maxdeg() / 2) ) {
               G2maxdegvar = P2maxdeg() / 2;
	}
        return G2maxdegvar;
}

void G2consone(unsigned long *g, unsigned long *e) { P2consone(e); }
void G2conszero(unsigned long *g, unsigned long *e) { P2conszero(e); }
void G2consx(unsigned long *g, unsigned long *e) { P2consx(e); }
void G2consxpow(unsigned long *g, unsigned long *e, unsigned long d) {
        P2consxpow(e,d);
	P2modeq(e,g);
}
int  G2isone(unsigned long *g,unsigned long *a) { return( P2isone(a)  ); }
int  G2iszero(unsigned long *g,unsigned long *a){ return( P2iszero(a) );}
int  G2isx(unsigned long *g,unsigned long *a)   { return( P2isx(a) );   } 


void G2add(unsigned long *g, unsigned long *a,
              unsigned long *b, unsigned long *e)  {
    P2add(a,b,e);
}

void G2addeq(unsigned long *g, unsigned long *a,
              unsigned long *b ){
    P2addeq(a,b);
}

void G2mult(unsigned long *g, unsigned long *a, 
              unsigned long *b, unsigned long *e)  {
    P2mult(a,b,e);
    P2modeq(e,g);
}

void G2multeq(unsigned long *g, unsigned long *a,
              unsigned long *b ){
    P2multeq(a,b);
    P2modeq(a,g);
}
 
void G2square(unsigned long *g, unsigned long *a, unsigned long *e) {
    P2square(a,e);
    P2modeq(e,g);
}

void G2squareeq(unsigned long *g, unsigned long *a) {
    P2squareeq(a);
    P2modeq(a,g);
}

int G2inv(unsigned long *g, unsigned long *a, unsigned long *e) {
    unsigned long d[G2LAENGE];
    P2hegcd(g, a, e, d);
    if( P2isone(d) ) { return 0; }
    return 1;
} 

int G2inveq(unsigned long *g,unsigned long *a) {
    unsigned long h[G2LAENGE];
    P2trans(a,h);
    return( G2inv(g,h,a) );
}

int G2div(unsigned long *g, unsigned long *a,
	  unsigned long *b, unsigned long *e){
    if( a == e ) {
        unsigned long h[G2LAENGE];
        if( G2inv(g,b,h) == 1 ) return 1;
        G2multeq(g,e,h);
        return 0;
    }
    if( G2inv(g,b,e) == 1 ) return 1;
    G2multeq(g,e,a);
    return 0;
}

int G2diveq(unsigned long *g, unsigned long *a, unsigned long *b ) {
    return( G2div(g,a,b,a) );
}
     

void G2pow(unsigned long *g,unsigned long *a,
	   unsigned long d, unsigned long *e){

    unsigned long h[G2LAENGE];
    if( d == 0 ) { G2consone(g,e); return; }
    if( d == 1 || G2iszero(g,a) ) { P2trans(a,e); return; }

    P2trans(a,h);
    G2consone(g,e);

    while( d ) {
        if( d & 1 ) { G2multeq(g,e,h); }
        d >>= 1;
        if( d ) { G2squareeq(g,h); }
    }
} 
/*
Ist nicht getestet, wird das ueberhaupt benoetigt?
void G2Epow(unsigned long *g,unsigned long *a,
                             unsigned long *d, unsigned long *e){ 
    
    unsigned long h[G2LAENGE];
    unsigned long z, ld, i;
    if( *d == 0 ) { G2consone(g,e); return; } 
    if( (*d == 1 && *(d+1) == 1) || G2iszero(g,a) ) { P2trans(a,e); return; } 

    P2trans(a,h);
    G2consone(g,e); 
    ld = *d++;
    while( ld ) { 
      z = *d++; ld--;
      for( i = 32; i--; ) { 
        if( z & 1 ) { G2multeq(g,e,h); } 
        z >>= 1; 
        if(z || ld) { G2squareeq(g,h); } 
        } 
      }
    } 
*/
