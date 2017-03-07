/*M
.SH NAME
locqsort - list of objects, constructive quick sort

.SH SYNOPSIS
.nf
#include<_arith1.h>

list locqsort(L,Comp,mode)
list L;
single (*Comp)(), mode;

.SH DESCRIPTION
locqsort() returns the list L sorted ascendingly
with respect to the linear order determined by
the compare function Comp which must have the
following property:
.nf

    Comp(a, b) < 0, if a < b
    Comp(a, b) = 0, if a = b
    Comp(a, b) > 0, if a > b

The value of mode must be either 0 or 1,
where for mode = 1 duplicate elements of
L will not be returned.

.SH EXAMPLE
.nf
int  icomp();
list L;

L = list5 (0,1,3,0,1);
L = locqsort (L, icomp, mode);
...
mode = 0: L = (0, 0, 1, 1, 3);
mode = 1: L = (0, 1, 3);

Here locqsort() hat the same effect as libsort(),
but works significantly faster.
M*/
/*H
        Version 1       01.02.1994      Georg Lay
   DATE locqsort      : 941201
H*/

#include <_arith1.h>

static int (*comp)();
static void quicksort (int*,int);

list	locqsort (L,Comp,mode)
list		  L;
int		  (*Comp)(),mode;
 {
 int len,*a,*A,old;
 list l,L_sort,L_red;

 bind (L);
 init (L_sort,L_red);

 if (llength (L) <= 1)	return (L);

 comp = Comp;
 len  = llength (L);

 a = A = (int*) calloc (len,sizeof (int));

 if (A == NULL) {
	fprintf (stderr,"\n\nlocqsort: *** out of memory, not sorting ***\n");
	return  (L);
	}

 for (l = L; l != _0; l = lred (l))
	*(a++) = lfirst (l);


 quicksort (A,len);

 L_sort = _0;
 for (a = A; len > 0; len--)
	L_sort = lcomp (*(a++), L_sort);

 cfree (A);

 if (mode == 0)	return (linv(L_sort));

 old = lfirst (L_sort);
 L_red  = list1 (old);

 for (l = lred (L_sort); l != _0; l = lred (l))
	if (comp (lfirst (l),old) != 0) {
		old = lfirst (l);

		L_red = lcomp (old,L_red);
		}

 return (L_red);
 }


static
void swap ( a, b)
int	   *a,*b;
 {
 int c;

 c = *a;
 *a = *b;
 *b = c;
 }


static
int *split_array ( A, na, nb)
int		  *A,*na,*nb;
 {
 int *a,*b,*B,x;

 x  = A[irand(*na)];

 a  = A;
 B  = A;
 B += (*na);

 *na = *nb = 0;

 while ((long)a < (long)B)
   if (comp (*a,x) > 0)		swap (a,--B), (*nb)++;
   else				a++;

 a = A;
 b = B;

 while ((long)a < (long)b)
   if (comp (*a,x) == 0)	swap (a,--b);
   else				a++, (*na)++;

 return (B);
 }


static
void quicksort (A,na)
int	       *A,na;
 {
 if (na == 2)
   if (comp(A[0],A[1]) > 0) swap (A,A+1);

 if (na > 2)
   {
   int *B,nb;

   B = split_array (A,&na,&nb);

   quicksort (A,na);
   quicksort (B,nb);
   }
 }
