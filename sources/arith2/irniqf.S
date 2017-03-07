/*M
.SH NAME
irniqf - integer representation as a norm in an imaginary quadratic field

.SH SYNOPSIS
.nf
#include <_arith2.h>

list irniqf(D, m, Fak, mode)
int  D,m;
list *Fak;
single mode;

.SH DESCRIPTION
irniqf() returns the list L of solutions to the norm equation
m = N(pi) where pi is an element of the maximal order O_K
of the imaginary quadratic field K = Q(sqrt(D)).
Every solution is represented as a list pi = (a,b) of two integers
a and b. The represented value equals pi = a + b * w with
.nf

	w = (1 + sqrt (D)) / 2  if D = 1 mod 4
	w = sqrt (D) / 2        if D = 0 mod 4

.fi
.PP
.TP 4
.B *Fak
is a list that either contains the factorization of m or
is the empty list. In the latter case, irniqf() determines
the factorization and saves it into *Fak.

.TP 4
.B mode
is a flag indicating which solutions should be contained in the result.
For mode = 0 the list L contains all principal ideals of O_K of Norm m,
where each such ideal is reported only once (by a generator).
For mode = 1 the list L contains all solutions and for mode = 2
the list L contains all solutions up to conjugation, i.e. all elements
of L have a non-negative imaginary part.
M*/
/*T
.N
	irniqf
.D
	integer representation as a norm in an imaginary quadratic
	field
.A
	$(D, m, Fak, mode)$
.SS
	#include <_arith2.h>

	list irniqf @
	int $D, m$;
	list $*Fak$;
	single $mode$;

	$L$ = irniqf @;
.SP
	$D$ is a discriminant of an imaginary quadratic field
	$m >= 1$
	$mode \in \{0, 1, 2\}$		
.PD
	irniqf determines solutions to the norm equation
	$m = N(\pi)$ where $\pi$ lies in the maximal order
	$\O_K$ of the imaginary quadratic field $K = \Q(\sqrt{D})$.
	The list $*Fak$ either contains the factorization of $m$ or
	is the empty list. In the latter case, irniqf determines the
	factorization and saves it in $*Fak$. Every solution is a list of
	the form $\pi = (a,b)$ and represents the number $\pi = a + b \* w$
	whith
.I 20
	$w = (1 + \sqrt{D})/2$,
	if $D \= 1 \mod 4$
.I
	$w = \sqrt{D}/2$,
	if $D \= 0 \mod 4$
.I

	The meaning of $mode$ is
.I 10
	$mode = 0$
	$L$ is a list of all principal ideals of $\O_K$ of Norm
	$m$. Each such ideal is reported only once (by a generator).
.I
	$mode = 1$
	$L$ contains all solutions to the norm equation
.I
	$mode = 2$
	$L$ contains all solutions to the norm equation up to
	conjugation: all elements of $L$ have non-negative imaginary
	part.	
T*/
/*H
	Version 1	01.10.1994	Georg J. Lay
	Version 2	01.02.1996	neue Doku	GL
   DATE irniqf       : 941201.960501
H*/

#include <_arith2.h>

static int DD;
static int D4;
static int D8;

static single base_insert (list,int,int);
static list ID_C (list);
static list ID_exp (list,int);
static list ID_prod (list,list);
static int LLLred (int,int);
static list next (list,list);
static int norm (list,list);
static list pimul1 (single,list);
static int scalar4 (list,list);
static list split_p (int, int, int*);

list
irniqf (D,m,Fak,mode)
int	D,m;
list	   *Fak;
single		mode;
{
 single typ,e,i;
 int p;
 list  L,A,B,Norm,Base,Split,SplitC,Id_p,Ex,ex,Id,Id_pC;

 init (p);
 globinit (&DD);
 init (L,A,B,Norm,Base,Split,SplitC,Id_p,Ex,ex,Id,Id_pC);

 D4 = mshom (4,D);
 D8 = mshom (8,D);

 DD = idif  (D,D4);				/* DD = (D -  D mod 4) / 4			*/
 DD = iquot (DD,4);

 if (*Fak == _0)	*Fak = ifact (m);

 Ex  = _0;
 Base = list3 (1,0,1);				/* Base = Max_Order			*/
 Split = SplitC = _0;
 for (L = ifel (*Fak); L != _0; L = lred2 (L)) {
	p    = lfirst  (L);
	e    = lsecond (L);
	Id_p = split_p (D,p,&typ);

	if (typ == -1)
		if (iodd (e) == 1) {
			Base = _0;
			break;
			}
		else 	for (i = 1; i <= e/2; i++)	Base = ID_prod (Base,Id_p);

	if (typ == 0)	for (i = 1; i <= e; i++)	Base = ID_prod (Base,Id_p);

	if (typ == 1) {
		Split = lcomp (Id_p,Split);
		Id_pC = ID_C (Id_p);
		SplitC= lcomp (Id_pC,SplitC);
		Ex    = lcomp (e   ,Ex);
		}
	}

 ex = lcopy (Ex);

 Norm = _0;

 if (Base != _0) do 	{
	Id = Base;

	for (i = 1; i<= llength (ex); i++) {
		Id_p  = ID_exp (lelt (Split,i), lelt (ex,i));
		Id_pC = ID_exp (lelt (SplitC,i),lelt (Ex,i) - lelt (ex,i));
		Id = ID_prod (Id,Id_p);
		Id = ID_prod (Id,Id_pC);
		}
	A = list2 (lelt (Id,1), 0);
	B = list2 (lelt (Id,2), lelt (Id,3));

	A = LLLred (A,B);

	L = norm (A,0);
	if (icomp (L,m) == 0) {
		if (lcomp (lsecond (A),0) < 0)	A = vecineg (A);
		Norm = lcomp (A,Norm);
		}

	if (Ex == _0)	break;
	}
 while (next (ex,Ex) != _0);

 if (mode != 0) {
    B = _0;
    for (L = Norm; L != _0; L = lred (L)) {
	A = lfirst (L);
	B = lcomp (A,B);
	switch (D) {
		case -3:
			A = pimul1 (3,A);  B = lcomp (A,B);
			A = pimul1 (3,A);  B = lcomp (A,B);
			break;       
		case -4:
			A = pimul1 (4,A);  B = lcomp (A,B);
			break;
		
		}
	}

    Norm = B;
    B = _0;
    for (L = Norm; L != _0; L = lred (L)) {
	A = lfirst (L);
	B = lcomp (A,B);
	A = pimul1 (2,A);
	B = lcomp (A,B);
	}

    Norm = B;
    }

 if (mode == 2) {
    B = _0;
    for (L = Norm; L != _0; L = lred (L)) {
	A = lfirst (L);
	if (icomp (lsecond (A),0) >= 0)		B = lcomp (A,B);
	}
    Norm = B;
    }

 return (Norm);
 }

/********************************************************************************/
/* Multipliziert pi mit primitiver r. Einheitswurzel                            */
/********************************************************************************/

static
list pimul1 (r,pi)
single r;
list pi;
 {
 int   A,B;
 init (A,B);

 A = lfirst (pi);
 B = lsecond(pi);

 switch (r)
 {
 case 2:
   A = ineg (A);
   B = ineg (B);
   pi = list2 (A,B);
   break;

 case 3:
   B = isum (A,B);
   B = ineg (B);
   pi = list2 (B,A);
   break;

 case 4:
   B = ineg (B);
   pi = list2 (B,A);
   break;
   }
 
 return (pi);
 }





static
list next (ex,Ex) /* zaehlt die Exponenten durch */
list  ex,Ex;
{
 single a;

 do	{
	a = lfirst (ex)-1;
	if (a < 0) {
		a = lfirst (Ex);
		lsfirst (ex,a);
		ex = lred (ex);
		Ex = lred (Ex);
	}
	else	{
		lsfirst (ex,a);
		break;
	}
 }
 while (Ex != _0);
 return (Ex);
}


static
list split_p (D, p, typ)			/* zerlegt p in Q(sqrt{D})		*/
int	      D, p,*typ;
 {
 int   u,v,w;
 list  I;
 bind (D);
 init (u,v,w);
 init (I);

 if (p == 2) {
	switch (D8) {
	case 0:	I = list3 (2,0,1);
		*typ = 0;
		break;

	case 4:	I = list3 (2,1,1); 
		*typ = 0;
		break;

	case 5:	I = list3 (2,0,2);
		*typ = -1;
		break;

	case 1:	I = list3 (2,0,1);
		*typ = 1;
		break;
	default: fprintf (stderr,"\nWarning: D  = %i is not a discriminant\n\n",D);
		}

	return (I);
	}

 D = mihom (p,D);

 if (D == 0) {
	*typ = 0;
	I = list3 (p,0,p);
	w = (D4 == 0) ? D4 : miinv (p,2);
	u = mineg (p,w);
	v = 1;

	base_insert (I,u,v);

	u = DD;
	v = midif (p,D4,w);

	base_insert (I,u,v);

	return (I);
	}

 w = mipsqrt (p,D);

 if (w == -1) {
	*typ = -1;	
	I = list3 (p,0,p);
	return (I);
	}

 w = misum   (p,w,D4);
 w = miquot  (p,w,2); 

 *typ = 1;
 I = list3 (p,0,p);
 u = mineg (p,w);
 v = 1;

 base_insert (I,u,v);

 u = DD;
 v = midif (p,D4,w);

 base_insert (I,u,v);

 return (I);
 }
	

static
int LLLred (A,B)	/* reduziert {A,B} mit LLL bei Norm aus		*/
int	A,B;	/* Skalarprodukt				*/
 {
 single s;
 int   l,S,N;

 bind (A,B);
 init (l,S,N);

 do	{
	S = A; A = B; B = S;

	S = scalar4 (A,B);
	N = scalar4 (A,A);

	s = isign (S);
	S = iabs (S);
	S = isum (S,S);
	S = isum (S,N);
	N = isum (N,N);
	l = iquot (S,N);
	l = iprod (l,s);

	S = vecismul (l,A);
	B = vecidif (B,S);

	N = norm (A,0);
	S = norm (B,0);
	}
 while (icomp (S,N) < 0);

 return (A);
 }



static
list ID_exp (I,n)	/* berechnet I^n			*/
list	     I;
int	       n;
 {
 list J;

 bind (I,n);
 init (J);

 J = list3 (1,0,1);				/* J = 1 ( = OrdMax )			*/

 while (n != 0) {
	if (iodd (n) == 1)	J = ID_prod (J,I); 
	n = iquot (n,2);
	if (n != 0)		I = ID_prod (I,I);
	}

 return (J);
 }



static
list ID_C (I)					/* das komplex Konjugierte von I	*/
list	   I;
 {
 int   a,b,c;
 init (a,b,c);

 a = lelt (I,1);
 b = lelt (I,2);
 c = lelt (I,3);

 if (D4 == 1) b = isum (b,c);
 c = ineg (c);

 return (list3 (a,b,c));
 }


static
list ID_prod (I,I_)				/* multipliziert I  = [a ,b +c * w]	*/
list	      I,I_;				/* mit		 I' = [a',b'+c'* w]	*/
 {
 list J;
 int u,v,w;
 int a ,b ,c;
 int a_,b_,c_;

 init (J);
 init (u,v,w);
 init (a ,b ,c);
 init (a_,b_,c_);

 a = lelt (I,1);	a_ = lelt (I_,1);
 b = lelt (I,2);	b_ = lelt (I_,2);
 c = lelt (I,3);	c_ = lelt (I_,3);

 u = iprod (a,a_);
 v = iprod (a,b_);
 w = iprod (a,c_);

 J = list3 (u,v,w);

 u = iprod (a_,b);
 v = iprod (a_,c);

 base_insert (J,u,v);

 u = iprod (b,b_);
 v = iprod (c,c_);
 w = iprod (v,DD);
 u = isum  (w,u);

 if (D4 == 0) 	v = 0;

 w = iprod (b,c_);	v = isum  (w,v);
 w = iprod (c,b_);	v = isum  (w,v);

 base_insert (J,u,v);

 return (J);
 } 


/*
	I = (a,b,c) repraesentiert den von (a,0) und (b,c) erzeugten
	Z-Modul.
	I = (a',b',c') wird veraendert zu dem von (a,0), (b,c)
	und (u,v) erzeugten Z-Modul
*/

static
single base_insert (I,u,v)
list I;
int  u,v;
 {
 int a,b,c;
 int aa,cc,ggT,r,q;

 init (a,b,c);
 init (aa,cc,ggT,r,q);

 if (u == 0) if (v == 0)	return (0);

 a = lfirst  (I);
 b = lsecond (I);
 c = lthird  (I);

 ggT = iegcd (c,v,&aa,&cc);

 r = iprod (c,u);
 q = iprod (v,b);
 r = idif  (r,q);
 r = iquot (r,ggT);				/* r = (c*u - v*b) / ggT		*/

 a = igcd (a,r);
 a = iabs (a);
 q = iprod (cc,u);
 b = iprod (aa,b);
 b = isum  (b,q);
 c = ggT;
 b = mihoms (a,b);

 leset (I,1,a);
 leset (I,2,b);
 leset (I,3,c);

 return (0);
 }


/********************************************************************************/
/*** Norm von pi + k                                                            */
/********************************************************************************/


static
int norm (pi,k)
list	  pi,k;
 {
 int   X,Y,X_;
 init (X,Y,X_);

 X = lfirst  (pi);
 X_ = isum (X,k);
 Y = lsecond (pi);

 if (D4 == 1)	X = isum (X,Y);

 X = iprod (X,X_);
 Y = iprod (Y,Y);
 Y = iprod (Y,DD);

 return (idif (X,Y));
 }



static
int scalar4 (A,B)		/* gibt 4*<A,B>	*/
list	A,B;
 {
 int   S,a,b,c;
 init (S,a,b,c);

 S = DD;

 b = lsecond (A);
 a = iprod (2,lfirst (A)); 	if (D4 == 1)	a = isum (a,b);

 S = iprod (S,b);

 b = lsecond (B);
 c = iprod (2,lfirst (B)); 	if (D4 == 1)	c = isum (c,b);

 S = iprod (S,b);
 S = iprod (S,4);

 a = iprod (a,c);
 return (idif (a,S));
 }
