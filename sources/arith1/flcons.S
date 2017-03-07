/*M
.SH NAME
flcons - floating point construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flcons(A,e,lA)
obj A;
single e,lA;

.SH DESCRIPTION
flcons() returns the internal list representation
of the floating point number A * BASIS^e using
at most FL_EPS+1 entries. FL_EPS is the global
precision set by flsetprec().
The first entry represents the exponent,
the tail of the list represents the mantissa.
Let x a real number and f it's floating point representation,
then the relative error of all floating point operations
is at most
.PP
    | ( x - f ) / x | <  1/2 * BASIS^( 1 - FL_EPS )

.PP
.TP 4   
.B A
is a single, an integer or a list A = (a) where a is not zero.
.TP 4
.B e
is the exponent for A.
.TP 4
.B lA
is the length of the list A, or 1 in case A is a single.

M*/
/*H    
	Version 1       18.03.91        Marc Conrad
   DATE flcons        : 910715
H*/

#include <_arith1.h>       

floating flcons(m,exp,lf)                                          

single exp,lf;
int m;      
{                   
    if(!m) return(0);   
    else if ( exp >= BASIS ) floverflow(1);    
    else {
        single n,a;
	bind( m );

	/* Abfrage, ob m = single => */         
	if (issingle(m)) m = list1(m);    
  
        n = lf - FL_EPS;   
        if (n > 0) {
		for(a=1;a<n;a++) m = lred(m);
		a = lfirst(m);
		m = lred(m);
		exp += n;   
		}             
	else a = 0;

/* Normierung (e,(0,0,0,1,2,3)) => (e+3,(1,2,3)) etc. bzw.    
  Runden.  ( 1073741823 ==  BASIS - 1 )  */
	if (a >= (1<<29) ) {
		while(( m != _0 ) && ((n=lfirst(m)) == 1073741823 )) {    
			m = lred(m);
			exp++;
			}                 
		if (n == 1073741823) m = list1(1);
		else { 
			n++;            
			m = lcomp(n,lred(m) );
			}
		}
	else if (a <= -(1<<29) ) {
		while(( m != _0 ) && ( (n=lfirst(m)) == -1073741823 )) {    
			m = lred(m);
			exp++;
			}                                                       
		if (n == -1073741823) m = list1(-1);      
		else { 
			n--;        
			m = lcomp(n,lred(m) );
			}
		}         
	else {                  
		while (!lfirst(m)) {  
			m = lred(m);
			exp++;
			} 
		}     
/* Underflow */       
	if ( exp <= -BASIS ) return (0);      
	else if ( exp >= BASIS ) floverflow(2);              
	else return(lcomp(exp,m));     
	} 
}    
		
		
