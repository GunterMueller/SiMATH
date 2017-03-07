/*M
.SH NAME
ecqnfdivpol - elliptic curve over quadratic number field division polynomial

.SH SYNOPSIS
.nf
# include <_ec3.h>

pol ecqnfdivpol(E,n)
list E;
single n;

.SH DESCRIPTION
ecqnfdivpol() determines the n-th division polynomial of the elliptic curve E as a polynomial in the variables x and y.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B n
is a single precision number.
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE eqisnfa4     : 980819  
H*/


# include <_ec3.h>

pol ecqnfdivpol(E,n)
list E;
single n;
{
	list P,H,I,D;
	single d,m,t;
	nfel a1,a3,b2,b4,b6,b8;
	nfel a2,a4,a6;
	list PEC;
	
	init(P,H,I,D);
	init(a1,a3,b2,b4,b6,b8);
	init(a2,a4,a6);
	bind(E);
	init(PEC);
	
	if(n==1) 
	{	P = itonf(1);
		P = list2(0,P);
		P = list2(0,P);
		return(P);		/** 1 **/	
	}
	d = ecqnfflddisc(E);
	H = lfirst(lfirst(E));
	a1 = lfirst(H);
	a2 = lsecond(H);
	a3 = lthird(H);
	a4 = lfourth(H);
	a6 = lfifth(H);
	if(n==2) 
	{	P = itonf(2);
		P = list2(0,P); 
		if(a1)
		{
			if(a3) H = list4(1,a1,0,a3);
			else   H = list2(1,a1);
			P = list4(1,P,0,H);
		}
		else if(a3)
		{
			H = list2(0,a3);
			P = list4(1,P,0,H);
		}
		else P = list2(1,P);
		return(P);		/** 2y **/	
	}
	b2 = ecqnfacb2(E);
	b4 = ecqnfacb4(E);
	b6 = ecqnfacb6(E);
	b8 = ecqnfacb8(E);
	if(n==3) 
	{
		if(b8) P = list2(0,b8);
		else P = _0;
		if(b6)
	 	{	
			H = qnfsum(d,b6,b6);
			H = qnfsum(d,H,b6);
			P = lcomp2(1,H,P);
		}
		if(b4)
	 	{	
			H = qnfsum(d,b4,b4);
			H = qnfsum(d,H,b4);
			P = lcomp2(2,H,P);
		}
		if(b2) P = lcomp2(3,b2,P);
		H = itonf(3);
		P = lcomp2(4,H,P);
		P = list2(0,P);
		return(P);
	}

	D = list4(2,1,0,ineg(d));
	D = ptodp(1,D);

	/** y^2+a1xy+a3y -x^3 -a2x^2-a4x-a6 **/	

	PEC = _0;	
	if(a6) 
	{
		I = qnfneg(d,a6);
		PEC = list2(0,I);
	}
	if(a4)
	{
		I = qnfneg(d,a4);
		PEC = lcomp2(1,I,PEC);
	}
	if(a2)
	{
		I = qnfneg(d,a2);
		PEC = lcomp2(2,I,PEC);
	}
	I = itonf(-1);
	PEC = lcomp(I,PEC);
	PEC = lcomp(3,PEC);
	PEC = list2(0,PEC);
	if(a3 || a1)
	{
		if(a3 && a1) I = list4(1,a1,0,a3);
		else if(a3)  I = list2(0,a3);
		else 	     I = list2(1,a1);
		PEC = lcomp2(1,I,PEC);
	}
	I = itonf(1);
	I = list2(0,I);
	PEC = lcomp2(2,I,PEC);

	if(n==4)
	{
		H = qnfprod(d,b4,b8);
		I = qnfprod(d,b6,b6);
		H = qnfdif(d,H,I);
		if(H) P = list2(0,H);
		else P = _0;
		H = qnfprod(d,b2,b8);
		I = qnfprod(d,b4,b6);
		H = qnfdif(d,H,I);
		if(H) P = lcomp2(1,H,P);
		if(b8)
		{	H = itonf(10);
			H = qnfprod(d,b8,H);
			P = lcomp2(2,H,P);
		}
		if(b6)
		{	H = itonf(10);
			H = qnfprod(d,b6,H);
			P = lcomp2(3,H,P);
		}
		if(b4)
		{	H = itonf(5);
			H = qnfprod(d,b4,H);
			P = lcomp2(4,H,P);
		}
		if(b2) P = lcomp2(2,b2,P);
		H = itonf(2);
		P = lcomp2(6,H,P);
		P = list2(0,P);
		H = ecqnfdivpol(E,2);
		H = pnfprod(2,D,P,H);
		I = pnfqrem(2,D,H,PEC,&P);	
		return(P);
	}

	if(mshom(2,n))
	{
		m = idif(n,1);
		m = iquot(m,2);
		I = ecqnfdivpol(E,m);
		H = pnfprod(2,D,I,I);
		H = pnfprod(2,D,H,I);
		t = m+2;
		P = ecqnfdivpol(E,t);
		P = pnfprod(2,D,H,P);
		
		t = m+1;
		I = ecqnfdivpol(E,t);
		t = m-1;
		H = ecqnfdivpol(E,t);
		H = pnfprod(2,D,I,H);
		I = pnfprod(2,D,I,I);
		H = pnfprod(2,D,H,I);
		
		H = pnfdif(2,D,P,H);
		I = pnfqrem(2,D,H,PEC,&P);	
		return(P);
	}

	m = iquot(n,2);
	t = m-1;
	I = ecqnfdivpol(E,t);
	I = pnfprod(2,D,I,I);
	t = m+2;
	P = ecqnfdivpol(E,t);
	P = pnfprod(2,D,I,P);
	
	t = m+1;
	I = ecqnfdivpol(E,t);
	I = pnfprod(2,D,I,I);
	t = m-2;
	H = ecqnfdivpol(E,t);
	H = pnfprod(2,D,I,H);
	P = pnfdif(2,D,P,H);

	H = ecqnfdivpol(E,m);
	P = pnfprod(2,D,P,H);

	H = ecqnfdivpol(E,2);
	H = pnfquot(2,D,P,H);
	I = pnfqrem(2,D,H,PEC,&P);	
	return(P);
	
}
	
