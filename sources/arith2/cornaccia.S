/*M
.SH NAME
cornaccia - determine a solution of the diophantine equation x^2+q*y^2=m
using the algorithm of cornaccia

.SH SYNOPSIS
.nf
#include<_arith2.h>

int cornaccia(m,q,x0,pX,pY)
int m,q,x0,*pX,*pY;

ex = cornaccia(m,q,x0,pX,pY);

.SH DESCRIPTION
cornaccia() determines a coprime integer solution (x,y), x, y > 0, 
of x^2+q*y^2=m, if there is any. In the case q=1, the algorithm only 
computes a coprime integer solution (x,y) subject to x > y > 0.
The return value ex equals 0 if cornaccia() could find such a
solution and is different to 0 otherwise. A solution (x,y) is stored 
at the addresses pX and pY, respectively. q and m must be natural 
numbers subject to 1 <= q < m.

There are two possibilities for x0:

a) x0 is a natural number satisfying m/2 < x0 < m and  
x0^2 = -q mod m  (*). Then the algorithm possibly (!) needs not 
determine the prime factorization of m. Observe that an x0 having 
the properties in (*) does not necessarily produce a solution 
of x^2+q*y^2=m, even if any!

b) x0 = 0: Then the algorithm is forced to determine the prime 
factorization of m, but you need not know a solution z of z^2 = -q 
mod m.

.SH NOTE
The function cornaccia() usually calls the function cornacciax0().
The only difference between these functions is that in cornacciax0() 
x0 must not be zero.

.SH SEE ALSO
.BR cornacciax0()
M*/
/*H
        Version 1       1.7.1998           Christian Guenther 

   DATE cornaccia    : 980701
H*/
        
#include <_arith2.h>

int cornaccia(m,q,x0,pX,pY)
   int m,q,x0,*pX,*pY;
{
   int ex;                              /* ex =0: there is a solution. 
                                           ex!=0: there is no solution    */
  
   init(ex);
   bind(m,q,x0);

   if(icomp(x0,0)!=0)                   /* x0 known:                      */
   {
      ex=cornacciax0(m,q,x0,pX,pY);
      if(icomp(ex,0)==0) return(0);     /* solution found                 */
   }
                  
   {                                    /* x0 unknown or the value 
                                           of x0 did not produce a 
                                           solution of x^2+q*y^2=m:       */ 
             
      list  M;                          /* list of all solutions z of
                                           z^2=-q mod m                   */ 
      int lengthM,                      /* length of M                    */
      q1,                               /* q1=m/2                         */
      x;                                /* for storing an element of M    */  
      single k;                         

      init(M,lengthM,q1,x);

      M = ifact(m);                     /* m's prime factorization        */
      M = ifel(M);
      q1= mineg(m,q);                   /* q1 = -q mod m                  */
      M = misqrtas(M,q1);               /* M = list of all solutions of
                                           z^2 = -q = q1 mod m            */ 
      if (M == _0) return(1);           /* no solution for z^2 = -q mod m,
                                           therefore no solution for
                                           x^2+q*y^2=m                    */
      
      lengthM=llength(M);               /* initializing some variables    */
      ex=1;
      k=0;
      q1=iquot(m,2);                    
      
      while(ex && icomp(k,lengthM)<0)   /* determination of a solution of
                                           x^2+q*y^2=m                    */ 
      {
         k++;
         x=lelt(M,k);
         if(icomp(x,q1)>0 && icomp(x,x0)!=0)
            ex=cornacciax0(m,q,x,pX,pY); 
      }

      return(ex);
   }    
}











