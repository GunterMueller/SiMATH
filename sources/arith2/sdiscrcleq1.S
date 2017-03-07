/*M
.SH NAME
sdiscrcleq1 - single discriminant, reduced class equation, first method

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol sdiscrcleq1(D, L, s, f, g, MSG)  
single D, *s, MSG; 
list L; 
pol *f, *g;

.SH DESCRIPTION
.TP 4
.B D 
< 0 is a discriminant, i.e. d = 0 or 1 mod 4.
.TP 4
.B L
is a list, containing primitive, reduced and binary quadratic forms of discriminant D, such as the forms created by iprpdbqf.
.TP 4
.B s
points on a single *s, which is in {0, 1, 2, 3, 48}.
.TP 4
.B f, g
point on polynomials *f, *g respectively.
.TP 4
.B MSG
determines, whether there is an output on stdout (MSG = 1) or not (MSG =! 1).
.PP
sdiscrcleq1 returns a reduced class equation, say H, of the dicriminant D.
H is a monic and univariate polynomial over Z.
.PP
*s determines which class invariant is used in order to compute the reduced class equation:
.PP 
*s = 1: the class invariant j	(s. cmodinvj),
   = 2: the class invariant gamma_3 (s. cgamma3),
   = 3: the class invariant gamma_2 (s. cgamma2),    
   = 48: the Yui-Zagier function.
.PP
For *s = 0, sdiscrcleq1 chooses the invariant, which allows the fastest computation.
.PP
By the choice of *s, the following restriction have to be taken into account:
.PP
*s = 1: no restrictions,
   = 2: D != 0 mod 2,
   = 3: D != 0 mod 3,
   = 48: D != 0 mod 3 and D = 1 mod 8.
.PP
The polynomials *f and *g specify, how a zero, say x, of the reduced class equation transforms to a zero j of the non reduced class equation (*s = 1):
.PP
j = *f(x)/*g(x).
.PP
For example, in the case *s = 1, j is equal to x.
	
.SH SEE ALSO
 cmodinvj
 cgamma_2
 cgamma_3
 iprpdbqf

M*/

/*H
	Version 1	15.01.1993	Georg J. Lay
   DATE sdiscrcleq1   : 941201
H*/

#include<_arith2.h>

static pol Weber(int,complex (*cl_func)(),list,obj,single,single);
static complex cl_j(int,int,int,int,int);
static complex cl_gamma2(int,int,int,int,list);
static complex cl_gamma3(int,int,int,int,complex);
static complex cl_yui(int,int,int,int,list);
static int get_prec(int,list);
static list get_units(single);

pol sdiscrcleq1 (D,prforms,s,f,g,MSG)
single		 D,	  *s,	 MSG;
list		   prforms;
pol			    *f,*g;
 {
 single	 D2,D3,D8;
 single	 EPS_OLD, mode, prec, cl,h;
 complex cl_gamma2(), cl_j(), cl_yui(), cl_X0();
 complex cl_gamma3();
 complex (*cl_inv)();
 list	 W,eps,info;

 bind	(D,prforms);
 init	(W,eps,info);

 D8 = mshom (8,D);
 D3 = mshom (3,D);
 D2 = mshom (2,D);

 h =	llength (lfirst	 (prforms));		/* h ist der Polynomgrad	*/
 h += 2*llength (lsecond (prforms));

 cl = 1;					/* beste Invariante w"ahlen	*/
 if (D2 != 0)			cl =  2;
 if (D3 != 0)			cl =  3;
 if (D3 != 0) if (D8 == 1)	cl = 48;

 switch (*s) {
 case  0 : *s = cl;			break;
 case  1 :				break;
 case  2 : if (D2 == 0)			goto error;	break;
 case  3 : if (D3 == 0)			goto error;	break;
 case 48 : if (D3 == 0 || D8 != 1)	goto error;	break;
 default :				goto error; }

 EPS_OLD = FL_EPS;				/* FL_EPS merken		*/

 switch (cl = *s) {

 case 48:					/* Klasseninvariante von	*/
						/* N. Yui			*/
    cl_inv = cl_yui;
    mode   = 1;

    *f = list4 (24,1,0,-16);
    *f = piexp (1,*f,3);			/* Transformation ist		*/
    *g = list2 (24,1);				/* (x^24-16)^3 / x^24		*/

    prec =  get_prec (D,prforms);
    prec = prec/47 +1;
    if (prec < 3) prec = 3;
    flinit (prec);
    break;

 case 3:					/* Klasseninvariante ist	*/
						/* gamma_2			*/
    cl_inv = cl_gamma2;
    mode   = 1;
    *f = list2 (3,1);				/* Transformation ist		*/
    *g = list2 (0,1);				/* x^3				*/

    prec =  get_prec (D,prforms);
    prec = prec/3 +1;
    if (prec < 3) prec = 3;
    flinit (prec);				/* Genauigkeit ?		*/
    break;

 case 2:					/* Klasseninvariante ist	*/
						/* sqrt{-D}*gamma_2		*/
    cl_inv = cl_gamma3;
    mode   = 1;
    *f = iprod (D,1728);
    *f = list4 (2,1,0,*f);			/* Transformation ist		*/
    *g = list2 (0,D);				/* x^2/D + 1728			*/

    prec =  get_prec (D,prforms);
    prec = prec/2 + 10+(h*ilog10 (D))/2;
    if (prec < 3) prec = 3;
    flinit (prec);				/* Genauigkeit ?		*/
    break;

 case 1:					/* Klasseninvariante ist j	*/

    cl_inv = cl_j;
    mode   = 1;
    *f = list2 (1,1);				/* Transformation ist		*/
    *g = list2 (0,1);				/* x				*/

    prec =  get_prec (D,prforms);
    flinit (prec);				/* Genauigkeit ?		*/
    break;

 default:;  }

 eps = itofl (1);				/* Genauigkeit fuer die Koeffi-	*/
 eps = flsquot (eps,100);			/* zienten des Polynoms		*/

 if (MSG == 1)	{
	printf ("\n the degree of the class equation is %d\n",h);
	printf (" class equation according to parameter *s = %d\n",cl);
	printf (" the initial precision is %d decimal digits\n",9*FL_EPS);
	}

 FL_EPS -= 2;

 do
   {
   FL_EPS += 4;
   flPi ();
   FL_EPS -= 2;

   if (cl_inv == cl_yui)	info = get_units (48);
   if (cl_inv == cl_gamma2)	info = get_units ( 3);
   if (cl_inv == cl_gamma3)	{
				info = itofl (-D);
				info = flsqrt(info);
				info = ccri (0,info);
				}

   W = Weber (D,cl_inv,prforms,info,mode,MSG);
   W = upcround (W,eps);

   if (W == _0 && MSG)	
     fprintf (stderr,"\n *** sdiscrcleq1(%i,*,%d,*,*) :precision increased ***\n",D,cl);
   }
 while (W == _0);

 FL_EPS = EPS_OLD;

 return (W);

 error:
 
 fprintf (stderr,"\n*** sdiscrcleq1(%d,*,s,*,*): bad parameter s = %d ***\n",D,*s);

 return (0);
 }




/*	wir basteln aus a den Linearfaktor x-a:		*/

#define	to_l(a)	((a == 0) ? list2 (1,_1) : (DUM = cneg(a),list4 (1,_1,0,DUM)))

static
pol Weber (D,cl_func,formen,info,mode,MSG)
int	   D;
complex	   (*cl_func)();
list		     formen;
obj			    info;
single				 mode,MSG;
 {
 double percent;
 int   a,b,c,L1,h;
 int   W_D,_1,x_j;
 complex j,x,z;

 init (a,b,c,L1);
 init (W_D,_1,x_j);
 init (j,x,z);

 _1 = cisum (0,1);					/* die komplexe 1		*/

 h =	llength (lfirst	 (formen));			/* h ist der Polynomgrad	*/
 h += 2*llength (lsecond (formen));

 W_D = list2 (0,_1);

 percent = 0.0;

 if (MSG == 1) {
   printf ("%5.1f%%",percent);
   fflush(stdout); 
   }

 for (L1 = lfirst (formen); L1 != _0; L1 = lred (L1))
   {
   a = lelt (lfirst (L1),1);
   b = lelt (lfirst (L1),2);
   c = lelt (lfirst (L1),3);

   j = cl_func (D,a,b,c,info);

   if (mode == 1) j = csimag (j,0);
   x_j = to_l (j);
   W_D = pcprod (1,W_D,x_j);

   if (MSG == 1) {
     printf ("\t%5.1f%%",100.0*(percent += 1.0)/((double) h));
     fflush(stdout); }
   }

 for (L1 = lsecond (formen); L1 != _0; L1 = lred (L1))
   {
   a = lelt (lfirst (L1),1);
   b = lelt (lfirst (L1),2);
   c = lelt (lfirst (L1),3);

   j = cl_func (D,a,b,c,info);
   
   if (mode == 1)				/* die Nullstelle zur negativen	*/
     {						/* Form (a,-b,c) ergibt sich	*/
     z = csabsv (j);				/* durch _j = conjg (j), wenn	*/
     z = ccri (z,0);				/* j die Nullstelle zur Form	*/
     x = creal (j);				/* (a,b,c) ist.			*/
     x = ccri (x,0);				/* Erzeuge den Faktor		*/
     x = ciprod (x,-2);				/* (x-j)*(x-_j)			*/
     x_j = list4 (2,_1,x,z);
     x_j = dptop (1,x_j);

     percent += 1.0;
     }
   else {					/* berechnet die Nullstelle	*/
     x_j = to_l (j);				/* wie "ublich			*/
     W_D = pcprod (1,W_D,x_j);

     if (MSG == 1) {
       printf ("\t%5.1f%%",100.0*(percent += 1.0)/((double) h));
       fflush(stdout); }

     b = ineg (b);
     j = cl_func (D,a,b,c,info);

     x_j = to_l (j);
     }
   W_D = pcprod (1,W_D,x_j);

   if (MSG == 1) {
     printf ("\t%5.1f%%",100.0*(percent += 1.0)/((double) h));
     fflush(stdout); }
   }
 if (MSG == 1) printf ("\n");

 return (W_D);
 }



static
complex cl_j (D,a,b,c,empty)
int	      D,a,b,c,empty;
 {
 complex j;
 init	(j);

 j = iqfroot (a,b,c);
 j = cmodinvj (j);

 return (j);
 }



static
complex cl_gamma2 (D,a,b,c,Z_3)
int		   D,a,b,c;
list			   Z_3;
 {
 single k;
 int   tau,g2;
 init (tau,g2);

 k = (a % 3 == 0) ? -c : a;

 k = mshom (3,b*k);

 tau = iqfroot (a,b,c);
 g2 = cgamma2 (tau);

 if (k != 0)	g2 = cprod (g2,lelt (Z_3,k));  

 return (g2);
 } 



static
complex cl_gamma3 (D,a,b,c,sqrt_D)
int		   D,a,b,c;
complex			   sqrt_D;
 {
 single k;
 int   tau,g3;
 init (tau,g3);

 tau = iqfroot (a,b,c);

 g3 = cgamma3 (tau);

 k = mshom (4,b);
 if (a % 2 == 0) if (c % 2 == 0) k = 4-k;

 if (k == 1) g3 = cneg (g3);  

 g3 = cprod (g3,sqrt_D);

 return (g3);
 } 



static
complex cl_yui (D,a,b,c,Z_48)
int		D,a,b,c;
list			Z_48;
 {
 single ex,eps,ac;

 int   tau,yui;
 init (tau,yui);

 tau = iqfroot	(a,b,c);

 eps = 0;

 a = mshom (48,a);
 b = mshom (48,b);
 c = mshom (48,c);

 ac = a*c % 48;

 if (a % 2 == 0) if (c % 2 == 0)
   {
   yui = cweberf (tau);
   ex = a-c-ac*c;
   }

 if (a % 2 == 0) if (c % 2 != 0)
   {
   yui = cweberf1 (tau);
   ex = a-c-ac*c;
   if (((D-1)/8) % 2 != 0) eps = 1;
   }

 if (a % 2 != 0) if (c % 2 == 0)
   {
   yui = cweberf2 (tau);
   ex = a-c+a*ac; 
   if (((D-1)/8) % 2 != 0) eps = 1;
   }

 ex = mshom (48,24*eps+b*ex);
 if (ex != 0) yui = cprod (lelt (Z_48,ex),yui);

 return (yui);
 } 



static
int get_prec (D,prforms)			/* Gibt Anzahl der be-	*/
int	      D;				/* noetigten Dezimalen	*/
list		prforms;
 {
 single h;
 list	l;
 double stellen, dD, fltoCfl();

 bind (D);

 h = llength (lfirst (prforms)) + 2*llength (lsecond(prforms));

 stellen = 0.0;
 for (l = lfirst  (prforms); l != _0; l = lred (l))	stellen += 1.0/((double) lfirst (lfirst (l)));
 for (l = lsecond (prforms); l != _0; l = lred (l))	stellen += 2.0/((double) lfirst (lfirst (l)));

 D  = itofl   (D);
 dD = fltoCfl (D);

 stellen *= M_PI/log(10.0) * sqrt (-dD);

 return (5 + h/4 + ((int) stellen));
 }


static
list get_units (n)			/* gibt eine Liste der n. Einheits-	*/
single		n;			/* wurzeln ohne die 1			*/
 {
 single	 i;
 complex c,z,_1;
 list	 Units,h;

 init	(c,z,_1);
 init	(Units);

 _1 = cisum (0,1);			/* die komplexe Eins			*/

 switch (n) {
 
 case 3:

    z	  = cexpsv  (_1,3);		/* z = 1^{1/3}				*/
    Units = list1   (z);
    z	  = cconjug (z);
    Units = lcomp   (z,Units);
    Units = linv    (Units);

    return (Units);

 case 48:

    z = cexpsv (_1,48);			/* z = 1^{1/48}				*/

    for (Units = list2 (z,_1), i = 2; i<=6; i++)
      {
      c = cprod (lfirst (Units),z);
      Units = lcomp (c,Units);
      }

    for (h = lred (Units); h != _0; h = lred (h))
      {
      c = lfirst (h);
      c = ccri (cimag(c), creal (c));
      Units = lcomp (c,Units);
      }

    for (h = lred (Units); h != _0 ; h = lred (h))
      {
      c = creal (lfirst (h));
      c = flneg (c);
      c = ccri (c, cimag (lfirst (h)));
      Units = lcomp (c,Units);
      }

    for (h = lred (Units); h != _0; h = lred (h))
      {
      c = cconjug (lfirst (h));
      Units = lcomp (c,Units);
      }

    Units = lred (Units);
    Units = linv (Units);

    return (lred (Units));
  }				/* end of switch			*/
 }

