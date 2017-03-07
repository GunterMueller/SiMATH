/*M
.SH NAME
elcfds - elliptic curve fast divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int elcfds(N, b, e)
int N;
single b, e;

.SH DESCRIPTION
elcfds() returns a factor of N or 0 in case
N is greater than 2^320 (overflow).
If the factorization failed, elcfds() returns 1 or N.
In this case, elcfds() may be called again with another
value b and/or a greater value e.
40 curves are being tested simultaneously.
For each point P on one of these curves the Point E*P is calculated,
where E is a product of prime numbers < e.
In particular, the maximum runtime of elcfds is determined by e.

.PP
.TP 4
.B N
> 1, should not be prime
.TP 4
.B b
should be chosen as random as possible
.TP 4
.B e
>= 0, as mentioned above, recommended value e = 50000

.SH NOTE
elcfds has NOTHING to do with the ec... functions!
For special applications, the constants for the
number of curves used and the limitation
of N can be set by modifying the source.

.SH SEE ALSO
elcpds, elcpdssum and for more details on the algorithm, please refer to
"Some integer factorization algorithms using elliptic curves"
of Richard P. Brent, September 1985.
M*/

/*H
	Version 1       25.06.1992      Marc Conrad
   DATE elcfds        : 921130
H*/

#include<_arith1.h>
#ifndef LP64
#include<_Earith.h>          
                                           
/*--------------------------------------------------------------------*/
/*         Voreinstellung der in der Doku erwaehnten Konstanten       */

/* Die Groesse von N ist durch 2^((LOC_LAENGE/2 - 1) * 32) beschraenkt      */
#define LOC_LAENGE 22       

/* LOC_ANZAHL = Anzahl der getesteten elliptischen Kurven             */
#define LOC_ANZAHL 32

/*--------------------------------------------------------------------*/


#define LOC_LAEANZ (LOC_LAENGE * LOC_ANZAHL)
#define LOC_LAEANZPE (LOC_LAEANZ + LOC_LAENGE)
/* A - B mod n */

#define Emsub_sp( A, B, ERG ) {if ( Ecomp( (A), (B) ) > 0 )  { \
			Eadd( (A), n, sub_aux );               \
			Esub( sub_aux, (B), ERG );             \
			}                                      \
	else Esub( A, B, ERG );}

/* P1 = (x1, y1), P2 = (x2, y2) */

static LONG x1[LOC_LAEANZ];
static LONG y01[LOC_LAEANZ];
static LONG x2[LOC_LAEANZ];
static LONG y2[LOC_LAEANZ];
static LONG aux[LOC_LAEANZ];
static LONG w[LOC_LAEANZPE];

static LONG glo[LOC_LAENGE];
static LONG n[LOC_LAENGE];
static LONG sub_aux[LOC_LAENGE];
static LONG lambda[LOC_LAENGE];

static LONG v1[LOC_LAENGE];
static LONG v2[LOC_LAENGE];
static LONG v3[LOC_LAENGE];


/*                P2 := P1 + P2                   */
static int subelcadd()
{
	single i;

/* aux = x1 - x2 */

	w[0] = 1;
	w[1] = 1;
	for (i = 0; i < LOC_LAEANZ; i += LOC_LAENGE) {
		Emsub_sp(x1 + i, x2 + i, aux + i)
			if (!(*(aux + i))) {
			*(aux+i) = 1;
			*(aux+i+1) = 1;
		}
	}

/* Berechnung des Inversen aux^-1     */
	for (i = 0; i < LOC_LAEANZ; i += LOC_LAENGE) {
		Emmult(aux + i, w + i, w + (i + LOC_LAENGE), n);
	}
	if (EGGT(w + LOC_LAEANZ, n, sub_aux, glo))
		return (Etoi(sub_aux));

/* eigentliche Addition */
	for (i = LOC_LAEANZ - LOC_LAENGE; i >= 0; i -= LOC_LAENGE) {
		Emmult(glo, w + i, v1, n);
		Emult(glo, aux + i, sub_aux);
		Ediv(sub_aux, n, glo, glo);
		Emsub_sp(y01 + i, y2 + i, v2);
		Emmult(v2, v1, lambda, n);
/* Berechnung von x2  */
		Emquad(lambda, v1, n);
		Emsub_sp(v1, x2 + i, v2);
		Emsub_sp(v2, x1 + i, x2 + i);
/* Berechnung von y2  */        
		Emsub_sp( x1+i, x2+i, aux+i );
		Emmult(lambda, aux + i, v1, n);
		Emsub_sp(v1, y01 + i, y2 + i);

	}          
	return (0);
}                

/* tt = times two: berechnet wird P2 := 2 P2  */
static int subelctt()
{				

	single i;

	w[0] = 1;
	w[1] = 1;
	for (i = 0; i < LOC_LAEANZ; i += LOC_LAENGE) {
		Eshift(y2 + i, 1, aux + i);
		Emult(aux + i, w + i, sub_aux);
		Ediv(sub_aux, n, v1, w + (i + LOC_LAENGE));
	}
	if (EGGT(w + LOC_LAEANZ, n, sub_aux, glo))
		return (Etoi(sub_aux));

	for (i = LOC_LAEANZ - LOC_LAENGE; i >= 0; i -= LOC_LAENGE) {
		Emmult(glo, w + i, v1, n);
		Emult(glo, aux + i, sub_aux);
		Ediv(sub_aux, n, glo, glo);
		Equad(x2 + i, v2);

/* 		v3 := (3 * v2) + 1 mod n			*/

		Eshift(v2, 1, v3);
		Eadd(v3, v2, sub_aux);
		Eincr(sub_aux);
		Ediv(sub_aux, n, v3, v3);

		Emmult(v3, v1, lambda, n);

/* x2  */
		Emquad(lambda, v1, n);
		Emsub_sp(v1, x2 + i, v2);
		Emsub_sp(v2, x2 + i, v1);
/* y2  */
		Emsub_sp(x2 + i, v1, v2);
		Emmult(lambda, v2, v3, n);
		Emsub_sp(v3, y2 + i, v2);
		Etrans(v2, y2 + i);
		Etrans(v1, x2 + i);
	}           
	return (0);
}


/*    Berechnet wird k * P   */
static int subelcsprod(k)
	single k;
{
	int ggt = 0;

	if (k > 1) {
		if (ggt = subelcsprod(k / 2))
			return (ggt);
		if (ggt = subelctt())
			return (ggt);
		if (k & 1)
			ggt = subelcadd();
	}
	return (ggt);
}


int elcfds(N, b, elcmax)
	int N;
	single elcmax, b;
{
	single i, m, k, u;
	unsigned z;
	int ggt;                  

/* Umwandlung N -> n und Test, ob N zu gross. */
	srand ( b );
	if (itoEb(N, n, LOC_LAENGE/2) ) return( 0 );      

	u = 1;
       
	for (i = 0; i < LOC_LAEANZ; i += LOC_LAENGE) {
		*(x2 + i) = 1;
		while( !(*(x2 + i + 1) = rand() )); 
		*(y2 + i) = 1;
		while( !(*(y2 + i + 1) = rand() ));          
	}     
	for (m = 2; m <= elcmax; m++) {     
		if (isspprime(m, &k)) { 
			if ( u > BASIS / k ) {     
			for (i = 0; i < LOC_LAEANZ; i += LOC_LAENGE) {
				Etrans(x2 + i, x1 + i);
				Etrans(y2 + i, y01 + i);
			}
			if (ggt = subelcsprod(u))  { 
				return (ggt);      
				} 
			u = 1;
			} else u = k * u;
		}
	}             
	return( 1 );
}          

#else /* LP64 */
int elcfds(int N, single b, single elcmax) {
    bind(N);
    /* N is greater than 2^320 (overflow).*/
    if (icomp(N,iexp(2,320))>0)
	return(0);
    return elcfds_lo(N,b,elcmax);
}
#endif
