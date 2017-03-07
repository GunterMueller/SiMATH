/*M
.SH NAME
ecqnfdwhnth - elliptic curve over quadratic number field difference between
Weil height and Neron-Tate height
 
.SH SYNOPSIS
.nf
#include<_ec2.h>
 
floating ecqnfdwhnth(E)
list   E;
 
.SH DESCRIPTION
ecqnfdwhnth() returns the difference between the Weil height and the 
Neron-Tate height of an elliptic curve over a quadratic number field K 
 
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
M*/
/*H
        Version 1      06.10.1998        S. Schmitt
   DATE ecqnfdwhnth    : 981015
H*/
 
#include<_ec2.h>

/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/    
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c
	qnftocomp(d,x)

	"quadratic number field element to complex number "

	gibt x als komplexe Zahl zurueck

c*/

static complex qnftocomp(d,x)
int d;
nfel x;
{
	int n,x1,x2;
	floating a,b;
	complex c,h;
	init(n,x1,x2,a,b,c);
	bind(d,x);

	if(x)
	{
		n = lfirst(x);
		x2 = lthird(x);
		b = itofl(x2);
		a = itofl(n);
		b = flquot(b,a);	/** x2/n **/
		/** x = (n 1 x2 x1) = x1/n + x2*sqrt(d)/n **/
		if(lsecond(x))		
		{
			c = itoc(d);
			c = csqrt(c);
			h = fltoc(b);
			c = cprod(c,h);	/** x2*sqrt(d)/n **/
			x1 = lfourth(x);
			b = itofl(x1);
			b = flquot(b,a); /** x1/n **/
			h = fltoc(b);
			c = csum(c,h);
			return(c);	
		}
		c = fltoc(b);
		return(c);
	}
	c = itoc(0);
	return(c);
}

/*c
	qnftoflfl(d,x,fx,fxq)
	"quadratic number field element to 2 floating point numbers"

	gibt x und die Konjugierte von x als floating point numbers
	zurueck.
c*/

static single qnftoflfl(d,x,fx,fxq)
int d;
nfel x;
floating *fx,*fxq;
{
	int n,x1,x2;
	floating h,k;
	init(n,x1,x2,h,k);
	bind(d,x,*fx,*fxq);

	(*fx) = itofl(0);
	(*fxq) = itofl(0);

	if(x)
	{
		n = lfirst(x);
		x2 = lthird(x);
		(*fx) = itofl(x2);
		h = itofl(n);
		(*fx) = flquot(*fx,h);	/** x2/n **/

		/** x = (n 0 x2 x1) = x1/n + x2*sqrt(d)/n **/
		if(lsecond(x))		
		{
			k = itofl(d);
			k = flsqrt(k);
			(*fx) = flprod(*fx,k);	/** x2*sqrt(d)/n **/
			x1 = lfourth(x);
			k = itofl(x1);
			k = flquot(k,h);	/** x1/n **/
			(*fxq) = fldif(k,*fx);
			(*fx) = flsum(k,*fx);
			return(1);
		}

		/** x = (n 0 x2) = x2/n**/
		(*fxq) = (*fx);
		return(1);
	}
	return(1);
}

/*c
	flmax(f,g)
	
	"floating point number maximum"

	gibt das Maximum von f und g zurueck.
c*/

static floating flmax(f,g)
floating f,g;
{
	bind(f,g);

	if(flcomp(f,g)==1) return(f);
	return(g);
}
	
                                                                                
/*c

	hinfty(d,x)
	"h_{\infty}(x)"

	Berechnet h_{\infty}(x) .
c*/

static floating hinfty(d,x)
int d;
nfel x;
{
	bind(d,x);
	if(isign(d)>0) 		/** reellquadratisch **/
	{
	 	floating fx,fxq,m1,m2;
		init(fx,fxq,m1,m2);

		qnftoflfl(d,x,&fx,&fxq);
		m1 = flmax(fx,itofl(1));
		m2 = flmax(fxq,itofl(1));
		m1 = flprod(m1,m2);
		m1 = fllog(m1);
		m1 = flquot(m1,itofl(2));
		return(m1);
	}
	else			/** imaginaerquadratisch **/ 
	{
		complex cx;
		floating m;

		init(cx,m);
		
		cx = qnftocomp(d,x);
		m = cabsv(cx);
		m = flmax(m,itofl(1));
		m = fllog(m);
		return(m);
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
                                            

floating ecqnfdwhnth( E )
list E;
{
    nfel j,disc;
    list trick;
    floating hj,hd, diff;
    int d;

    init( j,disc, trick );
    init(hj,hd, diff);
    init(d);
    bind( E );

    d = ecqnfflddisc(E);

	/** h(DELTA) **/

    disc = ecqnfacdisc( E );
    trick = list2(disc,0);
    hd = ecqnfwehe(d,E,trick);   /** der Punkt muss nicht auf der Kurve
				     liegen! Das ist der Trick! **/
	/** h_\infty(j) **/
    j = ecqnfjinv( E );
    hj = hinfty(d,j);
	

	/** mu(E) **/

    hd = flsum(hd,hj);
    hd = flquot(hd, itofl(6));

	/** h(j) **/

    trick = list2(j,0);
    hj = ecqnfwehe(d,E,trick);

    diff = Cfltofl(2.328);
    if(flcomp(hj,diff)==(-1))	/** hj < 2.328 **/ /** dann Delta1 **/
	diff = Cfltofl(2.14);
    else		/** sonst Delta2 **/
    {	hj = flquot(hj,itofl(12));
	diff = Cfltofl(1.946);
	diff = flsum(diff,hj);
    }
    diff = flsum(hd, diff);
	
    return(diff);
}
                                 

