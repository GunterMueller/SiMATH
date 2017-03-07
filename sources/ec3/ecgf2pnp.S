/*M
.SH NAME
ecgf2pnp - elliptic curve over Galois-field with characteristic 2, precompute number of points

.SH SYNOPSIS
.nf
#include <_ec3.h>

int ecgf2pnp (disc, MAXh, MAXd, d, m1, m2)
int disc, MAXh, MAXd, *d, *m1, *m2;

h = ecgf2pnp (disc, MAXh, MAXd, d, m1, m2);

.SH DESCRIPTION
.TP 4
.B disc
disc < 0 is a discriminant of an imarinary quadratic order R.
If disc cannot be used for a computation then ecgf2pnp()
stops and returns 0.
.TP 4
.B MAXh
If the ideal class number h of R exceeds
MAXh, then the calculation stops and 0 is returned.
MAXh = 0 is interpreted as infinity.
.TP 4
.B d
The elliptic curve E determined with ecgf2cc() will 
be defined over the finite field
GF(2^*d). This is the smallest field E can
be defined over. *d divides h.
.TP 4
.B MAXd
If *d > MAXd then ecgf2pnp() stops and returns 0.
MAXd = 0 is interpreted as infinity.
.TP 4
.B *m1 (and *m2)
is the numbers of points on the elliptic curve
E over GF(2^*d) that can be determined using
ecgf2cc().
.TP 4
.B h
if h is not equal to 0 (see above) then h
is the ideal class number of the imaginary quadratic order
R of discriminant disc. h is a multiple of *d.
.PP 
The curve E can be computed using ecgf2cc().
M*/
/*H
	Version 1	21.01.1996	Georg Lay
	DATE ecgf2pnp	:961201
H*/

#include <_ec3.h>

static int norm(int,list,list);
 
int ecgf2pnp (disc, MAXh, MAXd, d, m1, m2)
int disc, MAXh, MAXd, *d, *m1, *m2;
 {
 list  cl_group,Frob,h;
 init (cl_group,Frob);

 if (icomp (disc,0) >= 0)          return (0);     /* disc < 0 ?         */
 if (mshom (8,disc) != 1)          return (0);     /* disc = 1 mod 8 ?   */
 if (mshom (3,disc) == 0)	   return (0);	   /* spart Zeit	 */

 cl_group = iprpdbqf (disc, 0, MAXh);
 if (cl_group == _0) return (0);

 h = llength (lfirst (cl_group)) + 2*llength (lsecond (cl_group));

 for (*d = 1; *d <= h; (*d)++)  
 if (h % (*d) == 0) {
    if (MAXd > 0) if (*d > MAXd)  return (0);
    Frob = ipprniqf (2, *d, disc);		/* ist 2^d Norm in 	*/
    if (Frob != _0) {				/* Q(sqr(disc)) ? 	*/
	*m1 = norm (-disc,lfirst (Frob), 1);
	*m2 = norm (-disc,lfirst (Frob),-1);
	return (h);
	}
    }
 return (0);
 }


static
int norm (D,pi,k)
int D;
list pi,k;
 {
 int   N,X,Y;
 init (N,X,Y);

 X = lfirst  (pi);
 X = isum (X,k);
 Y = lsecond (pi);

 if (D % 4 == 0)
   {
   X = iprod (X,X);
   Y = iprod (Y,Y);
   Y = iprod (D,Y);
   }
 else
   {
   N = isum (X,Y);
   X = iprod (X,N);
   Y = iprod (Y,Y);
   Y = iprod (1+D,Y);
   }

 Y = iquot (Y,4);
 
 return (isum (X,Y));
 }
