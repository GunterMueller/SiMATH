/*M
.SH NAME
lsizerec - list size recursive part (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

single lsizerec (L, n)  
list L, 
single n;
   
.SH DESCRIPTION
lsizerec is the recursive part of lsize

.SH SEE ALSO
lsize

M*/
            
/*H
	Version 1	14.10.1992	Georg Lay
   DATE lsizerec      : 921130
H*/

#include <_list.h>
#include <string.h>

single lsizerec (l,len)
list l;
single len;
 {
 list lf;

 for (; l != _0; l = lred (l))
   {
   lf = lfirst (l);

   if (!isatom (lf))	len = lsizerec (lf,len + 2);
   else
     {
     char str[20];

     sprintf (str," %d ",lf);

     len += strlen (str);
     }
   }

 return (len + 2);
 }
