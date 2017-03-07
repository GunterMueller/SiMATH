/*M
.SH NAME
HDiadd - Heidelberg arithmetic package: integer addition
.SH SYNOPSIS
.nf
#include<_HDarith.h>

.\ HDiadd ()
Integer *a, *b;

IplasI(a, b)            a += b
IasIplI(sum, a, b)      sum = a + b
ImiasI(a, b)            a -= b
IasImiI(diff, a, b)     diff = a - b
Iinc(a)                 a++
Idec(a)                 a--
Ineg(a)                 a = -a
IeqI(a, b)              return (a == b)
IgtI(a, b)              return (a > b)
IneI(a, b)              return (a != b)
IgeI(a, b)              return (a >= b)
IltI(a, b)              return (a < b)
IleI(a, b)              return (a <= b)
Ige0(a)                 return (a >= 0)
Igt0(a)                 return (a > 0)
Ile0(a)                 return (a <= 0)
Ilt0(a)                 return (a < 0)
Ieq0(a)                 return (a == 0)
Ieq1(a)                 return (a == 1)

.SH DESCRIPTION
This file contains the above mentioned functions of the so-called Heidelberg arithmetic package that can be used in SIMATH programs. Please mind the compatibility notice and the original copyright below!

.SH COMPATIBILITY
.PP
.TP 4
1)  The data types being used do not conform the SIMATH conventions. Special functions have to be used for memory-management (c.f. HDiutil).
.PP
.TP 4
2)  The SIMATH datatype 'vec' MUST NOT be used. As a substitute vectors may be defined as an object (obj).
.PP
.TP 4
3)  The header _HDarith has to be included in every source. It incorporates _simath.h as well as the original Heidelberg header iint.h and some additional things. 

Now follows the copyright of the author.

.SH COPYRIGHT
LibI - Library for Large Integers
.PP
Arithmetic for integers of almost unlimited size for C and C++.
Copyright 1993 by Ralf Dentzer. The functions of LibI are usually
collected in a library called libI.a.
.PP
LibI can be copied and distributed freely for any non-commercial
purpose. If you copy LibI for somebody else, you may ask this person for refund
of your expenses. This should cover cost of media, copying and shipping.
You are not allowed to ask for more than this. In any case you must give
a copy of this copyright notice along with the program.
.PP
If you obtain LibI please send us a short notice to that effect, e.g.,
an e-mail message to the address 'dentzer@kalliope.iwr.uni-heidelberg.de',
containing your full name and address. This allows us to keep track of
the number of LibI users.
.PP
If you publish a mathematical result that was partly obtained using
LibI, please cite LibI, just as you would cite another paper that you
used. Also we would appreciate it if you could inform us about such a
paper.
.PP
You are permitted to modify and redistribute LibI, but you are not
allowed to restrict further redistribution. That is to say proprietary
modifications will not be allowed. We want all versions of LibI to
remain free.
.PP
If you modify any part of LibI and redistribute it, you must supply a
'README' document. This should specify what modifications you made in
which files. We do not want to take credit or be blamed for your
modifications.
.PP
Of course we are interested in all of your modifications. In particular
we would like to see bug-fixes, improvements and new functions. So again
we would appreciate it if you would inform us about all modifications you
make.
.PP
If you use LibI as part of other software, you should make clear in the
documentation of this software, that and how LibI was used. If you
redistribute LibI as part of your software, the restrictions stated
in this document apply. 
.PP
LibI is distributed by us without any warranty, to the extent permitted
by applicable state law. We distribute LibI *as is* without warranty
of any kind, either expressed or implied, including, but not limited to,
the implied warranties of merchantability and fitness for a particular
purpose.
.PP
The entire risk as to the quality and performance of the program is with
you. Should LibI prove defective, you assume the cost of all necessary
servicing, repair or correction.
.PP
In no case unless required by applicable law will we, and/or any other
party who may modify and redistribute LibI as permitted above, be
liable to you for damages, including lost profits, lost monies or other
special, incidental or consequential damages arising out of the use or
inability to use LibI.

.SH AUTHOR
.nf
Ralf Dentzer
IWR, Universitaet Heidelberg
Im Neuenheimer Feld 368
D-6900 Heidelberg, Germany
M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2	26.08.1993	Marc Conrad (neue Version)
   DATE HDiadd        : 930531.931130
H*/                                                             

#include<_HDarith.h>      

/* Integer Version 2.0, RD, 20.1.93	iadd.c	*/


void IplasI(a, b)
        register pInteger a;
	register const Integer *b;
/* a+=b; */
{   if (a->sign==b->sign) {
        register int neededlength=a->length;
        if (neededlength<b->length) {
                neededlength=b->length;
        }
        neededlength++;
        if (neededlength>a->maxlength) {
            register DigitType *newv;
	    register int oldlength=a->maxlength;
            a->maxlength=neededlength;
            newv=newDigitVec(&a->maxlength);
            a->length=
		DigitVecCadd(newv, a->vec, b->vec, a->length, b->length);
            delDigitVec(a->vec, oldlength);
            a->vec=newv;
            return;
        } else {
	    a->length=
		DigitVecCadd(a->vec, a->vec, b->vec, a->length, b->length);
            return;
        }
    } else {
        /* Vorzeichen verschieden, subtrahiere betragsmaessig 
                kleineres von groesserem */
        if ((b->length>a->length)||((b->length==a->length)
                        &&DigitVecGt(b->vec, a->vec, a->length))) {
            /* |b|>|a| */
            register int neededlength=b->length;
            if (neededlength<=a->maxlength) {
		a->length=DigitVecCsub(a->vec, b->vec, a->vec, 
				b->length, a->length);
                a->sign=b->sign;
                return;
            } else {
                register DigitType *newv;
                register int oldlength=a->maxlength;
                a->maxlength=neededlength;
                newv=newDigitVec(&a->maxlength);
                a->length=DigitVecCsub(newv, b->vec, a->vec, 
				b->length, a->length);
                delDigitVec(a->vec, oldlength);
                a->vec=newv;
                a->sign=b->sign;
                return;
            }
        } else {
                /* |b| <= |a| */
		register int l=a->length;
		register DigitType * lp= &(a->vec[l-1]);
                DigitVecCsubto(a->vec, b->vec, b->length);
		while ((l>0)&&(! *lp)) {
			l--; lp--;
		}
		a->length=l;
                if (!l)
                        a->sign = PLUS;
                return;
}   }   }       /* IplasI */

void IasIplI(sum, a, b)
        register pInteger sum;
	register const Integer *a, *b;
/* sum=a+b; */
{   register int neededlength;
    if (sum==a) {
        IplasI(sum, b);
	return;
    }
    if (sum==b) {
        IplasI(sum, a);
	return;
    }
    if (a->sign==b->sign) {     /* Addition */
        neededlength=a->length;
        if (neededlength<b->length)
            neededlength=b->length;
        neededlength++;
        if (neededlength>sum->maxlength) {
            delDigitVec(sum->vec, sum->maxlength);
            sum->maxlength=neededlength;
            sum->vec=newDigitVec(&sum->maxlength);
        }
        sum->length=
		DigitVecCadd(sum->vec, a->vec, b->vec, a->length, b->length);
        sum->sign=a->sign;
        return;
    } else {            /* Subtraktion */
        neededlength=a->length;
        if (neededlength<b->length)
            neededlength=b->length;
        if (neededlength>sum->maxlength) {      
            delDigitVec(sum->vec, sum->maxlength);
            sum->maxlength=neededlength;
            sum->vec=newDigitVec(&sum->maxlength);
        }
        if ((b->length>a->length) || (b->length==a->length)
                && DigitVecGt(b->vec, a->vec, a->length)) {
            /* |b| > |a| */
            sum->length=DigitVecCsub(sum->vec, b->vec, a->vec, 
				b->length, a->length);
            sum->sign=b->sign;
	    return;
        } else {
            /*  |b| <= |a| */
            sum->length=DigitVecCsub(sum->vec, a->vec, b->vec, 
				a->length, b->length);
	    if (!sum->length)
		sum->sign=PLUS;
	    else
            	sum->sign=a->sign;
	    return;
        }
}   }           /* IasIplI */

void ImiasI(a, b)
        register pInteger a;
	register const Integer *b;
/* a-=b; */
{   if (a->sign!=b->sign) {
        register int neededlength=a->length;
        if (neededlength<b->length) {
                neededlength=b->length;
        }
        neededlength++;
        if (neededlength>a->maxlength) {
            register DigitType *newv;
            register int oldlength=a->maxlength;
            a->maxlength=neededlength;
            newv=newDigitVec(&a->maxlength);
            a->length=DigitVecCadd(newv, a->vec, b->vec, a->length, b->length);
            delDigitVec(a->vec, oldlength);
            a->vec=newv;
            return;
        } else {
            a->length=DigitVecCadd(a->vec, a->vec, b->vec, a->length, b->length);
            return;
        }
    } else {
        /* Vorzeichen gleich, subtrahiere betragsmaessig 
                kleineres von groesserem */
        if ((b->length>a->length)||((b->length==a->length)
                        &&DigitVecGt(b->vec, a->vec, a->length))) {
            /* |b|>|a| */
            register int neededlength=b->length;
            if (neededlength<=a->maxlength) {
		a->length=DigitVecCsub(a->vec, b->vec, a->vec, 
				b->length, a->length);
                a->sign^=MINUS;
                return;
            } else {
                register DigitType *newv;
                register int oldlength=a->maxlength;
                a->maxlength=neededlength;
                newv=newDigitVec(&a->maxlength);
                a->length=DigitVecCsub(newv, b->vec, a->vec, 
				b->length, a->length);
                delDigitVec(a->vec, oldlength);
                a->vec=newv;
                a->sign^=MINUS;
                return;
            }
        } else {
                /* |b| <= |a| */
		register int l=a->length;
		register DigitType * lp= &(a->vec[l-1]);
                DigitVecCsubto(a->vec, b->vec, b->length);
		while ((l>0)&&(! *lp)) {
			l--; lp--;
		}
		a->length=l;
                if (!l)
                        a->sign = PLUS;
                return;
}   }   }       /* ImiasI */

void IasImiI(diff, a, b)
        register pInteger diff;
	register const Integer *a, *b;
/* diff=a-b; */
{   register int neededlength;
    if (diff==a) {
        ImiasI(diff, b);
	return;
    }
    if (diff==b) {
        ImiasI(diff, a);
	if (diff->length)
		diff->sign ^= MINUS;
	return;
    }
    if (a->sign!=b->sign) {     /* Addition */
        neededlength=a->length;
        if (neededlength<b->length)
            neededlength=b->length;
        neededlength++;
        if (neededlength>diff->maxlength) {
            delDigitVec(diff->vec, diff->maxlength);
            diff->maxlength=neededlength;
            diff->vec=newDigitVec(&diff->maxlength);
        }
        diff->length=
		DigitVecCadd(diff->vec, a->vec, b->vec, a->length, b->length);
        diff->sign=a->sign;
        return;
    } else {            /* Subtraktion */
        neededlength=a->length;
        if (neededlength<b->length)
            neededlength=b->length;
        if (neededlength>diff->maxlength) {      
            delDigitVec(diff->vec, diff->maxlength);
            diff->maxlength=neededlength;
            diff->vec=newDigitVec(&diff->maxlength);
        }
        if ((b->length>a->length) || (b->length==a->length)
                && DigitVecGt(b->vec, a->vec, a->length)) {
            /*  |b| > |a| */
            diff->length=DigitVecCsub(diff->vec, b->vec, a->vec, 
				b->length, a->length);
            diff->sign=a->sign^MINUS;
	    return;
        } else {
            /*  |b| <= |a| */
            diff->length=DigitVecCsub(diff->vec, a->vec, b->vec, 
				a->length, b->length);
	    if (!diff->length)
		diff->sign=PLUS;
	    else
            	diff->sign=a->sign;
	    return;
        }
}   }           /* IasImiI */

void Iinc(a)
        register Integer *a;
/* a++; */
{   if (a->sign==PLUS) {
        register int neededlength=a->length+1;
	DigitType b=1;
        if (neededlength>a->maxlength) {
            register DigitType *newv;
	    register int oldlength=a->maxlength;
            a->maxlength=neededlength;
            newv=newDigitVec(&a->maxlength);
            a->length=DigitVecCadd(newv, a->vec, &b, a->length, 1);
            delDigitVec(a->vec, oldlength);
            a->vec=newv;
            return;
        } else {
	    a->length=DigitVecCadd(a->vec, a->vec, &b, a->length, 1);
            return;
        }
    } else {
        /* Subtrahiere 1 von |a| */
	register int l=a->length;
	register DigitType * lp= &(a->vec[l-1]);
	DigitType b=1;
	DigitVecCsubto(a->vec, &b, 1);
	while ((l>0)&&(! *lp)) {
		l--; lp--;
	}
	a->length=l;
	if (!l)
		a->sign = PLUS;
	return;
}   }       	/* Iinc */

void Idec(a)
        register Integer *a;
/* a--; */
{   if (a->sign==MINUS) {
        register int neededlength=a->length+1;
	DigitType b=1;
        if (neededlength>a->maxlength) {
            register DigitType *newv;
	    register int oldlength=a->maxlength;
            a->maxlength=neededlength;
            newv=newDigitVec(&a->maxlength);
            a->length=DigitVecCadd(newv, a->vec, &b, a->length, 1);
            delDigitVec(a->vec, oldlength);
            a->vec=newv;
            return;
        } else {
	    a->length=DigitVecCadd(a->vec, a->vec, &b, a->length, 1);
            return;
    }   }
    if (!a->length) {
	a->sign=MINUS;
	a->length=1;
	a->vec[0]=1;
	return;
    } else {
        /* Subtrahiere 1 von |a| */
	register int l=a->length;
	register DigitType * lp = &(a->vec[l-1]);
	DigitType b=1;
	DigitVecCsubto(a->vec, &b, 1);
	while ((l>0)&&(! *lp)) {
		l--; lp--;
	}
	a->length=l;
	return;
}   }       	/* Idec */


BOOLEAN IeqI(a, b)
/* return a==b; */
        register const Integer *a, *b;
{       if ((a->sign==b->sign)&&(a->length==b->length)&&
                DigitVecEq(a->vec, b->vec, a->length))
                return TRUE;
        else
                return FALSE;
}

BOOLEAN IgtI(a, b)
/* return a>b; */
        register const Integer *a, *b;
{       if (a->sign==PLUS) {
                if (b->sign==MINUS)
                        return TRUE;
                else {
                        if ((a->length>b->length)||((a->length==b->length)
                                        &&DigitVecGt(a->vec, b->vec, a->length)))
                                return TRUE;
                        else
                                return FALSE;
                }
        } else {
                if (b->sign==PLUS)
                        return FALSE;
                else {
                        if ((a->length>b->length)||((a->length==b->length)
                                    &&!DigitVecGt(b->vec, a->vec, a->length)))
                                return FALSE;
                        else
                                return TRUE;
}       }       }       /* IgtI */

void Ineg(a)
	register pInteger a;
{	if (a->length)
		a->sign^=MINUS;
}

BOOLEAN IneI(a, b)
/* return a!=b; */
        const Integer *a, *b;
{       return !IeqI(a, b);
}

BOOLEAN IgeI(a, b)
/* return a>=b; */
        const Integer *a, *b;
{       return !IgtI(b, a);
}

BOOLEAN IltI(a, b)
/* return a<b; */
        const Integer *a, *b;
{       return IgtI(b, a);
}

BOOLEAN IleI(a, b)
/* return a<=b; */
        const Integer *a, *b;
{       return !IgtI(a, b);
}

BOOLEAN Ige0(a)
	const Integer *a;
{	return (a->sign==PLUS);
}

BOOLEAN Igt0(a)
	const Integer *a;
{	return ((a->sign==PLUS)&&(a->length));
}

BOOLEAN Ile0(a)
	const Integer *a;
{	return (!a->length || (a->sign==MINUS));
}

BOOLEAN Ilt0(a)
	const Integer *a;
{	return (a->sign==MINUS);
}

BOOLEAN Ieq0(a)
	const Integer *a;
{	return (!a->length);
}

BOOLEAN Ieq1(a)
	const Integer *a;
{	if ((*(a->vec)==1)&&(a->length==1)&&(a->sign==PLUS))
		return TRUE;
	else
		return FALSE;
}


