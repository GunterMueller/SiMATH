/*M
.SH NAME
ispteqisnfppt - is point of elliptic curve in short Weierstrass normal form over quadratic number field p times a point?

.SH SYNOPSIS
.nf
# include <_ec3.h>

single ispteqisnfppt(E,P,p,Q)
list E, P; 
single p;
list *Q;

.SH DESCRIPTION
ispteqisnfppt() tests, if there exists a point Q, such that P=p*Q. If there
is such a point, the return value is 1, otherwise, it is 0.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a point (in projective form) on E(K).
.TP 4
.B p
is a single precision prime number.
M*/
/*H
        Version 1       13.12.1998      S. Schmitt
   DATE ispteqisnfppt     : 981215  
H*/


# include <_ec3.h>

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    

                                                                                
/*c                                                    
	pol eqisnfomp(d,E,p)
	
	elliptic curve in short Weierstrass normal form over quadratic
	number field, omega_p

	Berechnet das Multiplikationspolynom omega_p. (p Primzahl)
c*/

pol eqisnfomp(D,PEC,E,p)
list D,PEC,E;
single p;
{
	pol P,H,I;
	single m;

	bind(D,PEC,E);
	init(P,H,I);

	m = idif(p,1);
	H = eqisnfdivpol(E,m);	/** psi_{m-1} **/
	H = pnfprod(2,D,H,H);
	m = isum(p,2);
	I = eqisnfdivpol(E,m);	/** psi_{m+2} **/
	P = pnfprod(2,D,H,I);

	m = isum(p,1);
	H = eqisnfdivpol(E,m);	/** psi_{m+1} **/
	H = pnfprod(2,D,H,H);
	m = idif(p,2);
	I = eqisnfdivpol(E,m);	/** psi_{m-2} **/
	H = pnfprod(2,D,H,I);
	
	P = pnfdif(2,D,P,H);

	H = itonf(4);
	H = list2(0,H);
	H = list2(1,H);		/** 2psi_2 **/

	H = pnfquot(2,D,P,H);
	I = pnfqrem(2,D,H,PEC,&P);

	return(P);
}

/*c
		ptqnfsubst(d,P,x)

	berechnet P(x)
c*/

nfel ptqnfsubst(d,P,x)
int d;
list P,x;
{
	nfel px,c;
		
	bind(d,P,x);
	init(px,c);

	P = ptodp(1,P);
	P = lred(P);
	px = 0;
	while(P!=_0)
	{
		c = lfirst(P);
		P = lred(P);
		px = qnfsum(d,px,c);
		px = qnfprod(d,px,x);
	}
	return(px);
}



/*c
		ptofzero (d,p,Nx,y0,E)

	macht aus den Nullstellen einen Punkt
c*/

list ptofzero(d,p,Nx,y0,E)
int d;
single p;
list Nx,y0,E;
{
	nfel x,y;
	list P;

	bind(d,Nx,y0,E);
	init(x,y,P);

	x = lfirst(Nx);

	if(y0)	
	{
		list D,PEC;
		init(D,PEC);

		D = epinit(d,E);
		PEC = lsecond(D);
		D = lfirst(D);

		if(p==2)
		{
			nfel A;
			init(A);

			D = eqisnfomp(D,PEC,E,p);
			D = lsecond(D);
			y = ptqnfsubst(d,D,x);

			D = qnfprod(d,x,x);
			A = eqisnfa4(E);
			D = qnfsum(d,A,D);
			D = qnfprod(d,D,x);
			A = eqisnfa6(E);
			D = qnfsum(d,A,D);  /** x^3+Ax+B **/

			D = qnfprod(d,D,y0);
			D = qnfsum(d,D,D);
			D = qnfsum(d,D,D);
			D = qnfsum(d,D,D); /** 8y0 * D **/

			y = qnfquot(d,y,D);
			A = itonf(1);
			P = list3(x,y,A);
			return(P);
		}
		else
		{
			list H;
			init(H);

			H = eqisnfdivpol(E,p);
			H = lsecond(H);
			y = ptqnfsubst(d,H,x);
			H = qnfprod(d,y,y);
			H = qnfprod(d,H,y);
			y = qnfprod(d,H,y0);

			H = eqisnfomp(D,PEC,E,p);
			H = lsecond(H);
			H = ptqnfsubst(d,H,x);
			y = qnfquot(d,y,H);
			
			H = itonf(1);
			P = list3(x,y,H);
			return(P);
		}
	}
	else
	{	
		nfel A,B;
		rat z1,z2,y1,y2;
		init(A,B);
		init(z1,z2,y1,y2);

		A = eqisnfa4(E);
		B = eqisnfa6(E);

		y = qnfprod(d,x,x);
		y = qnfsum(d,y,A);
		y = qnfprod(d,y,x);
		y = qnfsum(d,y,B);

		A = itonf(1);

		if(!y)
		{
			P = list3(x,0,A);
			return(P);
		}
		z1 = lfirst(y);
		if(lsecond(y)==0)
		{	
			y1 = lthird(y);
			y1 = rcons(y1,z1);
			if(isqnfelsqu(d,y1,0,&z1,&z2))
			{
				y = rrtoqnf(d,z1,z2);
				P = list3(x,y,A);
				return(P);
			}
			else return(_0);
		}
		y1 = lfourth(y);
		y2 = lthird(y);
		y1 = rcons(y1,z1);
		y2 = rcons(y2,z1);
		if(isqnfelsqu(d,y1,y2,&z1,&z2))
		{
			y = rrtoqnf(d,z1,z2);
			P = list3(x,y,A);
			return(P);
		}
		else return(_0);	
	}
}


/**********************************************************************/
/***                                                                ***/
/***               s t a t i c   f u n c t i o n s                  ***/
/***                          ( E n d )                             ***/
/***                                                                ***/
/***                                                                ***/
/***     B e g i n n i n g   o f   t h e   m a i n   p a r t        ***/
/***                                                                ***/      
/**********************************************************************/


single ispteqisnfppt(D,PEC,E,P,p,Q,Phip,Divp)
list D,PEC,E,P;
single p;
list *Q,Phip,Divp;
{
	list T,H;
	int d;
	nfel x0,y0;

	bind(D,PEC,E,P,*Q,Phip,Divp);
	init(T,H);
	init(d);
	init(x0,y0);

	(*Q) = _0;
	
	d = ecqnfflddisc(E);
	x0 = lfirst(P);
	y0 = lsecond(P);
	T = lthird(P);
	x0 = qnfquot(d,x0,T);
	y0 = qnfquot(d,y0,T);
	
	if(p==2)
	{
		nfel A,B,c;
		init(A,B,c);

		A = eqisnfa4(E);
		B = eqisnfa6(E);
		c = qnfsum(d,x0,x0);
		c = qnfsum(d,x0,x0);
		A = qnfprod(d,c,A);
		B = qnfprod(d,c,B);

		T = _0;
		if(B) T = lcomp2(0,B,T);
		if(A) T = lcomp2(1,A,T);
		if(x0) T = lcomp2(3,c,T);		/** 4x0*(x^3+Ax+B) **/

		T = pnfdif(1,D,T,Phip);
		
	}
	else  /** p!=2 **/
	{
		T = pnfprod(1,D,Divp,Divp);
		H = list2(0,x0);
		T = pnfprod(1,D,T,H);	/** x0 * psi_p^2 **/

		T = pnfdif(1,D,T,Phip);
	}
/**
printf(" vor upqnfzero T = %obj \n",T);
**/

	H = upqnfzero(d,T);	/** die Nullstellen in Q(sqrt(d)) **/
/*
printf(" danach \n");
**/

	if(H==_0) return(0);	/** keine Nullstelle gefunden **/
	(*Q) = ptofzero(d,p,H,y0,E);
	if((*Q)==_0) return(0);
	return(1);
}	
