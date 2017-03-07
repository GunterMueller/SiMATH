/*M
.SH NAME
erqislip - elliptic curve with integral coefficients over real quadratic number
field, short normal form, search for linear independent points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list erqislip(D,E,r)
int D;
list E;
single r;

.SH DESCRIPTION
erqislip() returns the list L=(L1,L2); list L1,L2;
where L2 contains r linear independent points of E(K), and L1 contains
all points which were found during the search.

.PP
.TP 4
.B D
is a squarefree positive integer not equal to 0 and 1.
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
   DATE erqislip    : 980930
H*/

#include <_ec2.h> 


/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/**********************************************************/
/**********************************************************/
/*** ispprqnfeq Anfang					***/
/**********************************************************/
/**********************************************************/
                                                                                
/*c
		fleqisnf(d, x, a4, a6, ym)
	"double elliptic curve equation"

	fleqisnf() gibt yp = x^3+a4*x+a6 (als double) zurueck.
	und ym = -x^3-a4*x+a6
c*/

static double fleqisnf(x,a4,a6,ym)
double x,a4,a6,*ym;
{
	double y;

	y = x*x;
	y = y+a4;
	y = y*x;
	(*ym) = a6-y;
	y = a6+y;
	
	return(y);

}

/*c
		isposintr(f)

	"is possible integer "

c*/

static single isposintr( f )
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
	ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)
	
	is possible point of elliptic curve over real quadratic number 
	field with integral coefficients, short normal form?

double sd,x,a4,a6,xc,a4c,a6c,k2m2;
ispprqnfeq() tests, if it is possible that there is a y, such that (x,y) or
(-x,y) is a point of E: y^2 = x^3 + a4x + a6. If this is true, isppiqnfeq() 
returns 1, else, isppiqnfeq() returns 0.         
sd is a double point representation of sqrt(d), where d is a a squarefree 
integer not equal to 0 and 1.  
x,a4,a6,xc,a4c,a6c are double point numbers with fc = the conjugate element 
of f in the number field K, represented as double point numbers.         
k2m2 = sqrt(k^2*m^2), da hier sowieso die Wurzel gezogen wird 
c*/

static single ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)
double sd,x,a4,a6,xc,a4c,a6c,k2m2;
{
	double al1,al2,bet1,bet2;
	double al1m,al2m;

	al1 = fleqisnf(x,a4,a6,&al1m);
	al2 = fleqisnf(xc,a4c,a6c,&al2m);
	
	if((al1==0 && al2==0) || (al1m==0 && al2m==0)) return(1);

	if(al1>0 && al2>0)  /** kann Quadrat sein **/
	{

		al1 = sqrt(al1);	
		al1 = al1*k2m2;
		al2 = sqrt(al2);
		al2 = al2*k2m2;

		bet1 = al1+al2;
		al1 = al1-al2;
		if(isposintr(bet1))
		{
			bet2 = al1/sd;
			if(isposintr(bet2)) return(1);
		}
	
		if(isposintr(al1))
		{
			bet2 = bet1/sd;
			if(isposintr(bet2)) return(1);
		}
	}
	if(al1m>0 && al2m>0)  /** kann Quadrat sein **/
	{

		al1m = sqrt(al1m);
		al1m = al1m*k2m2;
		al2m = sqrt(al2m);
		al2m = al2m*k2m2;

		bet1 = al1m+al2m;
		al1 = al1m-al2m;
		if(isposintr(bet1))
		{
			bet2 = al1/sd;
			if(isposintr(bet2)) return(1);
		}
	
		if(isposintr(al1))
		{
			bet2 = bet1/sd;
			if(isposintr(bet2)) return(1);
		}
	}

	return(0);
		
}
	
	
/**********************************************************/
/**********************************************************/
/*** ispprqnfeq Ende   					***/
/**********************************************************/
/**********************************************************/

/*c
		flisqrt(f,K)
	" double integral part of square root "

	gibt 1 zurueck, und K= der ganzzahligen Anteil von sqrt(f) zurueck, 
	falls [sqrt(f)] != [sqrt(f+1)] ist, ansonsten 0.
c*/

static single flisqrt(i,j,inf)
single i,j;
double *inf;
{
	if(i==j) /** i==j -> Sprung -> return(1) **/
	{
		j--;
		j/=2;
		(*inf) = j;
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
		fliquot(z,n,inq)
	" double integral part of quotient "

	gibt 1 zurueck und setzt inq =  ganzzahligen Anteil von z/n, falls
	[z/n] != [(z+1)/n] ist, ansonsten 0.
c*/

static single fliquot(qKh, qKhh,qK)/* qKh = K/sqrt(d), qKhh = (K+1)/sqrt(d) */
double qKh,qKhh,*qK;
{
	double ihh;
	
	(*qK) = floor(qKh);
	ihh = floor(qKhh);

	if((*qK)==ihh) return(0);
	return(1);

}

/*c
		qnftoflfl(A,sd,a,ac)

	" quadratic number field element to two doubles

	A ist eine Element aus K=Q(sqrt(d)), sd = sqrt(d) als
	doubles. a ist A als double,
	ac ist die Konjugierte von A als double.

c*/

static single qnftoflfl(A,sd,a,ac)
nfel A;
double sd,*a,*ac;
{
	int a1,a2,a0;
	floating ha;
	double fltoCfl();
	double hd;

	init(a1,a2,a0,ha);
	bind(A);

	if(A)
	{
		a0 = lfirst(A);
		if(!lsecond(A))
		{
			a1 = lthird(A);
			ha = itofl(a1);
			(*a) = fltoCfl(ha);
			ha = itofl(a0);
			(*ac) = fltoCfl(ha);
			(*a) = (*a)/(*ac);
			(*ac) = *a;
			return(1);
		}
		a1 = lfourth(A);
		a2 = lthird(A);
		ha = itofl(a1);
		(*a) = fltoCfl(ha);
		ha = itofl(a2);
		hd = fltoCfl(ha);
		hd = hd*sd;
		(*ac) = (*a)-hd;
		(*a) = (*a)+hd;
		ha = itofl(a0);
		hd = fltoCfl(ha);
		(*a) = (*a)/hd;
		(*ac) = (*ac)/hd;
		return(1);	

	}

	*a = 0.0;
	*ac = 0.0;
	return(1);


}

/*c

		iitoflquad(a,b)

	" two integers to double and quad "

	a,b sind zwei integers. a*b = km^2, es wird
	k*m/2 als double zurueckgegeben.

c*/

static double iitoflquad(a,b)
int a,b;
{
	int k,m;
	floating r;
	double res,fltoCfl();

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
	
		ffftoflfl(x0,x1,x2,sd,x,xc)

	" three doubles to two doubles "

	sd = sqrt(d) als double. Zurueckgegeben werden
	x = (x1+x2*sd)/x0, xc = (x1-x2*sd)/x0 als doubles.

c*/

static single ffftoflfl(x0,x1,x2,sd,x,xc)
double x0,x1,x2,sd,*x,*xc;
{
	(*x) = x2*sd;
	(*xc) = x1-(*x);
	(*x) = x1+(*x);
	(*x) = (*x)/x0;
	(*xc) = (*xc)/x0;

	return(1);
}

/*c
	flk2m2(km,x0)

	double k2m2
	
	gibt km*x0^2 als double zurueck

c*/

static double flk2m2(km,x0)
double km,x0;
{
	double k;

	k = x0*x0;
	k = k*km;

	return(k);
}


/*c
		ispkt(d,x0,x1,x2,a41,a42,a61,a62,P)

	is point

	Testet, ob x=(x1+sqrt(d)*x2)/x0 die x=Koordinate eines
	Punktes von E ist.

c*/

static single ispkt(d,x0,x1,x2,a41,a42,a61,a62,P)
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
		islgood(d,E,pkt,P,L,H)

	is list good

	Testet, ob der Punkt pkt in P vorkommt. Falls nicht, dann wird
	getestet, ob (L,pkt) linear unabhaengig sind. Gibt in diesem Fall
	1 zurueck, sonst 0.

	H = (P',L'), wobei ggf. bei P und L der Punkt pkt noch dazu gemacht ist.
c*/

static single islgood(d,E,pkt,P,L,H)
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

list erqislip( D,E,r )
int D;
list E;
single r;
{
	list P,L,pkt,H;
	double K,M,sd;
	single gef,gutsK,gutqK,gutsM,gutqM;
	int x0,x1,x2;
	double fx0,fx1,fx2;
	double sK,qK,sM,qM,qKh,qMh,qKhh,qMhh;
	nfel A4,A6;
	double a4,a6,a4c,a6c,k2m2;
	double km,x,xc,xh,N,edsd;
	rat a41,a42,a61,a62;
	single ik,jk,im,jm;
	double fltoCfl();
	floating hx0,hx1,hx2;

	init(P,L,pkt,H);
	init(x0,x1,x2);
	init(A4,A6);
	init(a41,a42,a61,a62);
	init(hx0,hx1,hx2);
    	bind( D,E );


	P = _0;
	L = _0;

	hx0 = flsqrt(itofl(D));		/** sd = sqrt(d) **/
	sd = fltoCfl(hx0);
	edsd = 1.0/sd;		/** 1/sqrt(d) **/

	A4 = eqisnfa4(E);
	A6 = eqisnfa6(E);
	qnftoflfl(A4,sd,&a4,&a4c);
	qnftoflfl(A6,sd,&a6,&a6c);
	qnftorrn(A4,&a41,&a42,&x0);
	qnftorrn(A6,&a61,&a62,&x0);

	if(A4) x0 = lfirst(A4);
	else x0 = 1;
	if(A6) x1 = lfirst(A6);
	else x1 = 1;
	km = iitoflquad(x0,x1);

	K = 1.0;
	qKh = edsd;
	qKhh = qKh+edsd;
	gef = 0;

	ik = 1;	
	jk = 3;

	while(gef< r)
	{

	   gutsK = flisqrt(ik,jk,&sK);	/** sK = sqrt(K), falls ok **/
	   gutqK = fliquot(qKh,qKhh,&qK);	/** qK = K/sd, falls ok **/
/**
printf("K = %f \n",K);
**/

	/** x0 ist fest **/
	   if(gutsK)
	   {
		jk+=2;
		ik = 0;
		fx0 = sK;
		k2m2 = flk2m2(km,fx0);


		M = 0.0;
		qMh = 0.0;
		qMhh = qMh+edsd;
		while(M<=K)
		{
		   gutqM = fliquot(qMh,qMhh,&qM);
		   
		   fx1 = M;
		   N = 0.0;
		   while(N<=qM)
		   {
			fx2 = N;

			ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
		
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 1 \n");
**/
			   if(ispkt(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
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
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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
			fx2 = qM;
			
			N = 0.0;
			while(N<M)
			{
				fx1 = N;
	
			ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
				
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 2\n");
**/
			   if(ispkt(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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

		fx1 = K;

	 	M = 1.0;
		im = 1;
		jm = 3;

		qMh = edsd;
		qMhh = qMh+edsd;
		
		while(M<=K)
		{
		   gutsM = flisqrt(im,jm,&sM);
		   gutqM = fliquot(qMh,qMhh,&qM);

		   if(gutsM || (M==K && sM==sK))
		   {
			im = 0;
			jm +=2;
			fx0 = sM;

			k2m2 = flk2m2(km,fx0);

		 	N = 0.0;
			while(N<=qM)
			{
			   	
		 	      	fx2 = N;

			ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
			
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 3\n");
**/
			   if(ispkt(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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
		   	fx2 = qM;

			N = 1.0;
			while(N<sM)
			{
		   		fx0 = N;
				k2m2 = flk2m2(km,fx0);

				ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
			   	
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 4\n");
**/
			   if(ispkt(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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
		fx2 = qK;

	 	M = 1.0;

		im = 1;
		jm = 3;
		while(M<=K)
		{
		   gutsM = flisqrt(im,jm,&sM);

		   if(gutsM || (M==K && sM==sK))
		   {
			im = 0;
			jm +=2;
			fx0 = sM;

			k2m2 = flk2m2(km,fx0);

			N = 0.0;
			while(N<=M)
			{
				fx1 = N;

				ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
			
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 5\n");
**/
			   if(ispkt(D,x0,x1,x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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

		   fx1 = M;

		   N = 1.0;
		   while(N<sM)
		   {
			fx0 = N;
			k2m2 = flk2m2(km,fx0);
		   	
			ffftoflfl(fx0,fx1,fx2,sd,&x,&xc);
		/************************************/
		/** Begin test **********************/	
		/************************************/

		    	if(ispprqnfeq(sd,x,a4,a6,xc,a4c,a6c,k2m2)  /* x1,x2 und -x1,-x2 */
			|| ispprqnfeq(sd,xc,a4,a6,x,a4c,a6c,k2m2)) /* x1,-x2 und -x1,x2 */
			{
			   fx0 = fx0+0.1;
			   fx1 = fx1+0.1;
			   fx2 = fx2+0.1;
			   hx0 = Cfltofl(fx0);
			   hx1 = Cfltofl(fx1);
			   hx2 = Cfltofl(fx2);
			   x0 = flfloor(hx0);
			   x1 = flfloor(hx1);
			   x2 = flfloor(hx2);
/**
printf("moeglich 6\n");
**/
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,x1,ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),x2,a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
				}
				P = lfirst(H);
				L = lsecond(H);
			   }
			   if(ispkt(D,x0,ineg(x1),ineg(x2),a41,a42,a61,a62,&pkt))
			   {
/**
printf("punkt \n");
**/
				if(islgood(D,E,pkt,P,L,&H))
				{
/**
printf("H = %obj \n",H);
**/
					gef++;
					if(gef==r) return(list2(P,L));
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
