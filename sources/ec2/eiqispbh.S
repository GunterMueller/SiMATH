/*M
.SH NAME
eiqispbh - elliptic curve with integral coefficients over imaginary quadratic 
number field, short normal form, search points with bounded height

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eiqispbh(D,E,A)
int D;
list E;
floating A;

.SH DESCRIPTION
eiqispbh() returns the list L=(P1,...,Pn) with all points of E(K) with
Weil-height less or equal to A.

.PP
.TP 4
.B D
is a negative squarefree integer.
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
   DATE eiqispbh    : 981015
H*/

#include <_ec2.h> 


/**************************************************************************/ 
/***                 s t a t i c   f u n c t i o n s                    ***/ 
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c                                                                             
                qnftoflflc(A,sd,a,ac)  
                                                 
        " quadratic number field element to two doubles                    
                         
        A ist eine Element aus K=Q(sqrt(d)), sd = sqrt(-d), d<0 als
        doubles. a ist der Realteil von A als double,
        ac ist der Imaginaerteil von A als double.
                                   
c*/                                
                                                                                
static single qnftoflflc(A,sd,ar,ai)
nfel A;             
double sd,*ar,*ai;              
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
                iitodquc(a,b)                                                 
        " two integers to double and quad "                                     
        a,b sind zwei integers. a*b = km^2, es wird   
        k*m/2 als double zurueckgegeben.  
c*/                     

static double iitodquc(a,b)                                                   
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
        dk2m2c(km,x0)                                                          
                                               
        double k2m2                                                            
                                                                           
        gibt km*x0^2 als double zurueck                 
   
c*/                                                                            
                              
static double dk2m2c(km,x0)
double km,x0;
{
        double k;                                   
         
        k = x0*x0;  
        k = k*km;    
                           
        return(k);        
}

/*c
                deqisnfc(d, x, a4, a6, a4c,a6c, ym, yc, ycm)
        "double elliptic curve equation"
                                                                               
        deqisnfc() gibt yp = x^3+a4*x+a6 (als double) zurueck.
        und ym = -x^3-a4*x+a6 und yc = x^3+a4cx+a6c und 
	ycm = -x^3-a4cx+a6.
c*/
                                                                               
static single deqisnfc(x,a4,a6,a4c,a6c,yr,yi,ymr,ymi)
double x,a4,a6,a4c,a6c,*yr,*yi,*ymr,*ymi;
{
        double z;
                                                                               
        z = x * x;
        z = z + a4;
        z = z * x;	/** x^3+a4*x **/
	(*yr) = z + a6;	/** x^3+a4x+a6 **/
	(*ymr) = a6-z;

	z = a4c*x;	
	(*yi) = z + a6c;
	(*ymi) = a6c-z;
	
        return(1);                                                             
                                                                               
}                    


/*c                                                                             
                cflsqrtc(a,b,c,d)   
        "complex sqrt as doubles"                                               
                                                                                
        berechnet (c+i*d) = sqrt(a+i*b)                                         
                                                                                
                a = c^2-d^2                                                     
                b = 2cd                                                         
c*/                                                                             
                                                                                
static single cflsqrtc(a,b,c,d)                     
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
                h = h*0.5;      /** 1/2(-a+sqrt(a^2+b^2) **/                    
                (*d) = sqrt(h);                                                 
                h = (*d)+(*d);                                                  
                (*c) = b/h;     /** b/2d **/                                    
                return(1);                                                      
        }                                                                       
}                                                                               
        


                                                                                
/*c                                                                             
        isposintic(f)                    
                                                                                
        "is possible integer"                                                   
                                                                                
c*/                                                                             
                                                                                
static single isposintic( f )   
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
        ispprqnfeqhc(sd,x,a4r,a6r,a4c,a6c,k2m2)                                 
                                                                               
        is possible point of elliptic curve over real quadratic number         
        field with integral coefficients, short normal form?                   
                                                                               
double sd,x,a4r,a6r,a4c,a6c,k2m2;                                             
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
                                                                            
static single ispprqnfeqhc(sd,x,a4r,a6r,a4c,a6c,k2m2)                        
double sd,x,a4r,a6r,a4c,a6c,k2m2;                                             
{                                            
	double al1r,al1i;
        double al1mr,al1mi;
	double bet1r,bet1i;
                                                   
        deqisnfc(x,a4r,a6r,a4c,a6c,&al1r,&al1i,&al1mr,&al1mi);

	cflsqrtc(al1r,al1i,&bet1r,&bet1i);

	al1r = bet1r * k2m2;
	al1i = bet1i * k2m2;

	/** Test: ist al1r ganz? ist al1i ganz? **/

	if(isposintic(al1r) && isposintic(al1i)) return(1);

	cflsqrtc(al1mr,al1mi,&bet1r,&bet1i);

	al1r = bet1r * k2m2;
	al1i = bet1i * k2m2;

	/** Test: ist al1r ganz? ist al1i ganz? **/

	if(isposintic(al1r) && isposintic(al1i)) return(1);


        return(0);                                                              
                                                                                
                                                                                
}                                                                               
                                                                                

/*c
                nfecsphc( x1, a1, a2, b1, b2, y1, y2)
        "number field elliptic curve"
                                                                               
        nfec() testet, ob rationale y1 und y2 existieren mit
        y1+sqrt(d)y2=                                                          
                x1^3+(a1+sqrt(d)a2)x1+(b1+sqrt(d)b2)   
        und gibt diese gegebenenfalls zurueck.                                 
c*/                                                                            
                                                                               
static single nfecsphc(x1,a1,a2,b1,b2,y1,y2)                                
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
		ispeqspc(d,a41,a42,a61,a62,x,Y)

	is point of elliptic curve?

	Testet, ob x^3+A4x+A6 = Y^2 ist und gibt ggf. Y zurueck.
	A4 = a41+ sqrt(d) * a42. A6 analog.

c*/

static ispeqspc(d,a41,a42,a61,a62,x,Y)
int d;
rat a41,a42,a61,a62,x;
nfel *Y;
{
	rat y1,y2,z1,z2;                                                       
                                                                               
        init(y1,y2,z1,z2);
	bind(d,a41,a42,a61,a62,x,*Y);

	nfecsphc(x,a41,a42,a61,a62,&z1,&z2);                                   
        if(isqnfelsqu(d,z1,z2,&y1,&y2))                                        
        {                                                                      
                (*Y) = rrtoqnf(d,y1,y2);                                       
                return(1);                                                     
        }                                                                      
        return(0);                                                             
}                         




/*c                                                                            
                ispkthc(d,x0,x1,a41,a42,a61,a62,P)                            
                                                                               
        is point                                                               
                                                                               
        Testet, ob x=x1/x0 die x=Koordinate eines                 
        Punktes von E ist.                                                     
                                                                               
c*/                                                                            
                                                                               
static single ispkthc(d,x0,x1,a41,a42,a61,a62,P)                              
int d,x0,x1;                                                                
rat a41,a42,a61,a62;                                                           
list *P;                                                                       
{                                                                              
        rat r1;                                                             
        nfel X,Y;                                                              
                                                                               
        init(r1,X,Y);                                                       
        bind(d,x0,x1,a41,a42,a61,a62,*P);                                   
                                                                               
        r1 = rcons(x1,x0);                                                     
        if(ispeqspc(d,a41,a42,a61,a62,r1,&Y))                            
        {                                                                      
                X = rtonf(r1);                                          
                (*P) = list3(X,Y,itonf(1));                                    
                return(1);                                                     
        }                                                                      
        return(0);                                                             
}                       






/*c
		eiqispbhQ(E,A)

	" elliptic curve over quadratic number field, short normal form,
	search points with bounded height with x in Q"

c*/

list eiqispbhQ(D,A4,A6,A)
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
	sd = -sd;		
	sd = sqrt(sd);		/** sqrt(-d), d<0 **/
	qnftoflflc(A4,sd,&a4r,&a4c);
	qnftoflflc(A6,sd,&a6r,&a6c);
	qnftorrn(A4,&a41,&a42,&xi0);
	qnftorrn(A6,&a61,&a62,&xi0);

	if(A4) xi0 = lfirst(A4);   
        else xi0 = 1;              
        if(A6) xi1 = lfirst(A6);  
        else xi1 = 1;            
        km = iitodquc(xi0,xi1);

	L = _0;
	x0 = 1;
	while(x0<=G)
	{
/**
printf("x0 = %f \n",x0);
**/


		k2m2 = dk2m2c(km,x0);

		x1 = 0;
		while(x1<=G)
		{
			x = x1/x0;

			/** test x1/x0 und -x1/x0 **/

			if(ispprqnfeqhc(sd,x,a4r,a6r,a4c,a6c,k2m2))
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
				if(ispkthc(D,xi0,xi1,a41,a42,a61,a62,&P))
				{
					if(!islelt(L,P)) 
					{
						L = lcomp(P,L);
/**
printf(" L = %obj \n",L);
**/
					}

				}
				xi1 = ineg(xi1);
				if(ispkthc(D,xi0,xi1,a41,a42,a61,a62,&P))
				{
					if(!islelt(L,P)) 
					{
						L = lcomp(P,L);
/**
printf(" L = %obj \n",L);
**/
					}
				}

			}
			x1 = x1+1;
		}
		x0 = x0+1;
	}
	return(L);
}

/*c
		ispolgoc(D,sd,tes,wf,w)

	"is polynomial good"

	Testet, ob b1^2-4b0b2 kein Quadrat in Q, aber eins
	in K ist. Wenn ja, dann ist w^2 = wf^2(als double)
	= b1^2-4b0b2.
c*/

static single ispolgoc(D,sd,tes,wf,w)
int D;
double sd,tes,*wf;		/** tes = b1^2-4*b0*b2 **/
int *w;
{
	floating fb;
	double t;
	int ib;

	init(fb,ib); 
	bind(D,*w);

			/** tes ist nach Konstruktion <=0 **/
			/** -> kein Quadrat in Q **/
			/** tes/(-d) soll Quadrat in Z sein **/
	tes = -tes;
	(*wf) = sqrt(tes);	/** sqrt(b1^2-4b0b2) als double **/

	t = (*wf)/sd;	
	if(!isposintic(t)) return(0); 

	tes = tes+0.1;
	fb = Cfltofl(tes);
	ib = flfloor(fb);
   	/** ib = b1^2-4b0b2 **/

   
	if(mihom(D,ib)) return(0);
   	/** ib ist nicht durch D tb **/
   
	ib = iquot(ib,D);
	if(isisqr(ib)!=1) return(0);
   	/** ib/d soll Quadrat sein **/
   
	(*w) = isqrt(ib);
	return(1);
   
}

/*c
		elemoutc(b0,b1,wf,km,x,xc,km2)
	
	"elements out "

	berechnet
		x = -(b1+wf)/2b0
		xc = -(b1-wf)/2b0
		km2 = km*4*b0^2
c*/

static single elemoutc(b0,b1,wf,km,xr,xc,km2)
double b0,b1,wf,km,*xr,*xc,*km2;
{
	b0 = b0+b0;
	(*xr) = b1/b0;
	(*xr) = -(*xr);
	(*xc) = wf/b0;
	(*km2) = km*b0;
	(*km2) = (*km2)*b0;
	
	return(1);
}

/*c                                                                             
 cceqisnf(xr,a4r,a6r,xi,a4i,a6i,yr,yi,myr,myi)                           
        "complex elliptic curve equation"                                       
                                                                                
c*/                                                                             
                                                                                
static single cceqisnf(xr,a4r,a6r,xi,a4i,a6i,yr,yi,myr,myi)              
double xr,a4r,a6r,xi,a4i,a6i,*yr,*yi,*myr,*myi;                                 
{                                                                               
        double h;                                                               
                                                                                
        h = xi*xi;                                                              
        (*yr) = xr*xr;                                                          
        (*yi) = 3*(*yr);                                                        
        (*yi) = (*yi) - h;                                                      
        (*yi) = (*yi)*xi;       /** yi = 3xr^2xi - xi^3 **/                     
        h = 3*h;                                                                
        (*yr) = (*yr)-h;                                                        
        (*yr) = (*yr)*xr;       /** yr = x^3-3xi^2xr    **/                     
                                                                                        h = a4r*xr;                                                             
        (*yr) = (*yr)+h;                                                        
        h = a4i*xi;                                                             
        (*yr) = (*yr)-h;                                                        
        (*myr) = a6r-(*yr);                                                     
        (*yr) = (*yr)+a6r;      /** yr = yr + a4rxr - a4ixi + a6r **/           
                                                                                
        h = a4r*xi;                                                             
        (*yi) = (*yi)+h;                                                        
        h = a4i*xr;                                                             
        (*yi) = (*yi)+h;                                                        
        (*myi) = a6i-(*yi);                                                     
        (*yi) = (*yi)+a6i;      /** yi = yi + a4rxi + a4ixr + a6i **/           
                                                                                
                                                                                
        return(1);                                                              
                                                                                
}                                                                               




/*c     
        isppreqc(sd,xr,a4r,a6r,xc,a4c,a6c,k2m2)   
        is possible point of elliptic curve over real quadratic number  
        field with integral coefficients, short normal form?           
c*/                                                                             
static single isppreqc(sd,xr,a4r,a6r,xi,a4i,a6i,k2m2) 
double sd,xr,a4r,a6r,xi,a4i,a6i,k2m2;   
{                                   

        double al1r,al1i,al2r,al2i;
        double bet1r,bet1i,bet2r,bet2i;
        double mal1r,mal1i,mal2r,mal2i;
                                                                                
        cceqisnf(xr,a4r,a6r,xi,a4i,a6i,&al1r,&al1i,&mal1r,&mal1i);
        xi = -xi;
        a4i = -a4i;
        a6i = -a6i;
        cceqisnf(xr,a4r,a6r,xi,a4i,a6i,&al2r,&al2i,&mal2r,&mal2i);       /** konj
ugierte **/
                                                                                
        cflsqrtc(al1r,al1i,&bet1r,&bet1i);
        cflsqrtc(al2r,al2i,&bet2r,&bet2i);
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
                if(isposintic(bet1r))     
                {                                                               
                        bet2i = al2r/sd;/** sd = sqrt(-d) mit d<0 !! **/        
                        if(bet2i<0) bet2i = -bet2i;                             
                        if(bet2i<0.001)                                         
                        {                                                       
                                bet2r = al2i/sd;                                
                                if(isposintic(bet2r)) return(1); 
                        }                                                       
                }                                                               
        }                                                                                                                                                       
        if(al2i<0) al2i = -al2i;                                                
        if(al2i<0.001)                                                          
        {                                                                       
                if(isposintic(al2r))                            
                {                                                               
                        bet2i = bet1r/sd;/** sd = sqrt(-d) mit d<0 !! **/       
                        if(bet2i<0) bet2i = -bet2i;                             
                        if(bet2i<0.001)                                         
                        {                                                       
                                bet2r = bet1i/sd;                               
                                if(isposintic(bet2r)) return(1); 
                        }                                                       
                }                                                               
        }                                                                       
                                                                                
        cflsqrtc(mal1r,mal1i,&bet1r,&bet1i);   
        cflsqrtc(mal2r,mal2i,&bet2r,&bet2i);  
                                                                                
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
                if(isposintic(bet1r))                          
                {                                                               
                        bet2i = al2r/sd;/** sd = sqrt(-d) mit d<0 !! **/        
                        if(bet2i<0) bet2i = -bet2i;                             
                        if(bet2i<0.001)                                         
                        {                                                       
                                bet2r = al2i/sd;                                
                                if(isposintic(bet2r)) return(1);
                        }                                                       
                }                                                               
        }                                                                       
                                                                                
        if(al2i<0) al2i = -al2i;                                                
        if(al2i<0.001)                                                          
        {                                                                       
                if(isposintic(al2r))                          
                {                                                               
                        bet2i = bet1r/sd;/** sd = sqrt(-d) mit d<0 !! **/       
                        if(bet2i<0) bet2i = -bet2i;                             
                        if(bet2i<0.001)                                         
                        {                                                       
                                bet2r = bet1i/sd;                               
                                if(isposintic(bet2r)) return(1);  
                        }                                                       
                }                                                               
        }                                                                       
                                                                                
        return(0);                                                              
                                                                                
}  

/*c
		elemout2c(b0,b1,w,r1,r2)

	" element out 2"

	gibt zurueck:
		-b1/2b0, w/2b0

c*/

static single elemout2c(b0,b1,w,r1,r2)
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
                ispktdc(d,r1,r2,a41,a42,a61,a62,P)
     
        is point
                                                      
        Testet, ob x=(r1+sqrt(d)*r2) die x=Koordinate eines
        Punktes von E ist.
                                                                              
c*/                     
     
static single ispktdc(d,r1,r2,a41,a42,a61,a62,P)
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
		ispppolgoc(D,sd,tes,b0,b1,b2,km,a4r,a4c,a6r,a6c,w)

	testet, ob ispolgoc() ist, und dann, ob isppreqc() gut ist.

c*/

static single ispppolgoc(D,sd,tes,b0,b1,km,a4r,a4c,a6r,a6c,w)
int D;
double sd,tes,b0,b1,km,a4r,a4c,a6r,a6c;
int *w;
{
	double wf,km2,xr,xc;

	bind(D,*w);

	if(ispolgoc(D,sd,tes,&wf,w))
	{

		elemoutc(b0,b1,wf,km,&xr,&xc,&km2);
		
		if(isppreqc(sd,xr,a4r,a6r,xc,a4c,a6c,km2)) return(1);

	}
	return(0);
}

/*c
		gentec(D,b0,b1,w,a41,a42,a61,a62,&H)

	testet, ob die Elemente Punkte sind

c*/

static single gentec(D,b0,b1,w,a41,a42,a61,a62,H)
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

	elemout2c(b0,b1,w,&r1,&r2);
	if(ispktdc(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r2 = rneg(r2);
	if(ispktdc(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r1 = rneg(r1);
	if(ispktdc(D,r1,r2,a41,a42,a61,a62,&P))
	{
		if(!islelt((*H),P)) (*H) = lcomp(P,(*H));
	}
	r2 = rneg(r2);
	if(ispktdc(D,r1,r2,a41,a42,a61,a62,&P))
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

list eiqispbhK(D,A4,A6,A)
int D;
nfel A4,A6;
floating A;
{

	list L,P,K;
	double b0,b1,b2,G,fltoCfl();
	floating h;
	double sd,km,M,Gi,vb0,b1q,tes;
	double a4r,a4c,a6r,a6c;
	double N,vb0i,zb0i;
	rat a41,a42,a61,a62;
	int w,mD;

	init(L,P,K);
	init(h);
	init(a41,a42,a61,a62);
	init(w,mD);
	bind(D,A4,A6,A);

	G = fltoCfl(A);
	G = G+G;
	G = exp(G);
	G = G+G;
/**
printf("und jetzt G = %f \n",G);
**/

	mD = ineg(D);	
	h = itofl(D);
	sd = fltoCfl(h);
	sd = -sd;
	sd = sqrt(sd);
	qnftoflflc(A4,sd,&a4r,&a4c);
	qnftoflflc(A6,sd,&a6r,&a6c);
	qnftorrn(A4,&a41,&a42,&P);
	qnftorrn(A6,&a61,&a62,&P);

	if(A4) P = lfirst(A4);   
        else P = 1;              
        if(A6) L = lfirst(A6);  
        else L = 1;            
        km = iitodquc(P,L);

	L = _0;
	b0 = 1;
	vb0 = 4;


	vb0i = 1/vb0;
	zb0i = vb0i+vb0i;
	
	while(b0<=G)
	{
/**
printf("b0 = %f \n",b0);
**/

		b1 = 0;
		b1q = 0;
		N = 0;
		M = 0;
		while(b1<=G)
		{
			b2 = floor(M);
			if(b2>G) break;
			tes = vb0*b2;
			tes = b1q-tes;	/** b1^2 - 4b0b2 **/
			while(b2<=G)	
			{
				if(ispppolgoc(mD,sd,tes,b0,b1,km,a4r,a4c,a6r,a6c,&w))
				{
/**
printf("moeglich \n");
**/
				   if(gentec(D,b0,b1,w,a41,a42,a61,a62,&K))
				   {
				   	while(K!=_0)
					{
					   P = lfirst(K);
					   K = lred(K);
					   if(!islelt(L,P)) 
					   {
						L = lcomp(P,L);
/**
printf("L = %obj \n",L);
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
			M = M+N;
			M = M + vb0i;	/** M = b1^2/4b0 **/
			N = N+zb0i;
/************************************************************************/
/**  M(b1) = b1^2/4b0,  M(0) = 0, M(b1+1) = M(b1) + N(b1) + 1/4b0     ***/
/**  N(b1) = b1/2b0,    N(0) = 0, N(b1+1) = N(b1) + 1/2b0             ***/
/************************************************************************/

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
                                               
list eiqispbh( D,E,A )
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

	LQ = eiqispbhQ(D,A4,A6,A);
	LK = eiqispbhK(D,A4,A6,A);
	while(LQ!=_0)
	{
		P = lfirst(LQ);
		LQ = lred(LQ);
		LK = lcomp(P,LK);
	}
	return(LK);
}
