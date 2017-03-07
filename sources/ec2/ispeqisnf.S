/*M
.SH NAME
ispeqisnf - is point of elliptic curve over quadratic number field with
integral coefficients, short normal form?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ispeqisnf(E, x,y)
list   E;
nfel x,*y;

.SH DESCRIPTION
ispeqisnf() tests, if there is a y, such that (x,y) is a point of E.
If this is true, ispeqisnf() returns 1 and y. Else, ispeqisnf() returns 0.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B x
is a quadratic number field element.
M*/
/*H
        Version 1       12.08.1998      S. Schmitt
   DATE eqisnfa4     : 980812
H*/


#include<_ec2.h>

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/
                                                                                
/*c
		nfec(d, x1, x2, a1, a2, b1, b2, y1, y2)
	"number field elliptic curve"

	nfec() testet, ob rationale y1 und y2 existieren mit
 	y1+sqrt(d)y2=
		(x1+sqrt(d)x2)^3+(a1+sqrt(d)a2)(x1+sqrt(d)x2)+(b1+sqrt(d)b2) 
	und gibt diese gegebenenfalls zurueck.
c*/

static single nfec(d,x1,x2,a1,a2,b1,b2,y1,y2)
int d;
rat x1,x2,a1,a2,b1,b2,*y1,*y2;
{
	rat h,k,l,rd;
	init(h,k,l,rd);
	bind(d,x1,x2,a1,a2,b1,b2,*y1,*y2);

	rd = itor(d);

	h = rprod(x1,x1);		/** x1^2 **/
	k = rprod(x2,x2);		/** x2^2 **/
	k = rprod(k,rd);		/** dx2^2 **/
	l = rprod(h,itor(3));		/** 3x1^2 **/
	l = rsum(k,l);			/** 3x1^2+dx2^2 **/
	l = rprod(l,x2);		/** 3x1^2x2+dx2^3 **/
	k = rprod(k,itor(3));		/** 3dx2^2 **/
	h = rsum(h,k);			/** x1^2+3dx2^2 **/
	h = rprod(h,x1);		/** x1^3+3dx1x2^2 **/

	k = rprod(a1,x1);		/** a1x1 **/
	h = rsum(h,k);			/** x1^3+3dx1x2^2+a1x1 **/
	k = rprod(a2,x2);		/** a2x2 **/
	k = rprod(k,rd);		/** da2x2 **/
	h = rsum(h,k);			/** x1^3+3dx1x2^2+a1x1+da2x2 **/
	*y1 = rsum(h,b1);		/** x1^3+3dx1x2^2+a1x1+da2x2+b1 **/
	
	k = rprod(a1,x2);		/** a1x2 **/
	h = rsum(l,k);			/** 3x1^2x2+dx2^3+a1x2 **/
	k = rprod(a2,x1);		/** a2x1 **/
	h = rsum(h,k);			/** 3x1^2x2+dx2^3+a1x2+a2x1 **/
	*y2 = rsum(h,b2);		/** 3x1^2x2+dx2^3+a1x2+a2x1+b2 **/

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


single ispeqisnf(E,x,y)
list E;
nfel x,*y;
{
	rat x1,x2,a1,a2,b1,b2,y1,y2,z1,z2;
	int d,n;
	nfel A,B;

	init(x1,x2,a1,a2,b1,b2,y1,y2,z1,z2);	
	init(d,n);
	init(A,B);
	bind(E,x,*y);

	d = ecqnfflddisc(E);
	A = eqisnfa4(E);
	B = eqisnfa6(E);
	qnftorrn(A,&a1,&a2,&n);
        qnftorrn(B,&b1,&b2,&n);
	qnftorrn(x,&x1,&x2,&n);
	nfec(d,x1,x2,a1,a2,b1,b2,&z1,&z2);                                      
        if(isqnfelsqu(d,z1,z2,&y1,&y2)) 
        {                                                               
                (*y) = rrtoqnf(d,y1,y2);
		return(1);
	}
	return(0);	
}
	
	

	

