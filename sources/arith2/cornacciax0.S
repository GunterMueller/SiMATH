/*M
.SH NAME
cornacciax0 - determine a solution of the diophantine equation 
x^2+q*y^2=m using the algorithm of cornaccia, given x0

.SH SYNOPSIS
.nf
#include<_arith2.h>
        
int cornacciax0 (m,q,x0,pX,pY) 
int m,q,x0,*pX,*pY;
        
ex = cornacciax0 (m,q,x0,pX,pY);

.SH DESCRIPTION
For the given value of x0, this algorithm tries to determine a 
coprime integer solution (x,y), x, y > 0, of x^2+q*y^2=m. In the 
case q=1, the algorithm only tries to compute a coprime integer 
solution (x,y) subject to x > y > 0. The return value ex equals 0 
if cornacciax0() could find such a solution and is different to 0 
otherwise.

The algorithm does not necessarily produce such a solution (x,y), 
even if any. Its success depends on the suitable choice of x0. You 
have the following statement: For every coprime integer solution (x,y),
x, y > 0, of x^2+q*y^2=m, there is a solution x0 of x0^2 = -q mod m
such that this algorithm will produce that solution (x,y).
The corresponding statement holds for the case q=1. In the case of 
existence, the computed solution (x,y) is stored at the addresses 
pX and pY, respectively. 

q and m are natural numbers subject to 1 <= q < m. x0 has to be a 
natural number satisfying  m/2 < x0 < m  and  x0^2 = -q mod m.   
 
.SH NOTE
The function cornacciax0() is often called by the function 
cornaccia() which allways finds an above described solution (x,y),
if any.

.SH SEE ALSO
.BR cornaccia()
M*/
/*H
        Version 1         1.7.1998         Christian Guenther

   DATE cornacciax0    : 980701
H*/

#include <_arith2.h>

int cornacciax0(m,q,x0,pX,pY)
   int m,q,x0,*pX,*pY;
{
   int q1,                              /* q1 = m/2                     */     
       bound,                           /* sqrt(m) <= bound < sqrt(m)+1 */ 
       x1,x2,x3,                        /* for an Eukl. algorithm       */
       y,v;                             /* for storing intermediate     */
                                        /* results                      */

   bind(m,q,x0);
   init(q1,bound,x1,x2,x3,y,v);

   bound=isqrt(m);                      /* initializations              */
   if(icomp(iprod(bound,bound),m)!=0)  
      bound=isum(bound,1);
   q1=iquot(m,2);
   if(icomp(x0,q1)<=0) x0=mineg(m,x0);  /* for safety                   */
   
   x2=x0;
   x3=m;

   do                                   /* Eukl. alg. for x0 und m:     */
   {                                    /* Repeat it until x3 (ie the   */
      x1=x2;                            /* remainder) is less than      */
      x2=x3;                            /* sqrt(m).                     */  
      x3=irem(x1,x2);
   }
   while(icomp(x3,bound)>=0);

   v=idif(m,iprod(x3,x3));              /* You have to test if          */ 
   if(irem(v,q)==0)                     /* sqrt((m-x3^2)/q) is an       */
   {                                    /* integer.                     */
                                        /* For this purpose it is       */
                                        /* firstly tested if            */
                                        /* (m-x^3^2)/q is an integer.   */
      v=iquot(v,q);                       
      y=isqrt(v);                       
  
      if(icomp(iprod(y,y),v)==0)        /* Yes: y=sqrt((m-x3^2)/q is an */
      {                                 /* integer and so (x3,y) is a   */
         *pX=x3;                        /* solution of x^2+q*y^2=m.     */
         *pY=y;                         
         return(0);
      }  
   }

   return(1);                           /* no solution found            */
}




