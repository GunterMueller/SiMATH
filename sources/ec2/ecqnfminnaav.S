/*M
.SH NAME 
ecqnfminnaav - elliptic curve over quadratic number field minimal equation at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecqnfminnaav(D, E, P, pi, z)
int    D;
list   E, P;
nfel pi;
single z;

.SH DESCRIPTION
ecqnfminnaav() returns the minimal equation of an elliptic curve E over a quadratic number field K = Q(D^(1/2)) with respect to a non archimedean absolute value.
.TP 3 
ecqnfminnaav() returns:
L = ( a1m, a2m, a3m, a4m, a6m ), where a1m, a2m, a3m, a4m and a6m are the minimal Weierstrass coefficients with respect to the given non archimedean absolute value.
.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi 
is a prime element of the prime ideal P.
.TP 4
.B z
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime
number in Q.
M*/
/*H
        Version 1       31.07.1998      S. Schmitt
   DATE ecqnfminnaav     :  980731
H*/

#include<_ec2.h>

static list ecqnfieltv( D, LC )
int  D;
list LC;
{
    nfel a1, a2, a3, a4, a6, b2, b4, b6, b8, c4, c6, DE, h;
                                                                                
    bind( D, LC );                                                              
    init( a1, a2, a3, a4, a6, b2, b4, b6, b8, c4, c6, DE, h );                  
                                                                                
    a1 = lfirst ( LC );                                                         
    a2 = lsecond( LC );                                                         
    a3 = lthird ( LC );                                                         
    a4 = lfourth( LC );                                                         
    a6 = lfifth ( LC );                                                         
                                                                                
    b2 = qnfsquare( D, a1 );                                                    
    h  = qnfiprod( D, a2, 4 );                                                 
    b2 = qnfsum   ( D, b2, h );               
                                                                                
    b4 = qnfprod ( D, a1, a3 );                                                 
    h  = qnfiprod( D, a4,  2 );                                                 
    b4 = qnfsum  ( D, b4,  h );                                                 
                                                                                
    b6 = qnfsquare( D, a3 );                                                    
    h  = qnfiprod ( D, a6, 4 );                                                 
    b6 = qnfsum   ( D, b6, h );                                                 
                                                                                
    b8 = qnfsquare( D, a1 );                                                    
    b8 = qnfprod  ( D, b8, a6 );                                                
    h  = qnfprod  ( D, a1, a3 );                                                
    h  = qnfprod  ( D,  h, a4 );                                                
    b8 = qnfdif   ( D, b8,  h );                                                
    h  = qnfprod  ( D, a2, a6 );                                                
    h  = qnfiprod ( D,  h,  4 );                                                
    b8 = qnfsum   ( D, b8,  h );                                                
    h  = qnfsquare( D, a3 );                                                    
    h  = qnfprod  ( D,  h, a2 );                                                
    b8 = qnfsum   ( D, b8,  h );                                                
    h  = qnfsquare( D, a4 );                                                    
    b8 = qnfdif   ( D, b8,  h );                                                
                                                                                
    c4 = qnfiprod ( D, b4, 24 );                                                
    h  = qnfsquare( D, b2 );                                                    
    c4 = qnfdif   ( D, h, c4 );                                                 
                                    
    c6 = qnfiprod ( D, b4,  36 );                                               
    h  = qnfsquare( D, b2 );                                                    
    c6 = qnfdif   ( D, c6,   h );                                               
    c6 = qnfprod  ( D, c6,  b2 );                                               
    h  = qnfiprod ( D, b6, 216 );                                               
    c6 = qnfdif   ( D, c6,   h );                                               
                                                                                
    DE = qnfiprod ( D, b4,  9 );                                                
    DE = qnfprod  ( D, b6, DE );                                                
    h  = qnfprod  ( D, b2, b8 );                                                
    DE = qnfdif   ( D, DE,  h );                                                
    DE = qnfprod  ( D, DE, b2 );                                                
    h  = qnfsquare( D, b6 );                                                    
    h  = qnfiprod ( D,  h, 27 );                                                
    DE = qnfdif   ( D, DE,  h );                                                
    h  = qnfexp   ( D, b4,  3 );                                                
    h  = qnfiprod ( D,  h,  8 );                                                
    DE = qnfdif   ( D, DE,  h );                                                
                                                                                
    return( list2( list6( b2, b4, b6, b8, c4, c6 ), DE ) );                     
}

list ecqnfmin23(E,P,pi,z)
list E,P;                                                                       
nfel pi;                                                                        
single z;                                                                       
{                                                                               
        int n,d;                                                                
        list L,LC,LTV;                                                          
        single h;                                                               
                                                                                
        bind(E,P,pi);                                                           
        init(n,d);                                                              
        init(L,LC,LTV);                                                         
                                                                                
        LC = ecqnfacpifdi(E);                                                   
        n = 0;                                                                  
        if(lfirst(LC)!=1)                                                       
        {                                                                       
                while(LC!=_0)                                                   
                {                                                               
                        L = lfirst(LC);                                         
                        if(oequal(L,P))
                        {                                                       
                                n = lsecond(LC);                                
                                break;                                          
                        }                                                       
                        LC = lred4(LC);                                         
                }                                                               
        }                                                                       
	if(!n) 
	{
		L = lfirst(lfirst(E));
		return(L);
	}

        d = ecqnfflddisc(E);                                                    
        LC = ecqnftoeci(d,lfirst(lfirst(E)));                                   
        L = ecqnfieltv(d,LC);                                                   
        LTV = lfirst(L);                                                        
                                                                                
        L = ecqnftatealg(d,LC,LTV,P,pi,z,n);  
        h = llength(L);                                                         
	if(h!=5)
	{
		L = lfirst(lfirst(E));
		return(L);
	}
        else
        {                                                                       
                list L1,LC1,LTV1,FD1;                                           
                init(L1,LC1,LTV1,FD1);                                          
                                 
                while(h==5)                                                     
                {                                                               
                        LC1 = ecqnftoeci(d,L);                                  
                        L1 = ecqnfieltv(d,LC1);                                 
                        LTV1 = lfirst(L1);                                      
                        FD1 = lsecond(L1);                                      
                        FD1 = qnfpifact(d,FD1);                                 
			n = 0;
                        while(FD1!=_0)                                          
                        {                                                       
                                L1 = lfirst(FD1);                               
                                if(oequal(L1,P))                                       
                                {                                               
                                        n = lsecond(FD1);                       
                                        break;                                  
                                }                                               
                                FD1 = lred4(FD1);                               
                        }                                                       
			if(!n) return(L);
                        L1 = ecqnftatealg(d,LC1,LTV1,P,pi,z,n);                 
                        h = llength(L1);                                        
                        if(h==5) L = L1;                                        
                }                                                               
        }                                                       
	return(L);
}

                                                                               











list  ecqnfminnaav(D,E,P,pi,z)
int	D;
list 	E,P;
nfel pi;
single z;
{	
	nfel	h,u,a1,a2,a3,a4,a6;
	single	f,g,p;
	list	L;

	init(h,u,a1,a2,a3,a4,a6,L);

	bind(D,E,P,pi);

	p = qnfidprime(P,pi,z);
	if(p==2 || p==3)
	{
		L = ecqnfmin23(E,P,pi,z);
		return(L);
	}

	L = lfirst(lfirst(E));
	L = ecqnftoeci(D,L);	/** Koeffizienten im Ganzheitsring **/
	a1 = lfirst(L);
	a2 = lsecond(L);
	a3 = lthird(L);
	a4 = lfourth(L);
	a6 = lfifth(L);

	f = -1;
	if(a1) f = qnfpiord(D,P,pi,z,a1);
	if(f && a2)
	{
		g = qnfpiord(D,P,pi,z,a2);
		g = iquot(g,2);
		if(f>0) f = smin(f,g);
		else f=g;
	}
	if(f && a3)
	{
		g = qnfpiord(D,P,pi,z,a3);
		g = iquot(g,3);
		if(f>0) f = smin(f,g);
		else f=g;
	}
	if(f && a4)
	{
		g = qnfpiord(D,P,pi,z,a4);
		g = iquot(g,4);
		if(f>0) f = smin(f,g);
		else f=g;
	}
	if(f && a6)
	{
		g = qnfpiord(D,P,pi,z,a6);
		g = iquot(g,6);
		if(f>0) f = smin(f,g);
		else f=g;
	}

	if(f)
	{
		u  = qnfexp(D,pi,f);
		a1 = qnfquot(D,a1,u);
		h  = qnfprod(D,u,u);
		a2 = qnfquot(D,a2,h);
		h  = qnfprod(D,h,u);
		a3 = qnfquot(D,a3,h);
		h  = qnfprod(D,h,u);
		a4 = qnfquot(D,a4,h);
		h  = qnfprod(D,h,u);
		h  = qnfprod(D,h,u);
		a6 = qnfquot(D,a6,h);
		L  = list5(a1,a2,a3,a4,a6);
	}
	return(L);
}
	
