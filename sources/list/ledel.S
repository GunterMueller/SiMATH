/*M
.SH NAME
ledel - list element delete

.SH SYNOPSIS
.nf
#include<_list.h>

obj ledel (pL,n)  
single n; 
list *pL;

.SH DESCRIPTION
.TP 4
.B n 
is an integer number, 0 < n < BASIS.
.TP 4
.B pL
points on a list, say L. L must have at least n ele-ments.
.PP
ledel deletes the n-th element in L and returns that ele-ment.
 
M*/
              
/*H
	Version 1	25.02.1992	Georg Lay
   DATE ledel         : 920331
H*/

#include <_list.h>

obj	ledel (pL,n)
list *pL;
single n;
 {
 single i;
 list   l,o;

 if (n == 1) 
   {
   o = lfirst (*pL);
   *pL = lred (*pL);
   
   return (o);
   }

 l = *pL;

 for (i = 2; i < n; i++) l = lred (l);

 o = lfirst (lred (l));

 lsred (l,lred2 (l));
 
 return (o);
 }
