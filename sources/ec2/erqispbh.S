/*M
.SH NAME
erqispbh - elliptic curve with integral coefficients over real quadratic number
field, short normal form, search points with bounded height 

.SH SYNOPSIS
.nf
#include<_ec2.h>

list erqispbh(D,E,A)
int D;
list E;
floating A;

.SH DESCRIPTION
erqispbh() returns the list L=(P1,...,Pn) with all points of E(K) with
Weil-height less or equal to A.

.PP
.TP 4
.B D
is a positive squarefree integer not equal to 1.
.TP 4
.B E
is a list containing the data of an elliptic curve E/K over a quadratic number
field (see `ecqnfinit').
.TP 4
.B A
is a positive floating point number.

M*/
/*H
	Version 1       07.10.1998      S. Schmitt
   DATE erqispbh    : 981015
H*/

#include <_ec2.h> 

/**************************************************************************/ 
/***                 s t a t i c   f u n c t i o n s                    ***/ 
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c                                                                             
                qnftoflflh(A,sd,a,ac)  
                                                 
        " quadratic number field element to two doubles                    
                         
        A ist eine Element aus K=Q(sqrt(d)), sd = sqrt(d) als
        doubles. a ist A als double,
        ac ist die Konjugierte von A als double.
                                   
c*/                                
                                                                                
static single qnftoflflh(A,sd,a,ac)
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
                iitodqu(a,b)                                                 
        " two integers to double and quad "                                     
        a,b sind zwei integers. a*b = km^2, es wird   
        k*m/2 als double zurueckgegeben.  
c*/                     

static double iitodqu(a,b)                                                   
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
        dk2m2(km,x0)                                                          
                                               
        double k2m2                                                            
                                                                           
        gibt km*x0^2 als double zurueck                 
   
c*/                                                                            
                              
static double dk2m2(km,x0)
double km,x0;
{
        double k;                                   
         
        k = x0*x0;  
        k = k*km;    
                           
        return(k);        
}

/*c
                deqisnf(d, x, a4, a6, a4c,a6c, ym, yc, ycm)
        "double elliptic curve equation"
                                                                               
        deqisnf() gibt yp = x^3+a4*x+a6 (als double) zurueck.
        und ym = -x^3-a4*x+a6 und yc = x^3+a4cx+a6c und 
	ycm = -x^3-a4cx+a6.
c*/
                                                                               
static double deqisnf(x,a4,a6,a4c,a6c,ym,yc,ycm)
double x,a4,a6,a4c,a6c,*ym,*yc,*ycm;
{
        double z,zc;
                                                                               
        z  = x * x;
	zc = z + a4c;
        z  = z + a4;
        z  = z * x;	/** x^3+a4*x **/
        zc = zc * x;	/** x^3+a4c*x **/
        (*ym) = a6-z;                                                          
	(*ycm) = a6c-zc;
	(*yc) = a6c+zc;
        z = a6+z;                                                              
                                                                               
        return(z);                                                             
                                                                               
}                    


/*c                                                                            
                ispih(f)                                                   
                                                                               
        "is possible integer "                                                 
                                                                               
c*/                                                                            
                                                                               
static single ispih( f )                                                   
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
        ispprqnfeqh(sd,x,a4,a6,a4c,a6c,k2m2)                                 
                                                                               
        is possible point of elliptic curve over real quadratic number         
        field with integral coefficients, short normal form?                   
                                                                               
double sd,x,a4,a6,a4c,a6c,k2m2;                                             
ispprqnfeq() tests, if it is possible that there is a y, such that (x,y) or    
(-x,y) is a point of E: y^2 = x^3 + a4x + a6. If this is true, isppiqnfeq()    
returns 1, else, isppiqnfeq() returns 0.                                       
sd is a double point representation of sqrt(d), where d is a a squarefree      
integer not equal to 0 and 1.                                                  
x,a4,a6,a4c,a6c are double numbers with fc = the conjugate element    
of f in the number field K, represented as double point numbers.               
k2m2 = sqrt(k^2*m^2), da hier sowieso die Wurzel gezogen wird               
x ist double einer rationalen Zahl, also in Q.
c*/                                                                         
                                                                            
static single ispprqnfeqh(sd,x,a4,a6,a4c,a6c,k2m2)                        
double sd,x,a4,a6,a4c,a6c,k2m2;                                             
{                                            
	double al1,al2,bet1,bet2;                   
        double al1m,al2m;                                                      
                                                   
        al1 = deqisnf(x,a4,a6,a4c,a6c,&al1m,&al2,&al2m);       

        if((al1==0 && al2==0) || (al1m==0 && al2m==0)) return(1); 
                                                                 
        if(al1>0 && al2>0)  /** kann Quadrat sein **/           
        {                                                    
                al1 = sqrt(al1);                            
                al1 = al1*k2m2;                            
                al2 = sqrt(al2);                          
                al2 = al2*k2m2;                          
                                                        
                bet1 = al1+al2;                        
                al1 = al1-al2;                        
                if(ispih(bet1))                      
                {                                                       
                        bet2 = al1/sd;                                 
                        if(ispih(bet2)) return(1);                    
                }                                                   
                if(ispih(al1))   
                {               
                        bet2 = bet1/sd;
                        if(ispih(bet2)) return(1);  
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
                if(ispih(bet1))
                {
                        bet2 = al1/sd;
                        if(ispih(bet2)) return(1);
                }
                if(ispih(al1))
                {
                        bet2 = bet1/sd;
                        if(ispih(bet2)) return(1);
                }
        }
        return(0);
}

/*c
                nfecsph( x1, a1, a2, b1, b2, y1, y2)
        "number field elliptic curve"
                                                                               
        nfec() testet, ob rationale y1 und y2 existieren mit
        y1+sqrt(d)y2=                                                          
                x1^3+(a1+sqrt(d)a2)x1+(b1+sqrt(d)b2)   
        und gibt diese gegebenenfalls zurueck.                                 
c*/                                                                            
                                                                               
static single nfecsph(x1,a1,a2,b1,b2,y1,y2)                                
rat x1,a1,a2,b1,b2,*y1,*y2;                                                 
{                                                                              
        bind(x1,a1,a2,b1,b2,*y1,*y2);                                     
                                                                               

	(*y1) = rprod(x1,x1);               	/** x1^2 **/   
	(*y1) = rsum((*y1),a1);			/** x1^2+a1 **/
        (*y1) = rprod((*y1),x1);                /** x1^3+a1x1 **/
	(*y1) = rsum((*y1),b1);			/** x1^3+a1x1+b1 **/
	
	(*y2) = rprod(x1,a2);			/** a2x1 **/
	(*y2) = rsum((*y2),b2);			/** a2x1+b2 **/

        return(0);
}





                                                

/*c
		ispeqsp(d,a41,a42,a61,a62,x,Y)

	is point of elliptic curve?

	Testet, ob x^3+A4x+A6 = Y^2 ist und gibt ggf. Y zurueck.
	A4 = a41+ sqrt(d) * a42. A6 analog.

c*/

static ispeqsp(d,a41,a42,a61,a62,x,Y)
int d;
rat a41,a42,a61,a62,x;
nfel *Y;
{
	rat y1,y2,z1,z2;                                                       
                                                                               
        init(y1,y2,z1,z2);
	bind(d,a41,a42,a61,a62,x,*Y);

	nfecsph(x,a41,a42,a61,a62,&z1,&z2);                                   
        if(isqnfelsqu(d,z1,z2,&y1,&y2))                                        
        {                                                                      
                (*Y) = rrtoqnf(d,y1,y2);                                       
                return(1);                                                     
        }                                                                      
        return(0);                                                             
}                         




/*c                                                                            
                ispkth(d,x0,x1,a41,a42,a61,a62,P)                            
                                                                               
        is point                                                               
                                                                               
        Testet, ob x=x1/x0 die x=Koordinate eines                 
        Punktes von E ist.                                                     
                                                                               
c*/                                                                            
                                                                               
static single ispkth(d,x0,x1,a41,a42,a61,a62,P)                              
int d,x0,x1;                                                                
rat a41,a42,a61,a62;                                                           
list *P;                                                                       
{                                                                              
        rat r1;                                                             
        nfel X,Y;                                                              
                                                                               
        init(r1,X,Y);                                                       
        bind(d,x0,x1,a41,a42,a61,a62,*P);                                   
                                                                               
        r1 = rcons(x1,x0);                                                     
        if(ispeqsp(d,a41,a42,a61,a62,r1,&Y))                            
        {                                                                      
                X = rtonf(r1);                                          
                (*P) = list3(X,Y,itonf(1));                                    
                return(1);                                                     
        }                                                                      
        return(0);                                                             
}                       






/*c
		eqisnfspbhQ(E,A)

	" elliptic curve over quadratic number field, short normal form,
	search points with bounded height with x in Q"

c*/

list eqisnfspbhQ(D,A4,A6,A)
int D;
nfel A4,A6;
floating A;
{
	list L,P;
	double x0,x1,G,H, fltoCfl();
	floating h,k;
	double sd,x,km,k2m2,xh;
	double a4r,a4c,a6r,a6c;
	rat a41,a42,a61,a62;
	int xi0,xi1;

	init(L,P);
	init(h,k);
	init(a41,a42,a61,a62);
	init(xi0,xi1);
	bind(D,A4,A6,A);

	G = fltoCfl(A);
	G = exp(G);
/**
printf(" G = %f \n",G);
**/

	h = itofl(D);
	sd = fltoCfl(h);
	sd = sqrt(sd);
	qnftoflflh(A4,sd,&a4r,&a4c);
	qnftoflflh(A6,sd,&a6r,&a6c);
	qnftorrn(A4,&a41,&a42,&xi0);
	qnftorrn(A6,&a61,&a62,&xi0);

	if(A4) xi0 = lfirst(A4);   
        else xi0 = 1;              
        if(A6) xi1 = lfirst(A6);  
        else xi1 = 1;            
        km = iitodqu(xi0,xi1);
	

	L = _0;
	x0 = 1;
	while(x0<=G)
	{
/**
printf("x0 = %f \n",x0);
**/


		k2m2 = dk2m2(km,x0);

		x1 = 0;
		while(x1<=G)
		{
			x = x1/x0;

			/** test x1/x0 und -x1/x0 **/

			if(ispprqnfeqh(sd,x,a4r,a6r,a4c,a6c,k2m2))
			{
				x = x0+0.1;
				xh = x1+0.1;
				k = Cfltofl(x);
				h = Cfltofl(xh);
				xi0 = flfloor(k);
				xi1 = flfloor(h);
/**
printf("Moeglich \n");
**/
				if(ispkth(D,xi0,xi1,a41,a42,a61,a62,&P))
				{
/**
printf(" Punkt %obj \n",P);
**/
					if(!islelt(L,P)) L = lcomp(P,L);

				}
			}
			x1 = x1+1;
		}
		x0 = x0+1;
	}
	return(L);
}

/*c
		ispolgood(D,sd,tes,wf,w)

	"is polynomial good"

	Testet, ob b1^2-4b0b2 kein Quadrat in Q, aber eins
	in K ist. Wenn ja, dann ist w^2 = wf^2(als double)
	= b1^2-4b0b2.
c*/

static single ispolgood(D,sd,tes,wf,w)
int D;
double sd,tes,*wf;		/** tes = b1^2-4*b0*b2 **/
int *w;
{
	floating fb;
	int ib;
	double t;

	init(fb,ib); 
	bind(D,*w);

			/** tes ist nach Konstruktion >=0 **/
	(*wf) = sqrt(tes);	/** sqrt(b1^2-4b0b2) als double **/

	tes = tes+0.1;
	fb = Cfltofl(tes);
	ib = flfloor(fb);	/** ib = b1^2-4b0b2 **/


	/** falls es integer ist -> return(0) **/
	if(ispih(*wf) && isisqr(ib)==1) return(0); 

	t = (*wf)/sd;
	if(!ispih(t)) return(0);

	if(mihom(D,ib)) return(0);	/** ib ist nicht durch D tb **/
	ib = iquot(ib,D);
	if(isisqr(ib)!=1) return(0);	/** ib/d soll Quadrat sein **/
	(*w) = isqrt(ib);
	return(1);
}

/*c
		elemout(b0,b1,wf,km,x,xc,km2)
	
	"elements out "

	berechnet
		x = -(b1+wf)/2b0
		xc = -(b1-wf)/2b0
		km2 = km*4*b0^2
c*/

static single elemout(b0,b1,wf,km,x,xc,km2)
double b0,b1,wf,km,*x,*xc,*km2;
{
	b0 = b0+b0;
	(*x) = b1+wf;
	(*x) = -(*x);
	(*xc) = wf-b1;
	(*x) = (*x)/b0;
	(*xc)= (*xc)/b0;
	(*km2) = km*b0;
	(*km2) = (*km2)*b0;
	
	return(1);
}

/*c                                                                             
                ddeqisnf(d, x, a4, a6, ym)                                      
        "double elliptic curve equation"                                        
                                                                                
        ddeqisnf() gibt yp = x^3+a4*x+a6 (als double) zurueck.                  
        und ym = -x^3-a4*x+a6                                                   
c*/                                                                             
                                                                                
static double ddeqisnf(x,a4,a6,ym)                                              
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
        isppreq(sd,x,a4,a6,xc,a4c,a6c,k2m2)   
        is possible point of elliptic curve over real quadratic number  
        field with integral coefficients, short normal form?           
c*/                                                                             
static single isppreq(sd,x,a4,a6,xc,a4c,a6c,k2m2)                            
double sd,x,a4,a6,xc,a4c,a6c,k2m2;   
{                                   
        double al1,al2,bet1,bet2;  
        double al1m,al2m;         
                                 
        al1 = ddeqisnf(x,a4,a6,&al1m);   
        al2 = ddeqisnf(xc,a4c,a6c,&al2m);
                                         
        if((al1==0 && al2==0) || (al1m==0 && al2m==0)) return(1);     
                                                                     
        if(al1>0 && al2>0)  /** kann Quadrat sein **/               
        {                                                          
                al1 = sqrt(al1);  
                al1 = al1*k2m2;  
                al2 = sqrt(al2);
                al2 = al2*k2m2;

                bet1 = al1+al2;         
                al1 = al1-al2;         
                if(ispih(bet1))       
                {                    
                        bet2 = al1/sd;         
                        if(ispih(bet2)) return(1);                          
                }                            
                                              
                if(ispih(al1))                                              
                {                           
                        bet2 = bet1/sd;    
                        if(ispih(bet2)) return(1);                          
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
                if(ispih(bet1))                                             
                {                  
                        bet2 = al1/sd;             
                        if(ispih(bet2)) return(1);                          
                }                                 
                                                 
                if(ispih(al1))                  
                {                              
                        bet2 = bet1/sd;       
                        if(ispih(bet2)) return(1);                          
                }                            
        }                                     
        return(0);    
}  

/*c
		elemout2(b0,b1,w,r1,r2)

	" element out 2"

	gibt zurueck:
		-b1/2b0, w/2b0

c*/

static single elemout2(b0,b1,w,r1,r2)
double b0,b1;
int w;
rat *r1,*r2;
{
	floating fb;
	int ib0,ib1;
	
	init(fb,ib0,ib1);
	bind(w,*r1,*r2);

	b0 = b0+0.1;
	b1 = b1+0.1;
	fb = Cfltofl(b0);
	ib0 = flfloor(fb);
	fb = Cfltofl(b1);
	ib1 = flfloor(fb);

	ib0 = isum(ib0,ib0);
	ib1 = ineg(ib1);
	(*r1) = rcons(ib1,ib0);
	(*r2) = rcons(w,ib0);
	return(1);
}

/*c
                ispktd(d,r1,r2,a41,a42,a61,a62,P)
     
        is point
                                                      
        Testet, ob x=(r1+sqrt(d)*r2) die x=Koordinate eines
        Punktes von E ist.
                                                                              
c*/                     
     
static single ispktd(d,r1,r2,a41,a42,a61,a62,P)
int d;
rat r1,r2,a41,a42,a61,a62;
list *P;
{  
        nfel X,Y;                                 
                            
        init(X,Y);
        bind(d,r1,r2,a41,a42,a61,a62,*P);

        if(ispeqisnfsp(d,a41,a42,a61,a62,r1,r2,&Y))
        {
                X = rrtoqnf(d,r1,r2);
                (*P) = list3(X,Y,itonf(1));
                return(1);
        }
        return(0);
}


/*c
		ispppolgoo(D,sd,tes,b0,b1,b2,km,a4r,a4c,a6r,a6c,w)

	testet, ob ispolgoo() ist, und dann, ob isppreq() gut ist.

c*/

static single ispppolgoo(D,sd,tes,b0,b1,km,a4r,a4c,a6r,a6c,w)
int D;
double sd,tes,b0,b1,km,a4r,a4c,a6r,a6c;
int *w;
{
	double wf,km2,x,xc;

	bind(D,*w);

	if(ispolgood(D,sd,tes,&wf,w))
	{

		elemout(b0,b1,wf,km,&x,&xc,&km2);
		
		if(isppreq(sd,x,a4r,a6r,xc,a4c,a6c,km2)
			|| isppreq(sd,x,a4c,a6c,xc,a4r,a6r,km2)) return(1);
		

	}
	return(0);
}

/*c
		gente(D,b0,b1,w,a41,a42,a61,a62,&H)

	testet, ob die Elemente Punkte sind

c*/

static single gente(D,b0,b1,w,a41,a42,a61,a62,H)
int D;
double b0,b1;
int w;
rat a41,a42,a61,a62;
list *H;
{
	rat r1,r2;
	list P;

	init(r1,r2,P);
	bind(D,w,a41,a42,a61,a62,*H);

	(*H) = _0;

	elemout2(b0,b1,w,&r1,&r2);
	if(ispktd(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r2 = rneg(r2);
	if(ispktd(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r1 = rneg(r1);
	if(ispktd(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r2 = rneg(r2);
	if(ispktd(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}

	if((*H)!=_0) return(1);
	return(0);
}




                                                          
/*c
		eqisnfspbK(E,A)

	" elliptic curve over quadratic number field, short normal form,
	search points with bounded height with x in K"

	x in K \ Q

c*/

/***************

	NEUE VERSION: DIREKTE SUCHE, keine verschraenkte Suche 

********************/

list eqisnfspbhK(D,A4,A6,A)
int D;
nfel A4,A6;
floating A;
{

	list L,P,K;
	double b0,b1,b2,G,fltoCfl();
	floating h;
	double sd,km,M,Gi,vb0,b1q,tes;
	double a4r,a4c,a6r,a6c;
	rat a41,a42,a61,a62;
	int w;

	init(L,P,K);
	init(h);
	init(a41,a42,a61,a62);
	init(w);
	bind(D,A4,A6,A);

	G = fltoCfl(A);
	G = G+G;
	G = exp(G);
	G = G+G;
/**
printf("und jetzt G = %f \n",G);
**/
	
	Gi = floor(G);

	h = itofl(D);
	sd = fltoCfl(h);
	sd = sqrt(sd);
	qnftoflflh(A4,sd,&a4r,&a4c);
	qnftoflflh(A6,sd,&a6r,&a6c);
	qnftorrn(A4,&a41,&a42,&P);
	qnftorrn(A6,&a61,&a62,&P);

	if(A4) P = lfirst(A4);   
        else P = 1;              
        if(A6) L = lfirst(A6);  
        else L = 1;            
        km = iitodqu(P,L);
	

	L = _0;
	b0 = 1;
	vb0 = 4;
	while(b0<=G)
	{
/**
printf("b0 = %f \n",b0);
**/

		b1 = 0;
		b1q = 0;
		while(b1<=G)
		{
			M = b1q/vb0;
			if(M>Gi) M=Gi;
			b2 = -Gi;
			tes = vb0*b2;
			tes = b1q-tes;	/** b1^2 - 4b0b2 **/
			while(b2<=M)	
			{
				if(ispppolgoo(D,sd,tes,b0,b1,km,a4r,a4c,a6r,a6c,&w))
				{
/**
printf("moeglich \n");
**/
				   if(gente(D,b0,b1,w,a41,a42,a61,a62,&K))
				   {
				   	while(K!=_0)
					{
					   P = lfirst(K);
					   K = lred(K);
					   if(!islelt(L,P)) 
					   {
						L = lcomp(P,L);
/**
printf(" b1 = %f \n",b1);
printf(" L = %obj \n",L);
**/
					   }
					}
				   }
				}

				b2 = b2+1.0;
				tes = tes - vb0;	/** b1^2 - 4b0b2 **/
			}
		
			b1q = b1q + b1;	
			b1 = b1+1.0;
			b1q = b1q + b1;
		}
		b0 = b0 + 1.0;
		vb0 = vb0 + 4.0;
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
                                               
list erqispbh( D,E,A )
int D;
list E;
floating A;
{
	list LQ,LK,P;
	nfel A4,A6;

	init(LQ,LK,P);
	init(A4,A6);
	bind(D,E,A);

	A4 = eqisnfa4(E);
	A6 = eqisnfa6(E);

	LQ = eqisnfspbhQ(D,A4,A6,A);
	LK = eqisnfspbhK(D,A4,A6,A);
	while(LQ!=_0)
	{
		P = lfirst(LQ);
		LQ = lred(LQ);
		LK = lcomp(P,LK);
	}
	return(LK);
}
