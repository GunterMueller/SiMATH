/*M
.SH NAME
rtofl - rational number to floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating rtofl(r)
rat r;

.SH DESCRIPTION
rtofl() returns the value of the rational number r
as a floating point number f.
The relative error is at most:
.PP
| ( r - f ) / r | < 1/2 * (2^30)^( 1 - FL_EPS )
M*/
/*H    
	Version 1       02.05.91        Marc Conrad
   DATE rtofl         : 910715
H*/

#include<_arith1.h>      
floating rtofl(r)
rat r;
{               
    if (!r) return (0);
    else {
	obj Z, N;
	single i, t, ll, exp;           

	bind( r );  
	init( Z, N );

	Z = rnum(r);
	N = rden(r);   
 
	exp = 0;       

	if(!issingle(N)) {        
		while(!lfirst(N)) N = lred(N), exp--; 
		ll = llength(N);
		if (lred(N) == _0) N = lfirst(N);    
		} 
                  
	else ll = 1;
	t = ll + FL_EPS + 1;       

	if (issingle(Z)) Z = list1(Z);        
        ll = llength(Z);

	for(i=ll;i<t;i++) Z = lcomp(0,Z), exp--;
	for(i=ll;i>t;i--) Z = lred(Z), exp++;   

/* 
	so siehts jetzt aus:
              N    1 + FL_EPS
	(. . . . .). . . . .    
	(. . . . . . . . . .)    = Z 
			 =t            
*/

	iqrem(Z,N,&N,&Z);      

	return( flcut(N,exp,(issingle(N) ? 1 : llength(N) ) ) );
	}

}
	
