/*M
.SH NAME
sputl - string put list

.SH SYNOPSIS
.nf
#include<_list.h>
 
char* sputl(l, str)  
list l; 
char *str;
 
.SH DESCRIPTION
sputl writes the list l to str and returns a pointer to str.

.SH CAUTION
sputl does not verify, if str is large enough.

M*/

/*H
	Version 1	14.10.1992	Georg Lay
	Version 2	11.12.1992	Funktionstyp char* statt void.  GL
	Version 2	16.01.1993	sputlrec als static. GL
   DATE sputl         : 921130.930115.930531
H*/

#include <_list.h>

static list sputlrec(list,list);

char* sputl (l,p0)
list l;
char *p0;
 {
 list  strl;
 char  *p;

 bind (l);
 init (strl);

 p = p0; 

 strl = sputlrec (l,_0);
 strl = lred (strl);
 strl = linv (strl);

 for (strl = lred (strl); strl != _0; strl = lred (strl)) 
   *(p++) = lfirst (strl);

 *p = '\0';

 return (p0); 
 }


static
list sputlrec (l,strl)
list l,strl;
 {
 list lf;

 strl = lcomp2 ('(',' ',strl);

 for (; l != _0; l = lred (l))
   {
   lf = lfirst (l);

   if (!isatom (lf))	strl = sputlrec (lf,strl);
   else
     {
     char str[20],*s;

     sprintf (str," %d ",lf);

     for (s = str; *s != '\0'; s++)	strl = lcomp ((int) (*s),strl);
     }
   }

 strl = lcomp2 (' ',')',strl);

 return (strl);
 }


