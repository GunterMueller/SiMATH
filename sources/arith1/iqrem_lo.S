/*M
.SH NAME
iqrem_lo - integer quotient and remainder, lists only

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iqrem_lo(A,B,pQ,pR)
int A,B,*pQ,*pR;

.SH DESCRIPTION
iqrem_lo()
calculates the integers *pQ = A / B and *pR = A - (*pQ) * B
for B!=0 and returns 0.
The computation is completely performed within the SIMATH memory
management, i.e. using only lists.

.SH NOTE
iqrem_lo() seems to work not correctly on all compilers. Please
use iqrem() instead.

.SH SEE ALSO
iqrem, iqrem_2, iqrem_3
M*/
/*H
	Version  1      14.02.1992	Marc Conrad (altes iqrem)
	Version  2	03.11.1994	MX-Version entfernt. MP
	Version  3	03.05.1999	Marc Conrad, Doku ergaenzt.
   DATE iqrem_lo      : 920331.941201
H*/

#include<_arith1.h>

/* Macros zum sukzessiven Setzten von Bits zu einer integer Zahl */

#define setze_bit {if ( k < 0 )  \
A = ( !q && (A == _0) ? _0 :  ( vzb ? lcomp( -q, A ) : lcomp( q, A ) ) )\
, q = ( 1 << 29 ), k = 28;else q += ( 1 << (k--) );}

#define setzek_bit {if ( k < 0 )  \
A = ( !q && (A == _0) ? _0 :  ( vzb ? lcomp( -q, A ) : lcomp( q, A ) ) )\
, q = 0, k = 28; else k-- ;}

/* Linksshift des arrays paa 					*/
/* es wird nur das Stueck zwischen pava und pae echt verschoben */
/* Der Rest wird nur 'virtuell' verschoben			*/
/* zur Realisierung dieser virtuellen Verschiebung dienen 	*/
/* Die Variablen sch, pava, pawa.				*/

#define ashift 	{					\
		if ( !sch ) *pava = *(--pawa), sch=29;	\
		else sch--;				\
		lfa++;					\
		pa = pava;  				\
		*pa <<= 1;  				\
		do {					\
		pa++;      				\
		*pa <<= 1;            			\
		if ( *(pa - 1) & 1073741824 ) {         \
			*(pa - 1) &= 1073741823;        \
			(*pa)++;                        \
			}                               \
		} while ( pa != pae );                  \
			}

/* maximale Arraygroesse 					*/

#define AMAX 250

int iqrem_lo(A, B, pq, pr)
int A, B, *pq, *pr;
{
	extern char *malloc(), *realloc();
	char *p;

	static int *paa, *pba, asize = 0, bsize;

	single *pb, *pbe, *phb, *pbue;
	single *pa, *pae, *pha, *paba, *pava, *pawa, *paue;

/* 
	paa:	Arrayanfang
	pae:	Arrayende, bei gespeicherter Zahl
	paue:	ultimatives Ende des Arrays 
	pha:	Hilfspointer
	pava, pawa, paba sind Hilfspointer
	analog fuer b
*/

	single vza, vzb;

/*  	Vorzeichen von a bzw. b     			*/

	single la, lb;

/* Laenge in Bits ( von a bzw. b )			*/

	single q;

/*  q, A : Quotient, B : Rest	 	    		*/


	single lfa, lrb, a, b, i, max, j, k, u, sch;
	list AL, BL;

/* Hilfsvariablen 					*/

	bind(A, B);

/* triviale Faelle					*/
	if (issingle(A)) {
		if (issingle(B)) {
			*pr = A % B;    
			*pq = A / B;
		} else
			*pr = A, *pq = 0;
		return (0);
	}
	if (issingle(B)) {
		return (isqrem(A, B, pq, pr));
	}
/*  Allocieren von Speicher beim ersten Aufruf v. iqrem	*/
/* falls nicht genug Speicher vorhanden, wird die alte  */
/* Version aufgerufen.					*/

	if (!asize) {
		asize = AMAX;
		bsize = AMAX;
		if ((paa = (int *) malloc(asize * sizeof(int))) == NULL) {
			return (iqrem_2(A, B, pq, pr));
		}
		if ((pba = (int *) malloc(bsize * sizeof(int))) == NULL) {
			return (iqrem_2(A, B, pq, pr));
		}
	}
	paue = paa + asize;
	pbue = pba + bsize;

/* Speichern von A in das Array paa			*/
	pa = paa;
	la = 0;
	AL = A;
	vza = 1;
	while (AL != _0) {
		if ((a = lfirst(AL)) >= 0)
			*(pa++) = a;
		else
			*(pa++) = -a, vza = 0;
		AL = lred(AL);
		if (pa == paue) {
			if ((p = malloc(AMAX * sizeof(int))) == NULL
			    || (free(p), (paa = (int *) realloc(paa,
			  (asize + AMAX) * sizeof(int))) == NULL)) {
				return (iqrem_2(A, B, pq, pr));
			}
			pa = paa + asize;
			asize += AMAX;
			paue = paa + asize;
		}
		la += 30;
	}
	pae = --pa;

/* Speichern von B in das Array pba			*/
	pb = pba;
	lb = 0;
	lrb = 0;
	vzb = 1;
	BL = B;
	while (BL != _0) {
		if ((b = lfirst(BL)) >= 0)
			*(pb++) = b;
		else
			*(pb++) = -b, vzb = 0;
		BL = lred(BL);
		lb += 30;
		lrb++;
		if (pb == pbue) {
			if ((p = malloc(AMAX * sizeof(int))) == NULL
			    || (free(p), (pba = (int *) realloc(pba,
			  (bsize + AMAX) * sizeof(int))) == NULL)) {
				return (iqrem_2(A, B, pq, pr));
			}
			pb = pba + bsize;
			bsize += AMAX;
			pbue = pba + bsize;
		}
	}
	pbe = --pb;

/* Trivialer Fall: A < B ( la und lb sind die Laenge in Bits ).	*/
	if (la < lb) {
		*pq = 0;
		*pr = A;
		return (0);
	} else if (la == lb) {
		pha = pae;
		phb = pbe;
		while ((*pha == *phb) && phb != pba)
			pha--, phb--;
		if (*pha < *phb) {
			*pq = 0;
			*pr = A;
			return (0);
		}
	}
/* Initialisieren der Hilfsvariablen 				*/
	paba = pae - (lrb - 1);
	if (paba != paa)
		pava = paba - 1;
	else
		pava = paa;
	pawa = pava;
	sch = 30;
	lfa = 0;
	vzb = vza ^ vzb;

/* Anschieben d.h. Normieren auf hoechstes Bit = 1		*/
/* von a:							*/
	while (*pae < (1 << 29)) {
		la--;
		ashift
	}
/* von b:							*/

	while (*pbe < (1 << 29)) {
		pb = pba;
		*pb <<= 1;
		lb--;
		if (pbe != pba)
			do {
				pb++;
				*pb <<= 1;
				if (*(pb - 1) & 1073741824) {
					*(pb - 1) &= 1073741823;
					(*pb)++;
				}
			} while (pb != pbe);
	}

/* max : Laenge des zu erwartenden Quotients			*/
	max = la - lb;
	k = max % 30;
	max++;

/* j zaehlt die gesetzten Bits					*/
	q = 0;
	j = 0;
	A = _0;

/* eigentliche Division :					*/

	for ( ; ; ) {
		pha = pae;
		phb = pbe;
		while ((*pha == *phb) && phb != pba)
			pha--, phb--;
		if (*pha < *phb) {
/* Shiften */
			setzek_bit
			if (++j == max)
				goto fertig;
			ashift
		}
/* Subtrahieren */
		pa = paba;
		pb = pba;
		do {
			*pa -= *pb;
			pb++;
			if (*pa < 0)
				*pa += 1073741824, *(++pa) -= 1;
			else
				pa++;
		} while (pa != pae);
		*pa -= *pb;

/* Shiften bis wieder fuehrende Eins */

		setze_bit;
		if (++j == max)
			goto fertig;
		ashift

			while (*pae < *pbe) {
			setzek_bit;
			if (++j == max)
				goto fertig;
			ashift
		}
	}
/* Ende der eigentlichen Division			*/
fertig:

	A = (vzb ? lcomp(-q, A) : lcomp(q, A));

/* Ergebnis aufbereiten 			*/
	if (A == _0)
		*pq = 0;
	else if (lred(A) == _0)
		*pq = lfirst(A);
	else
		*pq = A;
/* Rest berechnen durch verschieben von a      		*/

	pae++;
	lfa = lfa % 30;
	if (lfa) {
		*pae = 0;
		for (; lfa < 30; lfa++) {
			pa = pava;
			*pa <<= 1;
			do {
				pa++;
				*pa <<= 1;
				if (*(pa - 1) & 1073741824) {
					*(pa - 1) &= 1073741823;
					(*pa)++;
				}
			} while (pa != pae);
		}
	} else
		pae--;

	pa = pae;

/* und als Liste abspeichern 				*/
	B = _0;
	i = 1;
	for (; lrb > 0; lrb--) {
		if ((!(*(pa))) && i)
			pa--;
		else if (vza)
			B = lcomp(*(pa--), B), i = 0;
		else
			B = lcomp(-(*(pa--)), B), i = 0;
	}
	if (B == _0)
		*pr = 0;
	else if (lred(B) == _0)
		*pr = lfirst(B);
	else
		*pr = B;



	return (0);

}
