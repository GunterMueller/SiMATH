/*M
.SH NAME
ecqnflsers - elliptic curve over quadratic number field, L-series

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflsers(E,num)
list   E;
single num

.SH DESCRIPTION
ecqnflsers() returns the value of the L-series of E over a quadratic 
number field K.

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
   DATE ecqnflsers     :  980915
H*/




# include <_ec2.h>

extern single C[5500];

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c
		lsintf(x,Am)

	"L-series integrand f"

	Bei der Berechnung der L-Reihe an der Stelle 1 muss ueber die 
	Funktion f integriert werden. Hier wird f(x) zurueckgegeben,
	alles floatings. Am ist -2*pi*A_{E,K}^{-1/4}*m^{1/2}.
	Es ist
		f(x) = exp(Am(1/x+x)) *( 1/(-Am(1/x+x)) + 1)*1/(-Am(1/x+x)*1/x

c*/

static double lsintf(x,Am)
double x,Am;
{
	double y,z;
	
	y = 1/x;
	z = x+y;
	z = Am*z;	/** z = Am*(1/x+x) **/
	y = exp(z);
	z = -z;
	z = 1/z;
	y = y*z;	/** y = exp(z) * 1/z **/
	z = z+1;
	y = y*z;	/** y = exp(z) * (1/z + 1) * 1/z **/
	y = y/x;
	return(y);
}

/*c
		romblser(Am)
	"romberg at L-series"

	Berechnet
                \int_0^1 f(m,x)dx mit f aus lsintf()                      

	mit Romberg Verfahren
c*/

static double romblser(Am)
double Am;
{
        single i,k,n;
        double P[10];
        double h,s;
        double ih,x,q;

   	h = 1.0;                                                                
        n = 1;                                                                  
        P[0] = lsintf(1.0,Am); /** = f(0) + f(1), f(0 ) = 0 **/                
        P[0] = P[0]*0.5;        /** P[0] * h/2 **/                              
                                                                                
        for(k=1;k<=9;k++)
        {
                s = 0.0;
                n+=n;           /** 2^k **/
                h = h*0.5;      /** 1/2^k **/
                ih = h;         /** = 0+h */
                for(i=1;i<n;i=i+2)
                {
                        x = lsintf(ih,Am);
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
                lsfunh(Ae,m)                                                    
                                                                                
        "L-series function h"                                                   
                                                                                
        Bei der L-Reihe muss die Funktion h berechnet werden.                   
        Hier wird h(m) zurueckgegeben, alles floatings.                         
        Ae ist -2*pi*A_{E,K}^{-1/4}. 
        Es ist                                                                  
                h(m) = \int_0^1 f(m,x)dx mit f aus lsintf()                      
                                                                                
c*/                                                                             
                                                                                
                                                                                
static double lsfunh(Ae,m)                                                    
double Ae;
single m;                                                                  
{                                                                               
        double Am,h;                                                      
                                                                                
	Am = sqrt(m);
	Am = Ae*Am;

	h = romblser(Am);
	return(h);
}

/*c                                                                             
                lsintg(Ae)                                                   
                                                                                
        "L-series integral g"                                                       
                                                                                
        Bei der Berechnung der L-Reihe an der Stelle 1 muss das
	Integral ueber die Funktion g berechnet        
        werden. Hier wird 1/4 \int_1^\infty g(t) zurueckgegeben, 
	alles floatings.                 
	Es ist 
	\int_1^{\infty} g(t) dt = 4\sum_m=1^\infty C[m] h(m)
	mit h aus lsfunh().
        Ae ist -2*pi*A_{E,K}^{-1/4}. 
                                                                                
c*/                                       


static floating lsintg(Ae)                                                   
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
                	h = lsfunh(Ae,m);
                	h = C[m]*h;
                	G = G+h;
		}
if(!mshom(100,m)) printf(" L(1) m = %obj, G = %f \n",m,G);
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


floating ecqnflsers(E,num)
list E,num;
{
	single s;
	list N;
	floating Ae,L,h;
	int d;
	double Aed, fltoCfl();

	init(N,Ae,L,h,d);
	bind(E);	
	bind(C[0..num]);

	s = ecqnfsigns(E);
	if(s==(-1)) return(itofl(0));	

	d = ecqnfflddisc(E);
	/** Ae = -2*pi*A^{-1/4} mit                                       
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
        Ae = flneg(Ae);                                                         
	Aed = fltoCfl(Ae);	
	

	L = lsintg(Aed);
	h = flabs(L);
	if(flcomp(h,Cfltofl(0.001))<0) return(itofl(0));

	Ae = flprod(Ae,Ae);	/** 4pi^2 A^{-1/2} **/
	Ae = flprod(Ae, itofl(8));
	L = flprod(L,Ae);
	return(L);
	
	



}	

