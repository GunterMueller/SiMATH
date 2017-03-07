/*M
.SH NAME
iprpdbqf - integer primitive reduced positive definite binary quadratic forms

.SH SYNOPSIS
.nf
#include<_arith1.h>

list iprpdbqf(D,h1,h2)
int D;
single h1,h2;

.SH DESCRIPTION
iprpdbqf() returns a list L of primitive reduced positive
definite binary quadratic forms with a discriminate D<0.
Let h be the number of such forms.
If h<h1 or h>h2 (where h2=0 is intepreted as infinty)
then L = () will be returned, otherwise L equals (L1, L2).
If (a,b,c) is a form which is member of L2,
then (a,-b,c) also is reduced.
It holds that a,b,c >=0 for all forms (a,b,c) in L1 and L2.
This means h = #L1 + 2 * #L2.
M*/
/*H
	Version 1	01.07.1993	Georg Lay
   DATE iprpdbqf      : 931130
H*/

#include<_arith1.h>

static list sprpdbqf (single,single,single);

list iprpdbqf (D,h1,h2)
int	       D;
single 	       h1,h2;
 {
 int   a,b,c,m,r,wm,h;
 list  f1,f2;

 bind (D);
 init (a,b,c,m,r,wm);
 init (f1,f2); 

 if (icomp (D,0) >=0) return (_0);
 if (mshom (4,D) > 1) return (_0);
 if (isatom (D))      return (sprpdbqf (D,h1,h2));

 D = ineg(D);
 h = 0;
 f1 = f2 = _0;

 r = iquot (D,3);
 r = isqrt (r);

 for (b = iodd (D); icomp (b,r) <= 0; b = isum (b,2))
   {
   m = iprod (b,b);
   m = isum  (m,D);
   m = iquot (m,4);
   wm = isqrt (m);

   for (a = (b > 0) ? b : 1; icomp (a,wm) <= 0; a = isum (a,1))
   if (irem (m,a) == 0 && icomp (b,a) <= 0) {
       c = iquot (m,a);
       if (igcd (c,igcd (a,b)) == 1)
       if (icomp (c,a) == 0 || icomp (b,a) == 0 || b == 0)	f1 = lcomp (list3 (a,b,c),f1),h+=1;
       else							f2 = lcomp (list3 (a,b,c),f2),h+=2;
       }
   if (h2>0)	if (h>h2)	return (_0);
   }

 if (h<h1)	return (_0);

 return (list2 (f1,f2));
 }




static
list sprpdbqf (D,h1,h2)
single 	       D,h1,h2;
 {
 single a,b,c,m,r,am,wm,h;
 list  f1,f2;
 init (f1,f2); 

 D = -D;
 h = 0;
 f1 = f2 = _0;

 r = (single) sqrt (((double) D)/3.0);
 for (b = D % 2; b <= r; b += 2)
   {
   wm = isqrt (m = (b*b + D)/4);

   for (a = (b > 0) ? b : 1; a <= wm; a++)
   if (m % a == 0 && b <= a) {
       c = m/a;
       if (igcd (c,igcd (a,b)) == 1)
       if (c == a || b == a || b == 0)	f1 = lcomp (list3 (a,b,c),f1),h+=1;
       else				f2 = lcomp (list3 (a,b,c),f2),h+=2;
       }
   if (h2>0)	if (h>h2)	return (_0);
   }

 if (h<h1)	return (_0);

 return (list2 (f1,f2));
 }

