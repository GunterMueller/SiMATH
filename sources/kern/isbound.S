/*C
			isbound(pL)    

	"is bound in STACK ?"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	single isbound(pL)  obj *pL;
	n = isbound(pL);
	n = 1, falls pL im STACK eingetragen ist,
	sonst n=0.
C*/
/*H
	Version 1       03.02.1992	Marc Conrad
	Version 2	15.10.1993	stand versehentlich in 'list.  PS
   DATE isbound       : 920331.931130
H*/



#include<_list.h>

single isbound( pL )    
list *pL;  
{ 
single i; 
for (i=0; i<ST_INDEX; i++ )
	if ( pL == *(STACK+i) ) return(1);
return( 0 );
}
