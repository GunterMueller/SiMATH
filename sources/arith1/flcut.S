/*M
.SH NAME
flcut - floating point construction by cutting

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flcut(A,e,lA)
obj A;
single e,lA;

.SH DESCRIPTION
flcut() returns the internal list representation
of the floating point number A * BASIS^e using
at most FL_EPS+1 entries. See flcons() for further details.

.SH CAUTION
flcut() changes the content of the parameter A.
Therefore flcons() should be used instead since
flcons() performs the same operation without
this side-effect.

.SH SEE ALSO
flcons() 
M*/

/*H    
	Version 1       31.03.91        Marc Conrad
   DATE flcut         : 910715
H*/

#include <_arith1.h>       
floating flcut(m,exp,lf)                                          
/* Achtung! m wird veraendert!! (darf also nicht weiter verwendet werden)*/
single exp,lf;
int m;      
{                   
    if(!m) return(0);    
    else if ( exp >= BASIS ) floverflow( 3 );              
    else {
        single n,a;
	list g;  

	bind(m);
	init(g);

	/* Abfrage, ob m = single => */         
	if (issingle(m)) m = list1(m); 
     
        n = lf - FL_EPS;   
        if (n>0) {
		for(a=1;a<n;a++) m = lred(m);     
		g = m;
		m = lred(m);    
		exp += n;   
		a = lfirst(g);
		}       
	else g=0, a=0;        
/* Normierung & Runden  (e,0,0,0,1,2,3) => (e+3,1,2,3) etc.*/          
/* 1073741823 == BASIS - 1  */
	if (a >= (1<<29) ) {               

		while(( m != _0 ) && ((n=lfirst(m)) == 1073741823 )) { 
			g = m;
			m = lred(m);
			exp++;
			}                 
		if (n == 1073741823) g = list2(0,1);
		else n++, lsfirst(m,n);
		}
	else if (a <= -(1<<29) ) {
		while(( m != _0 ) && ( (n=lfirst(m)) == -1073741823 )) {    
			g = m;
			m = lred(m);
			exp++;
			}                 
		if (n == -1073741823) g = list2(0,-1);
		else  n--, lsfirst(m,n);
		}         
	else {                  
		while (!lfirst(m)) {  
			g = m;
			m = lred(m);
			exp++;
			} 
		}                
/* Underflow */           
	if ( exp <= -BASIS ) g=0;        
	else if ( exp >= BASIS ) floverflow( 4 );              
	else if (g) lsfirst(g,exp);
	else g = lcomp(exp,m);                     

	return(g);    
	}
}    
		
		
