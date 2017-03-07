/*M
.SH NAME
eqisnfdivpol - elliptic curve over quadratic number field with integral coefficients, short normal form, division polynomial

.SH SYNOPSIS
.nf
# include <_ec3.h>

pol eqisnfdivpol(E,n)
list E;
single n;

.SH DESCRIPTION
eqisnfdivpol() determines the n-th division polynomial of the elliptic curve E as a polynomial in the variables x and y.

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

pol eqisnfdivpol(E,n)
list E;
single n;
{
	list P,H,I,D;
	single d,m,t;
	nfel a4,a6;
	list PEC;
	
	init(P,H,I,D);
	init(a4,a6);
	bind(E);
	init(PEC);
	
	if(n==1) 
	{	P = itonf(1);
		P = list2(0,P);
		P = list2(0,P);
		return(P);		/** 1 **/	
	}
	if(n==2) 
	{	P = itonf(2);
		P = list2(0,P);
		P = list2(1,P);
		return(P);		/** 2y **/	
	}
	d = ecqnfflddisc(E);
	a4 = eqisnfa4(E);
	a6 = eqisnfa6(E);
	if(n==3) 
	{
		H = qnfprod(d,a4,a4);
		H = qnfneg(d,H);
		if(H) P = list2(0,H);
		else P = _0;
		H = itonf(12);
		H = qnfprod(d,a6,H);
		if(H) P = lcomp2(1,H,P);
		H = itonf(6);
		H = qnfprod(d,a4,H);
		if(H) P = lcomp2(2,H,P);
		H = itonf(3);
		P = lcomp2(4,H,P);
		P = list2(0,P);
		return(P);
	}
	if(n==4)
	{
		H = itonf(-4);
		H = qnfprod(d,a4,H);
		H = qnfprod(d,a4,H);
		H = qnfprod(d,a4,H);
		I = itonf(-32);
		I = qnfprod(d,a6,I);
		I = qnfprod(d,a6,I);
		H = qnfsum(d,H,I);
		if(H) P = list2(0,H);
		else P = _0;
		H = itonf(-16);
		H = qnfprod(d,a4,H);
		H = qnfprod(d,a6,H);
		if(H) P = lcomp2(1,H,P);
		H = itonf(-20);
		H = qnfprod(d,a4,H);
		H = qnfprod(d,a4,H);
		if(H) P = lcomp2(2,H,P);
		H = itonf(80);
		H = qnfprod(d,a6,H);
		if(H) P = lcomp2(3,H,P);
		H = itonf(20);
		H = qnfprod(d,a4,H);
		if(H) P = lcomp2(4,H,P);
		H = itonf(4);
		P = lcomp2(6,H,P);
		P = list2(1,P);
		return(P);
	}

	D = list4(2,1,0,ineg(d));
	D = ptodp(1,D);

	/** y^2-x^3 -a4x-a6 **/	

	PEC = _0;	
	if(a6) 
	{
		I = qnfneg(d,a6);
		PEC = list2(0,I);
	}
	if(a4)
	{
		I = qnfneg(d,a4);
		PEC = lcomp(I,PEC);
		PEC = lcomp(1,PEC);
	}
	I = itonf(-1);
	PEC = lcomp(I,PEC);
	PEC = lcomp(3,PEC);
	PEC = list2(0,PEC);
	I = itonf(1);
	I = list2(0,I);
	PEC = lcomp(I,PEC);
	PEC = lcomp(2,PEC);

	if(mshom(2,n))
	{
		m = idif(n,1);
		m = iquot(m,2);
		I = eqisnfdivpol(E,m);
		H = pnfprod(2,D,I,I);
		H = pnfprod(2,D,H,I);
		t = m+2;
		P = eqisnfdivpol(E,t);
		P = pnfprod(2,D,H,P);
		
		t = m+1;
		I = eqisnfdivpol(E,t);
		t = m-1;
		H = eqisnfdivpol(E,t);
		H = pnfprod(2,D,I,H);
		I = pnfprod(2,D,I,I);
		H = pnfprod(2,D,H,I);
		
		H = pnfdif(2,D,P,H);
		I = pnfqrem(2,D,H,PEC,&P);	
		return(P);
	}

	m = iquot(n,2);
	t = m-1;
	I = eqisnfdivpol(E,t);
	I = pnfprod(2,D,I,I);
	t = m+2;
	P = eqisnfdivpol(E,t);
	P = pnfprod(2,D,I,P);
	
	t = m+1;
	I = eqisnfdivpol(E,t);
	I = pnfprod(2,D,I,I);
	t = m-2;
	H = eqisnfdivpol(E,t);
	H = pnfprod(2,D,I,H);
	P = pnfdif(2,D,P,H);

	H = eqisnfdivpol(E,m);
	P = pnfprod(2,D,P,H);

	H = itonf(2);
	H = list2(0,H);
	H = list2(1,H);

	H = pnfquot(2,D,P,H);
	I = pnfqrem(2,D,H,PEC,&P);	
	return(P);
	
}
	
