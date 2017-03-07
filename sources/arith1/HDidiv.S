/*M
.SH NAME
HDidiv - Heidelberg arithmetic package: integer division
.SH SYNOPSIS
.nf
#include<_HDarith.h>

.\ HDidiv ()
Integer *a, *b, *q, *r;

Idiv(q, r, a, b)            q = a / b and r = a % b 
IasIdiI(q, a, b)            q = a / b
IdiasI(q, b)                q = q / b
IasIreI(r, a, b)            r = a % b
IreasI(r, b)                r = r % b

.SH DESCRIPTION
This file contains the above mentioned functions of the so-called Heidelberg arithmetic package that can be used in SIMATH programs. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
.PP
.B Caution:
As opposed to the division in SIMATH, here r is always >= 0. Therefore sgn(a) = sgn(r) always holds in iqrem(a, b, &q, &r).

M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2 	26.08.1993	neue Version (MC)
   DATE HDidiv	      : 930531.931130
H*/                                                             
#include<_HDarith.h>
                                                         
/* Integer Version 2.0, RD, 20.1.93	idiv.c	*/
/* Integer Version 2.1, normdiv changed, introduced
	quorem_p2p1, quorem_p3p2, RD, 30.4.93	*/
/* flexible quorem_p2p1d, RD, 4.5.93		*/
/* specialdiv, new j-loop in normdiv, RD, 5.5.93 */
/* DigitMult call changed, RD, 13.7.93		*/


/*  The following constant INVERSELIMIT gives the limit for
    precomputing the inverse of the highest digit of the divisor in a
    division and using two multiplications instead of one division for
    the first approximation of the partial quotient. The basic idea is
    due to Martin Schoenert.
*/

#define INVERSELIMIT 2

#define RADIXMINUSONE 	((DigitType)(-1))
#define BPDM1		(BitsPerDigit-1)
#define RADIXHALF 	((DigitType)(1UL<<BPDM1))

static DigitType specialdiv ( q, h, l, d, inv )
	DigitType *q, h, l, d, inv;
/*  Assume:	d >= beta/2,
		d >  h,
		inv == 0  or  beta^2/2 == d*inv + R, 0 <= R < d,
		h, l, d given, then
    Compute:	h*beta + l == d*QUO + REM  with  0 <= REM < d,
    Assign:	*q = QUO;
		return REM;
*/
{
    DigitType t1, t0, quo, c;

    /* special case for  d == beta/2 */
    if ( d == RADIXHALF ) {
        *q = (h << 1) | (l >> BPDM1);
	return (l << 1) >> 1;
    }

    /* special case where inv is not given */
    if ( inv == 0 )
	return DigitDiv(q, h, l, d);

    /* general case */
    /* multiply h with the reciprocal for a first approximation */
    t1 = DigitMult( &t0, h, inv );
    quo = (t1 << 1) | (t0 >> BPDM1);

    /* compute the remainder (h, l) - quo * d  */
    t1 = DigitMult( &t0, d, quo );
    c  = (l < t0); l -= t0;
    h -= c;
    h -= t1;

    /* our first approximation may be too small (but at most by 4) */
    while ( d <= l || h != 0 ) {
	quo++;
	c  = (l < d); l -= d;
	h -= c;
    }
    *q = quo;
    return l;
}


static void normdiv(u, v, q, ul, vl)
	register DigitType *u, *v;
	DigitType *q;
	int ul;
	register int vl;
/* u, v sind verschiedene Integer.vec der Laengen ul, vl >=2, die fuer 
   die Division u/v normiert sind. Das heisst auch, dass 
   v[vl-1] > u[ul-1] ist. u[ul-1]=0 ist zugelassen. v ist nicht 0. 
   Zurueckgegeben wird der Rest in u und der Quotient in q, die Laenge
   von q muss groesser oder gleich ul-vl+1 sein. */
{   register int j;
    DigitType inv;
    DigitType qdach, u2, u1, u0, v1, v0, c, rem, t1, t0, c1;

    if ( ul-vl >= INVERSELIMIT )
    	DigitDiv(&inv, RADIXHALF, 0, v[vl-1]);
    else
	inv = 0;

    for (j=ul-1; j>=vl; j--) {
	u2 = u[j];
	u1 = u[j-1];
	u0 = u[j-2];
	v1 = v[vl-1];
	v0 = v[vl-2];

	if ( v1 <= u2 ) {	/* then v1 == u2 */
	    qdach = RADIXMINUSONE;
	    /* calculate  (u2, u1, u0) - qdach*(v1, v0)
			== (u2, u1, u0) - (v1, v0, 0) + (v1, v0)
			== (u1, u0) - (v0, 0) + (v1, v0)
	    */
	    u0 += v0; 	c =  u0 < v0;
	    u1 += c;	c = u1 < c;
	    u1 += v1;	c+= u1 < v1;
	    u2 = c - (u1 < v0);	u1 -= v0;
	    while (u2) {
		qdach--;
		/* (u2, u1, u0) += (v1, v0); */
		u0 += v0;	c = u0 < v0;
		u1 += c;	c = u1 < c;
		u1 += v1;	c += u1 < v1;
		u2 += c;
	    }
	} else {
	    if (inv)
		rem = specialdiv(&qdach, u2, u1, v1, inv);
	    else
		rem = DigitDiv(&qdach, u2, u1, v1);
	    /* (u2, u1, u0) - qdach*(v1, v0);
		remember  rem == (u2, u1) - qdach*(v1);
	    */
	    t1 = DigitMult(&t0, qdach, v0);
	    c = u0 < t0; 	u0 -= t0;
	    u2 = -(rem < c);	u1 = rem -c;
	    u2 -= u1 < t1;	u1 -= t1;
	    while (u2) {
		qdach--;
		/* (u2, u1, u0) += (v1, v0); */
		u0 += v0;	c = u0 < v0;
		u1 += c;	c = u1 < c;
		u1 += v1;	c += u1 < v1;
		u2 += c;
	    }
	}

	/* Nun ist qdach bestimmt, und hoechstens 1 zu gross */
	c = DigitVecMultSub(u+j-vl, v, qdach, vl-2);
	c1 = u0 < c;	u[j-2] = u0 - c;
	c = u1 < c1;	u[j-1] = u1 - c1;
	c1 = u2 < c;	u[j] = u2 -c;

	if (c1) {		/* Addiere v zurueck */
	    qdach-=1;
	    c=DigitVecAdd(u+j-vl, u+j-vl, v, vl);
	    u[j] += c;
	}
	q[j-vl]=qdach;
    }		/* j-Schleife */
    return;
}		/* normdiv */

static DigitType norm_vecsli(u, a, toshift, count)
	DigitType *u, *a;
	int toshift, count;
/* 0<=toshift<=BitsPerDigit-1; */
{	DigitType accu, help;
	int i, bleft = BitsPerDigit - toshift;

	if ( ! toshift ) {
		for (i=0; i<count; i++)
			u[i]=a[i];
		return 0;
	}
	accu = 0;
	for ( i=0; i<count; i++ ) {
		help = a[i];
		accu |= (help<<toshift);
		u[i]=accu;
		accu=help>>bleft;
	}
	return accu;
}		/* norm_vecsli */

static void norm_vecsri(a, u, toshift, count)
	DigitType *a, *u;
	int toshift, count;
/* 0<=toshift<=BitsPerDigit-1; */
{	DigitType accu, help;
	int i, bleft=BitsPerDigit-toshift;

	if ( ! toshift ) {
		for (i=0; i<count; i++)
			a[i]=u[i];
		return;
	}
	accu=u[0];
	accu>>=toshift;
	for ( i=1; i<count; i++ ) {
		help=u[i];
		accu|=(help<<bleft);
		a[i-1]=accu;
		accu=help>>toshift;
	}
	a[count-1]=accu;
}		/* norm_vecsri  */


/*******************************************************/

#ifdef __GNUC__
DigitType uIdiasD(Integer *a, DigitType b)
#else
DigitType uIdiasD(a, b)
	register pInteger a;
	register DigitType b;
#endif
{	register DigitType rem;
	if (!a->length)
		return 0;
	rem=DigitVecDiv(a->vec, a->vec, b, a->length);
	if (!a->vec[a->length-1])
		a->length--;
	return rem;
}	/* uIdiasD */

#ifdef __GNUC__
DigitType IdiasD(Integer *a, DigitType b)
#else
DigitType IdiasD(a, b)
	register pInteger a;
	register DigitType b;
#endif
{	register DigitType rem;
	Integer one;
	if (!a->length)
		return 0;
	rem=DigitVecDiv(a->vec, a->vec, b, a->length);
	if (!a->vec[a->length-1])
		a->length--;
	if (a->sign==PLUS)
		return rem;
	if (!rem)
		return rem;
	cIasint(&one, 1);
	ImiasI(a, &one);
	dI(&one);
	return b-rem;
}	/* IdiasD */

#ifdef __GNUC__
DigitType uIasIdiD(Integer *q, const Integer *a, DigitType b)
#else
DigitType uIasIdiD(q, a, b)
	register pInteger q;
	register const Integer *a;
	register DigitType b;
#endif
{	register DigitType rem;
	register int nl;
	if (q==a)
		return uIdiasD(q, b);
	if (!a->length) {
		Iasint(q, 0);
		return 0;
	}
	nl=a->length;
	if (nl>q->maxlength) {
		delDigitVec(q->vec, q->maxlength);
		q->maxlength=nl;
		q->vec=newDigitVec(&q->maxlength);
	}
	rem=DigitVecDiv(q->vec, a->vec, b, a->length);
	if (q->vec[a->length-1])
		q->length=a->length;
	else
		q->length=a->length-1;
	q->sign=PLUS;
	return rem;
}	/* uIasIdiD */

#ifdef __GNUC__
DigitType IasIdiD(Integer *q, const Integer *a, DigitType b)
#else
DigitType IasIdiD(q, a, b)
	register pInteger q;
	register const Integer *a;
	register DigitType b;
#endif
{	register DigitType rem;
	register int nl;
	Integer one;
	if (q==a)
		return IdiasD(q, b);
	if (!a->length) {
		Iasint(q, 0);
		return 0;
	}
	nl=a->length;
	if (nl>q->maxlength) {
		delDigitVec(q->vec, q->maxlength);
		q->maxlength=nl;
		q->vec=newDigitVec(&q->maxlength);
	}
	rem=DigitVecDiv(q->vec, a->vec, b, a->length);
	if (q->vec[a->length-1])
		q->length=a->length;
	else
		q->length=a->length-1;
	if (a->sign==PLUS) {
		q->sign=PLUS;
		return rem;
	}
	q->sign=MINUS;
	if (!rem)
		return rem;
	cIasint(&one, 1);
	ImiasI(q, &one);
	dI(&one);
	return b-rem;
}	/* IasIdiD */

/*************************************************/

void uIdiv(q, r, a, b)
	pInteger q, r;
	const Integer *a, *b;
/* Division mit Rest, a=bq+r. */
{   register DigitType *u, *v;
    register int ul, vl;
    int unl, vnl, toshift;
    register int m;
    register int i;
    DigitType help, carry;

    vl=b->length;
    m=a->length-vl;
    if (m<0) {
	IasI(r, a);
	r->sign=PLUS;
	Iasint(q, 0);
	return;
    }
    if (vl<=1) {
	register DigitType rem;
	if (!vl)
		Ierror("uIdiv: division by zero");
	rem=uIasIdiD(q, a, b->vec[0]);
	*(r->vec)=rem;
	if (rem)
	    r->length=1;
	else
	    r->length=0;
	r->sign=PLUS;
	return;
    }
	/* Hilfsvariablen bereitstellen */
    ul=a->length+1;
    unl=ul;
    u=newDigitVec(&unl);
    vnl=vl;
    v=newDigitVec(&vnl);
	/* a, b normalisieren */
    help=b->vec[vl-1];
    toshift=0;
    while ( !( help >> (BitsPerDigit-1)) ) {
	help<<=1;
	toshift++;
    }
    u[ul-1]=norm_vecsli(u, a->vec, toshift, ul-1);
    norm_vecsli(v, b->vec, toshift, vl);
	/* eigentliche Division */
    if (m+1>q->maxlength) {
	delDigitVec(q->vec, q->maxlength);
	q->maxlength=m+1;
	q->vec=newDigitVec(&q->maxlength);
    }
    normdiv(u, v, q->vec, ul, vl);
	/* Rest zurueckgewinnen */
    if (vl>r->maxlength) {
	delDigitVec(r->vec, r->maxlength);
	r->maxlength=vl;
	r->vec=newDigitVec(&r->maxlength);
    }
    norm_vecsri(r->vec, u, toshift, vl);
    delDigitVec(u, unl);
    i=vl-1; 
    u=r->vec;
    while(!u[i] && i>=0)
	i--;
    r->length=i+1;
    r->sign=PLUS;
	/* Quotient auf Standardform */
    if (q->vec[m])
	q->length=m+1;
    else
	q->length=m;
    q->sign=PLUS;
    delDigitVec(v, vnl);
}		/* uIdiv */

/*************************************************/

void Idiv(q, r, a, b)
	pInteger q, r;
	const Integer *a, *b;
/* Division mit Rest, a=bq+r. */
{   register DigitType *u, *v;
    register int ul, vl;
    int unl, vnl, toshift;
    register int m;
    register int i;
    DigitType help, carry;
    BOOLEAN usebb=FALSE;
    Integer bb, one;

    vl=b->length;
    m=a->length-vl;
    if (m<0) { /* dann sind a, b verschiedene Variablen */
	if (a->sign==PLUS) {
	    IasI(r, a);
	    Iasint(q, 0);
	    return;
	}
	if (b->sign==PLUS) {
	    IasIplI(r, a, b);
	    Iasint(q, -1);
	    return;
	} else {
	    IasImiI(r, a, b);
	    Iasint(q, 1);
	    return;
	}	
    }		/* m<0 */
	/* Sonderfall: Divisor einstellig */
    if (vl<=1) {
	register DigitType rem;
	if (!vl)
		Ierror("Idiv: Division by zero");
	rem=IasIdiD(q, a, b->vec[0]);
	*(r->vec)=rem;
	if (rem)
	    r->length=1;
	else
	    r->length=0;
	r->sign=PLUS;
	q->sign^=b->sign;
	return;
    }
	/* Hilfsvariablen bereitstellen */
    ul=a->length+1;
    unl=ul;
    u=newDigitVec(&unl);
    vnl=vl;
    v=newDigitVec(&vnl);
	/* a zu u, b zu v normalisieren */
    help=b->vec[vl-1];
    toshift=0;
    while ( !( help >> (BitsPerDigit-1)) ) {
	help<<=1;
	toshift++;
    }
    u[ul-1]=norm_vecsli(u, a->vec, toshift, ul-1);
    norm_vecsli(v, b->vec, toshift, vl);
	/* eigentliche Division */
    if (a->sign==MINUS) {
	if ((b==r)||(b==q)) {
	    usebb=TRUE;
	    cIasI(&bb, b);
	}
    }
    if (m+1>q->maxlength) {
	delDigitVec(q->vec, q->maxlength);
	q->maxlength=m+1;
	q->vec=newDigitVec(&q->maxlength);
    }
    normdiv(u, v, q->vec, ul, vl);
	/* Rest zurueckgewinnen */
    if (vl>r->maxlength) {
	delDigitVec(r->vec, r->maxlength);
	r->maxlength=vl;
	r->vec=newDigitVec(&r->maxlength);
    }
    norm_vecsri(r->vec, u, toshift, vl);
    delDigitVec(u, unl);
    i=vl-1; 
    u=r->vec;
    while(!u[i] && i>=0)
	i--;
    r->length=i+1;
	/* Quotient auf Standardform */
    if (q->vec[m])
	q->length=m+1;
    else
	q->length=m;
    delDigitVec(v, vnl);
	/* Rest positiv, auf a==bq+r normalisieren. */
    if (a->sign==PLUS) {
	if (!(q->length))
	    q->sign=PLUS;
	else
	    q->sign=b->sign;
    	r->sign=PLUS;
        if (usebb)
         {dI(&bb);}
	return;
    }
    if (!r->length) {
	if (!q->length)
	    q->sign=PLUS;
	else
	    q->sign=a->sign^b->sign;
	r->sign=PLUS;
        if (usebb)
         {dI(&bb);}
	return;
    }
    cIasint(&one, 1);
    if (!usebb) {
    	if (b->sign==PLUS) {
	    r->sign=MINUS;
	    IplasI(r, b);
	    q->sign=PLUS;
	    IplasI(q, &one);
	    q->sign=MINUS;
            dI(&one);
	    return;
	} else {
	    r->sign=MINUS;
	    ImiasI(r, b);
	    q->sign=PLUS;
	    IplasI(q, &one);
            dI(&one);
	    return;
	}
    } else {
    	if (bb.sign==PLUS) {
	    r->sign=MINUS;
	    IplasI(r, &bb);
	    q->sign=PLUS;
	    IplasI(q, &one);
	    q->sign=MINUS;
            dI(&bb); 
            dI(&one);
	    return;
	} else {
	    r->sign=MINUS;
	    ImiasI(r, &bb);
	    q->sign=PLUS;
	    IplasI(q, &one);
            dI(&bb); 
            dI(&one);
	    return;
}   }   }	/* Idiv */

/*****************************************/

void IasIdiI(q, a, b)
	pInteger q;
	const Integer *a, *b;
/* Division, Quotient */
{	Integer r;
	cI(&r);
	Idiv(q, &r, a, b);
	dI(&r);
}

void IdiasI(q, b)
	pInteger q;
	const Integer *b;
/* Division, Quotient */
{	Integer r;
	cI(&r);
	Idiv(q, &r, q, b);
	dI(&r);
}

void IasIreI(r, a, b)
	pInteger r;
	const Integer *a, *b;
/* Division, Rest */
{	Integer q;
	cI(&q);
	Idiv(&q, r, a, b);
	dI(&q);
}

void IreasI(r, b)
	pInteger r;
	const Integer *b;
/* Division, Rest */
{	Integer q;
	cI(&q);
	Idiv(&q, r, r, b);
	dI(&q);
}

