/*M
.SH NAME
HDimul - Heidelberg arithmetic package: integer multiplication

.SH SYNOPSIS
.nf
#include<_HDarith.h>

.\ HDimul ()
Integer *a, *b, *p, *count;

IasImuI (p, a, b)              p = a * b
ImuasI(a, b)                   a *= b
IasIsrint(a, b, count)         a = b >> count
Israsint(a, count)             a = a >> count
IasIslint(a, b, count)         a = b << count
Islasint(a, count)             a = a << count
Isr1( a )                      a = a >> 1
Ieven(a)                       return (a even)

.SH DESCRIPTION
This file contains some internal functions of the so-called Heidelberg arithmetic package. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/
/*H
	Version  1      29.04.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      29.08.1993      Marc Conrad (neue Version)
   DATE HDimul        : 930531.931130
H*/                                                             
#include<_HDarith.h>    

/* 	imul.c		RD, 29.01.90	*/
/*	bug in IasIsrint fixed, RD, 32.08.91	*/        

/* Integer Version 2.0, RD, 21.1.93	imul.c	*/


#ifdef DO_NOT_USE_KARATSUBA

void IasImuI (accu, a, b)
	pInteger accu;
	const Integer *a, *b;
/* accu=a*b; */
{   	register int i, al, bl, neededlength;
    	register DigitType *paccu, *pa, *pb;
	if (accu==a) {
		ImuasI(accu, b);
		return;
	}
	if (accu==b) {
		ImuasI(accu, a);
		return;
	}
	al=a->length;
	bl=b->length;
    	if (!al || !bl) {
		Iasint(accu, 0);
		return;
    	}
    	neededlength=al+bl;
	if (neededlength > accu->maxlength) {
		delDigitVec(accu->vec, accu->maxlength);
		accu->maxlength=neededlength;
		paccu=newDigitVec(&accu->maxlength);
		accu->vec=paccu;
	} else
		paccu=accu->vec;
    	pa=a->vec;
	pb=b->vec;
	if (al > bl) {
            for ( i = 0; i < al; i++)
                paccu[i] = 0;
            for ( i = 0; i < bl; i++) 
                paccu[i+al] = 
			DigitVecMultAdd(paccu+i, pa, pb[i], al);
        } else {           
            for ( i = 0; i < bl; i++)
                paccu[i] = 0;
            for ( i = 0; i < al; i++) 
                paccu[i+bl] = 
			DigitVecMultAdd(paccu+i, pb, pa[i], bl);
        }
        if (paccu[neededlength-1])
            accu->length = neededlength;
        else
            accu->length = neededlength-1;
        accu->sign = a->sign ^ b->sign;
}		/* IasImuI */

void ImuasI(a, b)
	Integer *a;
	const Integer *b;
/* a*=b; */
{   	int maxl;
    	register DigitType *paccu, *pa, *pb;
    	register int i, al, bl;
	al=a->length;
	bl=b->length;
    	if (!al || !bl) {
		Iasint(a, 0);
		return;
    	}
    	maxl=al+bl;
    	paccu=newDigitVec(&maxl);
    	pa=a->vec;
	pb=b->vec;
	if (al > bl) {
            for ( i = 0; i < al; i++)
                paccu[i] = 0;
            for ( i = 0; i < bl; i++) 
                paccu[i+al] = 
			DigitVecMultAdd(paccu+i, pa, pb[i], al);
        } else {           
            for ( i = 0; i < bl; i++)
                paccu[i] = 0;
            for ( i = 0; i < al; i++) 
                paccu[i+bl] = 
			DigitVecMultAdd(paccu+i, pb, pa[i], bl);
        }
	al+=bl;
        if (paccu[al-1])
            a->length = al;
        else
            a->length = al-1;
        a->sign ^= b->sign;
	delDigitVec(a->vec, a->maxlength);
	a->vec=paccu;
	a->maxlength=maxl;
}		/* ImuasI */

#else
/* use karatsuba */

/* Prerequisite: enough space in the vectors to increase the length
	appropriately, given with the built-in memory management.
*/

#ifndef KARATSUBA_LIMIT1
#define KARATSUBA_LIMIT1 15
#endif
#ifndef KARATSUBA_LIMIT2
#define KARATSUBA_LIMIT2 KARATSUBA_LIMIT1
#endif

static void do_karatsuba( /* paccu, pa, pb, al, bl */ );

void IasImuI (accu, a, b)
	Integer *accu;
	const Integer *a, *b;
/* accu=a*b; */
/* Karatsuba, verwendet do_karatsuba */
{   	register int i, al, bl, neededlength;
    	register DigitType *paccu, *pa, *pb;

	if (accu==a) {
		ImuasI(accu, b);
		return;
	}
	if (accu==b) {
		ImuasI(accu, a);
		return;
	}
	al=a->length;
	bl=b->length;
    	if (!al || !bl) {
		Iasint(accu, 0);
		return;
    	}
    	neededlength=al+bl;
	if (neededlength > accu->maxlength) {
		delDigitVec(accu->vec, accu->maxlength);
		accu->maxlength=neededlength;
		paccu=newDigitVec(&accu->maxlength);
		accu->vec=paccu;
	} else
		paccu=accu->vec;
	if (al > bl) {
	    if (bl <= KARATSUBA_LIMIT1) {
	    	/* Standardmultiplikation */
    		pa=a->vec;
		pb=b->vec;
		for ( i = 0; i < al; i++)
		    paccu[i] = 0;
		for ( i = 0; i < bl; i++) 
		    paccu[i+al] = 
			    DigitVecMultAdd(paccu+i, pa, pb[i], al);
	    } else
		do_karatsuba(paccu, a->vec, b->vec, al, bl);
        } else {
	    if (al <= KARATSUBA_LIMIT1) {       
	    	/* Standardmultiplikation */
    		pa=a->vec;
		pb=b->vec;
		for ( i = 0; i < bl; i++)
		    paccu[i] = 0;
		for ( i = 0; i < al; i++) 
		    paccu[i+bl] = 
			    DigitVecMultAdd(paccu+i, pb, pa[i], bl);
	    } else
		do_karatsuba(paccu, b->vec, a->vec, bl, al);
        }
        if (paccu[neededlength-1])
            accu->length = neededlength;
        else
            accu->length = neededlength-1;
        accu->sign = a->sign ^ b->sign;
}	/* IasImuI, karatsuba	*/

void ImuasI(a, b)
	pInteger a;
	const Integer *b;
/* a*=b; */
/* Karatsuba, verwendet do_karatsuba */
{   	int maxl;
    	register DigitType *paccu, *pa, *pb;
    	register int i, al, bl;
	al=a->length;
	bl=b->length;
    	if (!al || !bl) {
		Iasint(a, 0);
		return;
    	}
    	maxl=al+bl;
    	paccu=newDigitVec(&maxl);
	if (al > bl) {
	    if (bl <= KARATSUBA_LIMIT1) {
	    	/* Standardmultiplikation */
    		pa=a->vec;
		pb=b->vec;
		for ( i = 0; i < al; i++)
		    paccu[i] = 0;
		for ( i = 0; i < bl; i++) 
		    paccu[i+al] = 
			    DigitVecMultAdd(paccu+i, pa, pb[i], al);
	    } else
		do_karatsuba(paccu, a->vec, b->vec, al, bl);
        } else {
	    if (al <= KARATSUBA_LIMIT1) {       
	    	/* Standardmultiplikation */
    		pa=a->vec;
		pb=b->vec;
		for ( i = 0; i < bl; i++)
		    paccu[i] = 0;
		for ( i = 0; i < al; i++) 
		    paccu[i+bl] = 
			    DigitVecMultAdd(paccu+i, pb, pa[i], bl);
	    } else
		do_karatsuba(paccu, b->vec, a->vec, bl, al);
        }
	al+=bl;
        if (paccu[al-1])
            a->length = al;
        else
            a->length = al-1;
        a->sign ^= b->sign;
	delDigitVec(a->vec, a->maxlength);
	a->vec=paccu;
	a->maxlength=maxl;
}		/* ImuasI, karatsuba */


static void do_karatsuba(paccu, pa, pb, al, bl)
	DigitType *paccu, *pa, *pb;
	int	al, bl;
	/* now pb is the shorter number */
{    	DigitType *tprod, *tmp, *res;
	int i, tmpl, k, q, r, n, n0, resl;

	/* calculate k minimal with 
		bl <= 2^k*n0 and n0<=KARATSUBA_LIMIT2, n=2^k*n0 */
	n0=bl;
	k=0;
	while (n0>KARATSUBA_LIMIT2) {
	    n0=(n0+1)/2;
	    k++;
	}
	n=n0<<k;
	/* fill a, b with zeroes, maybe al <= n */
	for (i=bl; i<n; i++)
	    pb[i]=0;
	for (i=al; i<n; i++)
	    pa[i]=0;
	/* split a */
	q=al/n;
	r=al%n;
	if (q==0) {	/* case al < n */
	    q=1;
	    r=0;
	}
	/* Now get temporaries for result of DigitVecKaratsubaM and tmp */
	tmpl=2*n;
	tmp=newDigitVec(&tmpl);
	tprod=newDigitVec(&tmpl);
	/* Get temporary for result. */
	resl=al+n;
	res=newDigitVec(&resl);
	/* calculate via DigitVecKaratsubaM a_i * b, 0<= i <q */
	DigitVecKaratsubaM(res, pa, pb, tmp, n);
	for (i=1; i<q; i++) {
	    DigitVecKaratsubaM(tprod, &pa[i*n], pb, tmp, n);
	    DigitVecCadd(&res[i*n], &res[i*n], tprod, n , 2*n);
	}
	/* calculate a_q * b */
	for (i=q*n; i<al; i++)
	    res[i+bl] = DigitVecMultAdd(&res[i], pb, pa[i], bl);
	for (i=0; i<al+bl; i++)
	    paccu[i]=res[i];
	delDigitVec(tmp, tmpl);
	delDigitVec(tprod, tmpl);
	delDigitVec(res, resl);
}		/* do_karatsuba */

#endif
/* DO_NOT_USE_KARATSUBA */

#ifdef __GNUC__
void IasImuD(Integer *accu, const Integer *b, DigitType c)
#else
void IasImuD(accu, b, c)
	register Integer *accu;
	const Integer *b;
	DigitType c;
#endif
{	register int nl;
	register DigitType carry;

	if (accu==b) {
		ImuasD(accu, c);
		return;
	}
	if (!c) {
		Iasint(accu, 0);
		return;
	}
	nl=b->length+1;
	if (nl > accu->maxlength) {
		delDigitVec(accu->vec, accu->maxlength);
		accu->maxlength=nl;
		accu->vec=newDigitVec(&accu->maxlength);
	}
	carry=DigitVecMult(accu->vec, b->vec, c, b->length);
	accu->vec[nl-1]=carry;
	if (carry)
		accu->length = nl;
	else
		accu->length = nl-1;
	accu->sign=b->sign;
}		/* IasImuD */

#ifdef __GNUC__
void ImuasD(Integer *accu, DigitType b)
#else
void ImuasD(accu, b)
	register pInteger accu;
	DigitType b;
#endif
{	register DigitType carry, *paccu;
	register int nl;
	BOOLEAN neednew;
	int maxl;

	if (!b) {
		Iasint(accu, 0);
		return;
	}
	nl=accu->length+1;
	if (nl>accu->maxlength) {
		neednew=TRUE;
		maxl=nl;
		paccu=newDigitVec(&maxl);
	} else {
		paccu=accu->vec;
		neednew=FALSE;
	}
	carry=DigitVecMult(paccu, accu->vec, b, accu->length);
	paccu[nl-1]=carry;
	if (carry)
		accu->length=nl;
	if (neednew) {
		delDigitVec(accu->vec, accu->maxlength);
		accu->vec=paccu;
		accu->maxlength=maxl;
}	}	/* ImuasD */

/****************************************************/

void IasIsrint(a, b, count)
	register pInteger a;
	register const Integer *b;
	unsigned int count;
/* Shift nach rechts */
{	register DigitType accu, help, *pa, *pb;
	register int i;
	int pts, bts, bleft, nl;
	if (a==b) {
		Israsint(a, count);
		return;
	}
	pts=count/BitsPerDigit;
	if (pts>=b->length) {
		Ias0(a);
		return;
	}
	bts=count%BitsPerDigit;
	bleft=BitsPerDigit-bts;
	nl=b->length-pts;
	if (nl>a->maxlength) {
		delDigitVec(a->vec, a->maxlength);
		a->maxlength=nl;
		a->vec=newDigitVec(&a->maxlength);
	}
	pa=a->vec;
	pb=b->vec;
	if ( !bts ) {
		for (i=pts; i<b->length; i++)
			pa[i-pts]=pb[i];
		a->length=nl;
		a->sign=b->sign;
		return;
	}
	accu=pb[pts];
	accu>>=bts;
	for (i=pts+1; i<b->length; i++) {
		help=pb[i];
		accu|=(help<<bleft);
		pa[i-pts-1]=accu;
		accu=help>>bts;
	}
	pa[nl-1]=accu;
	if (accu)
		a->length=nl;
	else
		a->length=nl-1;
	if (a->length)
		a->sign=b->sign;
	else
		a->sign=PLUS;
}		/* IasIsrint */

void Israsint(a, count)
	register pInteger a;
	unsigned int count;
/* Shift nach rechts */
{	register DigitType accu, help, *p;
	register int i;
	int pts, bts, bleft, l;
	pts=count/BitsPerDigit;
	if (pts>=a->length) {
		Ias0(a);
		return;
	}
	bts=count%BitsPerDigit;
	bleft=BitsPerDigit-bts;
	p=a->vec;
	if ( !bts ) {
		for (i=pts; i<a->length; i++)
			p[i-pts]=p[i];
		a->length=a->length-pts;
		return;
	}
	accu=p[pts];
	accu>>=bts;
	for (i=pts+1; i<a->length; i++) {
		help=p[i];
		accu|=(help<<bleft);
		p[i-pts-1]=accu;
		accu=help>>bts;
	}
	l=a->length-pts;
	if (accu) {
		p[l-1]=accu;
		a->length=l;
	} else
		a->length=l-1;
	if (!a->length)
		a->sign=PLUS;
}		/* Israsint */

void IasIslint(a, b, count)
	register pInteger a;
	register const Integer *b;
	unsigned int count;
/* Shift nach links */
{	register DigitType accu, help, *pa, *pb;
	register int i;
	int pts, bts, bleft, nl;
	if (!b->length) {
		Iasint(a, 0);
		return;
	}
	if (a==b) {
		Islasint(a, count);
		return;
	}
	pts=count/BitsPerDigit;
	bts=count%BitsPerDigit;
	bleft=BitsPerDigit-bts;
	nl=b->length+pts+1;
	if (nl>a->maxlength) {
		delDigitVec(a->vec, a->maxlength);
		a->maxlength=nl;
		a->vec=newDigitVec(&a->maxlength);
	}
	a->sign=b->sign;
	pa=a->vec;
	pb=b->vec;
	for (i=0; i<pts; i++) 
		pa[i]=0;
	if ( !bts ) {
		for (i=0; i<b->length; i++)
			pa[i+pts]=pb[i];
		a->length=nl-1;
		return;
	}
	accu=0;
	for (i=0; i<b->length; i++) {
		help=pb[i];
		accu|=(help<<bts);
		pa[i+pts]=accu;
		accu=help>>bleft;
	}
	pa[nl-1]=accu;
	if (accu)
		a->length=nl;
	else
		a->length=nl-1;
}		/* IasIslint */

void Islasint(a, count)
	register pInteger a;
	unsigned int count;
/* Shift nach links */
{	register DigitType accu, help, *pa, *pb;
	register int i;
	int pts, bts, bleft, nl, maxl;
	if (!a->length)
		return;
	pts=count/BitsPerDigit;
	nl=a->length+pts+1;
	if (nl>a->maxlength) {
		pb=a->vec;
		maxl=nl;
		pa=newDigitVec(&maxl);
	} else {
		pa=pb=a->vec;
	}
	bts=count%BitsPerDigit;
	bleft=BitsPerDigit-bts;
	accu=0;
	if ( bts) {
		for (i=a->length-1; i>=0; i--) {
			help=pb[i];
			accu|=(help>>bleft);
			pa[i+pts+1]=accu;
			accu=help<<bts;
		}
		pa[pts]=accu;
	} else {
		pa[nl-1]=0;
		for (i=a->length-1; i>=0; i--)
			pa[i+pts]=pb[i];
	}
	for (i=pts-1; i>=0; i--)
		pa[i]=0;
	if (nl>a->maxlength) {
		delDigitVec(a->vec, a->maxlength);
		a->vec=pa;
		a->maxlength=maxl;
	}
	if (pa[nl-1])
		a->length=nl;
	else
		a->length=nl-1;
}		/* Islasint */

BOOLEAN Isr1(a)
	register pInteger a;
{	register int l;
	register BOOLEAN b;
	l=a->length;
	if (!l)
		return 0;
	b=DigitVecSr1(a->vec, l);
	l--;
	if (!a->vec[l])
		a->length=l;
	return b;
}		/* Isr1 */

BOOLEAN Ieven(a)
	register const Integer *a;
{	return (!((*(a->vec))&1));
}	/* Ieven */





/* Integer Version 2.0, RD, 20.1.93	idigitkara.c	*/
/*	use DigitVecMult, RD, 24.2.93			*/

/*	Karatsuba method for multiplication of long integers.	*/
/*	Parameters optimized for Sparc Version.		*/



#ifndef KARATSUBA_LIMIT2
#define KARATSUBA_LIMIT2 15
#endif


/* Formulae:
    a == B^n a1 + a0;
    b == B^n b1 + b0;
    a b == (B^(2n) + B^n) a1 b1 + B^n (a1 - a0) (b0 - b1) + (B^n + 1) a0 b0;

	-----------------
V	|     a1 b1 	|
	-----------------
		-----------------
IV		|     a1 b1	|
		-----------------
		-----------------
III		||a1-a0||b0-b1|	|
		-----------------
		-----------------
II		|     a0 b0	|
		-----------------
			-----------------
I			|     a0 b0	|
			-----------------
	---------------------------------
	|	    prod		|
	---------------------------------

		|	|	|	|
		n3	n2	n	0

*/


static  DigitType vecadd4carry (/*sum, a, b, c, d, carry, k*/);
static  int vecadd3subcarry (/*accu, a, b, c, d, carry, k*/);
static  DigitType vecaddDigitType (/*accu, a, d, k*/);
static  DigitType vecaddscarry (/*accu, a, d, k*/);

void DigitVecKaratsubaM (prod, a, b, tmp, n2)
	DigitType *prod, *a, *b, *tmp;
	int n2;

/* 	In:	a[n2], b[n2];	n2 == 2^k * n0, with n0 <= KARATSUBA_LIMIT2
	Out:	prod[2*n2] = a[n2] * b[n2];
	Local:	tmp[2*n2] for intermediate results
	for n2>KARATSUBA_LIMIT2:	karatsuba-recursion with k-1
	else:		standard multiplication
*/
{	int sign, i, n, n3;
	DigitType carry;
	int subcarry;

	if (n2<=KARATSUBA_LIMIT2) {
	    /* use DigitVecMult and DigitVecMultAdd */
	    /* clearly n2 >= 1 */
	    prod[n2]=DigitVecMult(prod, a, b[0], n2);
            for ( i = 1; i < n2; i++) 
                prod[i+n2] = DigitVecMultAdd(&prod[i], a, b[i], n2);
	    return;
	}

	n=n2/2;
	n3=n2+n;

	DigitVecKaratsubaM(&prod[n2], a, b, prod, n);
	/* prod:	|    a0*b0	|		|	*/

	if (DigitVecGt(a, &a[n], n)) {
		sign=1;
		DigitVecSub(tmp, a, &a[n], n);	/* a0 - a1 */
	} else {
		sign=0;
		DigitVecSub(tmp, &a[n], a, n);	/* a1 - a0 */
	}
	/* tmp:		|	|	|	||a0-a1||	*/
	if (DigitVecGt(&b[n], b, n)) {
		sign^=1;
		DigitVecSub(&tmp[n], &b[n], b, n);	/* b1 - b0 */
	} else {
		DigitVecSub(&tmp[n], b, &b[n], n);	/* b0 - b1 */
	}
	/* tmp:		|	|	||b1-b0|||a0-a1||	*/


	DigitVecKaratsubaM(&tmp[n2], tmp, &tmp[n], prod, n);
	/* tmp:		||b1-b0|*|a0-a1|||b1-b0|||a0-a1||	*/

	DigitVecKaratsubaM(tmp, &a[n], &b[n], prod, n);
	/* tmp:		||b1-b0|*|a0-a1||    a1*b1	|	*/

	/*
			---------------------------------
	prod		|     a0 b0	|		|
			---------------------------------

			---------------------------------
	tmp		||a1-a0||b0-b1|	|     a1 b1	|
			---------------------------------
	*/

	if (sign==0) {		/* Einfach addieren */
	    for (i=0; i<n; i++)
		prod[i]=prod[n2+i];			/* I */
	    /* I + II + III + IV */
	    carry=vecadd4carry(&prod[n], 
			&prod[n3], &prod[n2], &tmp[n2], tmp, 0, n);
	    /* carry + II + III + IV + V */
	    carry=vecadd4carry(&prod[n2], 
			&prod[n3], &tmp[n3], &tmp[n], tmp, carry, n);
	    /* carry + V */
	    vecaddDigitType(&prod[n3], &tmp[n], carry, n);
	} else {		/* III subtrahieren */
	    for (i=0; i<n; i++)
		prod[i]=prod[n2+i];			/* I */
	    /* I + II + IV - III */
	    subcarry=vecadd3subcarry(&prod[n], 
			&prod[n3], &prod[n2], tmp, &tmp[n2], 0, n);
	    /* carry + II + IV + V - III */
	    subcarry=vecadd3subcarry(&prod[n2], 
			&prod[n3], &tmp[n], tmp, &tmp[n3], subcarry, n);
	    /* subcarry + V */
	    vecaddscarry (&prod[n3], &tmp[n], subcarry, n);
	}
}


static  DigitType vecadd4carry (accu, a, b, c, d, carry, k)
	DigitType *accu, *a, *b, *c, *d, carry;
	int k;
	/* accu[k]=a[k]+b[k]+c[k]+d[k]+carry; return carry; */
{	DigitType aa, bb, cc, dd, sum;
	for ( ; k>0; k--) {
		aa= *a++;
		bb= *b++;
		cc= *c++;
		dd= *d++;
		sum = aa+carry;
		carry = (sum < aa);
		sum += bb;
		carry += (sum < bb);
		sum += cc;
		carry += (sum < cc);
		sum += dd;
		carry += (sum < dd);
		*accu++= sum;
	}
	return carry;
}

static  int vecadd3subcarry (accu, a, b, c, d, carry, k)
	DigitType *accu, *a, *b, *c, *d;
	int carry, k;
	/* carry >= -1 */
	/* accu[k]=a[k]+b[k]+c[k]-d[k]+carry; return carry; */
{	DigitType aa, bb, cc, dd, sum, tmp, subc;
	if (carry < 0) {
		subc = 1;
		carry = 0;
	} else {
		subc=0;
	}
	for ( ; k>0; k--) {
		aa= *a++;
		bb= *b++;
		cc= *c++;
		dd= *d++;
		sum = aa+carry;
		carry = (sum < aa);
		sum += bb;
		carry += (sum < bb);
		sum += cc;
		carry += (sum < cc);
		tmp = sum - subc;
		subc = (tmp > sum);
		sum = tmp - dd;
		subc += (sum > tmp);
		*accu++= sum;
	}
	return carry-subc;
}

static  DigitType vecaddDigitType (accu, a, d, k)
	DigitType *accu, *a, d;
	int k;
	/* accu[k]=a[k]+d; return carry; */
{	DigitType sum, carry=d;
	for ( ; k>0; k-- ) {
		sum = *a++ + carry;
		carry = (sum < carry);
		*accu++ = sum;
	}
	return carry;
}
/* ACHTUNG:	k==0  ==>  carry==d */

static  DigitType vecaddscarry (accu, a, scarry, k)
	DigitType *accu, *a;
	int scarry, k;
	/* 2^BitsPerDigit > scarry >=-1 */
	/* accu[k]=a[k]+scarry; return carry; */
{	DigitType sum, carry, tmp;
	if (scarry >= 0) {
	    carry = scarry;
	    for ( ; k>0; k-- ) {
		sum = *a++ + carry;
		carry = (sum < carry);
		*accu++ = sum;
	    }
	    return carry;
	} else {
	    carry = 1;
	    for ( ; k>0; k-- ) {
		tmp = *a++;
		sum = tmp - carry;
		carry = (sum > tmp);
		*accu++ = sum;
	    }
	    return -carry;
	}
}
/* ACHTUNG:	k==0  ==>  carry==scarry */


