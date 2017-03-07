#ifndef __P2ARITH__
#define __P2ARITH__
/* #include <_Earith.h> */
#define P2LAENGE 500
/* =LAENGE  Entspricht G2maxdeg() == P2maxdeg()/2 = 7983 */

int P2maxdeg();
int P2deg(unsigned long *pp);

void P2consone(unsigned long *e);
void P2conszero(unsigned long *e);
void P2consx(unsigned long *e);
void P2consxpow(unsigned long *e, unsigned long d);

int  P2isone(unsigned long *a);
int  P2iszero(unsigned long *a);
int  P2isx(unsigned long *a);

void P2addeq(unsigned long *p, unsigned long *q);
void P2add(unsigned long *p, unsigned long *q, unsigned long *e);
void P2mult(unsigned long *a, unsigned long *b, unsigned long *e);
void P2multeq(unsigned long *a, unsigned long *b);
void P2square(unsigned long *a, unsigned long *e);
void P2squareeq(unsigned long *a);

int P2modeq(unsigned long *a, unsigned long *m);
int P2mod(unsigned long *a, unsigned long *m, unsigned long *e);
int P2divmodeq(unsigned long *a, unsigned long *m, unsigned long *e);
int P2divmod(unsigned long *a, unsigned long *b,
             unsigned long *q, unsigned long *r );
int P2diveq(unsigned long *a, unsigned long *b);
int P2div(unsigned long *a, unsigned long *b, unsigned long *e);
void P2pow(unsigned long *b, unsigned long d, unsigned long *e);
int P2gcdeq(unsigned long *a, unsigned long *b);
int P2gcd(unsigned long *a, unsigned long *b, unsigned long *e);
int P2hegcd(unsigned long *a,  unsigned long *b,
            unsigned long *s, unsigned long *d);

void P2trans(unsigned long *src, unsigned long *dest);

#endif /* __P2ARITH__ */
