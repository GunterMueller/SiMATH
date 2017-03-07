#ifndef __G2ARITH__
#define __G2ARITH
#include <_P2arith.h>
#define G2LAENGE P2LAENGE /* In einer besseren Welt sollte auch 1+P2LAENGE/2
                             oder sowas aehnliches moeglich sein. 
                             Im Moment aber noch nicht, bzw. es waere zu
                             pruefen ob so eine Welt wirklich besser waere.
                             MC, 24.08.1999 */  

int G2maxdeg();

void G2consone(unsigned long *g, unsigned long *e);
void G2conszero(unsigned long *g, unsigned long *e);
void G2consx(unsigned long *g, unsigned long *e);
void G2consxpow(unsigned long *g, unsigned long *e, unsigned long d);
int  G2isone(unsigned long *g,unsigned long *a);
int  G2iszero(unsigned long *g,unsigned long *a);
int  G2isx(unsigned long *g,unsigned long *a);


void G2add(unsigned long *g, unsigned long *a,
            unsigned long *b, unsigned long *e);   
void G2addeq(unsigned long *g, unsigned long *a, unsigned long *b ); 
void G2mult(unsigned long *g, unsigned long *a, 
              unsigned long *b, unsigned long *e);   
void G2multeq(unsigned long *g, unsigned long *a, unsigned long *b ); 
void G2square(unsigned long *g, unsigned long *a, unsigned long *e); 
void G2squareeq(unsigned long *g, unsigned long *a); 
int G2inv(unsigned long *g, unsigned long *a, unsigned long *e);  
int G2inveq(unsigned long *g,unsigned long *a);  
int G2div(unsigned long *g, unsigned long *a, 
                            unsigned long *b, unsigned long *e); 
int G2diveq(unsigned long *g, unsigned long *a, unsigned long *b );  
void G2pow(unsigned long *g,unsigned long *a,
                            unsigned long d, unsigned long *e); 
void G2Epow(unsigned long *g,unsigned long *a,
                             unsigned long *d, unsigned long *e); 
int G2togf2( unsigned long *g);
int gf2toG2( int a, unsigned long *g);

#endif /* __G2ARITH */
