/* DOC_SKIP */

/*M
.SH NAME
HDiio - Heidelberg arithmetic package: I/O functions

.SH SYNOPSIS
(Internal)
.nf

Integer *a;
FILE *fp;
char s[];

fscanI(fp, a)
fprintI(fp, a)
Itoa(n, s)  
atoI(s, n)

.SH DESCRIPTION
This file contains some internal functions of the so-called Heidelberg arithmetic package. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      26.08.1993      neue Version von libI (Marc Conrad) 
   DATE HDiio         : 930531.931130
H*/                                                             
#include<_HDarith.h>


/* Integer Version 2.0, RD, 21.1.93	iio.c	*/


int fscanI(fp, a)
	FILE *fp;
	pInteger a;
{	register int c, count;
	int sign=PLUS;
	Integer help;

	cI(&help);
	count=0;
	do {
		c=getc(fp);
		count++;
	} while (isspace(c));
	if (c=='-') {
		sign=MINUS;
		c=getc(fp);
		count++;
	} else if (c=='+') {
		c=getc(fp);
		count++;
	}
	while (isspace(c)) {
		c=getc(fp);
		count++;
	}
	while (c=='0') {
		c=getc(fp);
		count++;
	}
	Iasint(a, 0);
	while (isdigit(c)) {
		ImuasD(a, 10);
		Iasint(&help, c-'0');
		IplasI(a, &help);
		c=getc(fp);
		count++;
	}
	ungetc(c, fp);
	count--;
	if (!Ieq0(a))
		a->sign=sign;
	dI(&help);
	return count;
}		/* fscanI */

int fprintI(fp, a)
	FILE *fp;
	const Integer *a;
{	char *s;
	int i, sl, count=0;
	Integer help;

	sl=Ilog(a);
	sl=sl/3+2;
	s=(char*)malloc(sl*sizeof(char));
	if (!s)
		Ierror("fprintI: no memory available\n");
#ifdef USE_DIRECT_OUTPUT_CONVERSION
	if (sl==-1) {
		putc('0', fp);
		count++;
		return count;
	}
	if (Ilt0(a)) {
		putc('-', fp);
		count++;
	}
	cIasI(&help, a);
	i=0;
	while (!Ieq0(&help)) {
		s[i]='0'+uIdiasD(&help, 10);
		i++;
	}
	dI(&help);
	i--;
	for (; i>=0; i--) {
		putc(s[i], fp);
		count++;
	}
#else
	count=Itoa(a, s);
	for ( i=0; i<count; i++ )
		putc(s[i], fp);
#endif
	Ifree(s);
	return count;
}		/* fprintI */

/******************************************/

char * wIdata1(a, l)
	const Integer * a;
	int * l;
{	*l=sizeof(int) + sizeof(int);
	return (char *) (& a->length);
}

char * wIdata2(a, l)
	const Integer * a;
	int * l;
{	*l=a->length * sizeof(DigitType);
	return (char *) a->vec;
}

char * rIdata1(a, l)
	const Integer * a;
	int * l;
{	*l=sizeof(int) + sizeof(int);
	return (char *) (& a->length);
}

char * rIdata2(a, l)
	Integer * a;
	int * l;
{	int nl=a->length;
	if (nl > a->maxlength) {
		delDigitVec(a->vec, a->maxlength);
		a->maxlength=nl;
		a->vec=newDigitVec(&a->maxlength);
	}
	*l=nl * sizeof(DigitType);
	return (char *) a->vec;
}

/************************************/

#define RADIXMINUSONE ((DigitType)(-1))

int Itoa(n, s)
	const Integer *n;
	char s[];
{	int count=0;
	Integer help;
	char *p, *q, c;
	DigitType DECCONV=1;
	int NCONV=0;

	/* Dividiere von n nicht 10 ab, sondern DECCONV, jeweils fuer NCONV
	Dezimalstellen. */
	while (DECCONV < ((((DigitType)1)<<(BitsPerDigit-1))/5)) {
		DECCONV*=10;
		NCONV++;
	}

	if (Ieq0(n)) {
		s[count]='0';
		count++;
		s[count]='\0';
		return count;
	}
	if (Ilt0(n)) {
		s[count]='-';
		count++;
	}
	cIasI(&help, n);
	while (!Ieq0(&help)) {
		unsigned long rem=uIdiasD(&help, DECCONV);
		if (Ieq0(&help)) {	/* skip leading 0 */
			while ( rem ) {
				s[count]='0'+ rem % 10;
				count++;
				rem /= 10;
			}
		} else {		/* print leading 0 */
			int i;
			for (i=0; i<NCONV; i++) {
				s[count]='0'+ rem % 10; 
				count++; 
				rem /= 10; 
			}   
		}
	}
	dI(&help);
	/* Vertausche Stringeintraege, damit hoeherwertige Stellen
		vorne stehen.
	*/
	if (Ilt0(n))
		p= &s[1];
	else
		p= &s[0];
	q= &s[count-1];
	while (p<q) {
		c= *p;
		*p++= *q;
		*q-- = c;
	}
	s[count]='\0';
	return count;
}		/* Itoa */

int atoI(s, n)
	char s[];
	Integer *n;
{	register int c, count;
	Integer help;
	int sign=PLUS;

	cI(&help);
	count=0;
	do {
		c=s[count];
		count++;
	} while (isspace(c));
	if (c=='-') {
		sign=MINUS;
		c=s[count];
		count++;
	} else if (c=='+') {
		c=s[count];
		count++;
	}
	while (isspace(c)) {
		c=s[count];
		count++;
	}
	while (c=='0') {
		c=s[count];
		count++;
	}
	Iasint(n, 0);
	while (isdigit(c)) {
		ImuasD(n, 10);
		Iasint(&help, c-'0');
		IplasI(n, &help);
		c=s[count];
		count++;
	}
	count--;
	if (!Ieq0(n))
		n->sign=sign;
	dI(&help);
	return count;
}		/* atoI */

