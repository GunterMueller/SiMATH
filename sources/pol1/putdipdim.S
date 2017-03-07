/*M
.SH NAME
putdipdim - put distributive polynomial dimension
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
single putdipdim(r, dim, S, M, VL)  
single r, dim; 
list S, M, VL;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B dim, S, M                                                                    
are the values, computed by dipdimpolid, i.e.                                   
.IP                                                                             
 dim := the dimension of the ideal spanned by G,                                
 S   := the maximal free set of variables,                                      
 M   := the set of all maximal free sets of variables                           
        of VL.                                                                  
.TP 4                                                                           
.B VL                                                                           
is the list of variables of the polynomial ideal with length r.  
.PP
putdipdim writes dim, S, M to stdout.
.PP
putdipdim returns                                                              
.PP                                                                             
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
dipdimpolid                                                                     
                                                                                         
M*/                                                                             

/*H
	Version 1	28.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdipdim     : 931130.941201
H*/
/*
	For the definition of putdipdim please refer to the header file _pol1.h.
*/
