/*M
.SH NAME 
qnfpiord - quadratic number field integer element prime ideal order

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfielpiord(D, P, pi, z, a)
int      D;
list     P;
nfel     pi, a;
single   z;

.SH DESCRIPTION
qnfielpiord() computes the normalized P-adic valuation of an element a in the ri
ng of integers O_K of a quadratic number field K = Q(D^(1/2)) at a prime ideal P
, i.e. the order of the prime ideal in the prime ideal decomposition of the prin
cipal ideal (a). 
.TP 3 
It returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ord_P( a ), 
if a is an element in the ring of integers O_K of K = Q(D^(1/2))\\{0}. 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi
is a prime element of the prime ideal P.
.TP 4
.B z
is 0, 1 or 2, if the prime ideal P divides an inert, ramified or split prime num
ber in Q.
.TP 4
.B a
is an element in the ring of integers O_K of K. 
M*/
/*H
        Version 1      03.01.1997        Andreas Heiser
	Version 2      29.12.1998        Andreas Heiser
   DATE qnfielpiord  : 
H*/

#include<_arith2.h>
#include<_matr1.h>
	
single qnfielpiord(D,P,pi,z,a)
int     D;
list    P;
nfel    pi,a;
single  z;
{       
  single  w,i,j,k;
  rat     r,s;
  int     d,d1,n,p,h;
  nfel    b,bb,h1,h2;
  list    L,L1,H,HH,W;
  matrix  A,M,N,M2;
 
  init(w,r,s,d,d1,n,p,h,b,bb,h1,h2,i,j,k);
  init(L,L1,H,HH,A,M,N,M2,W);
  bind(D,P,pi,z,a);

  p=iprod(lfirst(P),lsecond(P));
  p=iquot(p,lfourth(P));

  if(z!=2)
    {
      r=qnfnorm(D,a);
      n=rnum(r);
      w=iavalint(p,n);
      if(!z)
	w=iquot(w,2);
      return(w);
    }
  else
    {
      L=qnfintbas(D);
      H=L;HH=_0;
      while(H!=_0)
	{
	  h1=lfirst(H);
	  h1=qnfprod(D,a,h1);
	  HH=lcomp(h1,HH);
	  H=lred(H);
	}
      HH=linv(HH);
      HH=qnfherm(D,HH);
      M=lfirst(HH);d1=lsecond(HH);
     
      L1=qnfherm(D,L);
      N=lfirst(L1);d=lsecond(L1);
      
      H=L;M2=_0;
      for(i=1;i<=2;i++)
	{
	  h1=lfirst(H);
	  h1=qnfprod(D,h1,pi);
	  L1=qnfielbasvec(D,h1);
	  M2=lcomp(L1,M2);
	  H=lred(H);
	}
      M2=linv(M2);
      M2=matransp(M2);
      M2=maitomami(p,M2);
      H=maminsb(p,M2);
      H=lfirst(H);
      
      bb=qnfiprod(D,lfirst(L),lfirst(H));
      h1=qnfiprod(D,lsecond(L),lsecond(H));
      bb=qnfsum(D,bb,h1);
     
      A=maitomar(N);A=marinv(A);
      M=maitomar(M);
      A=marprod(A,M);
      r=rcons(d,d1);
      A=marsmul(A,r);
      h1=iprod(maselel(A,1,1),maselel(A,2,2));
      
      if(mihom(p,h))
	return(0);
      else
	{
	  w=0;W=L;
	  r=rcons(iexp(d,2),maidet(N));
	  while(1)
	    {
	      L=_0;
	      for(i=1;i<=2;i++)
		{
		  h1=0;HH=W;
		  for(k=1;k<=2;k++)
		    {
		      h2=lfirst(HH);
		      h=rnum(maselel(A,k,i));
		      h2=qnfiprod(D,h2,h);
		      h1=qnfsum(D,h1,h2);
		      HH=lred(HH);
		    }
		  h1=qnfprod(D,h1,bb);
		  L=lcomp(h1,L);
		}
	      L=linv(L);H=L;
	      A=_0;
	      while(H!=_0)
		{
		  h1=lfirst(H);
		  HH=qnfielbasvec(D,h1);
		  A=lcomp(HH,A);
		  H=lred(H);
		}
	      A=linv(A);
	      A=matransp(A);
	      s=rcons(1,p);
	      A=maitomar(A);
	      A=marsmul(A,s);
	      if(ismari(A))
		w++;
	      else
		return(w);
	    }
	} 
    }
}

list qnfherm(D,L)
int   D;
list  L;
{
  matrix   M;
  nfel     a;
  int      d,k,l,m;
  single   i,j;
  list     H;

  init(M,a,d,k,l,m,i,j,H);
  bind(D,L);

  d=1;H=L;
  while(H!=_0)
    {
      a=lfirst(H);
      k=lfirst(a);
      d=ilcm(d,k);
      H=lred(H);
    } 
  H=L;j=1;
  M=maconszero(2,2);
  while(H!=_0)
    {
      a=lfirst(H);
      k=lfirst(a);
      k=iquot(d,k);
      i=lsecond(a);i++;
      a=lred2(a);
      while(a!=_0)
	{
	  l=lfirst(a);
	  l=iprod(l,k);
	  m=masetel(M,i,j,l);
	  i--;
	  a=lred(a);
	}
      j++;
      H=lred(H);
    }
  M=maihnf(M);
  return(list2(M,d));
}




