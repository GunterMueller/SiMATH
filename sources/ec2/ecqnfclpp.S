/*M
.SH NAME
ecqnfclpp - elliptic curve over quadratic number field coefficient of
L-series at power of prime ideals

.SH SYNOPSIS
.nf
# include <_ec2.h>

list ecqnfclpp(E,PF,p,e,q,m,r,num)
list E,PF;
single p,e,q,m,r,num;

.SH DESCRIPTION
ecqnfclpp() determines the coefficient of the L-series of E over the quadratic
number field K=Q(sqrt(d)) at the prime ideals over p^e.
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B PF
is the list PF = qnfpifact(d,itonf(p)).
.TP 4
.B p
is a single precision prime number.
.TP 4
.B e
is a single precision number.
.TP 4
.B q
is equal to p^e.
.TP 4
.B m
is the number of ideals in K with norm q.
.TP 4
.B r
is the return value of ecqnfreddec(E,PF,p).
.TP 4
.B num
is the number of computed coefficients.
M*/
/*H
        Version 1       27.08.1998      S. Schmitt
   DATE ecqnfclpp     :   980830
H*/


#include <_ec2.h>

extern list A[5500];

list ecqnfclpp(E,PF,p,e,q,m,r,num )
list E,PF;
single p,e,q,m,r,num;	/** q=p^e, m = # Ideale mit Norm q **/
{
	list L,P1;
	single a,b,pp;
	single i,k,c1,c2;

	bind(E,PF);
	bind(A[0..num]);
	init(L,P1);

	if( ((r==1 || r==2 || r==3) && e==2) /** traege und e=2 **/
	  || e==1 )
	{
		L = ecqnfclp(E,PF,p,r);
		return(L);
	}

	L = _0;

	switch(r)	/** r Rueckgabe aus ecqnfreddec **/
	{
		case 1:	/** traege + g **/
			pp = iprod(p,p);
			a = lfirst(A[pp]);
			q = iquot(q,pp);
			b = lfirst(A[q]);
			a = iprod(a,b);
			q = iquot(q,pp);
			b = lfirst(A[q]);
			b = iprod(b,pp);
			a = idif(a,b);
			L = list1(a);
			break;
		case 2: /** traege + m **/
			e = iquot(e,2);
			if(!mshom(2,e)) L = list1(1);
			else
			{	pp = iprod(p,p);
				L = lcopy(A[pp]);
			}
			break;
		case 3: /** traege + a **/
			L = list1(0);
			break;
		case 4: /** verzweigt + g **/
			a = lfirst(A[p]);
			q = iquot(q,p);
			b = lfirst(A[q]);
			a = iprod(a,b);
			q = iquot(q,p);
			b = lfirst(A[q]);
			b = iprod(b,p);
			a = idif(a,b);
			L = list1(a);
			break;
		case 5: /** verzweigt + m **/
			if(!mshom(2,e)) L = list1(1);
			else L = lcopy(A[p]);
			break;
		case 6: /** verzweigt + a **/
			L = list1(0);
			break;
		case -1: /** zerlegt + g + g **/
			a = lsecond(A[p]);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			a = iprod(a,b);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			b = iprod(b,p);
			a = idif(a,b);
			L = list1(a);

			c2 = iprod(q,p);/** p^{e-1} **/
			c1 = p;		/** p^1 **/
			for(i=1;i<e;i++)
			{
				P1 = llast(A[c2]);
				b = lfirst(P1);
				a = lfirst(A[c1]);
				a = iprod(a,b);
				L = lcomp(a,L);
				c2 = iquot(c2,p);
				c1 = iprod(c1,p);
			}
					
			a = lfirst(A[p]);
			q = iprod(q,p);
			b = lfirst(A[q]);
			a = iprod(a,b);
			q = iquot(q,p);
			b = lfirst(A[q]);
			b = iprod(b,p);
			a = idif(a,b);
			L = lcomp(a,L);
			break;
		case -2: /** zerlegt + g + m **/
			a = lsecond(A[p]);
			a = sexp(a,e);
			L = list1(a);

			c2 = iquot(q,p),/** p^{e-1} **/
			c1 = p;		/** p^1 **/
			for(i=1;i<e;i++)
			{
				P1 = llast(A[c2]);
				b = lfirst(P1);
				a = lfirst(A[c1]);
				a = iprod(a,b);
				L = lcomp(a,L);
				c2 = iquot(c2,p);
				c1 = iprod(c1,p);
			}
					
			a = lfirst(A[p]);
			q = iquot(q,p);
			b = lfirst(A[q]);
			a = iprod(a,b);
			q = iquot(q,p);
			b = lfirst(A[q]);
			b = iprod(b,p);
			a = idif(a,b);
			L = lcomp(a,L);
			break;
		case -3: /** zerlegt + g + a **/
			while(--m) L = lcomp(0,L);
			a = lfirst(A[p]);
			q = iquot(q,p);
			b = lfirst(A[q]);
			a = iprod(a,b);
			q = iquot(q,p);
			b = lfirst(A[q]);
			b = iprod(b,p);
			a = idif(a,b);
			L = lcomp(a,L);
			break;
		case -4: /** zerlegt + m + g **/
			a = lsecond(A[p]);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			a = iprod(a,b);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			b = iprod(b,p);
			a = idif(a,b);
			L = list1(a);

			c2 = iprod(q,p);/** p^{e-1} **/
			c1 = p;		/** p^1 **/
			for(i=1;i<e;i++)
			{
				P1 = llast(A[c2]);
				b = lfirst(P1);
				a = lfirst(A[c1]);
				a = iprod(a,b);
				L = lcomp(a,L);
				c2 = iquot(c2,p);
				c1 = iprod(c1,p);
			}

			a = lfirst(A[p]);
			a = sexp(a,e);
			L = lcomp(a,L);	
			
			break;
		case -5: /** zerlegt + m + m **/
			a = lfirst(A[p]);
			b = lsecond(A[p]);
			for(i=0;i<=e;i++)
			{
				k = e-i;
				c1 = sexp(a,i);
				c2 = sexp(b,k);
				c1 = iprod(c1,c2);
				L = lcomp(c1,L);
			}
			break;
		case -6: /** zerlegt + m + a **/
			while(--m) L = lcomp(0,L);
			if(!mshom(2,e)) L = lcomp(1,L);
			else
			{	
				a = lfirst(A[p]);
				L = lcomp(a,L);
			}
			break;
		case -7: /** zerlegt + a + g **/
			a = lsecond(A[p]);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			a = iprod(a,b);
			q = iquot(q,p);
			L = llast(A[q]);
			b = lfirst(L);
			b = iprod(b,p);
			a = idif(a,b);
			L = list1(a);
				
			while(--m) L = lcomp(0,L);
			break;
		case -8: /** zerlegt + a + m **/
			if(!mshom(2,e)) L = list1(1);
			else
			{	
				a = lsecond(A[p]);
				L = list1(a);
			}
			while(--m) L = lcomp(0,L);
			break;
		case -9: /** zerlegt + a + a **/
			while(m--) L = lcomp(0,L);
			break;

	}
	
	return(L);
}
