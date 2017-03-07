/*M
.SH NAME
ecqnflserfd - elliptic curve over quadratic number field, L-series, 
first derivative

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflserfd(E,num)
list   E;
single num;

.SH DESCRIPTION
ecqnflserfd() returns the value of the first derivative of the
L-series of E over a quadratic number field K.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B num
is the number of computed coefficients
M*/
/*H
        Version 1       13.09.1998      S. Schmitt
   DATE ecqnflserfd     :  980915
H*/




# include <_ec2.h>

extern single C[5500];

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c
		lsfdintf(x)

	"L-series first derivative integrand f"

	Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	ueber die Funktion f integriert werden. Hier wird f(x) zurueckgegeben,
	alles floatings. 
	Es ist
		f(x) = -Ei(-x)
		= -Eulersche_Konstante -log(x) 
		  - \sum_n=1^{\infty} (-x)^n/(n*n!)

c*/

static double lsfdintf(x)
double x;
{
	double y,gam,fn,nfaku;
	double mxhn,s;
	single kleiner;
	double test1,test2;

	if(x>46) return(0.0);

	gam = 0.57721;
	y = log(x);
	y = -y;
	y = y-gam;	/** -gamma - log(x) **/


	gam = exp(x);
	s = 10.0*10.0;
	fn = s*s;
	fn = fn*fn;
	fn = fn*s;
	gam = fn*gam; /** 10^10 * exp(x) **/

	fn = 0.0;
	nfaku = 1.0;
	mxhn = 1.0;
	x = -x;
	
	kleiner = 1;
	while(kleiner)
	{
		mxhn = x*mxhn;		/** (-x)^n **/
		fn = fn+1;		/** n **/
		nfaku = fn*nfaku;	/** n! **/
		test1 = fn*nfaku;	/** n*n! **/
		s = mxhn/test1;
		y = y-s;
	

		/** solange n*n! <= 10^10*exp(x)*x^n ist **/
		test2 = fabs(mxhn);
		test2 = test2*gam;
		if(test1>test2) kleiner = 0;
	}

	return(y);
}

/*c
		lsfdintF(x,am)

	"L-series first derivative integrand F"

	Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	ueber die Funktion F integriert werden. Hier wird F(x) zurueckgegeben,
	alles floatings. am ist 2*pi*A_{E,K}^{-1/4}*m^{1/2}.
	Es ist
		F(tau,am) = (f(cc)+exp(-cc))*1/(cc^2*x)
	mit cc = am*(1/x+x)
	mit der Funktion f aus lsfdintf().

c*/

static double lsfdintF(x,am)
double x,am;
{
	double y,cc;
        
	cc = 1/x;
	cc = x+cc;
	cc = am*cc;

	y = lsfdintf(cc);

	x = cc*x;
	x = cc*x;

	cc = -cc;
	cc = exp(cc);
	y = y+cc;
	y = y/x;

	return(y);
}

/*c                                                                             
                lsfdfunH(am)                                                    
                                                                                
        "L-series first derivative function H"
                                                                                
        Bei der Ableitung der L-Reihe muss die Funktion H berechnet 
	werden. Hier wird H(am) zurueckgegeben, alles floatings. 
        am ist 2*pi*A_{E,K}^{-1/4}m^{1/2}. 
        Es ist                                                                  
                H(am) = \int_0^1 F(x,am)dx mit F aus lsfdintF()
	das Integral wird mit dem Rombergverfahren berechnet.
                                                                                
c*/                                                                             
                                                                                
                                                                                
static double lsfdfunH(am)
double am;   
{       
	single i,k,n;
        double P[10];                               
        double h,s;       
        double ih,x,q;       
                                                  
        h = 1.0;                
        n = 1;            
        P[0] = lsfdintF(1.0,am); /** = f(0) + f(1), f(0 ) = 0 **/
        P[0] = P[0]*0.5;        /** P[0] * h/2 **/

	for(k=1;k<=9;k++)                                                       
        {                                                                       
                s = 0.0;                                                        
                n+=n;           /** 2^k **/                                     
                h = h*0.5;      /** 1/2^k **/                                   
                ih = h;         /** = 0+h */                                    
                for(i=1;i<n;i=i+2)                                              
                {
                        x = lsfdintF(ih,am);
                        s = s+x;
                        ih = ih+h;
                        ih = ih+h;      /** 0+h*i **/
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
                lsfdsum(Ae,k)                                                   
                                                                                
        "L-series first derivative, sum"
                                                                                
        Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	
	\sum_m=1^{\infty} c(m) H(m)

	mit der Funktion H aus lsfdfunH() berechnet werden.
        Ae ist 2*pi*A_{E,K}^{-1/4}. 
                                                                                
c*/                                       


static floating lsfdsum(Ae)                                                   
double Ae;                                                                  
{                                                                               
        single m,M;                                                             
        double c,h,G;                                                      
	floating res;
       
	init(res); 
                                                                                
        M = C[0];                                                               
        G = 0.0;
        for(m=1;m<=M;m++)                                                      
        {                                           
		if(C[m])
		{
			c = sqrt(m);
			c = Ae*c;
                	h = lsfdfunH(c);
                	h = C[m]*h;
                	G = G+h;
		}
if(!mshom(100,m)) printf("L'(1), m=%obj, G=%f \n",m,G);
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


floating ecqnflserfd(E,num)
list E;
single num;
{
	single s;
	list N;
	floating Ae,L,h;
	int d;
	double Aed,fltoCfl();

	init(N);
	init(Ae,L,h);
	init(d);
	bind(E);
	bind(C[0..num]);

	s = ecqnfsigns(E);
	if(s==1) return(itofl(0));

	d = ecqnfflddisc(E);
	/** Ae = 2*pi*A^{-1/4} mit                                       
            A = Norm(N_E) D^2, D = Diskriminante von K|Q. **/                   
                                                                                
        N = ecqnfpifcond(E);                                                    
        N = qnfabsnorm(d,N);                                                    
        Ae = rtofl(N);                                                          
        Ae = flsqrt(Ae);                                                        
        N = ecqnfflddisc(E);                                                    
	if(!ecqnfdmod4(E))      N = iprod(N,4);                                 
        if(isign(N)==(-1)) N = ineg(N);  
        Ae = flprod(Ae,itofl(N));                                               
        Ae = flsqrt(Ae);                                                        
        L = flPi();                                                            
        L = flsum(L,L);                                                      
        Ae = flquot(L,Ae);                                                     
	Aed = fltoCfl(Ae);

	L = lsfdsum(Aed);
	h = flabs(L);
	if(flcomp(h,Cfltofl(0.001))<0) return(itofl(0));

	Ae = flprod(Ae,Ae);	/** 4pi^2 A^{-1/2} **/
	Ae = flprod(Ae, itofl(16));
	L = flprod(L,Ae);
	return(L);
	
	



}	

