/*M
.SH NAME
ecqnflserhd - elliptic curve over quadratic number field, L-series, 
higher derivative

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflserhd(E,k,num)
list   E;
single k,num;

.SH DESCRIPTION
ecqnflserhd() returns the value of the k-th derivative of the
L-series of E over a quadratic number field K.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B k
is a single precision number.
.TP 4
.B num
is the number of computed coefficients.
M*/
/*H
        Version 1       09.09.1998      S. Schmitt
   DATE ecqnflserhd     :  980915
H*/




# include <_ec2.h>

extern single C[5500];

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c
		lshdintf(x,Am)

	"L-series higher derivative integrand f"

	Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	ueber die Funktion f integriert werden. Hier wird f(x) zurueckgegeben,
	alles floatings. Am ist -2*pi*A_{E,K}^{-1/4}*m^{1/2}*\tau^{-1/2}.
	Es ist
		f(x) = exp(Am * (1/x+x)) * 1/x

c*/

static double lshdintf(x,Am)
double x,Am;
{
	double y;
	
	y = 1/x;
	y = y+x;
	y = Am*y;
	y = exp(y);
	y = y/x;
	return(y);
}


/*c
	romblshd(Am)
	" romberg higher derivative "

	Berechnet wird
                \int_0^1 f(x,Am)dx mit f aus lshdintf()

	mit dem Rombergverfahren.

c*/

static double romblshd(Am)
double Am;   
{                                                                               
	single i,k,n;                                                           
        double P[10];                                                           
        double h,s;                                                             
        double ih,x,q;                                                          
                                                                                
        h = 1.0;                                                                
        n = 1;                                                                  
        P[0] = lshdintf(1.0,Am); /** = f(0) + f(1), f(0 ) = 0 **/               
        P[0] = P[0]*0.5;        /** P[0] * h/2 **/                              
                                                                                
        for(k=1;k<=9;k++)                                                       
        {                                                                       
                s = 0.0;                                                        
                n+=n;           /** 2^k **/                                     
                h = h*0.5;      /** 1/2^k **/                                   
                ih = h;         /** = 0+h */                                    
                for(i=1;i<n;i=i+2)                                              
                {                                                               
                        x = lshdintf(ih,Am);  
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
                lshdfunF1(tau,am)                                                    
                                                                                
        "L-series higher derivative function F1"
                                                                                
        Bei der Ableitung der L-Reihe muss die Funktion h berechnet 
	werden. Hier wird F1(tau) zurueckgegeben, alles floatings. 
        am ist -2*pi*A_{E,K}^{-1/4}m^{1/2}. 
        Es ist                                                                  
                F1(tau) = \int_0^1 f(x,am * tau^{-1/2})dx mit f aus lshdintf()
                                                                                
c*/                                                                             
                                                                                
                                                                                
static double lshdfunF1(tau,am)
double tau,am;   
{                                                                               
        double Am,eps,F1;
                                                                                

	Am = sqrt(tau);
	Am = am/Am;
	
	F1 = romblshd(Am);
	return(F1);
}

/*c
		lshdintF(tau,am,k)

	"L-series higher derivative integrand F"

	Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	ueber die Funktion F integriert werden. Hier wird F(tau) zurueckgegeben,
	alles floatings. am ist -2*pi*A_{E,K}^{-1/4}*m^{1/2}.
	Es ist
		F(tau,am,k) = F1(tau,am)*(-log(tau))^k * tau^2
	mit der Funktion F1 aus lshdfunF1().

c*/

static double lshdintF(tau,am,k)
double tau,am;
single k;
{
	double y,z,zhk;
	
	y = lshdfunF1(tau,am);
	z = log(tau);
	z = -z;
	zhk = z;
	while(--k) zhk = zhk*z;	/** z^k **/
	y = y*zhk;
	y = y*tau;
	y = y*tau;
	return(y);
}

/*c                                                                             
                lshdfunH(am,k)                                                    
                                                                                
        "L-series higher derivative function H"
                                                                                
        Bei der Ableitung der L-Reihe muss die Funktion H berechnet 
	werden. Hier wird H(am,k) zurueckgegeben, alles floatings. 
        am ist -2*pi*A_{E,K}^{-1/4}m^{1/2}. 
        Es ist                                                                  
                H(am,k) = \int_0^1 F(tau,am,k)dtau mit F aus lshdintF()

	Das Integral wird mit dem Rombergverfahren berechnet
                                                                                
c*/                                                                             
                                                                                
                                                                                
static double lshdfunH(am,ke)
double am;   
single ke;
{                                                                               
	single i,k,n;                                                           
        double P[10];                                                           
        double h,s;                                                             
        double ih,x,q;                                                          
                                                                                
        h = 1.0;                                                                
        n = 1;                                                                  
        P[0] = lshdintF(1.0,am,ke); /** = f(0) + f(1), f(0 ) = 0 **/               
        P[0] = P[0]*0.5;        /** P[0] * h/2 **/                              
                                                                                
        for(k=1;k<=9;k++)                                                       
        {                                                                       
                s = 0.0;                                                        
                n+=n;           /** 2^k **/                                     
                h = h*0.5;      /** 1/2^k **/                                   
                ih = h;         /** = 0+h */                                    
                for(i=1;i<n;i=i+2)                                              
                {                                                               
                        x = lshdintF(ih,am,ke);  
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
                lshdsum(Ae,k)                                                   
                                                                                
        "L-series higher derivative, sum"
                                                                                
        Bei der Berechnung der Ableitung der L-Reihe an der Stelle 1 muss 
	
	\sum_m=1^{\infty} c(m) H(m)

	mit der Funktion H aus lshdfunH() berechnet werden.
        Ae ist -2*pi*A_{E,K}^{-1/4}. 
                                                                                
c*/                                       


static floating lshdsum(Ae,k)                                                   
double Ae;                                                                  
single k;
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
                	h = lshdfunH(c,k);
                	h = C[m]*h;
                	G = G+h;
		}
if(!mshom(100,m)) printf("L(%obj)(1): m = %obj, G = %f \n",k,m,G);
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


floating ecqnflserhd(E,k,num)
list E;
single k,num;
{
	single s;
	list N;
	floating Ae,L,h;
	int d;
	double Aed,fltoCfl();

	init(N,Ae,L,h,d);
	bind(E);
	bind(C[0..num]);

	s = ecqnfsigns(E);
	if((s==(-1) && !mihom(2,k)) || (s==1 && mihom(2,k))) return(itofl(0));	

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

	L = lshdsum(Aed,k);
	h = flabs(L);
	if(flcomp(h,Cfltofl(0.001))<0) return(itofl(0));

	Ae = flprod(Ae,Ae);	/** 4pi^2 A^{-1/2} **/
	Ae = flprod(Ae, itofl(4));
	L = flprod(L,Ae);
	return(L);
	
	



}	

