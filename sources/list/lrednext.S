/*M
.SH NAME
lrednext - list of reductants next

.SH SYNOPSIS
.nf
#include<_list.h>
 
list lrednext( L )  
list L;
   
.SH DESCRIPTION
.TP 4
.B L
= ( L(1), ..., L(n)), n > 0, is a list containing lists L(i), such that L(i) is a non-empty reductant of L(i+1).
.PP
lrednext returns a list R = (R(1), ..., R(n)), where R(i) is a non-empty reductant of L(i) and R(i+1) for 1 <= i < n. If no such list exists, lrednext returns the empty one.
 
M*/

/*H
	Version 1       13.04.1988      R.Boeffgen
	Version 2       09.02.1989      fehlende Initialisierung von l
					ergaenzt.  A.Stein
	Version 3       10.02.1989      Dokumentation ergaenzt.  PS
	Version 4       13.02.1989      Ueberarbeitete Version. A.Stein 
	Version 5       27.02.1991      Initialisierung von i nicht mehr
					2 sondern 1. A.Stein
   DATE lrednext      : 890501.910301
H*/


# include <_list.h>

list lrednext( L )
list L;
{
	list R, l, f, r;
	bind(l);         

   /***    reduziere erste Liste falls moeglich,    ***/
   /***    d.h. falls erste Liste Laenge > 1 hat    ***/
	
	l = lfirst( L );
	R = lred( L );
	if ( (r=lred(l)) != _0 )  R = lcomp( r,R );
	else {

   /***    andernfalls finde (falls moeglich) erste reduzierbare Liste,    ***/
   /***    d.h. erste Liste, deren Vorgaenger nicht ihr 1.Reduktum ist     ***/
		
		single i=1;
		while ( R != _0 )  {
			f = lfirst( R ) ;
			R = lred( R );
			i++;                       
            		if ( (r=lred(f)) != l ) {  

	/***    konstruiere Ergebnisliste, falls eine    ***/
  	/***    reduzierbare Liste gefunden wurde        ***/

                         	while ( i-- ) {
					R = lcomp( r,R );
					r = lred( r );
		  		}
                           	break;    	  
			}                          
				
	/*** f auffrischen ***/

			l = f ;
		}  

	}
 
  /***    Rueckgabe    ***/   

	return( R );
}
