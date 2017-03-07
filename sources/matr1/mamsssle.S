/*M
.SH NAME
mamsssle - matrix of modular singles, solution of a system of linear equations

.SH SYNOPSIS
.nf
#include<_matr1.h>

single mamsssle(p, A, b, pX, pN)
single p;
matrix A;
vec b, *pX;
list *pN;

.SH DESCRIPTION
mamsssle() computes the solutions of the equation A*x=B.
In case there is no solution, the returned value is -1
and both *pX and *pN are empty lists.
If there is exactly one solution, it is assigned to *pX,
the returned value is zero and *pN is the empty list.
If there is more than one solution, *pX is an arbitrary
solution, the returned value is the dimension of the
null space and *pN is a list of basis vectors of the null space.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B A
is a mxn matrix over Z/pZ.
.TP 4
.B b
is a vector of length m over Z/pZ.
.TP 4
.B *pX
is a vector of length n over Z/pZ,
representing nothing or a solution.
.TP 4
.B *pN
is a vector over Z/pZ,
representing nothing or a basis of the null space.

.SH CAUTION
The matrix A will be changed.
M*/
/*H
	Version 1	23.03.1992	Georg Lay
	Version 2	09.05.1993	Module sind static	GL
   DATE mamsssle      : 920331.930531
H*/



/*cP
        Geloest wird das lineare Gleichungssystem     (*) A * x = b
        mittels Gausselimination.
        Es findet keine Pivotierung statt.
	Wird nur eine Nullraum-Basis von A gesucht, so setzt man b = _0.
        Die Funktion arbeitet ueber einem Koerper (K,+,*).
	K ist hierbet im Funktionskopf durch das Objekt 'charakter'
	charakterisiert.
	Ist die Funktion an einen anderen Koerper K' anzupassen, so ist
	folgendes zu beachten:
	(1) Die define-Definitionen sind an K' anzupassen.
	    Hierbei ist das Objekt, welches K' beschreibt, mit
	   '*charakter' zu bezeichnen. (Entfaellt unter Umstaenden)
	(2) Eventuell muss eine andere Include-Datei gewaehlt werden.
	(3) Falls die 0 in K' nicht durch das Atom '0' repraesentiert wird,
	    so ist die define-Anweisung 'oequal' ersatzlos zu streichen.
	(4) Die Funktion bleibt auch dann unkritisch, wenn die 0 bzw.
	    die 1 in K' durch Listen dargestellt werden.
Pc*/

        
#include <_matr1.h>

#define _NULL     0				/*  0   in K  */
	    /* _NULL statt NULL wegen NULL-Pointer in stdio.h */
#define EINS      1				/*  1     "   */
#define neg(a)    msneg(*charakter,a)		/*  -a    "   */
#define inv(a)    msinv(*charakter,a)		/*  1/a   "   */
#define dif(a,b)  msdif(*charakter,a,b)		/*  a-b   "   */
#define prod(a,b) msprod(*charakter,a,b)	/*  a*b   "   */
#define oequal(a,b) ((a)==_NULL)

single zeilen,spalten,rang,dim;

static single initial(list*,list*,list*);
static single ordnen(list*,list*,list*);
static single einsetzen(obj*,list*,list*,list*);
static list erweitern(obj*,list*,list*);
static single loesen(list);
static single dreieck(obj*,list*,list*,list*);
static obj durchsuchen(list*,list*,list*,single);
static zeilentausch(single,single,list*);
static spaltentausch(single,single,list*);

single mamsssle (charakter,A,b,px,pL)
obj charakter;
list   A,b,*px,*pL;		/*  b == _0   : nur Nullraum-Basis bestimmen  */
 {
 single s;
 list  perm,L;			/*  perm merkt Spaltentausche von A.          */
 init (perm,L);
 bind (charakter,A,b,*px,*pL);

 initial (&A,&b,&perm);

 rang = dreieck (&charakter,&A,&b,&perm);	 /* A auf obere 3-eck Gestalt */

 dim = loesen (b);			    

 if (dim >= 0)
   {
   L = erweitern (&charakter,&A,&b);	    /* erweitert (A|b) zu (A|b|L)*/
   einsetzen     (&charakter,&A,&b,&L);	    /* rueckwaerts einsetzen     */
   ordnen (&L,&b,&perm);		    /* Zeilen von L|b sortieren  */
   }

 if (dim>0)				    /* *pL bereitstellen         */
   {
   *px = b;
   *pL = matransp (L);
   }
 else
   if (dim == 0)
     {
     *px = b;
     *pL = _0;
     }
   else
     *px = *pL = _0;

 return (dim);
 }   

/*****************************************************************************/

static
single initial (A,b,perm)
list *A,*perm,*b;
 {
 single s;

 zeilen = manrrow (*A);
 spalten= manrcol (*A);

 *b = lcopy (*b);

 *perm = _0;
 for (s = spalten; s>0; *perm = lcomp (s--,*perm));   /*  perm[s] = s */

 if (*b==_0)
   {		
   obj   ___null;
   init (___null);

   ___null = _NULL;

   for (s=1; s<=zeilen; s++)      /* b = nullvec			  */
     *b = lcomp (___null,*b);
   } 
 return (0);
 }

/*****************************************************************************/

static
single ordnen (L,b,perm)
list *L,*b,*perm;
 {
 single n,z;
 list  l,m;
 init (l,m);

 z = 0;
 for (l = *perm; l!=_0; l = lred (l))
   if (lfirst(l) != ++z)
     {
     n = z+1;
     for (m = lred(l); lfirst (m) != z; m = lred (m)) n++;

     zeilentausch (z,n,L);
     zeilentausch (z,n,perm);
     zeilentausch (z,n,b);
     }
 return (0);
 }   

/*****************************************************************************/

static
single einsetzen (charakter,A,b,L)
obj *charakter;
list *A,*b,*L;
 {
 single z,s,d;
 obj dummy,dommy,dia,dib,l1b;
 list  l1A,l2A,l3A,l4A,l3b,l1L,l2L,l3L,l4L;
 init (l1A,l2A,l3A,l4A,l3b,l1L,l2L,l3L,l4L);
 init (dummy,dommy,dia,dib,l1b);
 
 for (d=rang; d>=2; d--)
   {
   l1b = lelt (*b,d);			    /*  l1b -> b[d]		*/
 
   l1A = *A;				    /*  l1A -> A[1]	        */
   l3L = *L;				    /*  l3L -> L[1]		*/
   l3b = *b;				    /*  l3b -> b[1]	        */

   for (z=1; z<d; z++)
     {
     l2A = lfirst (l1A);		    /*  l2A -> A[z,.]		*/
     dib = lelt   (l2A,d);		    /*  dib =  A[z,d]		*/
     l4L = lfirst (l3L);		    /*  l4L -> L[z,.]		*/
     l2L = lelt   (*L,d);		    /*  l2L -> L[d,.]		*/

     for (s=1; s<=dim; s++)		    /*  L[z] = A[z,d]*L[z]-L[d]	*/
       {
       dummy = lfirst (l2L);		    /*	    =  L[d,s]		*/
       dummy = prod   (dib,dummy);
       dommy = lfirst (l4L);		    /*	    =  L[z,s]		*/
       dummy = dif    (dommy,dummy); 
       lsfirst (l4L,dummy);
   
       l4L = lred (l4L);		    /*  s++			*/
       l2L = lred (l2L);
       }
     dummy = prod   (dib,l1b);		    /*  b[z] = A[z,d]*b[z]-b[d]	*/
     dommy = lfirst (l3b);
     dummy = dif    (dommy,dummy); 
     lsfirst (l3b,dummy);
					    /*  A[z,d] 'ist' nun _NULL	*/  
     l3L = lred (l3L);			    /*  z++			*/
     l3b = lred (l3b);
     l1A = lred (l1A);
     }
   }
 return (0);
 }

/*****************************************************************************/
          
static
list erweitern (charakter,A,b)
obj *charakter;
list *A,*b;
 {
 single z,s;
 obj dummy;
 list  lb,l1A,l2A,l1L,l2L;
 init (lb,l1A,l2A,l1L,l2L);
 init (dummy);

					    /* b wird auf richtige	*/
					    /* Laenge gebracht :	*/
 lb = linv (*b);			    /* Laenge(b) = spalten	*/
 if (zeilen>spalten)
   lb = lreduct (lb,zeilen-spalten);	    /* _NULLen abschneiden	*/
 else					    /* b.z.w.			*/
   {
   dummy = _NULL;
   for (z=zeilen+1; z<=spalten; z++)
     lb = lcomp (dummy,lb);		    /* _NULLen anhaengen	*/
   }
 *b = linv (lb);

 l1L = _0;				    /* L aufbauen :		*/
 l1A = *A;
 for (z=1; z<=rang; z++)		    /* L[z,s-rang] = -A[z,s]	*/
   {					    /* mit 1 <= z <= rang	*/
   l2L = _0;				    /*   rang < s <= spalten	*/
   l2A = lfirst (l1A);
   for (l2A = lreduct (l2A,rang); l2A!=_0; l2A = lred (l2A))
     {
     dummy = lfirst (l2A);
     dummy = neg (dummy);
     l2L   = lcomp (dummy,l2L);
     }
   l1L = lcomp (l2L,l1L);
   l1A = lred  (l1A);
   }

 for (z=rang+1; z<=spalten; z++)
   {
   l2L = _0;
   for (s=1; s<=dim; s++)
     {
     dummy = (s==z-rang) ? (EINS) : (_NULL);
     l2L = lcomp (dummy,l2L);
     }
   l1L = lcomp (l2L,l1L);
   }

 l1L = linv (l1L);
 return (l1L);
 } 

/*****************************************************************************/

static
single loesen (b)
list b;
 {
 obj   ___null;
 init (___null);

 ___null = _NULL;
 for (b = lreduct (b,rang); b!=_0; b = lred (b))
   if (!oequal(lfirst(b),___null))
     return (-1);

 return (spalten - rang);
 }

/*****************************************************************************/

static
single dreieck (charakter,A,b,perm)
obj *charakter;
list   *A,*b,*perm;   
 {
 single z,s,d,diagonal;
 obj dia,dib,dummy,dummy1,dummy2,___null;
 list   l1A,l2A,l3A,l4A,l5A,l1b,l3b;
 init  (l1A,l2A,l3A,l4A,l5A,l1b,l3b);
 init  (dia,dib,dummy,dummy1,dummy2,___null);

 ___null = _NULL;

 l1A = *A;				/*  l1A -> A[1]			    */
 l1b = *b;				/*  l1b -> b[1]			    */
 diagonal = (zeilen<spalten) ? zeilen : spalten;
 for (d=1 ;d<=diagonal; d++)
   {
   l5A = lfirst  (l1A);
   l5A = lreduct (l5A,d-1);		/*  l5A -> A[d,d]		    */

   dia = lfirst (l5A);			/*  dia  = A[d,d]		    */
   if (oequal(dia,___null))		/*  falls auf der Hauptdiagonalen   */
     {					/*  eine _NULL auftaucht,	    */
     dia = durchsuchen (A,b,perm,d);	/*  so in der Untermatrix	    */
					/*  A[z>=d,s>=d] Element != _NULL   */
     l1A = lreduct (*A,d-1);		/*  suchen und Zeiger aktualisieren */
     l1b = lreduct (*b,d-1);
     l5A = lfirst  (l1A);
     l5A = lreduct (l5A,d-1);
     }

   if (oequal(dia,___null))		/*  gefunden ?			    */
     return (--d);			/*  nein, dann mit rang(A) zurueck  */
   else					/*  ja, dann die Zeilen A[z>d]	    */
     {					/*  mit Gauss bearbeiten.	    */
     l3A = l1A;     
     l3b = l1b;

     dia = inv (dia);			/*  zunaechst Zeile (A|b)[d] so	    */
					/*  normieren, dass A[d,d] = EINS   */
     for (l2A = l5A; l2A!=_0; l2A = lred (l2A))
       {
       dummy = lfirst (l2A);
       dummy = prod (dia,dummy);
       lsfirst (l2A,dummy);
       }
     dummy = lfirst (l1b);
     dummy = prod (dia,dummy);
     lsfirst (l1b,dummy);

     for (z=d+1; z<=zeilen; z++)
       {
       l3A = lred (l3A);		/*  l3A -> A[z]			    */
       l3b = lred (l3b);

       l2A = l5A;
       l4A = lfirst  (l3A);
       l4A = lreduct (l4A,d-1);		/*  l4A -> A[z,d]		    */

       dib = lfirst (l4A);
       if (!oequal(dib,___null))
         {
         for (s=d+1; s<=spalten; s++)	/*  A[z] = A[z,d]*A[z]-A[d]	    */
           {
           l2A = lred (l2A);		/*  l2A -> A[d,s]		    */
           l4A = lred (l4A);		/*  l4A -> A[z,s]		    */

           dummy1 = lfirst (l4A);
           dummy2 = lfirst (l2A); 
           dummy2 = prod (dib,dummy2);
           dummy1 = dif  (dummy1,dummy2);
           lsfirst (l4A,dummy1);
           }
         dummy1 = lfirst (l3b);		/*  b[z] = A[z,d]*b[z]-b[d]	    */
         dummy2 = lfirst (l1b); 
         dummy2 = prod (dib,dummy2);         
         dummy1 = dif  (dummy1,dummy2);
         lsfirst (l3b,dummy1);
         }
       }
     }
   l1A = lred (l1A);
   l1b = lred (l1b);  
   }
 return (--d);
 }  

/*****************************************************************************/

static
obj durchsuchen (A,b,perm,d)
single d;
list   *A,*b,*perm;
 {
 single z,s;
 obj   dia,___null;
 list   l1,l2;
 init  (l1,l2);
 init (dia,___null);

 z = d;
 for (l1 = lreduct (*A,d-1); l1!=_0; l1 = lred (l1))
   {
   s = d;
   l2 = lfirst (l1);
   for (l2 = lreduct (l2,d-1); l2!=_0; l2 = lred (l2))
     {
     dia = lfirst (l2);			/*  = A[z,s]			    */
     if (!oequal(dia,___null))		/*  falls != _NULL, so		    */
       {				/*  A[z,s] nach A[d,d]		    */
       if (z!=d)
         {
         zeilentausch (d,z,A);
         zeilentausch (d,z,b);
         }
       if (s!=d)
         {
         spaltentausch (d,s,A);
         zeilentausch  (d,s,perm);
         }
       return (dia);
       }
     s++;
     }
   z++;
   }
 return (dia);
 }

/*****************************************************************************/

static
zeilentausch (z1,z2,v)
single z1,z2;
list   *v;
 {
 single i;
 obj   o1,o2;
 list  l1,l2;
 init (l1,l2,o1,o2);

 if (z1>z2) {i=z1; z1=z2; z2=i;}

 l1 = lreduct (*v,z1-1);
 l2 = lreduct (l1,z2-z1);

 o2 = lfirst (l2);
 o1 = lfirst (l1);
 lsfirst (l2,o1);
 lsfirst (l1,o2);
 }

/*****************************************************************************/

static
spaltentausch (s1,s2,v)
single s1,s2;
list   *v;
 {
 list  l,h;
 init (l,h);

 for (l = *v; l!=_0; l = lred (l))
   {
   h = lfirst (l);
   zeilentausch (s1,s2,&h);
   }
 }
