/*M
.SH NAME
ecqnfsigns - elliptic curve over quadratic number field, sign of
the functional equation, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecqnfsigns(E,num)
list   E,num;

.SH DESCRIPTION
ecqnfsigns() returns the sign of the functional equation of the 
L-series of E over a quadratic number field K.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B num
is the number of computed coefficients.
M*/                                                                             
/*H                                                                             
        Version 1       03.09.1998      S. Schmitt                              
   DATE ecqnfsigns     :  980915                                                
H*/                         





#include <_ec2.h>

extern single C[5500];

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/    
/**************************************************************************/    


/*c
		sigintf(x,Au)
	
	"sign integrand f"

	Bei der Berechnung des Vorzeichens muss ueber die Funktion f 
	integriert werden. Hier wird f(x) zurueckgegeben, alles floatings.
	Au ist -2*pi*A_{E,K}^{-1/4}u^{1/2}.
	Es ist 
		f(x) = exp(Au * (1/x+x)) *1/x

c*/


static double sigintf(x,Au)
double x,Au;
{
	double y;

	y = 1/x;
	y = x+y;
	y = Au*y;
	y = exp(y);
	y = y/x;

/**
	double y,z;
	
	z = x*x;
	y = 1/z;
	y = y+z;
	y = Au*y;
	y = exp(y);
	y = y/x;
**/

	return(y);
}

/*c
	rombsign(Au)
	
	"romberg at signum"

	Berechnet 
		\int_0^1 f(x)dx 
	Au ist -2*pi*A_{E,K}^{-1/4}u^{1/2}.
	Es ist 
		f(x) = exp(Au * (1/x+x)) *1/x die Funktion
	aus sigintf().

	Berechnet das ganze mit Romberg Verfahren

c*/

static double rombsign(Au)
double Au;
{
	single i,k,n;
	double P[10];
	double h,s;
	double ih,x,q;

	h = 1.0;
	n = 1;
	P[0] = sigintf(1.0,Au);	/** = f(0) + f(1), f(0 ) = 0 **/
	P[0] = P[0]*0.5;	/** P[0] * h/2 **/
	
	for(k=1;k<=9;k++)
	{
		s = 0.0;
		n+=n;		/** 2^k **/
		h = h*0.5;	/** 1/2^k **/
		ih = h;		/** = 0+h */
		for(i=1;i<n;i=i+2)
		{
			x = sigintf(ih,Au);
			s = s+x;
			ih = ih+h;
			ih = ih+h;	/** 0+h*i **/
		}
		s = s*h;
		x = P[k-1]*0.5;
		P[k] = x+s;

		/** Trapezregel Ende **/

		q = 1.0;
		for(i=k-1;i>=0;i--)
		{
			q = q+q;
			q = q+q;
			s = q-1;
			x = P[i+1]-P[i];
			x = x/s;
			P[i] = P[i+1]+x;
		}
	}
	return(P[0]);
}


	







/*c
		sigfunh(Ae,u)
	
	"sign function h"

	Bei der Berechnung des Vorzeichens  muss die Funktion h berechnet 
	werden. Hier wird h(u) zurueckgegeben, alles floatings.
	Ae ist -2*pi*A_{E,K}^{-1/4}. Dabei wird allerdings 
	(wegen des konstanten Faktors 2) nur 1/2 h(u) 
	zurueckgegeben, d.h. dieses h(u) ist 1/2*h_ARBEIT(u).	
	Es ist 
		h(u) = \int_0^1 f(x)dx mit f aus sigintf()	

c*/


static double sigfunh(Ae,u)
double Ae,u;
{
	double Au,h;


	Au = sqrt(u);
	Au = Ae*Au;
/**
	Au = Ae*u;
**/
/** 3. Version
	Au = sqrt(u);
	Au = Ae/Au;
**/

	h = rombsign(Au);
/**
	h = h*u;
**/
/** 3. Version
	h = h/u;
	h = h/u;
**/

	return(h);	
}




/*c
		sigfung(Ae,t)
	
	"sign function g"

	Bei der Berechnung des Vorzeichens muss die Funktion g berechnet 
	werden. Hier wird g(t) zurueckgegeben, alles floatings.
	Ae ist -2*pi*A_{E,K}^{-1/4}. Dabei wird allerdings 
	(wegen des konstanten Faktors 2) nur 1/2 g(t) 
	zurueckgegeben, d.h. dieses g(t) ist 1/2*g_ARBEIT(t).	
	Es ist 
		g(u) = \sum_{m=1}^{infty} C[m] h(m*t)
	mit h wie in sigfunh().

c*/


static floating sigfung(Ae,t)
double Ae,t;
{
	single m,M;
	floating res;
	double c,mt,h,G;

	init(res);

	M = C[0];
	G = 0.0;
	mt = 0.0;
	for(m=1;m<=M;m++)	
	{
		mt = mt+t;	    /** m*t **/
		if(C[m])
		{
			h = sigfunh(Ae,mt);
			h = C[m]*h;
			G = G+h;
		}
if(!mshom(100,m)) printf("sign m = %obj, G = %f \n ",m,G);
	}
	res = Cfltofl(G);
	return(res);

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


single ecqnfsigns( E,num )                    
list E,num;
{
	if( lfourth(lfourth(E))==_0)
	{

	list N,L4;
	floating Ae, g1,g2;
	int d;
	single sig;
	double Aed,fltoCfl();

	bind(E);
	bind(C[0..num]);
	init(N,L4,Ae,g1,g2,d);


	d = ecqnfflddisc(E);

	/** Ae = -2*pi*A^{-1/4} mit 
	    A = Norm(N_E) D^2, D = Diskriminante von K|Q. **/

	N = ecqnfpifcond(E);
	N = qnfabsnorm(d,N);
	Ae = rtofl(N);
	Ae = flsqrt(Ae);
	N = ecqnfflddisc(E);
	if(!ecqnfdmod4(E))	N = iprod(N,4);
	if(isign(N)==(-1)) N = ineg(N);
	Ae = flprod(Ae,itofl(N));
	Ae = flsqrt(Ae);
	g1 = flPi();
	g1 = flsum(g1,g1);
	Ae = flquot(g1,Ae);
/** 3. Version
	Ae = flprod(g1,Ae);
**/
	Ae = flneg(Ae);

	Aed = fltoCfl(Ae);

	/** Es ist g(t) = eps t^{-2}g(\frac{1}{t}). Ist also 
		g(1) ungleich 0 -> eps = 1 **/

	g1 = sigfung(Aed,1.0);
	g1 = flabs(g1);

	if(flcomp(g1,Cfltofl(0.0001)) >0) sig = 1; /** g1 > 0.00001 **/
	else
	{

	/** Es ist g(2) = eps/4 g(\frac{1}{2}). **/

		g2 = sigfung(Aed,0.5);
		g1 = sigfung(Aed,2.0);

		if(flsign(g1)==flsign(g2)) sig = 1;
		else sig = -1;
	}

	L4 = lfourth(E);
	N = list5(sig,-1,itofl(0),itofl(0),-1);
	leset(L4,4,N);
	leset(E,4,L4);
	return(sig);
    }

    return( lfirst(lfourth(lfourth(E))) );
}
