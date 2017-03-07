/*M
.SH NAME
HDiutil - Heidelberg arithmetic package: utilities

.SH SYNOPSIS
.nf
#include<_HDarith.h>

.\ HDiutil ()
Integer *a, *b;
int i;

cI(a)           construction 
dI(a)           destruction
IasI(a, b)      a = b                              
Iasint(a, i)    a = i                                   
Ilog(a)         return (int) log2(|a|) or -1 in case a==0
longasI (a)     i = a (if possible)

.SH DESCRIPTION
This file contains the above mentioned functions of the so-called Heidelberg arithmetic package that can be used in SIMATH programs. Please mind the compatibility notice and the original copyright in the file HDiadd.S!

.SH SEE ALSO
Itoi, itoI
M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      17.08.1993      neue Version.  MC
	Version  3	01.12.1993	wegen HP-Version 3 Zeilen ausgeblendet.  MC
   DATE HDiutil       : 930531.931130.940315
H*/                                                             


/*sim 
!!!! Achtung! In diesem File sind einige Sachen geaendert, 
die alle die Tatsache benutzen, dass sizeof(int) = sizeof(long) 
= sizeof(DigitType) = sizeof(unsigned int) etc. ist. 
Sonst gibts auf apollo Schwierigkeiten, insbesondere warnings.                         
Der Compiler der apollo10000 akzeptiert einen Shift um 32 Bits nicht!
Deswegen wurden einige Zeilen der Form u <<= BitsPerDigit auskommentiert 
und u = 0 hinzugefuegt. Dies fuehrt dazu, dass auch im Fehlerfall
(z.B. Aufruf von intasI(a) mit einer Zahl a, die kein C-integer darstellt)
der Rueckgabewert gleich dem Originalrueckgabewert ist. 
Die Kommentare von SIMATH sind mit "sim" gekennzeichnet.
sim*/

           
#include<_HDarith.h>                      

/* Integer Version 2.0, RD, 21.1.93	iutil.c	*/


/* For the conversion from/to int and long */
/*sim define int2DigitType  ((sizeof(int)+sizeof(DigitType)-1)/sizeof(DigitType)) sim*/
/*sim define long2DigitType ((sizeof(long)+sizeof(DigitType)-1)/sizeof(DigitType)) sim*/
#define int2DigitType  1 
#define long2DigitType 1

/* Standard maxlength at creation of Integer */
#define INITLENGTH 4

void cI(a)
        register Integer * a;
{       a->sign=PLUS;
        a->length=0;
        a->maxlength=INITLENGTH;
        a->vec=newDigitVec(&a->maxlength);
}       /* cI */

void cIasint(a, i)
        register Integer * a; register int i;
{       register int j;
        if (i<0) {
                a->sign=MINUS;
                i= -i;
        } else 
                a->sign=PLUS;
        a->maxlength=int2DigitType;
        a->vec=newDigitVec(&a->maxlength);
	if ( int2DigitType == 1 ) {
		a->vec[0]=i;
		if ( i )
			a->length=1;
		else
			a->length=0;
		return;
	}   
/*sim
        j=0;
        while (i) {
                a->vec[j]=i;
                i>>=BitsPerDigit;
		j++;
        }
	a->length=j;
sim*/
}               /* cIasint */

void cIasuint(a, i)
        register Integer * a; register unsigned int i;
{       register int j;
        a->sign=PLUS;
        a->maxlength=int2DigitType;
        a->vec=newDigitVec(&a->maxlength);
	if ( int2DigitType == 1 ) {
		a->vec[0]=i;
		if ( i )
			a->length=1;
		else
			a->length=0;
		return;
	} 
/*sim
        j=0;
        while (i) {
                a->vec[j]=i;
                i>>=BitsPerDigit;
		j++;
        }
	a->length=j;
sim*/
}               /* cIasuint */

void cIaslong(a, i)
        register Integer * a; register long i;
{       register int j;
        if (i<0) {
                a->sign=MINUS;
                i= -i;
        } else 
                a->sign=PLUS;
        a->maxlength=long2DigitType;
        a->vec=newDigitVec(&a->maxlength);
	if ( long2DigitType == 1 ) {
		a->vec[0]=i;
		if ( i )
			a->length=1;
		else
			a->length=0;
		return;
	}
/*sim
        j=0;
        while (i) {
                a->vec[j]=i;
                i>>=BitsPerDigit;
		j++;
        }
	a->length=j;
sim*/
}               /* cIaslong */

void cIasulong(a, i)
        register Integer * a; register unsigned long i;
{       register int j;
        a->sign=PLUS;
        a->maxlength=long2DigitType;
        a->vec=newDigitVec(&a->maxlength);
	if ( long2DigitType == 1 ) {
		a->vec[0]=i;
		if ( i )
			a->length=1;
		else
			a->length=0;
		return;
	}           
/*sim
        j=0;
        while (i) {
                a->vec[j]=i;
                i>>=BitsPerDigit;
		j++;
        }
	a->length=j;
sim*/
}               /* cIasulong */

void cIasI(a, b)
/* create a from b */
        register Integer *a;
	register const Integer *b;
{       register int i;
        a->sign=b->sign;
        a->length=b->length;
        a->maxlength=b->length;
        a->vec=newDigitVec(&a->maxlength);
        for (i=0; i<b->length; i++)
                a->vec[i]=b->vec[i];
}           	/* cIasI */

void cImaxlength(a, l)
        register Integer * a;
	int l;
{       a->sign=PLUS;
        a->length=0;
        a->maxlength=l;
        a->vec=newDigitVec(&a->maxlength);
}       /* cI */

void dI(a)
        register Integer * a;
{       delDigitVec(a->vec, a->maxlength);
        a->vec=NULL;
}

Integer *  ncI()
{	register Integer *a;
	a=_newInteger();
	cI(a);
	return a;
}

Integer *  ncIasint(i)
	int i;
{	register Integer *a;
	a=_newInteger();
	cIasint(a, i);
	return a;
}

Integer *  ncIasI(b)
	Integer *b;
{	register Integer *a;
	a=_newInteger();
	cIasI(a, b);
	return a;
}

Integer *  ncImaxlength(l)
	int l;
{	register Integer *a;
	a=_newInteger();
	cImaxlength(a, l);
	return a;
}

void ddI(a)
	Integer *a;
{	dI(a);
	_delInteger(a);
}

/************************************/

void IasI(a, b)
        register Integer *a;
	register const Integer *b;
{       register int i;
        register int neededlength;
	a->sign=b->sign;
	neededlength=b->length;
	if (a->maxlength < neededlength) {
		delDigitVec(a->vec, a->maxlength);
		a->maxlength=neededlength;
		a->vec=newDigitVec(&a->maxlength);
	}
        a->length=neededlength;
        for (i=b->length-1; i>=0; i--)
                a->vec[i]=b->vec[i];
}               /* IasI */

void Iasint(a, i)
	register Integer * a; register int i;
{       register int j;
        if (i<0) {
                a->sign=MINUS;
                i= -i;
        } else 
                a->sign=PLUS;
	if ( int2DigitType == 1 ) {
		a->vec[0]=i;
		if ( i )
			a->length=1;
		else
			a->length=0;
		return;
	}    
/*sim
        j=0;
        while (i) {
                a->vec[j]=i;
                i>>=BitsPerDigit;
		j++;
        }
	a->length=j;
sim*/
}               /* Iasint */

void Ias0(a)
	register Integer * a;
{	a->length=0;
	a->sign=PLUS;
}

void Ias1(a)
	register Integer * a;
{	a->length=1;
	a->sign=PLUS;
	*(a->vec)=1;
}

/************************************/

int Ilog(a)
	const Integer * a;
/* return (groesste Ganze von log_2(|a|), bzw -1 falls a==0); */
{	register DigitType m;
	register int i, j;

	i=a->length;
	if (!i)
		return -1;
	j=0;
	m=a->vec[i-1];
	m>>=1;
	while(m) {
		m>>=1;
		j++;
	}
	return j+(i-1)*BitsPerDigit;
}

int intlog(i)
	register int i;
/* return (groesste Ganze von log_2(|i|), bzw -1 falls a==0); */
{	register int j;

	if (!i)
		return -1;
	j=0;
	i>>=1;
	while(i) {
		i>>=1;
		j++;
	}
	return j;
}	/* intlog */

#undef fprintf
void Ierror(s)
	const char * s;
{	fprintf(stderr, "I: %s\n", s);
#ifdef unix
	abort();
#else
	exit(-1);
#endif
}		/* Ierror */

/******************************************************************/

static unsigned long maxint=(1UL<<sizeof(int)*8-1)-1;
static unsigned long maxnegint=(1UL<<sizeof(int)*8-1);
/*
wegen HP-Version ausgeblendet

static unsigned long maxuint=1<<sizeof(int)*8;
static unsigned long maxlong=(1<<sizeof(long)*8-1)-1;
static unsigned long maxneglong=(1<<sizeof(long)*8-1);
*/

BOOLEAN Iisint (a)
	const Integer * a;
{	register unsigned int u;
	register int i;
	if (!a->length)
		return TRUE;
	if (a->length>int2DigitType)
		return FALSE;         
	       



/* Maybe sizeof(int)<sizeof(DigitType), then int2DigitType==1 */
/* We assume that sizeof(long)>=sizeof(DigitType) */
/*sim
	if (sizeof(int)<sizeof(DigitType))
		if (a->sign==PLUS)
			return a->vec[0] <= maxint;
		else
			return a->vec[0] <= maxnegint;
sim*/
/* Now we assume that sizeof(DigitType) divides sizeof(int) ! */
	u=0;     
	for (i=a->length-1; i>=0; i--) {
		u = 0; 
/*sim 		u<<=BitsPerDigit;       sim*/
		u+=a->vec[i];
	}   
	if (a->sign==PLUS)
		return u <= maxint;
	else
		return u <= maxnegint;
}	/* Iisint */

BOOLEAN Iisuint (a)
	const Integer * a;
{	if (a->sign==MINUS)
		return FALSE;
	if (!a->length)
		return TRUE;
	if (a->length>int2DigitType)
		return FALSE;
/* Maybe sizeof(int)<sizeof(DigitType), then int2DigitType==1 */
/* We assume, that sizeof(long)>=sizeof(DigitType) */
/*sim
	if (sizeof(int)<sizeof(DigitType))
		return a->vec[0] <= maxuint;
sim*/
/* Now we assume, that sizeof(DigitType) divides sizeof(int) ! */
	return TRUE;
}	/* Iisuint */

BOOLEAN Iislong (a)
	const Integer * a;
{
/* We assume that sizeof(long)>=sizeof(DigitType) and
   that sizeof(DigitType) divides sizeof(long) ! */
/*sim in SIMATH ist long int = int, also: sim*/
	return( Iisint( a ) ); 
/*sim 
	register unsigned long u;
	register int i;
	if (!a->length)
		return TRUE;
	if (a->length>long2DigitType)
		return FALSE;
	u=0;
	for (i=a->length-1; i>=0; i--) {
		u<<=BitsPerDigit;
		u+=a->vec[i];
	}
	if (a->sign==PLUS)
		return u <= maxlong;
	else
		return u <= maxneglong;       
sim*/
}	/* Iislong */

BOOLEAN Iisulong (a)
	const Integer * a;
{	if (a->sign==MINUS)
		return FALSE;
/* We assume, that sizeof(DigitType) divides sizeof(long) ! */
	if (a->length<=long2DigitType)
		return TRUE;
	else
		return FALSE;
}	/* Iisulong */


int intasI (a)
	const Integer * a;
/* We assume Iisint(a) to be true ! */
{	register unsigned int u;
	register int i;
	if (!a->length)
		return 0;
/* Maybe sizeof(int)<sizeof(DigitType), then int2DigitType==1 */
/* We assume that sizeof(long)>=sizeof(DigitType) */
/*sim
	if (sizeof(int)<sizeof(DigitType))
		if (a->sign==PLUS)
			return a->vec[0];
		else
			return - a->vec[0];
sim*/
/* Now we assume that sizeof(DigitType) divides sizeof(int) ! */
	u=0;
	for (i=a->length-1; i>=0; i--) {
		u = 0; 
/*sim		u<<=BitsPerDigit;  sim*/
		u+=a->vec[i];
	}
	if (a->sign==PLUS)
		return u;
	else
		return -u;
}	/* intasI */

unsigned int uintasI (a)
	const Integer * a;
/* We assume Iisuint(a) to be true ! */
{	register unsigned int u;
	register int i;
	if (!a->length)
		return 0;
/* Maybe sizeof(int)<sizeof(DigitType), then int2DigitType==1 */
/* We assume that sizeof(long)>=sizeof(DigitType) */
/*sim
	if (sizeof(int)<sizeof(DigitType))
		return a->vec[0];
sim*/
/* Now we assume that sizeof(DigitType) divides sizeof(int) ! */
	u=0;
	for (i=a->length-1; i>=0; i--) {
		u = 0; 
/*sim 		u<<=BitsPerDigit;    sim*/
		u+=a->vec[i];
	}
	return u;
}	/* uintasI */

long longasI (a)
	const Integer * a;
/* We assume Iislong(a) to be true ! */
{
/* We assume that sizeof(long)>=sizeof(DigitType) and
   that sizeof(DigitType) divides sizeof(long) ! */
	register unsigned long u;
	register int i;
	if (!a->length)
		return 0;
	u=0;
	for (i=a->length-1; i>=0; i--) {
		u = 0; 
/*sim		u<<=BitsPerDigit;   sim*/
		u+=a->vec[i];
	}
	if (a->sign==PLUS)
		return u;
	else
		return -u;
}	/* longasI */

unsigned long ulongasI (a)
	const Integer * a;
/* We assume Iisulong(a) to be true ! */
{
/* We assume, that sizeof(DigitType) divides sizeof(long) ! */
	register unsigned long u;
	register int i;
	if (!a->length)
		return 0;
	u=0;
	for (i=a->length-1; i>=0; i--) {
		u = 0; 
/*sim		u<<=BitsPerDigit;    sim*/
		u+=a->vec[i];
	}
	return u;
}	/* ulongasI */
