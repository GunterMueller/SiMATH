/*M
.SH NAME
lscountup - list of singles count up

.SH SYNOPSIS
.nf
#include<_arith1.h>

list lscountup(L,k)
single k;
list L;

.SH DESCRIPTION
lscountup() is used to enumerate all lists
of singles. A list L is regarded as a r-tuple
of singles written from the tail to the head.
The tuples are order by
.TP 4
.PP
1. the sum of the absolute values and
.TP 4
.PP
2. lexicographically
.PP
where the ordering on Z is 0 < 1 < -1 < 2 < -2 ...
lscountup() returns the successor of L which has
at least one entry changed starting at the k-th place.
.SH EXAMPLE
.nf
Let L=(0,0), then successive calls to L=lscountup(L,1)
will yield (1,0), (-1,0), (0,1), (0,-1), (2,0), 
(-2,0), (1,1), (-1,1), (1,-1), (-1,-1), (0,2), ... 
M*/
/*H
        Version 1       04.05.1995      Wolfgang Schwarz
   DATE lscountup     : 951201
H*/

#include <_arith1.h>

list lscountup(L,k)
list L;
single k;
{single i,a,b;
 bind(L);

 a=0;
 for (i=1;i<k;i++)
  {a+=sabs(lfirst(L));
   L=lred(L);
  }
 if (a>0)
   {b=lfirst(L);
    L=lred(L);
    if (b>0) b = -b;
    else {b=1-b; a--;}
    L=lcomp(b,L);
    for (i=2;i<k;i++) L=lcomp(0,L);
    L=lcomp(a,L);
   }
 else
   {do
       {a=lfirst(L);
        L=lred(L);
        i++;
       } while (a==0 && L!=_0);

    if (a>0) {L=lcomp(-a,L); for (;i>2;i--) L=lcomp(0,L);}
    else {      if (L==_0)
                       {for (;i>2;i--) L=lcomp(0,L);
                        L=lcomp(1-a,L);
                        if (a==0 && k>1) L=lscountup(L,k);
                       }
                else   {b=lfirst(L);
                        L=lred(L);
                        if (b>0) {L=lcomp(-b,L);a = -a;}
                        else     {L=lcomp(-b+1,L);a = -a-1;}
                        for (;i>2;i--) L=lcomp(0,L);
                        L=lcomp(a,L);
                       }

         }
 }
 return(L);
}

