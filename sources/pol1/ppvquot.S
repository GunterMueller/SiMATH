/*M
.SH NAME   
ppvquot - polynomial quotient by power of variable, (recursive)
                                                                     
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol ppvquot(r, P, i, n)  
single r, i, n; 
pol P;
 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.       
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables.      
.TP 4                                                                           
.B i                                                                            
is an integer number, 0 < i <= r.   
.TP 4                                                                           
.B n                                                                            
is an integer number, 0 <= n < BASIS. The n-th power of the i-th variable Xi must be a divider of the polynomial P.
.PP
ppvquot returns the polynomial P1, where
.IP
P1 = P / Xi^n.
                                                                   
.SH SEE ALSO
ppmvquot
                                                                    
M*/                                                                             

/*H
	Version 1       16.02.1989      A.Stein
	Version 2	15.05.1992	a gebunden.  PS
   DATE ppvquot       : 891101.920601
H*/


#include <_pol1.h>

pol ppvquot(r,P,i,n)
single r;
pol P;
single i,n;
{
	pol P1;
	init(P1);

/* P oder n gleich 0 */
	if (!P  ||  !n) P1 = P;

/* P,n ungleich 0 */

	else {
		single e,hr;
		obj a,ah;
		bind(P);
		init(a);

		hr = r - 1 ;
		for( P1 = _0; P != _0 ; P = lred2(P) ) {
			e = lfirst(P);
			ah = lsecond(P);
			a = ( i==r ) ? ( e-=n , ah )
				     :  ( ppvquot(hr,ah,i,n) ) ;
			P1 = lcomp2(a,e,P1) ;
		}
		P1 = linv(P1);
	}

	return(P1);
}
