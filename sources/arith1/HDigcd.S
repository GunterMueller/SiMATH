/*M
.SH NAME
HDigcd - Heidelberg arithmetic package: greatest common divisor

.SH SYNOPSIS
.nf
#include<_HDarith.h>

.\ HDigcd ()
Integer *a, *b, *d, *u, *v;

Idgcd(d, a, b)          d = gcd(a, b);              Euclidian algorithm 
Ibgcd(d, a, b)          d = gcd(a, b);              binary algorithm
Ielba(d, u, v, a, b)    d = gcd(a, b) = u*a + v*b;  Euclid-Lenstra-Berlekamp
Ibelba(d, u, v, a, b)   d = gcd(a, b) = u*a + v*b;  binary algorithm
Ireduce(a, b)           a = a / gcd(a, b)
                        b = b / gcd(a, b)


.SH DESCRIPTION
This file contains the above mentioned functions of the so-called Heidelberg arithmetic package that can be used in SIMATH programs. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/ 

/*H
	Version  1      19.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      19.08.1993      2. Version Marc Conrad 
   DATE HDigcd	      : 930531.931130
H*/                                                             
#include<_HDarith.h>
     
/* Integer Version 2.1, RD, 7.5.93	igcd.c	*/
/* removed "else" in Ibgcd, RD, 7.5.93		*/
/* used Digitbgcd in Ibgcd, RD, 7.5.93		*/
/* "bgcdkernel", RD, 11.5.93			*/

/* Integer Version 2.0, RD, 21.1.93	igcd.c	*/
/* Division with remainder in Ibgcd only for different lengths,
		RD, 12.2.93			*/


void Idgcd(d, a, b)
	Integer *d;
	const Integer *a, *b;
/* d = gcd(a, b);   Euklidischer Algorithmus, Division mit Rest */
{	Integer aa, bb, q, r;
	register pInteger pa, pb, pq, pr, copy;
	if (Ieq0(a)) {
		IasI(d, b);
		d->sign=PLUS;
		return;
	}
	if (Ieq0(b)) {
		IasI(d, a);
		d->sign=PLUS;
		return;
	}
	pa= &aa; pb= &bb; pq= &q; pr= &r;
	cIasI(pa, a);
	cIasI(pb, b);
	cI(pq);
	cI(pr);
	pa->sign=PLUS;
	pb->sign=PLUS;
	while (TRUE) {
		uIdiv(pq, pr, pa, pb);
		if (Ieq0(pr))
			break;
		copy=pa; pa=pb; pb=pr; pr=copy;
	}
	IasI(d, pb);
	dI(pa); dI(pb); dI(pq); dI(pr); 
}		/* Idgcd */

static DigitType Digitbgcd(a, b)
	DigitType a, b;
{	int commontwo=0;
	while (!(a&1) && !(b&1)) {
		commontwo++;
		a>>=1;
		b>>=1;
	}
	while (!(a&1))
		a>>=1;
	while (!(b&1))
		b>>=1;
	while (TRUE)
	    if (a>=b) {
		a-=b;
		if (!a)
		    break;	
		while (!(a&1))
		    a>>=1;
	    } else {
		b-=a;
		while (!(b&1))
		    b>>=1;
	    }
	return b<<commontwo;
}		/* Digitbgcd */


static int bgcdkernel ( d, a, al, b, bl )
	DigitType 	*d;
	DigitType 	*a;
	int		al;
	DigitType 	*b;
	int		bl;
/*	In:		a[0..al-1], b[0..bl-1]
	Compute:	d[0..dl-1] = gcd ( a[0..al-1], b[0..bl-1] );
	Out:		d[0..dl-1]; return dl;
	Where:		d[] has to be long enough to hold the result,
			a[0..al-1], b[0..bl-1] are destroyed,
			if dl>0 then d[dl-1] != 0,
			leading 0's are allowed,
			a == b == d are allowed.
	Note:		d[dl ...] are not changed.
			For preformance reasons the effective lengths
			of a and b should be similar.
	Uses:		DigitVecGt,
			DigitVecSri,
			DigitVecCsubto.
*/

{	int 		i, digitshift=0, bitshift=0, j, k;
	DigitType	a0, b0, s, t;

	/* get effective length of a and b */
	while (al > 0 && a[al-1] == 0)
		al--;
	while (bl > 0 && b[bl-1] == 0)
		bl--;

	/* return if a or b are 0 */
	if (al == 0) {
		for (i=0; i<bl; i++)
			d[i] = b[i];
		return bl;
	}
	if (bl == 0) {
		for (i=0; i<al; i++)
			d[i] = a[i];
		return al;
	}

	/* remove common powers of 2 */
	while ( (*a & 1) == 0 && (*b & 1) == 0 ) {
		if (*a == 0 && *b == 0) {
			a++;
			b++;
			al--;
			bl--;
			digitshift++;
		} else {
			a0 = *a;	
			b0 = *b;
			while ( (a0 & 1) == 0 && (b0 & 1) == 0 ) {
				a0 >>= 1;
				b0 >>= 1;
				bitshift++;
			}
			DigitVecSri(a, al, bitshift);
			DigitVecSri(b, bl, bitshift);
			if ( a[al-1] == 0 )
				al--;
			if ( b[bl-1] == 0 )
				bl--;
			break;
	}	}

	/* make a and b odd */
	if ( (*a & 1) == 0 ) {
		while ( *a == 0 ) {
			a++;
			al--;
		}
		a0 = *a;
		i=0;
		while ( (a0 & 1 ) == 0 ) {
			a0 >>= 1;
			i++;
		}
		DigitVecSri(a, al, i);
		if ( a[al-1] == 0 )
			al--;
	} else if ( (*b & 1) == 0 ) {
		while ( *b == 0 ) {
			b++;
			bl--;
		}
		b0 = *b;
		i=0;
		while ( (b0 & 1 ) == 0 ) {
			b0 >>= 1;
			i++;
		}
		DigitVecSri(b, bl, i);
		if ( b[bl-1] == 0 )
			bl--;
	}

	/* check for special case */
	if (al == 1 && bl == 1) {
		*b = Digitbgcd(*a, *b);
		bl = 1;
		goto bgcdfinalshift;
	}

	/* main loop */
	while ( 1 ) {
	    /* here a, b are odd and al, bl are their lengths */
	    if ( bl > al || al == bl && DigitVecGt(b, a, bl) ) {
		/* now b > a */
		DigitVecCsubto(b, a, al);
		while ( b[bl-1] == 0 ) {
		    bl--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
		while ( *b == 0 ) {
		    b++;
		    bl--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
		b0 = *b >> 1;
		i = 1;
		while ( (b0 & 1) == 0 ) {
		    b0 >>= 1;
		    i++;
		}
		DigitVecSri (b, bl, i);
		if ( b[bl-1] == 0 ) {
		    bl--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
	    } else {
		/* now b <= a */
		DigitVecCsubto(a, b, bl);
		while ( al > 0 && b[bl-1] == 0 ) {
		    bl--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
		if (al == 0)
		    goto bgcdfinalshift;
		while ( *a == 0 ) {
		    a++;
		    al--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
		a0 = *a >> 1;
		i = 1;
		while ( (a0 & 1) == 0 ) {
		    a0 >>= 1;
		    i++;
		}
		DigitVecSri (a, al, i);
		if ( a[al-1] == 0 ) {
		    al--;
		    if ( bl == 1 && al == 1 ) {
			*b = Digitbgcd (*a, *b);
			goto bgcdfinalshift;
		    }
		}
	    }
	}	/* main loop */

	/* now the result is b[0..bl-1] * powers of 2 */
bgcdfinalshift:
	for (i = 0; i < digitshift; i++)
		d[i] = 0;
	if ( bitshift == 0 ) {
		for (i = 0; i < bl; i++)
			d[digitshift + i] = b[i];
		return bl + digitshift;
	}
	/* now actual shift */
	j = bitshift;
	k = BitsPerDigit - j;
	s = 0;
	for ( i = 0; i < bl; i++ ) {
		t = b[i];
		s |= (t << j);
		d[digitshift + i] = s;
		s = t >> k;
	}
	if (s) {
		d[digitshift + bl] = s;
		return digitshift + bl + 1;
	} else
		return digitshift + bl;
}		/* bgcdkernel */

#ifndef USE_OLD_BGCD

void Ibgcd(d, a, b)
	Integer *d;
	const Integer *a, *b;
/*
 * d = gcd(a, b);   binaerer Algorithmus, 
 * verwendet bgcdkernel
 * Achtung:
 * Sind die Zahlen a, b sehr unterschiedlich gross, so ist
 * Ibgcd relativ langsam. Deshalb ist es sinnvoll, vorher
 * eine Division mit Rest durchzuf"uhren.
 *
 */
{	int l;
	Integer aa, bb;
	DigitType *v;

	if (!a->length) {
		IasI(d, b);
		d->sign=PLUS;
		return;
	}
	if (!b->length) {
		IasI(d, a);
		d->sign=PLUS;
		return;
	}
	cI(&aa);
	cI(&bb);
	/* Nun zuerst eine Division mit Rest */
	if (IgtI(a, b)) {
	    if (a->length >= (b->length << 1)) {
		IasIreI(&aa, a, b);
		if (!aa.length) {
			IasI(d, b);
			d->sign=PLUS;
			dI(&aa);
			dI(&bb);
			return;
		}
	    	IasI(&bb, b);
	    } else {
		IasI(&aa, b);
	    	IasI(&bb, a);
	    }
	} else {
	    if (b->length >= (a->length << 1)) {
		IasIreI(&aa, b, a);
		if (!aa.length) {
			IasI(d, a);
			d->sign=PLUS;
			dI(&aa);
			dI(&bb);
			return;
		}
	    	IasI(&bb, a);
	    } else {
		IasI(&bb, b);
	    	IasI(&aa, a);
	    }
	}
	/* Nun ist bb >= aa */

	l = bgcdkernel( bb.vec, aa.vec, aa.length, bb.vec, bb.length);

	v = d->vec;
	d->vec = bb.vec;
	bb.vec = v;

	d->length = l;
	l = d->maxlength;
	d->maxlength = bb.maxlength;
	bb.maxlength = l;

	d->sign = PLUS;

	dI(&aa);	
	dI(&bb);
}		/* Ibgcd */

#else

void Ibgcd(d, a, b)
	Integer *d;
	const Integer *a, *b;
/*
 * d = gcd(a, b);   binaerer Algorithmus, 
 * direkt auf irv.c aufgesetzt.
 * Achtung:
 * Sind die Zahlen a, b sehr unterschiedlich gross, so ist
 * Ibgcd relativ langsam. Deshalb ist es sinnvoll, vorher
 * eine Division mit Rest durchzuf"uhren.
 *
 */
{	register int l, al, bl;
	int toshift=0;
	Integer aa, bb;
	register DigitType *lp, *avec, *bvec;
	if (!a->length) {
		IasI(d, b);
		d->sign=PLUS;
		return;
	}
	if (!b->length) {
		IasI(d, a);
		d->sign=PLUS;
		return;
	}
	cI(&aa);
	cI(&bb);
	/* Nun zuerst eine Division mit Rest */
	if (IgtI(a, b)) {
	    if (a->length >= (b->length << 1)) {
		IasIreI(&aa, a, b);
		if (!aa.length) {
			IasI(d, b);
			d->sign=PLUS;
			dI(&aa);
			dI(&bb);
			return;
		}
	    } else {
		IasI(&aa, a);
	    }
	    IasI(&bb, b);
	} else {
	    if (b->length >= (a->length << 1)) {
		IasIreI(&bb, b, a);
		if (!bb.length) {
			IasI(d, a);
			d->sign=PLUS;
			dI(&aa);
			dI(&bb);
			return;
		}
	    } else {
		IasI(&bb, b);
	    }
	    IasI(&aa, a);
	}


	avec=aa.vec;
	bvec=bb.vec;
	al=aa.length;
	bl=bb.length;
	while (!(*avec & 1) && !(*bvec & 1)) {
		toshift++;
		DigitVecSr1(avec, al);
		if (!avec[al-1])
			al--;
		DigitVecSr1(bvec, bl);
		if (!bvec[bl-1])
			bl--;
	}
	while (!(*avec & 1)) {
		DigitVecSr1(avec, al);
		if (!avec[al-1])
			al--;
	}
	while (!(*bvec & 1)) {
		DigitVecSr1(bvec, bl);
		if (!bvec[bl-1])
			bl--;
	}
	while (TRUE) {
		if (bl>al || ((al==bl)&& DigitVecGt(bvec, avec, bl))) {
			lp=avec; avec=bvec; bvec=lp;
			l=al; al=bl; bl=l;
		}
		/* now  a >= b */
		lp= &(avec[al-1]);
		DigitVecCsubto(avec, bvec, bl);
		if (! *lp) {
		    while ((al>0)&&(! *lp)) {
			al--; lp--;
		    }
		    if (!al)
			break;
		    if ((al == 1) && (bl == 1)) {
			*bvec = Digitbgcd(*bvec, *avec);
			break;
		}   }
		if (al) 
		    while (!(*avec & 1)) {
			register DigitType low;
			l=1;
			low=*avec>>1;
			while ( !(low & 1) && l<BitsPerDigit-1 ) {
			    l++;
			    low>>=1;
			}
			DigitVecSri(avec, al, l);
			if (!avec[al-1]) {
			    al--;
			    if ((al == 1) && (bl == 1)) {
				*bvec = Digitbgcd(*bvec, *avec);
				goto end;
		    }	}   }
		else
		    break;	/* gcd in  bvec[0..bl-1] */
	}
end:	if (avec==aa.vec) {
		bb.length=bl;
		bb.sign=PLUS;
		IasIslint(d, &bb, toshift);
		dI(&aa); dI(&bb);
		return;
	} else {
		aa.length=bl;
		aa.sign=PLUS;
		IasIslint(d, &aa, toshift);
		dI(&aa); dI(&bb);
		return;
	}
}		/* Ibgcd */

#endif

/*************************************************/

void Idxgcd(d, u, v, a, b)
	Integer *d, *u, *v;
	const Integer *a, *b;
/* d = gcd(a, b) = ua + vb;   Euklid-Lenstra-Berlekamp */
{	Integer aa, bb, wua, wva, wub, wvb, q, r;
	register pInteger pa, pb, pq, pr, ua, va, ub, vb, copy;
	if (Ieq0(a)) {
		IasI(d, b);
		Ias0(u);
		Ias1(v);
		v->sign=b->sign;
		d->sign=PLUS;
		return;
	}
	if (Ieq0(b)) {
		IasI(d, a);
		Ias1(u);
		Ias0(v);
		u->sign=a->sign;
		d->sign=PLUS;
		return;
	}
	pa= &aa; pb= &bb; pq= &q; pr= &r;
	ua= &wua; va= &wva; ub= &wub; vb= &wvb;
	cIasI(pa, a);
	cIasI(pb, b);
	cI(pq);
	cI(pr);
	pa->sign=PLUS;
	pb->sign=PLUS;
	cIasint(ua, 1);
	ua->sign=a->sign;
	cIasint(va, 0);		/* pa == ua*a + va*b */
	cIasint(ub, 0);
	cIasint(vb, 1);
	vb->sign=b->sign;	/* pb == ub*a + vb*b */
	while (TRUE) {
		uIdiv(pq, pr, pa, pb);
		if (Ieq0(pr))
			break;
		copy=pa; pa=pb; pb=pr; pr=copy;
		IasImuI(pr, pq, ub);
		copy=ua; ua=ub; ub=copy;
		ImiasI(ub, pr);
		IasImuI(pr, pq, vb);
		copy=va; va=vb; vb=copy;
		ImiasI(vb, pr);
	}
	IasI(d, pb);
	IasI(u, ub);
	IasI(v, vb);
	dI(pa); dI(pb); dI(pq); dI(pr);
	dI(ua); dI(ub); dI(va); dI(vb); 
}		/* Idxgcd */

void Ibxgcd(d, u, v, a, b)
	Integer *d, *u, *v;
	const Integer *a, *b;
/* d = gcd(a, b) = u*a + v*b;   binaerer Algorithmus */
{	register int toshift=0;
	Integer aa, bb, A, B, wxa, wxb, wya, wyb;
	register pInteger pa, pb, pA, pB, xa, xb, ya, yb, swap;
	if (Ieq0(a)) {
		IasI(d, b);
		Ias0(u);
		Ias1(v);
		v->sign=b->sign;
		d->sign=PLUS;
		return;
	}
	if (Ieq0(b)) {
		IasI(d, a);
		Ias1(u);
		Ias0(v);
		u->sign=a->sign;
		d->sign=PLUS;
		return;
	}
	pa= &aa; pb= &bb; xa= &wxa; xb= &wxb; ya= &wya; yb= &wyb;
	pA= &A; pB= &B;
	cIasI(pa, a);
	cIasI(pb, b);
	while (Ieven(pa) && Ieven(pb)) {
		toshift++;
		Isr1(pa);
		Isr1(pb);
	}
	cIasI(pA, pa);
	cIasI(pB, pb);
	pa->sign=PLUS;
	pb->sign=PLUS;
	cIasint(xa, 1);
	xa->sign=a->sign;
	cIasint(ya, 0);		/* pa == xa*pA + ya*pB */
	cIasint(xb, 0);
	cIasint(yb, 1);
	yb->sign=b->sign;	/* pb == xb*pA + yb*pB */
	while (Ieven(pa)) {
		Isr1(pa);
		if (Ieven(xa) && Ieven(ya)) {
			Isr1(xa);
			Isr1(ya);
		} else {
			IplasI(xa, pB);
			Isr1(xa);
			ImiasI(ya, pA);
			Isr1(ya);
	}	}
	while (Ieven(pb)) {
		Isr1(pb);
		if (Ieven(xb) && Ieven(yb)) {
			Isr1(xb);
			Isr1(yb);
		} else {
			IplasI(xb, pB);
			Isr1(xb);
			ImiasI(yb, pA);
			Isr1(yb);
	}	}
	while (TRUE) {
		if (IgtI(pb, pa)) {
			swap=pa; pa=pb; pb=swap;
			swap=xa; xa=xb; xb=swap;
			swap=ya; ya=yb; yb=swap;
		} else {
			ImiasI(pa, pb);
			ImiasI(xa, xb);
			ImiasI(ya, yb);
			if (!Ieq0(pa))
			    while (Ieven(pa)) {
				Isr1(pa);
				if (Ieven(xa) && Ieven(ya)) {
					Isr1(xa);
					Isr1(ya);
				} else {
					IplasI(xa, pB);
					Isr1(xa);
					ImiasI(ya, pA);
					Isr1(ya);
			    }	}
			else
			    break;
	}	}
	IasIslint(d, pb, toshift);
	IasI(u, xb); IasI(v, yb);
	dI(pa);	dI(pb);	dI(pA);	dI(pB);
	dI(xa);	dI(xb);	dI(ya);	dI(yb);
}		/* Ibxgcd */

/***********************************************/

void Ireduce(a, b)
	pInteger a, b;
/* Kuerze gcd von a und b */
{	Integer d, r;
	cI(&d);
	cI(&r);
	Ibgcd(&d, a, b);
	Idiv(a, &r, a, &d);
	Idiv(b, &r, b, &d);
	dI(&d);
	dI(&r);
}

