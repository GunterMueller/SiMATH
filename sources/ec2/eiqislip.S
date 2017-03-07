/*M
.SH NAME
eiqislip - elliptic curve with integral coefficients over imaginary quadratic 
number field, short normal form, search for linear independent points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eiqislip(D,E,r)
int D;
list E;
single r;

.SH DESCRIPTION
eiqislip() returns the list L=(L1,L2); list L1,L2;
where L2 contains r linear independent points of E(K), and L1 contains
all points which were found during the search.

.PP
.TP 4
.B D
is a squarefree negative integer.
.TP 4
.B E
is a list containing the data of an elliptic curve E/K over a quadratic number
field (see `ecqnfinit').
.TP 4
.B r
is a single precision number which should not be greater than the rank of
E over K.

M*/
/*H
	Version 1       24.09.1998      S. Schmitt
   DATE eiqislip    : 980930
H*/

#include <_ec2.h> 


/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*****************************************************/
/*****************************************************/
/**	isppiqnfeq.S	Anfang			******/
/*****************************************************/
/*****************************************************/

/*c
 ceqisnf(xr,a4r,a6r,xi,a4i,a6i,yr,yi,myr,myi)
	"complex elliptic curve equation"

c*/

static single ceqisnf(xr,a4r,a6r,xi,a4i,a6i,yr,yi,myr,myi)
double xr,a4r,a6r,xi,a4i,a6i,*yr,*yi,*myr,*myi;
{
	double h;

	h = xi*xi;
	(*yr) = xr*xr;
	(*yi) = 3*(*yr);
	(*yi) = (*yi) - h;
	(*yi) = (*yi)*xi;	/** yi = 3xr^2xi - xi^3 **/
	h = 3*h;
	(*yr) = (*yr)-h;
	(*yr) = (*yr)*xr;	/** yr = x^3-3xi^2xr	**/

	h = a4r*xr;
	(*yr) = (*yr)+h;
	h = a4i*xi;
	(*yr) = (*yr)-h;
	(*myr) = a6r-(*yr);
	(*yr) = (*yr)+a6r;	/** yr = yr + a4rxr - a4ixi + a6r **/

	h = a4r*xi;
	(*yi) = (*yi)+h;
	h = a4i*xr;
	(*yi) = (*yi)+h;
	(*myi) = a6i-(*yi);
	(*yi) = (*yi)+a6i;	/** yi = yi + a4rxi + a4ixr + a6i **/
	
	
	return(1);

}

/*c
		cflsqrt(a,b,c,d)
	"complex sqrt as doubles"

	berechnet (c+i*d) = sqrt(a+i*b)

		a = c^2-d^2
		b = 2cd
c*/

static single cflsqrt(a,b,c,d)
double  a,b,*c,*d;
{
	if(b==0.0)
	{
		if(a>=0)
		{
			(*c) = sqrt(a);
			(*d) = 0.0;
			return(1);
		}
		(*c) = 0.0;
		a = -a;
		(*d) = sqrt(a);
		return(1);
	}
	else
	{
		double h;
		
		h = a*a;
		(*d) = b*b;
		h = h+(*d);
		h = sqrt(h);
		h = h-a;
		h = h*0.5;	/** 1/2(-a+sqrt(a^2+b^2) **/
		(*d) = sqrt(h);
		h = (*d)+(*d);
		(*c) = b/h;	/** b/2d **/
		return(1);
	}
}

/*c
	isposinti(f)

	"is possible integer"

c*/

static single isposinti( f )
double f;
{
        double fr;

        fr = f+0.5;
        fr = floor(fr);
        fr = f-fr;
        if(fr<0) fr= -fr;
        if(fr<0.001) return(1);
        else return(0);
}

/*c
	
single isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)

	is possible point of elliptic curve over imaginart quadratic 
	number field with integral coefficients, short normal form?

isppiqnfeq() tests, if it is possible that there is a y, such that (x,y) or
(-x,y) is a point of E: y^2 = x^3 + a4x + a6. If this is true, isppiqnfeq() 
returns 1, else, isppiqnfeq() returns 0.
sd
is a complex point representation of sqrt(d), where d is a squarefree integer 
not equal to 0 and 1.
x,a4,a6,xc,a4c,a6c
are complex numbers with fc = the conjugate element of f in the 
number field K, represented as complex numbers.
k2m2 = sqrt(k^2*m^2), da hier sowieso die Wurzel gezogen wird 

c*/


single isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)
double sd,xr,a4r,a6r,xi,a4i,a6i,k2m2;
{

	double al1r,al1i,al2r,al2i;
	double bet1r,bet1i,bet2r,bet2i;
	double mal1r,mal1i,mal2r,mal2i;

	ceqisnf(xr,a4r,a6r,xi,a4i,a6i,&al1r,&al1i,&mal1r,&mal1i);
	xi = -xi;
	a4i = -a4i;
	a6i = -a6i;
	ceqisnf(xr,a4r,a6r,xi,a4i,a6i,&al2r,&al2i,&mal2r,&mal2i);	/** konjugierte **/

	cflsqrt(al1r,al1i,&bet1r,&bet1i);
	cflsqrt(al2r,al2i,&bet2r,&bet2i);

	al1r = bet1r * k2m2;
	al1i = bet1i * k2m2;
	al2r = bet2r * k2m2;
	al2i = bet2i * k2m2;

	bet1r = al1r+al2r;
	bet1i = al1i+al2i;
	if(bet1i<0) bet1i = -bet1i;
	al2r = al1r-al2r;
	al2i = al1i-al2i;

	if(bet1i<0.001)
	{
		if(isposinti(bet1r))
		{
			bet2i = al2r/sd;/** sd = sqrt(-d) mit d<0 !! **/
			if(bet2i<0) bet2i = -bet2i;
			if(bet2i<0.001)
			{
				bet2r = al2i/sd;
				if(isposinti(bet2r)) return(1);
			}
		}
	}

	if(al2i<0) al2i = -al2i;
	if(al2i<0.001)
	{
		if(isposinti(al2r))
		{
			bet2i = bet1r/sd;/** sd = sqrt(-d) mit d<0 !! **/
			if(bet2i<0) bet2i = -bet2i;
			if(bet2i<0.001)
			{
				bet2r = bet1i/sd;
				if(isposinti(bet2r)) return(1);
			}
		}
	}

	cflsqrt(mal1r,mal1i,&bet1r,&bet1i);
	cflsqrt(mal2r,mal2i,&bet2r,&bet2i);

	al1r = bet1r * k2m2;
	al1i = bet1i * k2m2;
	al2r = bet2r * k2m2;
	al2i = bet2i * k2m2;

	bet1r = al1r+al2r;
	bet1i = al1i+al2i;
	if(bet1i<0) bet1i = -bet1i;
	al2r = al1r-al2r;
	al2i = al1i-al2i;

	if(bet1i<0.001)
	{
		if(isposinti(bet1r))
		{
			bet2i = al2r/sd;/** sd = sqrt(-d) mit d<0 !! **/
			if(bet2i<0) bet2i = -bet2i;
			if(bet2i<0.001)
			{
				bet2r = al2i/sd;
				if(isposinti(bet2r)) return(1);
			}
		}
	}

	if(al2i<0) al2i = -al2i;
	if(al2i<0.001)
	{
		if(isposinti(al2r))
		{
			bet2i = bet1r/sd;/** sd = sqrt(-d) mit d<0 !! **/
			if(bet2i<0) bet2i = -bet2i;
			if(bet2i<0.001)
			{
				bet2r = bet1i/sd;
				if(isposinti(bet2r)) return(1);
			}
		}
	}

	return(0);


}
	

/*****************************************************/
/*****************************************************/
/**	isppiqnfeq.S	Ende  			******/
/*****************************************************/
/*****************************************************/

/*c
		cisqrt(f,K)
	" complex integral part of square root "

	gibt 1 zurueck, und K= der ganzzahligen Anteil von sqrt(f) zurueck, 
	falls [sqrt(f)] != [sqrt(f+1)] ist, ansonsten 0.
c*/

static single cisqrt(i,j,inf)
single i,j;
double *inf;
{

	if(i==j) /** i==j -> Sprung -> return(1) **/
	{
		j--;
		j/=2;
		(*inf)=j;
		return(1);
	}
	else	/** kein Sprung -> return(0) **/
	{
		j--;
		j/=2;
		(*inf) = j;
		return(0);
	}
}


/*c
		coiquot(z,n,inq)
	" complex integral part of quotient "

	gibt 1 zurueck und setzt inq =  ganzzahligen Anteil von z/n, falls
	[z/n] != [(z+1)/n] ist, ansonsten 0.
c*/

static single coiquot(qKh, qKhh,qK)/* qKh = K/sqrt(d), qKhh = (K+1)/sqrt(d) */
double qKh,qKhh;
double *qK;
{
	double ihh;

	(*qK) = floor(qKh);
	ihh = floor(qKhh);

	if((*qK)==ihh) return(0);
	return(1);

}


/*c
		qnftocc(A,sd,a,ac)

	" quadratic number field element to two complex
	 numbers "

	A ist eine Element aus K=Q(sqrt(d)), sd = sqrt(d) als
	complex number. A = a + i*ai als complex number.

c*/

static single qnftocc(A,sd,ar,ai)	/** A = ar+i*ai **/
nfel A;
double sd,*ar,*ai;
{
	int a1,a2,a0;
	floating ha;
	double hd;
	double fltoCfl();

	init(a1,a2,a0,ha);
	bind(A);

	if(A)
	{
		a0 = lfirst(A);
		if(!lsecond(A))
		{
			a1 = lthird(A);
			ha = itofl(a1);
			(*ar) = fltoCfl(ha);
			ha = itofl(a0);
			(*ai) = fltoCfl(ha);
			(*ar) = (*ar)/(*ai);
			(*ai) = 0.0;
			return(1);
		}
		a1 = lfourth(A);
		a2 = lthird(A);
		ha = itofl(a1);
		(*ar) = fltoCfl(ha);
		ha = itofl(a2);
		(*ai) = fltoCfl(ha);
		(*ai) = (*ai) * sd;
		ha = itofl(a0);
		hd = fltoCfl(ha);
		(*ar) = (*ar)/hd;
		(*ai) = (*ai)/hd;
		return(1);	

	}

	*ar = 0.0;
	*ai = 0.0;
	return(1);


}

/*c

		iitocquad(a,b)

	" two integers to complex and quad "

	a,b sind zwei integers. a*b = km^2, es wird
	k*m/2 als complex zurueckgegeben.

c*/

static double iitocquad(a,b)
int a,b;
{
	int k,m;
	floating r;
	double res, fltoCfl();

	init(k,m,r);
	bind(a,b);

	a = iprod(a,b);
	k = isfp(a);
	m = iquot(a,k);
	r = itofl(m);
	r = flsqrt(r);
	r = flprod(r,itofl(k));
	res = fltoCfl(r);
	res = res/2.0;

	return(res);
}

/*c
	
		ffftocc(x0,x1,x2,sd,x,xc)

	" three doubles to two complex "

	sd = sqrt(d) als double. Zurueckgegeben werden
	x = (x1+x2*sd)/x0, xc = (x1-x2*sd)/x0 als complex.

c*/

static single ffftocc(x0,x1,x2,sd,xr,xi)
double x0,x1,x2;
double sd,*xr,*xi;	/** x =xr + i*xi **/
{

	(*xr) = x1/x0;
	(*xi) = x2*sd;
	(*xi) = (*xi)/x0;

	return(1);
}

/*c
	ck2m2(km,x0)

	complex k2m2
	
	gibt km*x0^2 als complex zurueck

c*/

static double ck2m2(km,x0)
double km;
double x0;
{
	double k;

	k = x0*x0;
	k = k*km;

	return(k);
}


/*c
		ispktc(d,x0,x1,x2,a41,a42,a61,a62,P)

	is point

	Testet, ob x=(x1+sqrt(d)*x2)/x0 die x=Koordinate eines
	Punktes von E ist.

c*/

static single ispktc(d,x0,x1,x2,a41,a42,a61,a62,P)
int d,x0,x1,x2;
rat a41,a42,a61,a62;
list *P;
{
	rat r1,r2;
	nfel X,Y;

	init(r1,r2,X,Y);
	bind(d,x0,x1,x2,a41,a42,a61,a62,*P);

  	r1 = rcons(x1,x0);
   	r2 = rcons(x2,x0);
	if(ispeqisnfsp(d,a41,a42,a61,a62,r1,r2,&Y)) 
	{
		X = rrtoqnf(d,r1,r2);
		(*P) = list3(X,Y,itonf(1));
		return(1);
	}
	return(0);
}


/*c
		islgoodc(d,E,pkt,P,L,H)

	is list good

	Testet, ob der Punkt pkt in P vorkommt. Falls nicht, dann wird
	getestet, ob (L,pkt) linear unabhaengig sind. Gibt in diesem Fall
	1 zurueck, sonst 0.

	H = (P',L'), wobei ggf. bei P und L der Punkt pkt noch dazu gemacht ist.
c*/

static single islgoodc(d,E,pkt,P,L,H)
int d;
list E,pkt,P,L,*H;
{
	bind(d,E,pkt,P,L,*H);

	if(!islelt(P,pkt))
	{
		P = lcomp(pkt,P);
		L = lcomp(pkt,L);
		if(ecqnfptlin(d,E,L))
		{
			(*H) = list2(P,L);
			return(1);
		}
		L = lred(L);
	}
	(*H) = list2(P,L);
	return(0);
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

list eiqislip( D,E,r )
int D;
list E;
single r;
{
	list P,L,pkt,H;
	double K,M,N,sd;
	single gef,gutsK,gutqK,gutsM,gutqM;
	int x0,x1,x2;
	double flx0,flx1,flx2;
	double sK,qK,sM,qM;
	double qKh,qMh,qKhh,qMhh;
	nfel A4,A6;
	double k2m2;
	double a4r,a6r,a4i,a6i,km;
	double xr,xi;
	double edsd;
	rat a41,a42,a61,a62;
	single ik,jk,im,jm;
	floating hx0,hx1,hx2;
	double fltoCfl();

	init(P,L,pkt,H);
	init(x0,x1,x2);
	init(A4,A6);
	init(a41,a42,a61,a62);
	init(hx0,hx1,hx2);
    	bind( D,E );


	P = _0;
	L = _0;

 	hx0 = itofl(D);
	hx0 = flneg(hx0);
	hx0 = flsqrt(hx0);	
	sd = fltoCfl(hx0);		/** sd = sqrt(-d), d<0 **/
	edsd = 1.0/sd;

	A4 = eqisnfa4(E);
	A6 = eqisnfa6(E);
	qnftocc(A4,sd,&a4r,&a4i);
	qnftocc(A6,sd,&a6r,&a6i);
	qnftorrn(A4,&a41,&a42,&x0);
	qnftorrn(A6,&a61,&a62,&x0);

	if(A4) x0 = lfirst(A4);
	else x0 = 1;
	if(A6) x1 = lfirst(A6);
	else x1 = 1;
	km = iitocquad(x0,x1);	/** km ist eigentlich ein floating **/

	K = 1.0;
	qKh = edsd;
	qKhh = qKh+edsd;
	gef = 0;

	ik = 1;	
	jk = 3;

	while(gef< r)
	{

	   gutsK = cisqrt(ik,jk,&sK);		/** sK = sqrt(K), falls ok **/
	   gutqK = coiquot(qKh,qKhh,&qK);	/** qK = K/sd, falls ok **/
/**
printf(" K = %f \n",K);
**/

	/** x0 ist fest **/
	   if(gutsK)
	   {
		jk+=2;
		ik = 0;
		flx0 = sK;
		k2m2 = ck2m2(km,flx0);


		M = 0.0;
		qMh = 0.0;
		qMhh = qMh+edsd;
		while(M<=K)	
		{
		   gutqM = coiquot(qMh,qMhh,&qM);
		   
		   flx1 = M;
		   N = 0.0;
		   while(N<=qM)
		   {
			flx2 = N;

			ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
		
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;                                       
                           flx2 = flx2+0.1;                                       
                           hx0 = Cfltofl(flx0);                                  
                           hx1 = Cfltofl(flx1);                                  
                           hx2 = Cfltofl(flx2);                                  
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 1 \n");
**/
			   if(ispktc(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/

			N = N+1.0;

		   }

		   if(gutqM || (M==K && qM==qK))
		   {   
			flx2 = qM;
			
			N = 0.0;
			while(N<M)
			{
				flx1 = N;
	
			ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
				
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;                                       
                           flx2 = flx2+0.1;                                       
                           hx0 = Cfltofl(flx0);                                  
                           hx1 = Cfltofl(flx1);                                  
                           hx2 = Cfltofl(flx2);                                  
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 2\n");
**/
			   if(ispktc(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/

			N = N+1.0;
		     }
		 }

		M = M+1.0;
		qMh = qMhh;
		qMhh = qMhh+edsd;
	     }

	   }

	/** x1 ist fest **/

		flx1 = K;

	 	M = 1.0;
		im = 1;
		jm = 3;

		qMh = edsd;
		qMhh = qMh+edsd;
		
		while(M<=K)
		{
		   gutsM = cisqrt(im,jm,&sM);
		   gutqM = coiquot(qMh,qMhh,&qM);

		   if(gutsM || (M==K && sM==sK))
		   {
			im = 0;
			jm +=2;
			flx0 = sM;

			k2m2 = ck2m2(km,flx0);

		 	N = 0.0;
			while(N<=qM)
			{
			   	
		 	      	flx2 = N;

			ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
			
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;                                       
                           flx2 = flx2+0.1;                                       
                           hx0 = Cfltofl(flx0);                                  
                           hx1 = Cfltofl(flx1);                                  
                           hx2 = Cfltofl(flx2);                                  
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 3\n");
**/
			   if(ispktc(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/

			N = N+1.0;
		    }

		 }
		 if(gutqM || (M==K && qM==qK))
		{
		   	flx2 = qM;

			N = 1.0;
			while(N<sM)
			{
		   		flx0 = N;
				k2m2 = ck2m2(km,flx0);

				ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
			   	
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;                                       
                           flx2 = flx2+0.1;                                       
                           hx0 = Cfltofl(flx0);                                  
                           hx1 = Cfltofl(flx1);                                  
                           hx2 = Cfltofl(flx2);                                  
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 4\n");
**/
			   if(ispktc(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/

			N = N+1.0;

		   }

		  }
		   M = M+1.0;
		   im++;
		   qMh = qMhh;
		   qMhh = qMhh+edsd;
		}


	/** x2 ist fest **/
	   if(gutqK)
	   {
		flx2 = qK;

	 	M = 1.0;

		im = 1;
		jm = 3;
		while(M<=K)
		{
		   gutsM = cisqrt(im,jm,&sM);

		   if(gutsM || (M==K && sM==sK))
		   {
			im = 0;
			jm +=2;
			flx0 = sM;

			k2m2 = ck2m2(km,flx0);

			N = 0.0;
			while(N<=M)
			{
				flx1 = N;

				ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
			
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;    
                           flx2 = flx2+0.1;    
                           hx0 = Cfltofl(flx0);
                           hx1 = Cfltofl(flx1);
                           hx2 = Cfltofl(flx2);
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 5\n");
**/
			   if(ispktc(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/

			N = N+1.0;
		    }
		  }

		   flx1 = M;

		   N = 1.0;
		   while(N<sM)
		   {
			flx0 = N;
			k2m2 = ck2m2(km,flx0);
		   	
			ffftocc(flx0,flx1,flx2,sd,&xr,&xi);
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(isppiqnfeq(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2)  /* x1,x2 und -x1,-x2 */
			|| isppiqnfeq(sd,xi,a4r,a6r,xr,a4i,a6i,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   flx0 = flx0+0.1;   
                           flx1 = flx1+0.1;                                       
                           flx2 = flx2+0.1;                                       
                           hx0 = Cfltofl(flx0);                                  
                           hx1 = Cfltofl(flx1);                                  
                           hx2 = Cfltofl(flx2);                                  
                           x0 = flfloor(hx0);                                   
                           x1 = flfloor(hx1);                                   
                           x2 = flfloor(hx2);     
/**
printf("moeglich 6\n");
**/
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispktc(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgoodc(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(H);
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			}

		/************************************/
		/** End test ************************/	
		/************************************/


			N = N+1.0;

		   }
		   M = M+1.0;
		   im++;
		}
				

	   }


	   K = K+1.0;
	   qKh = qKhh;		/** K/sqrt(d) **/
	   qKhh = qKhh+edsd;	/** (K+1)/sqrt(d) **/
	   ik++;
	}
}
